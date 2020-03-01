from flask import Blueprint, request, jsonify
from db.Module import Module
from bson.json_util import dumps
from db.Lecture import Lecture
import json


modules_api = Blueprint('modules_api', __name__)
lectures_api = Blueprint('lectures_api', __name__)

lectureObj = Lecture()
moduleObj = Module()

@modules_api.route("/modules/createModule", methods=["POST","GET"])
def createModule():
    rd = request.get_json()
    moduleObj.createModule(rd['courseName'], rd['lecturerName'], rd['startDate'])
    return jsonify(success=True), 200

@modules_api.route("/modules/addLecture", methods=["POST","GET"])
def addLectureToModule():
    rd = request.get_json()
    moduleObj.addLecture(rd["moduleID"],rd["lectureID"])
    return jsonify(success=True), 200


@modules_api.route("/modules/getModules")
def getModules():
    modulesList = moduleObj.listModules()
    return dumps(list(modulesList))

@modules_api.route("/modules/getLectures", methods=["POST","GET"])
def getLecturesFromModuleID():
    lectureIDs = moduleObj.getLectureIDs(request.args.get('moduleID'))
    lectureObjectList = []
    for lectureID in lectureIDs:
        tempObj = lectureObj.getLecture(lectureID)
        lectureObjectList.append(tempObj)
    return dumps(list(lectureObjectList))
