from passlib.context import CryptContext
from jose import JWTError, jwt
from datetime import datetime, timedelta

# Secret key for JWT
SECRET_KEY = "vuH9(PJ_kF9PX)/"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

# Password hashing
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def verify_password(plain_password, hashed_password):
    """Verify if the provided password matches the stored hash."""
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password):
    """Hash the user's password using bcrypt."""
    return pwd_context.hash(password)

def create_access_token(user_id: str, email: str, expires_delta: timedelta = None):
    """
    Generate a JWT access token embedding user_id and email.
    
    :param user_id: Unique identifier of the user.
    :param email: User's email.
    :param expires_delta: Optional expiration time.
    :return: Encoded JWT token.
    """
    to_encode = {
        "sub": email,  # Subject: Email
        "user_id": user_id,  # Include user_id in the token
        "exp": datetime.utcnow() + (expires_delta or timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES))
    }
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
