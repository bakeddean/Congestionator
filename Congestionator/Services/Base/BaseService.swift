//
//  BaseService.swift
//  EngagementHub
//
//  Created by Dean Woodward on 10/02/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import Foundation

class BaseService {
    
    struct staticVariables {
        static var baseURL: String!
        static var isStubDataOn: Bool = Configuration.shouldStubData()
    }
    
    class var baseURL: String {
        get {
            return staticVariables.baseURL
        }
        set(newBaseURL) {
            if (staticVariables.baseURL != newBaseURL) {
                staticVariables.baseURL = newBaseURL
                let client = AFHTTPClient(baseURL: NSURL(string: newBaseURL))
                RKObjectManager.setSharedManager(RKObjectManager(HTTPClient: client))
            }
        }
    }
    
    class var isStubDataOn: Bool {
        get {
            return staticVariables.isStubDataOn
        }
        set(newIsStubDataOn) {
            staticVariables.isStubDataOn = newIsStubDataOn
        }
    }
    
    init() {
        configureRestKit()
    }
    
    func configureRestKit() {
        let loggingLevels = Configuration.getRKLoggingLevels()
        RestKitObjC.initLoggingForObjectMapping(loggingLevels.objectMapping, andCoreData: loggingLevels.coreData)
        
        if let baseURL = Configuration.getBaseURL() {
            BaseService.baseURL = baseURL
        } else {
            println("WARNING: BaseURL has not been set in Config.plist. Defaulting to 'http://127.0.0.1/'")
            BaseService.baseURL = "http://127.0.0.1/"
        }
    }
}
