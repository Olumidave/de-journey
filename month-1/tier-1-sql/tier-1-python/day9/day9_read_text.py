with open ("data/orders.csv", "r", encoding="utf-8") as file:
    for line in file:
        pieces = line.strip().split(",")
        print(len(pieces), "pieces:", pieces)
       