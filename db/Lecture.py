from db.dbConnect import DBConnect
import pymongo
from bson.objectid import ObjectId

class Lecture(DBConnect):

    def createLecture(self, lectureName, lectureDate, lectureTime, lecturer):
        lectureCol = super().dbCol("Lectures","Lectures")
        lectureDict = {
            "lectureName":lectureName,
            "lectureDate":lectureDate,
            "lectureTime":lectureTime,
            "lecturer":lecturer,
            "comments":[],
            "polls":[]
            }
        lectureCol.insert(lectureDict)

    def addComment(self, lectureID, commentString):
        lectureCol = super().dbCol("Lectures","Lectures")

        lectureCol.update(
            { "_id" : ObjectId(lectureID)},
            { "$push": {
                "comments": {
                    "_id": ObjectId(),
                    "commentString":commentString,
                    "upvotes": 0
                    }
                }
            })
    
    def getLecture(self, lectureID):
        lectureCol = super().dbCol("Lectures","Lectures")
        lecture = lectureCol.find_one({ "_id" : ObjectId(lectureID)})
        if lecture is not None:
            return lecture
        else:
            return None
    
    def getCommentsFromLectureID(self, lectureID):
        lectureCol = super().dbCol("Lectures","Lectures")
        lecture = lectureCol.find_one({"_id":ObjectId(lectureID)})
        if lecture is not None:
            return lecture['comments']
        else:
            return None

    def upvoteCommentFromLectureAndCommentID(self, lectureID, commentID):
        lectureCol = super().dbCol("Lectures","Lectures")
        lecture = lectureCol.find_and_modify(
            query = {"_id": ObjectId(lectureID), 'comments._id' : ObjectId(commentID)},
            update = { "$inc": {'comments.$.upvotes':1}})

    def updateLiveFromLectureID(self, lectureID, isLive):
        lectureCol = super().dbCol("Lectures","Lectures")
        if(bool(isLive)):
            lectureCol.update(
            { "_id" : ObjectId(lectureID)},
            { "$set": {"isLive": True}})
        else:
            lectureCol.update(
            { "_id" : ObjectId(lectureID)},
            { "$set": {"isLive": False}})