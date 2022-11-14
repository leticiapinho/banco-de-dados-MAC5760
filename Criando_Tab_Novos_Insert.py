import random
import pandas as pd
from RandomWordGenerator import RandomWord

import warnings
warnings.filterwarnings("ignore")

novos = pd.DataFrame()

for i in range(1000):
    end = 2020
    rMin = 90
    tit = 'movie'
    srt = random.randint(1970, 2018)
    tconst = '_tt00%d' %i
    priTtl = RandomWord(max_word_size=9, constant_word_size= True)
    priTtl = priTtl.generate()
    orgTtl = priTtl
    isAd = random.choice([1, 0])
    novos = novos.append({'tconst': tconst, 'tit':tit, 'priTtl': priTtl, 'orgTtl': orgTtl, 'isAd':isAd, 'srt':str, 'end':end, 'rMin':rMin}, ignore_index=True)

print(novos)
