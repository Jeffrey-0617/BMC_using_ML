import csv

with open('fv.csv', 'a', newline='') as fv_file:
    writer = csv.writer(fv_file)

    f = open("fv.txt", "r")
    data = f.read()

    # replacing end splitting the text
    # when newline ('\n') is seen.
    fv = data.split("\n")
    fv.pop()

    f.close()

    writer.writerow(fv)
