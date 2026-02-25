"""
FastAPI service for model inference.
Handles health checks, predictions, and metrics.
"""
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import joblib

app = FastAPI()
model = joblib.load('model.pkl')

class PredictionRequest(BaseModel):
    patient_id: str
    features: dict

@app.get("/health")
def health():
    return {"status": "ok", "model_version": "1.2.0"}

@app.post("/predict")
def predict(request: PredictionRequest):
    try:
        result = model.predict([request.features])
        return {
            "patient_id": request.patient_id,
            "risk_score": float(result[0]),
            "model_version": "1.2.0"
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
