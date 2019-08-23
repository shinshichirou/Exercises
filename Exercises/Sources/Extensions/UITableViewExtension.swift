//
//  UITableView.swift
//  Exercises
//
//  Created by Igor Tudoran on 8/23/19.
//  Copyright © 2019 DIGIS IOS. All rights reserved.
//

import UIKit

extension UITableView {
    
    public func cellWithType<T: UITableViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
    
    public func headerWithType<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: type.className) as! T
    }
    
}
