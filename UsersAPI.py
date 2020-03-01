from flask import Blueprint, request, jsonify, render_template, redirect
from db.User import User
from db.Module import Module
from db.Lecture import Lecture
users_api = Blueprint('users_api', __name__)
modules_api = Blueprint('modules_api', __name__)
lectures_api = Blueprint('lectures_api', __name__)

apiUser = User()
moduleObj = Module()
LectureObj = Lecture()

@users_api.route("/users/student/createUser", methods=['POST', 'GET'])
def createUser():
    rd = request.get_json()
    apiUser.createStudentUser(rd["username"],rd["email"],rd["password"])
    return jsonify(success=True)

@users_api.route("/users/student/login", methods=["POST","GET"])
def loginUser():
    rd = request.get_json()
    if(rd is not None and "email" in rd):
        userPassword = apiUser.getPassword(rd["email"])
        if(userPassword is not None and apiUser.verify_password(userPassword,rd["password"])):
            return redirect("/users/listModules")
    elif(request.form['email'] is not None):
        email = request.form["email"]
        userPassword = apiUser.getPassword(email)
        if(userPassword is not None and apiUser.verify_password(userPassword,request.form["password"])):
            return redirect("/users/listModules")
    return render_template("index.html", failed=True)

@users_api.route("/users/listModules")
def listModules():
    moduleList = moduleObj.listModules()
    return render_template("modules.html",moduleList=moduleList)

@users_api.route("/users/getLectureInfo", methods=["POST"])
def getLectureInfo():
    moduleID = request.form["moduleID"]
    lectureIDs = moduleObj.getLectureIDs(moduleID)
    lectureList = []
    for lectureID in lectureIDs:
        lectureList.append(LectureObj.getLecture(lectureID))
    return render_template("lectures.html", lectureList=lectureList)


@users_api.route("/user/lecture/getLecture",methods=["POST"])
def displayLectureInfo():
    lectureID = request.form['lectureID']
    lecture = LectureObj.getLecture(lectureID)
    return render_template("lecture.html", lecture=lecture)
