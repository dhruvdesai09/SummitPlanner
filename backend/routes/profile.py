from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from pydantic import BaseModel
from ..database import get_db
from ..models import User, Profile

router = APIRouter()

# Profile Request Model
class ProfileUpdateRequest(BaseModel):
    full_name: str
    phone: str
    address: str

# Fetch user profile
@router.get("/profile/{user_id}")
def get_profile(user_id: int, db: Session = Depends(get_db)):
    profile = db.query(Profile).filter(Profile.user_id == user_id).first()
    if not profile:
        raise HTTPException(status_code=404, detail="Profile not found")

    return {
        "user_id": profile.user_id,
        "full_name": profile.full_name,
        "phone": profile.phone,
        "address": profile.address
    }

# Create or update user profile
@router.put("/profile/{user_id}")
def update_profile(user_id: int, request: ProfileUpdateRequest, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    profile = db.query(Profile).filter(Profile.user_id == user_id).first()
    if not profile:
        # Create profile if it doesn't exist
        profile = Profile(user_id=user_id, full_name=request.full_name, phone=request.phone, address=request.address)
        db.add(profile)
    else:
        # Update profile if it exists
        profile.full_name = request.full_name
        profile.phone = request.phone
        profile.address = request.address

    db.commit()
    db.refresh(profile)

    return {"message": "Profile updated successfully"}

# Delete user profile
@router.delete("/profile/{user_id}")
def delete_profile(user_id: int, db: Session = Depends(get_db)):
    profile = db.query(Profile).filter(Profile.user_id == user_id).first()
    if not profile:
        raise HTTPException(status_code=404, detail="Profile not found")

    db.delete(profile)
    db.commit()

    return {"message": "Profile deleted successfully"}
