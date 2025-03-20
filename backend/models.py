from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from .database import Base

# User Model
class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, nullable=False)
    email = Column(String, unique=True, nullable=False)
    password = Column(String, nullable=False)

    # Establish one-to-one relationship with Profile
    profile = relationship("Profile", uselist=False, back_populates="user", cascade="all, delete-orphan")

# Profile Model
class Profile(Base):
    __tablename__ = "profiles"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), unique=True, nullable=False)
    full_name = Column(String, nullable=True)
    phone = Column(String, nullable=True)
    address = Column(String, nullable=True)

    # Establish relationship with User
    user = relationship("User", back_populates="profile")
