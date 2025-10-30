

-----

# Insurance Premium Prediction API 🩺

This project is an end-to-end machine learning application that predicts insurance premium categories (Low, Medium, High) based on user data.

It features a **Scikit-learn** model trained on a custom dataset, served via a high-performance **FastAPI**, and is fully containerized with **Docker** for easy and scalable deployment.

## 🚀 Features

  * **Real-time Prediction:** Get insurance premium predictions instantly via a REST API endpoint.
  * **Automatic Feature Engineering:** The API accepts raw user data (age, weight, height, etc.) and automatically computes derived features (like BMI, Age Group, and Lifestyle Risk) using Pydantic's `@computed_field`.
  * **Data Validation:** Pydantic models enforce strict data types and validation for all incoming requests, ensuring data integrity before it hits the model.
  * **Scalable Deployment:** Fully containerized with Docker for easy, reproducible, and isolated deployment.
  * **Health Check:** A `/health` endpoint is provided to monitor the API's status and model version.

## 🛠️ Tech Stack

  * **Python 3.11**
  * **FastAPI:** For building the high-performance API.
  * **Pydantic:** For data validation, settings management, and API schemas.
  * **Uvicorn:** As the ASGI server to run FastAPI.
  * **Scikit-learn:** For training the RandomForestClassifier.
  * **Pandas:** For data manipulation in the model training phase.
  * **Jupyter Notebook:** For model research, EDA, and training.
  * **Docker:** For containerization.

-----

## 📂 Project Structure

Here is a complete overview of the project's file structure and data flow.

```
INSURENCE_PREMIUM_PREDICTION_FASTAPI/
├── app.py                  # 1. Main FastAPI application
├── Dockerfile              # 6. Docker container setup
├── requirements.txt        # 5. Python dependencies
├── venv/                   # (Virtual environment)
├── config/                 # 4. Configuration files
│   └── city_tire.py        #    (Stores city tier lists)
├── models/                 # 2. Model and prediction logic
│   ├── model.pkl           #    (The trained scikit-learn model)
│   └── predict.py          #    (Code to load the model and make predictions)
├── schema/                 # 3. Pydantic data models (schemas)
│   ├── user_input.py       #    (Validates incoming data, computes features)
│   └── prediction_response.py #    (Defines the API's JSON output structure)
├── fastapi_ml_model (1).ipynb # (Jupyter notebook for research/training)
├── README.md               # (Project documentation)
└── LICENSE                 # (License file)
```

### ➡️ Data Flow

1.  **`app.py`** receives an HTTP request at the `/predict` endpoint.
2.  **`schema/user_input.py`** validates the incoming JSON. It uses the raw data (like `age`, `weight`) and lists from **`config/city_tire.py`** to automatically compute engineered features (like `bmi`, `age_group`).
3.  **`app.py`** passes these computed features to the function in **`models/predict.py`**.
4.  **`models/predict.py`** loads the `models/model.pkl` file and uses it to generate a prediction.
5.  **`app.py`** takes this result and formats it using the **`schema/prediction_response.py`** model, sending the final JSON response back to the user.

-----

## 🏁 Getting Started

You can run this project in two ways: locally with a virtual environment or as a Docker container.

### 1\. Running with Docker (Recommended)

This is the simplest way to get the application running.

1.  **Build the Docker image:**

    ```sh
    docker build -t insurance-api .
    ```

2.  **Run the Docker container:**

    ```sh
    docker run -d -p 8000:8000 --name insurance-container insurance-api
    ```

    The API will now be accessible at `http://localhost:8000`.

### 2\. Running Locally

1.  **Clone the repository:**

    ```sh
    git clone https://github.com/Harish-lvrk/INSURENCE_PREMIUM_PREDICTION_FASTAPI.git
    cd INSURENCE_PREMIUM_PREDICTION_FASTAPI
    ```

2.  **Create and activate a virtual environment:**

    ```sh
    python3 -m venv venv
    source venv/bin/activate
    ```

3.  **Install the dependencies:**

    ```sh
    pip install -r requirements.txt
    ```

4.  **Run the application:**

    ```sh
    uvicorn app:app --host 0.0.0.0 --port 8000
    ```

    The API will be accessible at `http://localhost:8000`.

-----

## 📖 API Endpoints

Once the application is running, you can access the interactive API docs at `http://localhost:8000/docs`.

### Health Check

  * **Endpoint:** `GET /health`
  * **Description:** Checks the API's health and returns the current model version.
  * **Success Response (200):**
    ```json
    {
      "status": "ok",
      "version": "1.0.0",
      "model_loaded": true
    }
    ```

### Prediction

  * **Endpoint:** `POST /predict`

  * **Description:** Predicts the insurance premium category.

  * **Request Body:**

    ```json
    {
      "age": 35,
      "weight": 80.5,
      "height": 1.75,
      "income_lpa": 12.5,
      "smoker": false,
      "city": "Mumbai",
      "occupation": "private_job"
    }
    ```

  * **Success Response (200):**

    ```json
    {
      "predicted_category": {
        "predicted_category": "Medium",
        "confidence": 0.78,
        "class_probabilities": {
          "Low": 0.12,
          "Medium": 0.78,
          "High": 0.10
        }
      }
    }
    ```

-----

## 🔬 Model Training

The complete process of data exploration, feature engineering, model comparison (RandomForest, LogisticRegression, SVM, GradientBoosting), and hyperparameter tuning is documented in the `fastapi_ml_model (1).ipynb` notebook.

The final trained **RandomForestClassifier** (90% accuracy on the test set) is saved as `models/model.pkl`.

## 📄 License

This project is licensed under the MIT License.
