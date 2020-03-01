from flask import Blueprint, request, jsonify
from db.Lecture import Lecture
from bson.json_util import dumps
import json

lectures_api = Blueprint('lectures_api', __name__)

lectureObj = Lecture()

@lectures_api.route("/lecture/addLecture", methods=['POST', 'GET'])
def createLecture():
    rd = request.get_json()
    lectureObj.createLecture(rd["lectureName"],rd["lectureDate"],rd["lectureTime"],rd["lecturer"])
    return jsonify(success=True)


@lectures_api.route("/lecture/addComment", methods=["POST"])
def addComment():
    rd = request.get_json()
    lectureObj.addComment(rd["lectureID"],rd["comment"])
    return jsonify(success=True)

@lectures_api.route("/lecture/getComments", methods=["POST","GET"])
def getComments():
    return dumps(lectureObj.getCommentsFromLectureID(request.args.get("lectureID")))


@lectures_api.route("/lecture/upvoteComment", methods=["GET","POST"])
def upvoteComment():
    lectureObj.upvoteCommentFromLectureAndCommentID(request.args.get('lectureID'),request.args.get('commentID'))
    return jsonify(success=True),200

@lectures_api.route("/lecture/updateLive", methods=["GET","POST"])
def updateLive():
    isLiveVar = request.args.get("isLive")
    if(isLiveVar.lower() == "true"):
        lectureObj.updateLiveFromLectureID(request.args.get('lectureID'),True)
    else:
        lectureObj.updateLiveFromLectureID(request.args.get('lectureID'),False)
    return jsonify(success=True), 200
