//
//  CongestionLocation.swift
//  Congestionator
//
//  Created by Dean Woodward on 27/02/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import Foundation

class CongestionLocation: BaseModel {
    var id: NSNumber?
    var imageUrl: String?
    var lat: NSNumber?
    var lon: NSNumber?
    var region: String?
    //var thumbUrl: String?
}

/*
{
"id": "233",
"imageUrl": "http://www.trafficnz.info/camera/233.jpg",
"lat": "-40.762458",
"lon": "175.155501",
"name": "Otaki",
"offline": false,
"region": "Wellington"
},
*/
