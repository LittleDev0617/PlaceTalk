from pyproj import Transformer
from requests import get

def link2lat_lon(link):
    '''
    1. 건물 누르고 공유
    https://naver.me/Gh846DFX
    >>> r.history[1].url
    'https://map.naver.com/v5?summaryCard=14146210.138743695%7C4516139.686555475%7Cplace%7C31949741'


    // 그냥 땅 아무데서 공유
    >>> r=get('http://naver.me/G6fIbsiZ').history[0].headers
    >>> r
    { 'Location': 'https://map.naver.com/v5/?c=14146100.436657023,4515246.072676912,20,0,0,0,dh',  .. }
    '''
    
    link = link.replace('https', 'http')    
    r = get(link)
    if len(r.history) == 1:
        lat, lon = r.history[0].headers['Location'].split('c=')[1].split(',')[:2]
    elif len(r.history) == 2:
        lat, lon, a, b = r.history[1].url.split('Card=')[1].split('%7C')
    
    return Transformer.from_crs('EPSG:3857', 'EPSG:4326').transform(float(lat), float(lon))
        