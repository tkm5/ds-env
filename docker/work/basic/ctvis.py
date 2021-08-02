import numpy as np
import pandas as pd

from glob import glob
import nibabel as nib

def _get_df(base_path='covid-data', folder='rp_im'):
    data_dict = pd.DataFrame({'FilePath': glob(f'{base_path}/{folder}/*'),
                              'FileName': [p.split('/')[-1] for p in glob(f'{base_path}/{folder}/*')]})
    return data_dict


def get_df_all(base_path='covid-data'):
    rp_im_df = _get_df(base_path, folder='rp_im')
    rp_msk_df = _get_df(base_path, folder='rp_msk')
    return rp_im_df.merge(rp_msk_df, on='FileName', suffixes=('Image', 'Mask'))


def load_path(path):
    nifti = nib.load(path)
    data = nifti.get_fdata()
    return np.rollaxis(data, axis=1, start=0)