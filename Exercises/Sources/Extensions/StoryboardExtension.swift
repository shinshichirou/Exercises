//
//  StoryboardExtension.swift
//  Exercises
//
//  Created by Igor Tudoran on 8/23/19.
//  Copyright © 2019 DIGIS IOS. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    public func viewController<T: UIViewController>(_ type: T.Type) -> T {
        return self.instantiateViewController(withIdentifier: type.className) as! T
    }
    
}
