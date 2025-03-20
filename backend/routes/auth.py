from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..database import get_db
from ..models import User, Profile
from ..security import get_password_hash, verify_password, create_access_token
from pydantic import BaseModel, EmailStr

router = APIRouter()

# Request models
class SignupRequest(BaseModel):
    username: str
    email: EmailStr
    password: str

class LoginRequest(BaseModel):
    email: EmailStr
    password: str

# Signup Route
@router.post("/signup")
def signup(request: SignupRequest, db: Session = Depends(get_db)):
    if db.query(User).filter(User.email == request.email).first():
        raise HTTPException(status_code=400, detail="Email already registered")
    
    hashed_password = get_password_hash(request.password)
    new_user = User(username=request.username, email=request.email, password=hashed_password)
    
    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    # Create an empty profile for the new user
    new_profile = Profile(user_id=new_user.id, full_name="", phone="", address="")
    db.add(new_profile)
    db.commit()

    return {"message": "User created successfully"}

# Login Route
@router.post("/login")
def login(request: LoginRequest, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.email == request.email).first()
    if not user or not verify_password(request.password, user.password):
        raise HTTPException(status_code=401, detail="Invalid credentials")
    
    access_token = create_access_token(user_id=str(user.id), email=user.email)
    return {"access_token": access_token, "token_type": "bearer"}
