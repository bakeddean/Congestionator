//
//  ContentService.swift
//  EngagementHub
//
//  Created by Dean Woodward on 10/02/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import Foundation

class ContentService: BaseService {
    
    private override init() {
        super.init()
    }
    
    class var sharedInstance: ContentService {
        struct Singleton {
            static let instance = ContentService()
        }
        
        return Singleton.instance
    }
    
    override func configureRestKit() {
        super.configureRestKit()
        configureCongestionLocationList()
    }
    
    private func configureCongestionLocationList() {
        let congestionLocationListMapping = RKObjectMapping(forClass: CongestionLocation.self)
        congestionLocationListMapping.addAttributeMappingsFromArray(["id", "imageUrl", "lat", "lon", "region"])
        
        let responseDescriptor = RKResponseDescriptor(mapping: congestionLocationListMapping, method: RKRequestMethod.GET, pathPattern: ServicesResourceURI.GetCameras, keyPath: nil, statusCodes: NSIndexSet(index: 200))
        RKObjectManager.sharedManager().addResponseDescriptor(responseDescriptor)
    }
    
    // GET [API_BASE_URI]/cameras.json
    func getCongestionLocations(#success: (congestionLocations: [CongestionLocation]) -> (), failure:(errorResponses: AnyObject?, operation: RKObjectRequestOperation?) -> ()) {
        RKObjectManager.sharedManager().getObjectsAtPath(
            ServicesResourceURI.GetCameras,
            parameters: nil,
            success: { (operation, mappingResult) -> Void in
                var array = mappingResult.array() as NSArray
                success(congestionLocations: array as [CongestionLocation])
            },
            failure: { (operation, error) -> Void in
                let errorResponse = (error.userInfo![RKObjectMapperErrorObjectsKey])?.firstObject
                failure(errorResponses: nil, operation: operation)
            }
        )
    }
}
