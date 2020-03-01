from flask import Blueprint, render_template

web_portal = Blueprint('web_portal', __name__)

@web_portal.route("/")
def displayModule():
    return render_template("index.html", title="Artificial Intelligence")