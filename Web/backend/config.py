from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    # Supabase Configuration
    SUPABASE_URL: str
    SUPABASE_KEY: str
    
    # JWT Configuration
    SECRET_KEY: str = "your-secret-key-change-in-production"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24  # 24 hours
    
    # App Configuration
    APP_NAME: str = "E-Book Mart API"
    DEBUG: bool = True

    class Config:
        env_file = ".env"

settings = Settings()