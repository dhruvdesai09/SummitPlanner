from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

DATABASE_URL = "postgresql://summit_user:summitplanner@localhost:5432/summit_planner"

# Create SQLAlchemy Engine
engine = create_engine(DATABASE_URL)

# Create Session Factory
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Define Base for Models
Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()