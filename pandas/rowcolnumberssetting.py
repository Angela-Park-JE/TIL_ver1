
# setting the maximum number of columns in jupyter notebook display

import pandas as pd

pd.set_option('display.max.columns', 50) 
pd.set_option('display.max_rows', None)

# You can reset an option back to its default value like this:

pd.reset_option('display.max_rows')

# And reset all of them back:

pd.reset_option('all')

# You have to set also 

pd.set_option('display.min_rows', 50)
