
import pickle
import pandas as pd

MODEL_VERSION = '1.0.0'
# import the ml model
with open('models/model.pkl', 'rb') as f:
    model = pickle.load(f)

def predict_output(input_dict):

    input_df = pd.DataFrame([input_dict])

    # what are the classes in the ml model
    class_labels = model.classes_.tolist()

    # classes probs
    probabilities = model.predict_proba(input_df)[0]

    #predicted class
    predicted_class = model.predict(input_df)[0]

    confidence = round(max(probabilities),4)

    class_probs = dict(zip(class_labels,map(lambda p: round(p,4),probabilities)))

    return {
        'predicted_category': predicted_class,
        'confidence': confidence,
        'class_probabilities': class_probs
    }