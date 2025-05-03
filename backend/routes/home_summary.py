from fastapi import APIRouter, Query
from pydantic import BaseModel
from typing import List

router = APIRouter()

# 📊 Models for the home summary response
class BudgetItem(BaseModel):
    category: str
    amount: float

class InvestmentItem(BaseModel):
    type: str
    amount: float
    returns: float

class HomeData(BaseModel):
    available: float
    income: float
    emergencyFundProgress: float
    budgetItems: List[BudgetItem]
    investments: List[InvestmentItem]
    emergencyTip: str

# 🧠 Mock summary endpoint
@router.get("/", response_model=HomeData)
def get_home_summary(email: str = Query(...)):
    # ✅ Replace with DB logic later
    return {
        "available": 3200.50,
        "income": 50000.00,
        "emergencyFundProgress": 0.75,
        "budgetItems": [
            {"category": "Rent", "amount": 15000},
            {"category": "Groceries", "amount": 4000},
            {"category": "Utilities", "amount": 2000}
        ],
        "investments": [
            {"type": "FD", "amount": 10000, "returns": 500},
            {"type": "PPF", "amount": 5000, "returns": 300}
        ],
        "emergencyTip": "Try to save at least ₹5000 this month."
    }
