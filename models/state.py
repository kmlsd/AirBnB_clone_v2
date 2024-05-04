#!/usr/bin/python3
""" State Module for HBNB """
from os import getenv
import models
from models.base_model import BaseModel, Base
from models.city import City
from sqlalchemy import Column, String
from sqlalchemy.orm import relationship


class State(BaseModel, Base):
    """ State class """

    __tablename__ = "states"

    if getenv('HBNB_TYPE_STORAGE') == "db":
        name = Column(String(128), nullable=False)
        cities = relationship("City", cascade="all, delete", backref="state")

    else:
        name = ""

        @property
        def cities(self):
            """ Returns the list of City instances with
            state_id equals to the current State.id """
            cities = models.storage.all(City)
            clst = []
            for city in cities.values():
                if city.state_id == self.id:
                    clst.append(city)
            return clst
