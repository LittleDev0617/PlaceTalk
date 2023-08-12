from pyproj import Transformer

def link2lat_lon(link):
    if 'map.naver.com' in link:        
        lat, lon, a, b = link.split('Card=')[1].split('%7C')
        return Transformer.from_crs('EPSG:3857', 'EPSG:4326').transform(float(lat), float(lon))
        