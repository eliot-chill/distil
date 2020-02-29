import pymongo
client = pymongo.MongoClient("mongodb+srv://distilUser:whatever12@distil-tatww.gcp.mongodb.net/test?retryWrites=true&w=majority")
db = client.test