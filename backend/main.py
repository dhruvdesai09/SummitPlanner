from fastapi import FastAPI
from .routes.auth import router

app = FastAPI()

app.include_router(router)

@app.get("/")
def home():
    return {"message": "Welcome to Summit Planner API"}
