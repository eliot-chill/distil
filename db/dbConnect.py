import pymongo
from db import config


class DBConnect():

    client = None

    def __init__(self):
        self.client = pymongo.MongoClient(f"mongodb+srv://distilUser:{config.getPassword()}@distil-tatww.gcp.mongodb.net/test?retryWrites=true&w=majority")
    
    def dbCol(self, dbName,collectionName):
        return self.client[dbName][collectionName]
    
