# Use a lightweight Python image as the base
FROM python:3.11-slim

# Set the working directory inside the container
# All subsequent commands will run in this directory
WORKDIR /app

# Copy only the requirements.txt first
# This allows Docker to cache dependency installation if requirements don't change
COPY requirements.txt .

# Install Python dependencies listed in requirements.txt
# --no-cache-dir prevents pip from storing unnecessary cache to keep image smaller
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the project files into the container
# Make sure .dockerignore exists to avoid copying unnecessary files like venv or __pycache__
COPY . .

# Expose port 8000 so the container can be accessed from the host
EXPOSE 8000

# Command to run the FastAPI app using Uvicorn
# --host 0.0.0.0 makes it accessible outside the container
# --port 8000 matches the exposed port
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
