from flask import Blueprint, request, jsonify
from db.Users import User
users_api = Blueprint('users_api', __name__)

apiUser = User()

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
            return jsonify(success=True), 200
    return jsonify(success=False), 403
