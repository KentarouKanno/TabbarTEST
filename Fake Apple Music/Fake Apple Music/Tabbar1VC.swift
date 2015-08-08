//
//  Tabbar1VC.swift
//  Fake Apple Music
//
//  Created by KentarOu on 2015/08/08.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

import Foundation
import UIKit

class Tabbar1VC: UIViewController,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let animationDuration = 0.3
    
    var modalV:ModalView!
    var startPoint: CGPoint?
    var nowPoint: CGPoint?
    var tabbarFrame: CGRect!
    
    let data = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        for i in 0...100 {
            self.data.addObject("IndexPath.row = \(i)")
        }
        
        modalV = ModalView.instance()
        modalV.frame = CGRectMake(0,self.view.frame.size.height - 44 - 49, self.view.frame.size.width, self.view.frame.size.height + 64);
        self.view.addSubview(modalV)
        
        modalV.superV = self
        
        tabbarFrame = self.tabBarController?.tabBar.frame
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel!.text = "\(data[indexPath.row])"
        
        return cell
    }
    
    
    func setTabBarVisible(visible:Bool, duration: NSTimeInterval) {
    
        let offsetY = (visible ? 0 : 49.0)
        UIView.animateWithDuration(duration) {
            self.tabBarController?.tabBar.frame = CGRectOffset(self.tabbarFrame, 0, CGFloat(offsetY))
        }
    }
    
    func tabBarIsVisible() ->Bool {
        return self.tabBarController?.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if let touch = touches.first as? UITouch {
            startPoint = touch.locationInView(self.view)
            println(startPoint)
        }
        nowPoint = modalV.frame.origin
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let touch: UITouch = touches.first as! UITouch
        let location: CGPoint = touch.locationInView(self.view)
        
        let deltaY: CGFloat = CGFloat(location.y - startPoint!.y)
        
        
        if modalV.frame.origin.y >= -64 &&  modalV.frame.origin.y <= self.view.frame.size.height - 49 - 44 {
            
            if nowPoint!.y + deltaY <= -64 {
                
                self.tabBarController?.tabBar.frame = CGRectOffset(tabbarFrame, 0, 49)
                modalV.frame.origin.y = -64
                
            } else if nowPoint!.y + deltaY >= self.view.frame.size.height - 49 - 44 {
                
                self.tabBarController?.tabBar.frame = CGRectOffset(tabbarFrame, 0, 0)
                modalV.frame.origin.y = self.view.frame.size.height - 49 - 44
                
            } else {
                
                var value = self.view.frame.size.height - 44 - 49 + 64
                var value2 = modalV.frame.origin.y + 64
                var value3 = 1.0 - (value2 / value)
    
        
                self.tabBarController?.tabBar.frame = CGRectOffset(tabbarFrame, 0, 49 * value3)
                modalV.frame.origin.y = nowPoint!.y + deltaY
            }
        }
    }
    
    func upModalView(duration: NSTimeInterval) {
        
        UIView.animateWithDuration(duration, animations: {
            self.modalV.frame.origin.y = -64
        })
    }
    
    func downModalView(duration: NSTimeInterval) {
        
        UIView.animateWithDuration(duration, animations: {
            self.modalV.frame.origin.y = self.view.frame.size.height - 49 - 44
        })
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if modalV.frame.origin.y > self.view.frame.size.height / 2 {
            
            self.downModalView(animationDuration)
            self.setTabBarVisible(true, duration: animationDuration)
        } else {
            self.upModalView(animationDuration)
            self.setTabBarVisible(false, duration: animationDuration)
        }
    }
}

