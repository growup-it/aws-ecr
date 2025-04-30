from flask import Flask
import os

app = Flask(__name__)


@app.route("/")
def hello():
    name = os.environ.get("NAME")
    return f"Hello, {name}!"


if __name__ == "__main__":
    app.run(host="0.0.0.0")
