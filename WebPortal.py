from flask import Blueprint, render_template

web_portal = Blueprint('web_portal', __name__)

@web_portal.route("/displayModule")
def displayModule():
    return render_template("webportal.html", title="Artificial Intelligence")