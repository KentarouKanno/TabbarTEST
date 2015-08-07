//
//  ModalView.swift
//  Fake Apple Music
//
//  Created by KentarOu on 2015/08/08.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

import Foundation
import UIKit

class ModalView : UIView {
    
    var superV: Tabbar1VC!
    
    var rect:CGRect = CGRect()
    
    class func instance() -> ModalView {
        return UINib(nibName: "ModalView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! ModalView
    }
    
    
    @IBAction func pushHeader(sender: AnyObject) {
        
        rect = self.frame;
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.frame = CGRectMake(0, -64, self.frame.size.width, self.frame.size.height + 64)
        })
            
        superV.setTabBarVisible(false, animated: true)
    }
    
    @IBAction func pushDown(sender: AnyObject) {
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.frame = self.rect
        })
        
        superV.setTabBarVisible(true, animated: true)
    }
    
    
    
    
}