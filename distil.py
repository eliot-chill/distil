from flask import Flask, render_template
from UsersAPI import users_api

app = Flask(__name__)

app.register_blueprint(users_api)

@app.route("/")
def hello():
    return "<h1 style='color:blue'>Hello There!</h1>"


@app.route("/test")
def test():
    return render_template("index.html")

if __name__ == "__main__":
    app.run(host='0.0.0.0')
