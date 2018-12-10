# services/users/project/config.py


import os  # new


class BaseConfig:
    """Base configuration"""
    DEBUG = False
    TESTING = False
    SQLALCHEMY_TRACK_MODIFICATIONS = False  # new
    SECRET_KEY = 'my_precious'
    DEBUG_TB_ENABLED = False              # new
    DEBUG_TB_INTERCEPT_REDIRECTS = False  # new
    BCRYPT_LOG_ROUNDS = 13


class DevelopmentConfig(BaseConfig):
    """Development configuration"""
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL')  # new
    DEBUG_TB_ENABLED = True  # new
    BCRYPT_LOG_ROUNDS = 4


class TestingConfig(BaseConfig):
    """Testing configuration"""
    TESTING = True
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_TEST_URL')  # new
    BCRYPT_LOG_ROUNDS = 4


class ProductionConfig(BaseConfig):
    """Production configuration"""
    DEBUG = False
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL')  # new
