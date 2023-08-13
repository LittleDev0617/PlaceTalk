export type Location = {
    location_id : number,
    loc_name : string,
    lat : number,
    lon : number
}

export type Place = {
    place_id : number,
    name : string,
    category : string, 
    state : number, 
    startDate : string, 
    endDate : string, 
    locations : Location
}

export type PlaceFilterOption = {
    category : string,
    dist : number,
    lat : number,
    lon : number
}