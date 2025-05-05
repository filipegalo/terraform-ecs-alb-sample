import os
import boto3

class Config:
    # Base configuration
    SECRET_KEY = os.environ.get('SECRET_KEY', 'your-secret-key')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    ENVIRONMENT = os.environ.get('ENVIRONMENT', 'dev')
    ENVIRONMENT_TYPE = os.environ.get('ENVIRONMENT_TYPE', 'dev')

    # Database settings
    DB_HOST = os.environ.get('DB_HOST', 'localhost')
    DB_PORT = os.environ.get('DB_PORT', '5432')
    DB_NAME = os.environ.get('DB_NAME', 'mydb')
    DB_USER = os.environ.get('DB_USER', 'db_user')
    DB_PASSWORD = os.environ.get('DB_PASSWORD', 'yourpassword')

    SQLALCHEMY_DATABASE_URI = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}?sslmode=prefer"

