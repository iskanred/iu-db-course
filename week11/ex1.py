from pymongo import MongoClient

client = MongoClient()
db = client['test']
restaraunts = db['restaraunts']


def print_indian():
    for doc in restaraunts.find({"cuisine": "Indian"}):
        print(doc['name'])


def print_indian_or_thai():
    for doc in restaraunts.find({"$or": [{"cuisine": "Indian"},
                                         {"cuisine": "Thai"}]}):
        print(doc['name'])


def print_with_specific_address():
    doc = restaraunts.find_one(
        {
            "address.building": "1115",
            "address.street": "Rogers Avenue",
            "address.zipcode": "11226"
        })
    print(doc['name'])


print_indian()
print_indian_or_thai()
print_with_specific_address()
