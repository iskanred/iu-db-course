from pymongo import MongoClient

client = MongoClient()
db = client['test']
restaraunts = db['restaraunts']


def delete_single_Manhattan():
    db.laba.delete_one({'borough': 'Manhattan'})


def delete_all_Thai():
    db.laba.delete_many({'cuisine': 'Thai'})


delete_single_Manhattan()
delete_all_Thai()
