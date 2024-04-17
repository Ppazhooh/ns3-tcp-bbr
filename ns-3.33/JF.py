import pandas as pd
import numpy as np
import os

goodputs = []
start_time = 11
root_dir = 'traces/bbr/'
for dirpath, dirnames, filenames in os.walk(root_dir):
    for filename in filenames:
        if 'goodput.txt' in filename:

                df = pd.read_csv(root_dir + filename , 
                 sep="\s+",
                 header=None, 
                 names=['Time', 'Goodput'])

                df = df[df['Time'] > start_time]
                df = df.reset_index(drop=True)
                
                goodputs.append(df['Goodput'].mean())


goodputs = np.array(goodputs)
J = (np.sum(goodputs) ** 2) / (len(goodputs) * np.sum(goodputs ** 2))
# J = 2
# write J to last line of JF_results.txt
with open('JF_results.txt', 'a') as f:
    f.write(str(J) + '\n')
    f.close()
