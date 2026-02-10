from flask import request, render_template
from models import db, Membership
from pricing import recommend, calc_total, calc_breakdown

def register_routes(app):

    @app.route("/")
    def home():
        return "Server alive."

    @app.route("/signup")
    def signup():
        return render_template("signup.html")

    def build_addons_list(args):
        addons_list = []

        v = (args.get("addon_swim") or "").strip()
        if v != "":
            addons_list.append(v)

        v = (args.get("addon_classes") or "").strip()
        if v != "":
            addons_list.append(v)

        v = (args.get("addon_massage") or "").strip()
        if v != "":
            addons_list.append(v)

        v = (args.get("addon_physio") or "").strip()
        if v != "":
            addons_list.append(v)

        return addons_list

    @app.route("/recommend")
    def rec():
        try:
            age = int(request.args.get("age"))
        except:
            return "Invalid age"

        student = request.args.get("student") == "1"
        plan = request.args.get("plan") or ""

        if age < 16:
            return "Under 16 not allowed"

        addons_list = build_addons_list(request.args)

        ug, pz, best = recommend(age, student, plan, addons_list)

        return render_template(
            "recommend.html",
            ug=ug,
            pz=pz,
            best=best,
            age=age,
            student="1" if student else "0",
            plan=plan,
            addon_swim=request.args.get("addon_swim", ""),
            addon_classes=request.args.get("addon_classes", ""),
            addon_massage=request.args.get("addon_massage", ""),
            addon_physio=request.args.get("addon_physio", "")
        )

    @app.route("/confirm")
    def confirm():
        try:
            age = int(request.args.get("age"))
        except:
            return "Invalid age"

        student = request.args.get("student") == "1"
        plan = request.args.get("plan") or ""
        gym = request.args.get("gym") or ""

        if age < 16:
            return "Under 16 not allowed"

        addons_list = build_addons_list(request.args)

        total = calc_total(gym, age, student, plan, addons_list)

        return render_template(
            "confirm.html",
            age=age,
            student="1" if student else "0",
            plan=plan,
            gym=gym,
            addons_list=addons_list,
            cost=total,
            addon_swim=request.args.get("addon_swim", ""),
            addon_classes=request.args.get("addon_classes", ""),
            addon_massage=request.args.get("addon_massage", ""),
            addon_physio=request.args.get("addon_physio", "")
        )

    @app.route("/pay")
    def pay():
        try:
            age = int(request.args.get("age"))
        except:
            return "Invalid age"

        student = request.args.get("student") == "1"
        plan = request.args.get("plan") or ""
        gym = request.args.get("gym") or ""

        if age < 16:
            return "Under 16 not allowed"

        addons_list = build_addons_list(request.args)

        b = calc_breakdown(gym, age, student, plan, addons_list)
        total = b["total"]

        m = Membership(
            age=age,
            is_student=student,
            chosen_gym=gym,
            plan=plan,
            addons=",".join(addons_list),
            final_cost=total
        )
        db.session.add(m)
        db.session.commit()

        return render_template(
            "paid.html",
            mid=m.membership_id,
            cost=total,
            total_before=b["total_before_discount"],
            discount=b["discount_money"],
            rate=b["rate"]
        )

    @app.route("/member/<mid>")
    def member(mid):
        m = Membership.query.filter_by(membership_id=mid).first()
        if not m:
            return "not found"
        return render_template("member.html", m=m)
