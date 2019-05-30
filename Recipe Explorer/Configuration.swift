//
//  Configuration.swift
//  Recipe Explorer
//
//  Created by Furqan on 2019-05-30.
//  Copyright © 2019 Furqan. All rights reserved.
//

import Foundation

class Configuration {
    
    private class func configObjectForKey(_ key: String) -> String {
        let configObject = Bundle.main.object(forInfoDictionaryKey: key) as? String
        assert(configObject != nil, "Config key \(key) was not found")
        
        // If the configuration is not valid, the app is not able to function correctly. Therefore we can suppress the force unwrapp warning here
        return configObject!
    }
    
    class func contentfulAccessToken() -> String {
        return configObjectForKey("CONFIG_CONTENTFUL_ACCESS_TOKEN")
    }
    
    class func contentfulEnvironmentId() -> String {
        return configObjectForKey("CONFIG_CONTENTFUL_ENVIRONMENT_ID")
    }
    
    class func contentfulSpaceId() -> String {
        return configObjectForKey("CONFIG_CONTENTFUL_SPACE_ID")
    }
}
