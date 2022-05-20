import csv

with open('fv.csv', 'a', newline='') as fv_file:
    writer = csv.writer(fv_file)
    writer.writerow(["A","B","C","D","E","F","G","H","I","J","K","L","M"])
