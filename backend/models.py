from sqlalchemy import Column, Integer, String, ForeignKey, Enum, Float, DateTime
from sqlalchemy.orm import relationship
from datetime import datetime
from .database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, nullable=False)
    email = Column(String, unique=True, index=True, nullable=False)
    password = Column(String, nullable=False)

    profile = relationship("Profile", back_populates="user", uselist=False)
    financial_goals = relationship("FinancialGoal", back_populates="user")

class Profile(Base):
    __tablename__ = "profiles"
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), unique=True)
    full_name = Column(String, nullable=False)
    dob = Column(String, nullable=False)
    gender = Column(String, nullable=False)
    income_level = Column(Integer, nullable=False)

    user = relationship("User", back_populates="profile")


class FinancialGoal(Base):
    __tablename__ = "financial_goals"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    goal_name = Column(String, nullable=False)
    goal_type = Column(Enum("savings", "investment", name="goal_type_enum"), nullable=False)
    target_amount = Column(Float, nullable=False)
    current_amount = Column(Float, default=0.0)
    start_date = Column(DateTime, default=datetime.utcnow)
    end_date = Column(DateTime, nullable=False)

    user = relationship("User", back_populates="financial_goals")
