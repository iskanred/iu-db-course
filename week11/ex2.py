import datetime

from pymongo import MongoClient

client = MongoClient()
db = client['test']
restaraunts = db['restaraunts']


def insert_specific_restaraunt():
    restaraunts.insert_one(
        {
            'address': {'building': '1480', 'coord': [-73.9557413, 40.7720266], 'street': '2 Avenue', 'zipcode': '10075'},
            'borough': 'Manhattan', 'cuisine': 'Italian',
            'grades': [{'date': datetime.datetime(2014, 10, 1, 0, 0), 'grade': 'A', 'score': 11}],
            'name': 'Vella',
            'restaurant_id': '41704620'
        })


insert_specific_restaraunt()

