from flask import Blueprint, render_template
from flask import request
# from web_app.TransloaditInterface import TransloaditInterface

web_portal = Blueprint('web_portal', __name__)

@web_portal.route("/")
def displayLoginPage():
    return render_template("index.html")

@web_portal.route("/login")

@web_portal.route("/displayModule")
def displayModule():
    module_id = request.args.get("id")
    title = "Artificial Intelligence" # actually use module ID for this bit
    videos = [["Welcome - L01", "45:12", "/pics/23/01.jpg"], ["Use Cases - L02", "52:44", "/pics/23/02.jpg"]]
    videos_len = len(videos)
    return render_template("lecture/module.html", title=title, videos=videos, videos_len=videos_len)


@web_portal.route("/deliver", methods=["POST","GET"])
def deliverModule():
    module_id = request.args.get("id")
    title = "Artificial Intelligence" # actually use module ID for this bit
    return render_template("lecture/deliver.html", title=title)

