//
//  CongestionLocation.swift
//  Congestionator
//
//  Created by Dean Woodward on 27/02/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import Foundation
import MapKit

class CongestionLocation: BaseModel {
    var id: NSNumber?
    var imageUrl: String?
    var lat: NSNumber?
    var lon: NSNumber?
    var region: String?
    var name: String?
    
    var storedImages = [UIImage]()
    
    var mapPoint: MKMapPoint {
        return MKMapPointForCoordinate(coordinateHelper())
    }
  
    func pinColor() -> MKPinAnnotationColor  {
        return MKPinAnnotationColor.Green
    }
    
    func coordinateHelper() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(CLLocationDegrees(lat!),CLLocationDegrees(lon!))
    }
}

extension CongestionLocation: MKAnnotation {
  var coordinate: CLLocationCoordinate2D { return CLLocationCoordinate2DMake(CLLocationDegrees(lat!),CLLocationDegrees(lon!)) }
  var title: String { return name! }
}
