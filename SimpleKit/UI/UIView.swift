//
//  SimplicityView.swift
//  Giggle
//
//  Created by Zac Adams on 19/08/15.
//  Copyright (c) 2015 zacattack. All rights reserved.
//

import Foundation
import UIKit;


enum UIViewEdge : Int {
    case top
    case right
    case bottom
    case left
};

extension UIView{
    
    // MARK:- Position
    
    var position:CGPoint{
        get{
            return self.frame.origin;
        }
        
        set{
            self.frame = CGRect(origin: newValue, size: self.size);
        }
    }
    

    var x:CGFloat{
        get{
            return self.frame.origin.x;
        }
        
        set{
            self.position = CGPoint(x: newValue, y: self.y);
        }
    }
    
    var y:CGFloat{
        get{
            return self.frame.origin.y;
        }
        
        set{
            self.position = CGPoint(x: self.x, y: newValue);
        }
    }
}


// MARK:- Size
extension UIView{
    
    var size:CGSize{
        get{
            return self.frame.size;
        }
        
        set{
            self.frame = CGRect(origin: self.position, size: newValue);
        }
    }
    
    var width:CGFloat{
        get{
            return frame.size.width;
        }
        
        set{
            self.size = CGSize(width: newValue, height: self.height);
        }
    }
    
    var height:CGFloat{
        get{
            return frame.size.height;
        }
        
        set{
            self.size = CGSize(width: self.width, height: newValue);
        }
    }
}

// MARK:- Insets
extension UIView{

    
    var top:CGFloat{
        get {
            return self.y;
        }
        
        set{
            self.y = newValue;
        }
    }
    
    var right:CGFloat{
        get{
            return self.x + self.width;
        }
        
        set{
            self.x = newValue - self.width;
        }
    }
    
    
    var bottom:CGFloat{
        get{
            return self.y + self.height;
        }
        
        set{
            self.y = newValue - self.height;
        }
    }
    
    
    var left:CGFloat{
        get{
            return self.x;
        }
        
        set{
            self.x = newValue;
        }
    }
    
    
}

// MARK: - Fill:
extension UIView{
    
    func fill() -> Void {
        self.fillWithInsets(UIEdgeInsets.zero);
    }
    
    func fillWithInsets( _ insets: UIEdgeInsets) -> Void{
        
        if let superview = self.superview{
            self.frame = UIView.rectFullInSuperview(superview, insets: insets);
        }
    }
}

// MARK: - Edge
extension UIView{
    
    func setEdge(_ edge: UIViewEdge, length: CGFloat) -> Void{
        self.setEdge(edge, length: length, insets: UIEdgeInsets.zero);
    }
    
    func setEdge(_ edge: UIViewEdge, length: CGFloat, insets: UIEdgeInsets) -> Void{

        if let superview = self.superview{
            self.frame = UIView.rectInSuperview(superview, edge: edge, length: length, insets: insets);
        }
    }
}

// MARK:- Rect / Frame
extension UIView{
    
    class func rectInSuperview(_ superview: UIView, edge:UIViewEdge, length:CGFloat, insets:UIEdgeInsets) -> CGRect{
        switch (edge) {
            case UIViewEdge.top:
                return CGRect(x: insets.left, y: insets.top, width: superview.width - insets.left - insets.right, height: length);
            
            case UIViewEdge.right:
                return CGRect(x: superview.width - length - insets.right, y: insets.top, width: length, height: superview.height - insets.top - insets.bottom);
            
            case UIViewEdge.bottom:
                return CGRect(x: insets.left, y: superview.height - length - insets.bottom, width: superview.width - insets.left - insets.right, height: length);
            
            case UIViewEdge.left:
                return CGRect(x: insets.left, y: insets.top, width: length, height: superview.height - insets.top - insets.bottom);
        }
    }
    
    class func rectFullInSuperview(_ superview: UIView, insets:UIEdgeInsets) -> CGRect {
        return CGRect(x: insets.left, y: insets.top, width: superview.width - insets.left - insets.right, height: superview.height - insets.top - insets.bottom);
    }
}
