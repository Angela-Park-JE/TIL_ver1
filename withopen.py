# pd.read_csv() 없이, 즉 판다스를 사용할 수 없을 때 csv 파일을 불러올 떄 사용.

import csv

raw = []
with open('./data/mall_customer.csv', 'r', encoding = 'utf-8') as f:
    rdr = csv.reader(f)
    for line in rdr:
        raw.append(line)
