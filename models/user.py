#!/usr/bin/python3
"""Defines the User class."""
from os import getenv
from models.base_model import Base
from models.base_model import BaseModel
from sqlalchemy import Column
from sqlalchemy import String
from sqlalchemy.orm import relationship


class User(BaseModel, Base):
    """  password (sqlalchemy String): The user's password.
        first_name (sqlalchemy String): The user's first name.
        last_name (sqlalchemy String): The user's last name.
  
    """
     __tablename__ = 'users'

    if getenv("HBNB_TYPE_STORAGE") == "db":
      email = Column(String(128), nullable=False)
      password = Column(String(128), nullable=False)
      first_name = Column(String(128))
      last_name = Column(String(128))
      places = relationship("Place", backref="user", cascade="delete")
      reviews = relationship("Review", backref="user", cascade="delete")
     
    else:
        email = ''
        password = ''
        first_name = ''
        last_name = ''
   
