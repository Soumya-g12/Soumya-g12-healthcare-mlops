# Healthcare MLOps Pipeline

Production ML system for clinical predictions. This is a sanitized version showing architecture and patterns, not actual patient data or models.

## What this does

- Trains models on schedule or when drift is detected
- Serves predictions via REST API with sub-second latency
- Monitors model performance and data quality
- Retrains automatically when things go sideways

## Architecture
S3 → SageMaker → Airflow → API → PostgreSQL

## Key patterns

- **Drift detection:** Statistical tests on feature distributions trigger retraining
- **Blue-green deployment:** New models shadow test before going live
- **Observability:** Prometheus metrics, structured logging, PagerDuty alerts

## Project structure
infrastructure/
├── airflow_dags/          # Orchestration logic
├── terraform/             # AWS infrastructure
└── docker/                # Container definitions
serving/
├── app/                   # FastAPI inference API
└── tests/                 # API and integration tests
notebooks/                 # Analysis and exploration
.github/workflows/         # CI/CD automation

## Run locally

```bash
docker-compose up --build
# API available at localhost:8000/health

What I learned
Hospital data changes in ways you can't predict — build monitoring first
SageMaker endpoints are great until they're not; have a rollback plan
Clinical users need explanations, not just predictions — built SHAP integration

---

## **STEPS TO CREATE EACH FILE**

1. Click **"Add file"** → **"Create new file"**
2. Type the full filename (with folders) like: `infrastructure/airflow_dags/model_retraining_dag.py`
3. Paste the code
4. Click **"Commit new file"**
5. Repeat for next file

---
