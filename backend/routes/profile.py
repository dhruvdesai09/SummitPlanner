from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from pydantic import BaseModel, Field
from ..database import get_db
from ..models import User, Profile

router = APIRouter(prefix="/profile", tags=["Profile"])

# Profile Request Model
class ProfileUpdateRequest(BaseModel):
    full_name: str = Field(..., example="John Doe")
    phone: str = Field(..., example="+1234567890")
    address: str = Field(..., example="123 Main Street, NY")

# Fetch user profile
@router.get("/{user_id}", response_model=ProfileUpdateRequest)
def get_profile(user_id: int, db: Session = Depends(get_db)):
    profile = db.query(Profile).filter(Profile.user_id == user_id).first()
    if not profile:
        raise HTTPException(status_code=404, detail="Profile not found")
    return profile

# Create or update user profile
@router.put("/{user_id}")
def update_profile(user_id: int, request: ProfileUpdateRequest, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    profile = db.query(Profile).filter(Profile.user_id == user_id).first()
    if not profile:
        profile = Profile(user_id=user_id, **request.dict())
        db.add(profile)
    else:
        for key, value in request.dict().items():
            setattr(profile, key, value)

    db.commit()
    db.refresh(profile)
    return {"message": "Profile updated successfully", "profile": profile}

# Delete user profile
@router.delete("/{user_id}")
def delete_profile(user_id: int, db: Session = Depends(get_db)):
    profile = db.query(Profile).filter(Profile.user_id == user_id).first()
    if not profile:
        raise HTTPException(status_code=404, detail="Profile not found")

    db.delete(profile)
    db.commit()
    return {"message": "Profile deleted successfully"}
