//
//  NSObject+className.swift
//  Recipe Explorer
//
//  Created by Furqan on 2019-05-30.
//  Copyright © 2019 Furqan. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// Returns name of class
    class var className: String {
        return String(describing: self)
    }
    
}
