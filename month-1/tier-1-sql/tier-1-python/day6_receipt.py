# Day 6: Konga receipt

customer_name = "Olumide David"
product = "Samsung TV"
price = 380000
quantity = 2

subtotal = price * quantity
vat = subtotal * 0.075
total = subtotal + vat

print("KONGA RECEIPT")
print("Customer:", customer_name)
print("Product:", product)
print("Subtotal:", subtotal)
print("VAT:", vat)
print("Total:", total)