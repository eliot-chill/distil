from flask import Flask, render_template
from UsersAPI import users_api
from WebPortal import web_portal

app = Flask(__name__)

app.register_blueprint(users_api)
app.register_blueprint(web_portal)

@app.route("/")
def hello():
    return "<h1 style='color:blue'>Hello There!</h1>"


@app.route("/test")
def test():
    return render_template("index.html")

if __name__ == "__main__":
    app.run(host='0.0.0.0')
