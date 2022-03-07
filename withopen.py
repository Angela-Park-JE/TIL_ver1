import csv

raw = []
with open('./data/mall_customer.csv', 'r', encoding = 'utf-8') as f:
    rdr = csv.reader(f)
    for line in rdr:
        raw.append(line)
