from decimal import Decimal
from models import MembershipOption

def get_price(gym: str, item_type: str, name: str) -> Decimal:
    row = MembershipOption.query.filter_by(gym=gym, item_type=item_type, name=name).first()
    if row is None:
        return Decimal("0")
    return Decimal(str(row.price))

def _discount_rate(gym: str, age: int, is_student: bool) -> Decimal:
    if gym == "ugym":
        if age > 66:
            return Decimal("0.15")
        if is_student or age < 25:
            return Decimal("0.20")
    elif gym == "powerzone":
        if age > 66:
            return Decimal("0.20")
        if is_student or age < 25:
            return Decimal("0.15")
    return Decimal("0")

def _parse_addon_token(token: str):
    """
    token examples:
      'swim:with'
      'classes:without'
      'massage:with'
      'physio:without'
    """
    token = (token or "").strip().lower()
    if token == "":
        return None

    if ":" not in token:
        return (token, "without")

    cat, mode = token.split(":", 1)
    cat = cat.strip()
    mode = mode.strip()

    if cat in ["swimming", "pool"]:
        cat = "swim"
    if mode not in ["with", "without"]:
        mode = "without"

    return (cat, mode)

def calc_breakdown(gym: str, age: int, student: bool, plan: str, addons_list):
    if age < 16:
        raise ValueError("Under 16 not allowed")

    gym = (gym or "").lower().strip()
    plan = (plan or "").strip()

    joining_fee = get_price(gym, "joining_fee", "Joining fee")
    base_membership = get_price(gym, "membership", plan)

    has_gym_membership = base_membership > 0

    
    discountable = base_membership
    non_discountable = Decimal("0")

    for raw in (addons_list or []):
        parsed = _parse_addon_token(raw)
        if not parsed:
            continue

        cat, mode = parsed

        if mode == "with" and not has_gym_membership:
            mode = "without"

        item_type = f"{cat}_{mode}"
        price = get_price(gym, item_type, "Standard")

        if cat in ["massage", "physio"]:
            non_discountable += price
        else:
            discountable += price

    rate = _discount_rate(gym, age, student)
    discount_money = (discountable * rate)

    total_before_discount = joining_fee + discountable + non_discountable
    total_after_discount = total_before_discount - discount_money

    return {
        "joining_fee": joining_fee,
        "discountable": discountable,
        "non_discountable": non_discountable,
        "rate": rate,
        "discount_money": discount_money,
        "total_before_discount": total_before_discount,
        "total": total_after_discount.quantize(Decimal("0.01")),
    }

def calc_total(gym: str, age: int, student: bool, plan: str, addons_list):
    b = calc_breakdown(gym, age, student, plan, addons_list)
    return b["total"]

def recommend(age: int, student: bool, plan: str, addons_list):
    ug = calc_total("ugym", age, student, plan, addons_list)
    pz = calc_total("powerzone", age, student, plan, addons_list)
    best = "ugym" if ug <= pz else "powerzone"
    return ug, pz, best
