from fastapi import FastAPI
from backend.routes.auth import router as auth_router
from backend.routes.profile import router as profile_router
from backend.routes.financial_goal import router as financial_goal_router

app = FastAPI(title="Summit Planner API")

# ✅ Include routers
app.include_router(auth_router, prefix="/auth", tags=["Authentication"])
app.include_router(profile_router, prefix="/users", tags=["User Profile"])
app.include_router(financial_goal_router, prefix="/financial", tags=["Financial Goals"])

# 🌟 Root endpoint
@app.get("/")
def home():
    return {"message": "Welcome to Summit Planner API 🚀"}

