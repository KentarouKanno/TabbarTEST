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
        superV.upModalView(0.5)
        superV.setTabBarVisible(false, animated: true)
    }
    
    @IBAction func pushDown(sender: AnyObject) {
        superV.downModalView(0.5)
        superV.setTabBarVisible(true, animated: true)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.nextResponder()?.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.nextResponder()?.nextResponder()?.touchesMoved(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.nextResponder()?.nextResponder()?.touchesEnded(touches, withEvent: event)
    }
}