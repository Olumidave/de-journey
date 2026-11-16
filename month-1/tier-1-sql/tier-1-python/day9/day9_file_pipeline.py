import csv
import json

CITY_FIXES = {
    "lagos": "Lagos",
    "abuja": "Abuja",
    "kano": "Kano",
    "enugu": "Enugu",
    "ph": "Port Harcourt",
}


def clean_text(raw_text):
    if raw_text is None:
        return ""
    return str(raw_text).strip().title()


def parse_whole_number(raw_value):
    try:
        return int(str(raw_value).strip())
    except ValueError:
        return None


def parse_money(raw_value):
    if raw_value is None:
        return None
    text = str(raw_value).upper()
    for junk in ["₦", "NGN", "N", ",", " "]:
        text = text.replace(junk, "")
    try:
        return float(text)
    except ValueError:
        return None


def clean_city(raw_city):
    key = str(raw_city).strip().lower()
    return CITY_FIXES.get(key, clean_text(raw_city))


def read_orders(path):
    try:
        with open(path, "r", encoding="utf-8", newline="") as file:
            reader = csv.DictReader(file)
            return list(reader), None
    except FileNotFoundError:
        return [], "File not found: " + path


raw_orders, error = read_orders("data/orders.csv")

if error is not None:
    print("STOP:", error)
    print("Check that you are inside the folder that contains the data folder.")
else:
    good_orders = []
    rejected_orders = []

    for raw in raw_orders:
        customer = clean_text(raw.get("customer"))
        quantity = parse_whole_number(raw.get("quantity"))
        unit_price = parse_money(raw.get("unit_price"))

        if customer == "":
            reason = "customer name missing"
        elif quantity is None or quantity < 1:
            reason = "quantity not valid"
        elif unit_price is None or unit_price <= 0:
            reason = "unit_price not valid"
        else:
            reason = None

        if reason is None:
            good_orders.append({
                "order_id": raw["order_id"],
                "customer": customer,
                "product": clean_text(raw.get("product")),
                "quantity": quantity,
                "unit_price": unit_price,
                "total": round(unit_price * quantity, 2),
                "city": clean_city(raw.get("city")),
                "status": clean_text(raw.get("status")),
            })
        else:
            rejected_orders.append({
                "order_id": raw.get("order_id"),
                "customer": raw.get("customer"),
                "reason": reason,
            })

    good_columns = ["order_id", "customer", "product", "quantity",
                    "unit_price", "total", "city", "status"]
    with open("output/clean_orders.csv", "w", encoding="utf-8", newline="") as file:
        writer = csv.DictWriter(file, fieldnames=good_columns)
        writer.writeheader()
        writer.writerows(good_orders)

    rejected_columns = ["order_id", "customer", "reason"]
    with open("output/rejected_orders.csv", "w", encoding="utf-8", newline="") as file:
        writer = csv.DictWriter(file, fieldnames=rejected_columns)
        writer.writeheader()
        writer.writerows(rejected_orders)

    total_value = 0
    for order in good_orders:
        total_value += order["total"]

    summary = {
        "records_received": len(raw_orders),
        "records_accepted": len(good_orders),
        "records_rejected": len(rejected_orders),
        "total_value_of_accepted_orders": total_value,
    }
    with open("output/summary.json", "w", encoding="utf-8") as file:
        json.dump(summary, file, indent=2)

    print("Received:", len(raw_orders))
    print("Accepted:", len(good_orders))
    print("Rejected:", len(rejected_orders))
    print(f"Total value of accepted orders: ₦{total_value:,.2f}")
    print("Files written to the output folder.")