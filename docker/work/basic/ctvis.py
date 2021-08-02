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


def load_nifti(path):
    nifti = nib.load(path)
    data = nifti.get_fdata()
    return np.rollaxis(data, axis=1, start=0)


def label_color(mask_volume, 
                ggo_color = [255, 0, 0],
                consolidation_color = [0, 255, 0],
                effusion_color = [0, 0, 255]):
    
    shp = mask_volume.shape
    # make empty box
    mask_color = np.zeros((shp[0], shp[1], shp[2], 3), dtype=np.float64)
    # color setting
    mask_color[np.equal(mask_volume, 1)] = ggo_color
    mask_color[np.equal(mask_volume, 2)] = consolidation_color
    mask_color[np.equal(mask_volume, 3)] = effusion_color

    return mask_color