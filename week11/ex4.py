import datetime

from pymongo import MongoClient

client = MongoClient()
db = client['test']
restaraunts = db['restaraunts']


def func():
    deleted_row = 0
    updated_row = 0
    cursor = restaraunts.find({"address.street": "Rogers Avenue"})

    for item in cursor:
        not_deleted = True

        for i in item['grades']:
            if i['grade'] == 'C':
                db.laba.delete_one({'_id': item['_id']})
                not_deleted = False
                deleted_row += 1
                break

        if not_deleted:
            temp_grade = item['grades']
            temp_grade.append({'date': datetime.datetime(2014, 12, 18, 0, 0), 'grade': 'C', 'score': 777})
            db.laba.update_one({'_id': item['_id']}, {'$set': {'grades': temp_grade}})
            updated_row += 1

    print("Deleted rows", deleted_row)
    print("Updated rows", updated_row)


func()
