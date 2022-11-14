import random
import pandas as pd
from RandomWordGenerator import RandomWord

import warnings
warnings.filterwarnings("ignore")

novos = pd.DataFrame()

for i in range(999):
    end = 2022
    rMin = 90
    tit = 'movie'
    srt = random.randint(1990, 2022)
    tconst = '_tt%d' %i
    priTtl = RandomWord(max_word_size=8, constant_word_size= True)
    priTtl = priTtl.generate()
    orgTtl = priTtl
    isAd = random.choice([1, 0])
    novos = novos.append({'tconst': tconst, 'tit':tit, 'priTtl': priTtl, 'orgTtl': orgTtl, 'isAd':isAd, 'srt':str, 'end':end, 'rMin':rMin}, ignore_index=True)

print(novos)
