import pymongo
import config
client = pymongo.MongoClient(f"mongodb+srv://distilUser:{config.getPassword()}@distil-tatww.gcp.mongodb.net/test?retryWrites=true&w=majority")
db = client.test