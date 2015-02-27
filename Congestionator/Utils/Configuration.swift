//
//  Configuration.swift
//  EngagementHub
//
//  Created by Malcolm Pullman on 18/02/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import Foundation

class Configuration {
    
    private class func getConfigurationAttribute(attribute: String) -> AnyObject? {
        if let path = NSBundle.mainBundle().pathForResource("Config", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) {
                return dict[attribute]
            }
        }
        return nil
    }
    
    class func getBaseURL() -> String? {
        return Configuration.getConfigurationAttribute("BaseURL") as String?
    }
    
    class func getOrganisationID() -> String? {
        return Configuration.getConfigurationAttribute("OrganisationID") as String?
    }
    
    class func shouldStubData() -> Bool {
        if let stubData = Configuration.getConfigurationAttribute("RKStubData") as? Bool {
            return stubData
        } else {
            println("WARNING: RKStubData has not been set in Config.plist. Defaulting to 'False'")
            return false
        }
    }
    
    class func getRKLoggingLevels() ->  (objectMapping: String, coreData: String) {
        var objectMapping = "Off"
        var coreData = "Off"
        
        if let objectMappingConfiguration = Configuration.getConfigurationAttribute("RKObjectMappingLoggingLevel") as String? {
            objectMapping = objectMappingConfiguration
        } else {
            println("WARNING: RKObjectMappingLoggingLevel has not been set in Config.plist. Defaulting to 'Off'")
        }
        
        if let coreDataConfiguration = Configuration.getConfigurationAttribute("RKCoreDataLoggingLevel") as String? {
            coreData = coreDataConfiguration
        } else {
            println("WARNING: RKCoreDataLoggingLevel has not been set in Config.plist. Defaulting to 'Off'")
        }
        
        return (objectMapping: objectMapping, coreData: coreData)
    }
}