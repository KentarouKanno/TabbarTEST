//
//  Tabbar1VC.swift
//  Fake Apple Music
//
//  Created by KentarOu on 2015/08/08.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

import Foundation
import UIKit

class Tabbar1VC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let modalV = ModalView.instance()
        modalV.frame = CGRectMake(0,self.view.frame.size.height - 44 - 49, self.view.frame.size.width, self.view.frame.size.height + 64);
        self.view.addSubview(modalV)
        
        modalV.superV = self
    }
    
    func setTabBarVisible(visible:Bool, animated:Bool) {
        
        
        if (tabBarIsVisible() == visible) { return }
        
        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)
        
        // zero duration means no animation
        let duration:NSTimeInterval = (animated ? 0.5 : 0.0)
        
        if frame != nil {
            UIView.animateWithDuration(duration) {
                self.tabBarController?.tabBar.frame = CGRectOffset(frame!, 0, offsetY!)
                return
            }
        }
    }
    
    func tabBarIsVisible() ->Bool {
        return self.tabBarController?.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

