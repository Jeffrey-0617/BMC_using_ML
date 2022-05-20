import pandas as pd #import the pandas library for data manipulation

data = pd.read_csv("fv.csv", header=0, na_values=['?'])

# code the categorical features {Gender, family_history_with_overweight,
# FAVC, CAEC, SMOKE, SCC, CALC, MTRANS}
categories = ["A","B","C","D","E","F","G","H","I","J","K","L","M"]

for i in categories:
    data[i] = data[i].astype('category')
    data[i] = data[i].cat.codes
print(data)
