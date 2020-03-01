from db.dbConnect import DBConnect
import pymongo
from bson.objectid import ObjectId

class Module(DBConnect):

    def createModule(self, name, lecturerName, startDate):
        moduleCol = super().dbCol("Modules", "Modules")
        moduleDict = {"courseName":name,"lecturerName":lecturerName, "startDate":startDate ,"lectureIDs":[]}
        moduleCol.insert(moduleDict)

    def addLecture(self, moduleID, lectureID):
        moduleCol = super().dbCol("Modules", "Modules")
        module = moduleCol.update(
            { "_id" : ObjectId(moduleID)},
            { "$push": {"lectureIDs":ObjectId(lectureID) }})

    def listModules(self):
        moduleCol = super().dbCol("Modules","Modules")
        return moduleCol.find()

    def getLectureIDs(self, courseID):
        moduleCol = super().dbCol("Modules","Modules")
        lectureIDlist = moduleCol.find_one({"_id":ObjectId(courseID)})
        if lectureIDlist is not None:
            return lectureIDlist['lectureIDs']
        else:
            return None