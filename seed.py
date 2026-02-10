from app import app
from models import db, MembershipOption

DATA = [
    
    ("ugym", "joining_fee", "Joining fee", "10"),

    ("ugym", "membership", "Super-off peak", "16"),
    ("ugym", "membership", "Off-peak", "21"),
    ("ugym", "membership", "Anytime", "30"),

    ("ugym", "swim_without", "Standard", "25"),
    ("ugym", "swim_with", "Standard", "15"),     

    ("ugym", "classes_without", "Standard", "20"),
    ("ugym", "classes_with", "Standard", "10"),  

    ("ugym", "massage_without", "Standard", "30"),
    ("ugym", "massage_with", "Standard", "25"),  

    ("ugym", "physio_without", "Standard", "25"),
    ("ugym", "physio_with", "Standard", "20"),   


    ("powerzone", "joining_fee", "Joining fee", "30"),

    ("powerzone", "membership", "Super-off peak", "13"),
    ("powerzone", "membership", "Off-peak", "19"),
    ("powerzone", "membership", "Anytime", "24"),

    ("powerzone", "swim_without", "Standard", "20"),
    ("powerzone", "swim_with", "Standard", "12.5"),  

    ("powerzone", "classes_without", "Standard", "20"),
    ("powerzone", "classes_with", "Standard", "0"),  

    ("powerzone", "massage_without", "Standard", "30"),
    ("powerzone", "massage_with", "Standard", "25"),

    ("powerzone", "physio_without", "Standard", "30"),
    ("powerzone", "physio_with", "Standard", "25"),
]

with app.app_context():
    db.create_all()

    MembershipOption.query.delete()
    db.session.commit()

    for g, t, n, p in DATA:
        db.session.add(MembershipOption(gym=g, item_type=t, name=n, price=p))

    db.session.commit()
    print("seed done")
