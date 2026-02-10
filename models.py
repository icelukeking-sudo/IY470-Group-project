from flask_sqlalchemy import SQLAlchemy
import uuid
from datetime import datetime

db = SQLAlchemy()

class MembershipOption(db.Model):
    __tablename__ = "membership_options"
    id = db.Column(db.Integer, primary_key=True)
    gym = db.Column(db.String(20))
    item_type = db.Column(db.String(20))
    name = db.Column(db.String(50))
    price = db.Column(db.Numeric(10,2))

class Membership(db.Model):
    __tablename__ = "memberships"
    id = db.Column(db.Integer, primary_key=True)
    membership_id = db.Column(db.String(40), default=lambda: uuid.uuid4().hex)

    age = db.Column(db.Integer)
    is_student = db.Column(db.Boolean)
    chosen_gym = db.Column(db.String(20))
    plan = db.Column(db.String(50))
    addons = db.Column(db.Text)
    final_cost = db.Column(db.Numeric(10,2))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
