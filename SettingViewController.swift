//
//  SettingViewController.swift
//  TipCal
//
//  Created by admin on 8/10/15.
//  Copyright (c) 2015 datdn1. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var tenTipButton: UIButton!
    
    @IBOutlet weak var fifteenTipButton: UIButton!
    
    @IBOutlet weak var eighteenTipButton: UIButton!
    
    @IBOutlet weak var tweltyTipButton: UIButton!
    
    var userDefault = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting transform and alpha property of ten tip button
        var tenTipTransform = CGAffineTransformMakeTranslation(-view.bounds.width, 0)
        tenTipButton.layer.cornerRadius = tenTipButton.frame.size.width / 2.0
        tenTipButton.clipsToBounds = true
        tenTipButton.transform = tenTipTransform
        tenTipButton.alpha = 0.0
        
        // Setting transform and alpha property of fifteen tip button
        var fifteenTipTransform = CGAffineTransformMakeTranslation(view.bounds.width, 0)
        fifteenTipButton.layer.cornerRadius = tenTipButton.frame.size.width / 2.0
        fifteenTipButton.clipsToBounds = true
        fifteenTipButton.transform = fifteenTipTransform
        fifteenTipButton.alpha = 0.0
        
        // Setting transform and alpha property of eight tip button
        var eightTipTransform = CGAffineTransformMakeTranslation(-view.bounds.width, 0)
        eighteenTipButton.layer.cornerRadius = tenTipButton.frame.size.width / 2.0
        eighteenTipButton.clipsToBounds = true
        eighteenTipButton.transform = eightTipTransform
        eighteenTipButton.alpha = 0.0
        
        // Setting transform and alpha property of ten tip button
        var tweltyTipTransform = CGAffineTransformMakeTranslation(view.bounds.width, 0)
        tweltyTipButton.layer.cornerRadius = tenTipButton.frame.size.width / 2.0
        tweltyTipButton.clipsToBounds = true
        tweltyTipButton.transform = tweltyTipTransform
        tweltyTipButton.alpha = 0.0
        
        // setting animation
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations:
            {
                // animation for ten tip button
                self.tenTipButton.alpha = 1.0
                self.tenTipButton.transform = CGAffineTransformIdentity
                
                // animation for fifteen tip button
                self.fifteenTipButton.alpha = 1.0
                self.fifteenTipButton.transform = CGAffineTransformIdentity
                
                // animation for eight tip button
                self.eighteenTipButton.alpha = 1.0
                self.eighteenTipButton.transform = CGAffineTransformIdentity
                
                // animation for tweltty tip button
                self.tweltyTipButton.alpha = 1.0
                self.tweltyTipButton.transform = CGAffineTransformIdentity
            }, completion:
            {
                finished in
                //set default tip
                var tipDefault = self.userDefault.integerForKey("defaultTipKey")
                
                // get view
                for view in self.view.subviews
                {
                    if let tipButton = view as? UIButton
                    {
                        if tipButton.tag == tipDefault
                        {
                            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut | UIViewAnimationOptions.Repeat, animations:
                                {
                                    tipButton.alpha = 0.6
                                }, completion: nil)
                        }
                    }
                }
        })
    }
    
    @IBAction func selectedTipHandler(sender: UIButton){
        
        // finish all animation
        tenTipButton.layer.removeAllAnimations()
        tenTipButton.alpha = 1.0
        fifteenTipButton.layer.removeAllAnimations()
        fifteenTipButton.alpha = 1.0
        eighteenTipButton.layer.removeAllAnimations()
        eighteenTipButton.alpha = 1.0
        tweltyTipButton.layer.removeAllAnimations()
        tweltyTipButton.alpha = 1.0
        
        //var userDefault = NSUserDefaults.standardUserDefaults()
        
        switch (sender.tag){
        case 0:
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut | UIViewAnimationOptions.Repeat, animations:
                {
                    self.tenTipButton.alpha = 0.6
                }, completion: nil)
            userDefault.setInteger(0, forKey: "defaultTipKey")
            userDefault.synchronize()
        case 1:
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut | UIViewAnimationOptions.Repeat, animations:
                {
                    self.fifteenTipButton.alpha = 0.6
                }, completion: nil)
            userDefault.setInteger(1, forKey: "defaultTipKey")
            userDefault.synchronize()
        case 2:
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut | UIViewAnimationOptions.Repeat, animations:
                {
                    self.eighteenTipButton.alpha = 0.6
                }, completion: nil)
            userDefault.setInteger(2, forKey: "defaultTipKey")
            userDefault.synchronize()
        case 3:
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut | UIViewAnimationOptions.Repeat, animations:
                {
                    self.tweltyTipButton.alpha = 0.6
                }, completion: nil)
            userDefault.setInteger(3, forKey: "defaultTipKey")
            userDefault.synchronize()
        default:
            println("Invalid!!!")
        }
    }
}
