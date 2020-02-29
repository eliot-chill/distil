from flask import Blueprint

users_api = Blueprint('users_api', __name__)

@users_api.route("/users/createUser")
def createUser():
    return "Hello new user"