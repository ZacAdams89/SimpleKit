//
//  SimplicityCGRect.swift
//  Giggle
//
//  Created by Zac Adams on 19/08/15.
//  Copyright (c) 2015 zacattack. All rights reserved.
//

import Foundation
import UIKit

extension CGRect{
    
    var x:CGFloat{
        get{
            return self.origin.x;
        }
    }
    
    var y:CGFloat{
        get{
            return self.origin.y;
        }
    }
    
    var width:CGFloat{
        get{
            return self.size.width;
        }
    }
    
    var height:CGFloat{
        get{
            return self.size.height;
        }
    }
    
    
    func inset(_ insets: UIEdgeInsets) -> CGRect{
        return CGRect(x: self.x + insets.left,
                      y: self.y + insets.top,
                      width: self.width - insets.right,
                      height: self.height - insets.bottom);
    }
    
}
