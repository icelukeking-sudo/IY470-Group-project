from flask import Flask
from models import db
from routes import register_routes

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://iy470:iy470pass@localhost:3306/iy470_gym"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db.init_app(app)

register_routes(app)

print(app.url_map)

if __name__ == "__main__":
    app.run(debug=True)

