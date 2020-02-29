from flask import Blueprint

modules_api = Blueprint('modules_api', __name__)

@modules_api.route("/modules/createModule")
def createModule():
    return "something"