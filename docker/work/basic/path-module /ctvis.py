import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import nibabel as nib
from glob import glob

def _get_df(base_path='public-covid-data', folder='rp_im'):
    data_dict = pd.DataFrame({'FilePath': glob(f'{base_path}/{folder}/*'),
                              'FileName': [p.split('/')[-1] for p in glob(f'{base_path}/{folder}/*')]})
    return data_dict

def get_df_all(base_path='public-covid-data'):
    get_df('rp_im')
    rp_im_df = _get_df(base_path='public-covid-data', folder='rp_im')
    rp_msk_df = _get_df(base_path='public-covid-data', folder='rp_msk')
    df = rp_im_df.merge(rp_msk_df, on='FileName', suffixes=('Image', 'Mask'))
    return df
