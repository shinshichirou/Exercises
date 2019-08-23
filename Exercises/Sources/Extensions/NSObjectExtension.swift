//
//  NSObjectExtension.swift
//  Exercises
//
//  Created by Igor Tudoran on 8/23/19.
//  Copyright © 2019 DIGIS IOS. All rights reserved.
//

import UIKit

extension NSObject {
    
    public static var className: String {
        if let component = String(describing: self).split(separator: ".").last {
            return String(component)
        } else {
            return ""
        }
    }
    
}
