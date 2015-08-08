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
    var startPoint: CGPoint?
    var modalV:ModalView!
    var nowPoint: CGPoint?
    
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
       // modalV.setPanGesture()
        
       // nowPoint = modalV.frame.origin
        
        
    }
    
    
    
    func panGesture(gesture: UIPanGestureRecognizer) {
        
        //nowPoint = gesture.locationInView(self.view)
        
        // println("Pan")
        
        let point = gesture.translationInView(self.view)
        
        modalV.frame.origin.y = nowPoint!.y + point.y

        println("\(point.x)")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    /*
    Cellに値を設定するデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(data[indexPath.row])"
        
        return cell
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
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if let touch = touches.first as? UITouch {
            startPoint = touch.locationInView(self.view)
            println(startPoint)
        }
        
        // タッチをやり始めた時のイメージの座標を取得
        nowPoint = modalV.frame.origin
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        println("Move super")
        
        let touch: UITouch = touches.first as! UITouch
        let location: CGPoint = touch.locationInView(self.view)
        println("location =\(location)")
        
        // 移動量を計算
        let deltaX: CGFloat = CGFloat(location.x - startPoint!.x)
        let deltaY: CGFloat = CGFloat(location.y - startPoint!.y)
        //println("deltaX: \(deltaX), deltaY: \(deltaY)")
        
        println("\(self.view.frame.size.height - 49 - 45)")
        
        
        if modalV.frame.origin.y >= -64 &&  modalV.frame.origin.y <= self.view.frame.size.height - 49 - 44 {
            
            if nowPoint!.y + deltaY <= -64 {
                
                modalV.frame.origin.y = -64
            } else if nowPoint!.y + deltaY >= self.view.frame.size.height - 49 - 44 {
                
                modalV.frame.origin.y = self.view.frame.size.height - 49 - 44
            } else {
            
                modalV.frame.origin.y = nowPoint!.y + deltaY
            }
        }
    }
    
    func upModalView(duration: NSTimeInterval) {
        UIView.animateWithDuration(duration, animations: { () -> Void in
            
            self.modalV.frame.origin.y = -64
        })
    }
    
    func downModalView(duration: NSTimeInterval) {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            self.modalV.frame.origin.y = self.view.frame.size.height - 49 - 44
        })
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if modalV.frame.origin.y > self.view.frame.size.height / 2 {
            
            self.downModalView(0.3)
            self.setTabBarVisible(true, animated: true)
        } else {
            self.upModalView(0.3)
            self.setTabBarVisible(false, animated: true)
        }
    }
}

