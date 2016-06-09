//
//  AppDelegate.swift
//  TwitterBirdAnimation
//
//  Created by Bin on 16/6/9.
//  Copyright © 2016年 chenbin. All rights reserved.
//

import UIKit
import QuartzCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mask: CALayer?
    var animationView: UIView?
    
//    var imageView: UIImageView?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let backgroundView = UIView(frame: self.window!.frame)
        backgroundView.backgroundColor = UIColor.blackColor()
        self.window!.addSubview(backgroundView)
        
        let animationView = UIView(frame: backgroundView.frame)
        animationView.backgroundColor = UIColor.redColor()
        backgroundView.addSubview(animationView)
        
        self.mask = CALayer()
        self.mask!.contents = UIImage(named: "twitter logo mask")!.CGImage
        self.mask!.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.mask!.position = CGPoint(x: animationView.frame.size.width / 2, y: animationView.frame.size.height / 2)
        animationView.layer.mask = mask
        self.animationView = animationView
        
        animateMask()
        
        let vc: ViewController?
        vc = ViewController()
        window?.rootViewController = vc
        
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        UIApplication.sharedApplication().statusBarHidden = true
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private func animateMask() { // 关键帧动画
        
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 1
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 1 // 延时1秒
        
        let initalBounds = NSValue(CGRect: mask!.bounds)
        let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 90, height: 90))
        let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 1500, height: 1500))
        
        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut), CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)]
        self.mask!.addAnimation(keyFrameAnimation, forKey: "bounds")

    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
//        self.animationView!.layer.mask = nil // remove mask
//        self.animationView?.removeFromSuperview()
        
        UIView.animateWithDuration(1, animations: { 
            self.animationView!.alpha = 0.0
            }) { (true) in
                self.animationView!.layer.mask = nil // remove mask
                self.animationView?.removeFromSuperview()
        }
    }

}






