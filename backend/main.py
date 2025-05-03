from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from backend.routes.auth import router as auth_router
from backend.routes.profile import router as profile_router
from backend.routes.financial_goal import router as financial_goal_router
from backend.routes.home_summary import router as home_summary_router  # NEW

app = FastAPI(title="Summit Planner API")

# ✅ Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ✅ Include routers
app.include_router(auth_router, prefix="/auth", tags=["Authentication"])
app.include_router(profile_router, prefix="/users", tags=["User Profile"])
app.include_router(financial_goal_router, prefix="/financial", tags=["Financial Goals"])
app.include_router(home_summary_router, tags=["Home Summary"])  # NEW

# 🌟 Root endpoint
@app.get("/")
def home():
    return {"message": "Welcome to Summit Planner API 🚀"}
