from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from pydantic import BaseModel, Field
from datetime import datetime
from ..database import get_db
from ..models import FinancialGoal, User

router = APIRouter()

# 🎯 Financial Goal Request Model
class FinancialGoalRequest(BaseModel):
    goal_name: str = Field(..., example="Emergency Fund")
    goal_type: str = Field(..., example="savings")  # savings or investment
    target_amount: float = Field(..., example=10000.0)
    current_amount: float = Field(0.0, example=500.0)
    end_date: datetime = Field(..., example="2025-12-31T00:00:00")

# ➕ Create a new financial goal
@router.post("/financial_goal/{user_id}")
def create_financial_goal(user_id: int, request: FinancialGoalRequest, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    goal = FinancialGoal(
        user_id=user_id,
        goal_name=request.goal_name,
        goal_type=request.goal_type,
        target_amount=request.target_amount,
        current_amount=request.current_amount,
        end_date=request.end_date
    )

    db.add(goal)
    db.commit()
    db.refresh(goal)
    
    return {"message": "Financial goal created successfully", "goal_id": goal.id}

# 📌 Get all financial goals for a user
@router.get("/financial_goal/{user_id}")
def get_financial_goals(user_id: int, db: Session = Depends(get_db)):
    goals = db.query(FinancialGoal).filter(FinancialGoal.user_id == user_id).all()
    if not goals:
        raise HTTPException(status_code=404, detail="No financial goals found")

    return [{"goal_id": goal.id, "goal_name": goal.goal_name, "goal_type": goal.goal_type, 
             "target_amount": goal.target_amount, "current_amount": goal.current_amount, 
             "start_date": goal.start_date, "end_date": goal.end_date} for goal in goals]

# 🔄 Update financial goal
@router.put("/financial_goal/{goal_id}")
def update_financial_goal(goal_id: int, request: FinancialGoalRequest, db: Session = Depends(get_db)):
    goal = db.query(FinancialGoal).filter(FinancialGoal.id == goal_id).first()
    if not goal:
        raise HTTPException(status_code=404, detail="Financial goal not found")

    goal.goal_name = request.goal_name
    goal.goal_type = request.goal_type
    goal.target_amount = request.target_amount
    goal.current_amount = request.current_amount
    goal.end_date = request.end_date

    db.commit()
    db.refresh(goal)

    return {"message": "Financial goal updated successfully"}

# ❌ Delete financial goal
@router.delete("/financial_goal/{goal_id}")
def delete_financial_goal(goal_id: int, db: Session = Depends(get_db)):
    goal = db.query(FinancialGoal).filter(FinancialGoal.id == goal_id).first()
    if not goal:
        raise HTTPException(status_code=404, detail="Financial goal not found")

    db.delete(goal)
    db.commit()

    return {"message": "Financial goal deleted successfully"}
