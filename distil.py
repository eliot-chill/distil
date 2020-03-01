from flask import Flask, render_template
from UsersAPI import users_api
from ModulesAPI import modules_api
from WebPortal import web_portal
from LecturesAPI import lectures_api

app = Flask(__name__,static_folder="static")

app.register_blueprint(users_api)
app.register_blueprint(modules_api)
app.register_blueprint(web_portal)
app.register_blueprint(lectures_api)

if __name__ == "__main__":
    app.run(host='0.0.0.0')
