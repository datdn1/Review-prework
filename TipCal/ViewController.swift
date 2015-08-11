//
//  ViewController.swift
//  TipCal
//
//  Created by admin on 8/8/15.
//  Copyright (c) 2015 datdn1. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var tipSegment: UISegmentedControl!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountView: UIView!
    
    var userDefault = NSUserDefaults.standardUserDefaults()
    var tipValue = 10.0
    var tipValueArr = [0.1, 0.15, 0.18, 0.2]
    var isSaveWhenLauchAgain = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let billOffsetX = -view.bounds.width
        let tipOffsetY = view.bounds.height
        let amountOffsetY = view.bounds.height
        setInitializePositionViews(billOffsetX, withTipOffsetY: tipOffsetY, withAmountOffsetY: amountOffsetY)
        
        if let isLaunched: AnyObject = userDefault.objectForKey("isLaunched")
        {
            isSaveWhenLauchAgain = true
        }
        else
        {
            isSaveWhenLauchAgain = false
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        tipSegment.selectedSegmentIndex = userDefault.integerForKey("defaultTipKey")
        var billValue = 0.0
        var tipAmount = 0.0
        
        if !isSaveWhenLauchAgain
        {
            billValue = (billTextField.text as NSString).doubleValue
            tipAmount = billValue * tipValueArr[tipSegment.selectedSegmentIndex]
        }
        else
        {
            tipAmount = userDefault.doubleForKey("tipAmountValue")
            billValue = userDefault.doubleForKey("billValue")
            billTextField.text = String(format: "%.2f", billValue)
        }
        tipAmountLabel.text = String(format: "%.2f", tipAmount)
        amountLabel.text = String(format: "%.2f", billValue + tipAmount)
        if billValue > 0
        {
            animationWhenSettingBack(1.0, whenHasBill: true)
        }
        else
        {
            animationWhenSettingBack(1.0, whenHasBill: false)
        }
        isSaveWhenLauchAgain = false
        billTextField.becomeFirstResponder()
        super.viewWillAppear(animated)
    }
    
    @IBAction func tipChangeHandler(sender: UISegmentedControl)
    {
        println("\(sender.selectedSegmentIndex)")
        let indexOfTip = sender.selectedSegmentIndex
        var billAmount = (billTextField.text as NSString).doubleValue
        var tipAmount = billAmount * tipValueArr[indexOfTip]
        tipAmountLabel.text = String(format: "%.2f", tipAmount)
        amountLabel.text = String(format: "%.2f", billAmount + tipAmount)
        userDefault.setInteger(indexOfTip, forKey: "defaultTipKey")
        userDefault.synchronize()
    }
    
    
    @IBAction func billChangeHandler(sender: UITextField) {
        var billAmount = (billTextField.text as NSString).doubleValue
        if billAmount > 0
        {
            animationWhenEnterBill(1.0, whenBillValid: true)
        }
        else
        {
            animationWhenEnterBill(1.0, whenBillValid: false)
        }
        var tipAmount = billAmount * tipValueArr[tipSegment.selectedSegmentIndex]
        tipAmountLabel.text = String(format: "%.2f", tipAmount)
        amountLabel.text = String(format: "%.2f", billAmount + tipAmount)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hideKeyBoardHandler(sender: UITapGestureRecognizer) {
        self.billTextField.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var billTransform = CGAffineTransformMakeTranslation(-view.bounds.width, 0)
        billTextField.transform = billTransform
        amountView.transform = CGAffineTransformMakeTranslation(0, view.bounds.height)
        tipSegment.transform = CGAffineTransformMakeTranslation(0, view.bounds.height)
    }

    func updateView()
    {
        if !isSaveWhenLauchAgain{
        var lastAccsessTimeObject: AnyObject? = userDefault.objectForKey("lastAccess")
        if let isFirstLoad: AnyObject = lastAccsessTimeObject
        {
            var lastAccsessTime = lastAccsessTimeObject as NSDate
            var currentTime = NSDate()
            var differenceTime = currentTime.timeIntervalSinceDate(lastAccsessTime)
            if (differenceTime < 10)
            {
                // Get parameter from user default
                var tipAmountValue = userDefault.doubleForKey("tipAmountValue")
                var billValue = userDefault.doubleForKey("billValue")
                var amountValue = userDefault.doubleForKey("amountValue")
                var tipIndex = userDefault.integerForKey("defaultTipKey")
                
                setViews(billValue, withTipIndex: tipIndex, withTipAmount: tipAmountValue, withAmount: amountValue, hasReset: false)
                self.billTextField.transform = CGAffineTransformIdentity
                if billValue == 0
                {
                    animationWhenEnterBill(1.0, whenBillValid: false)
                }
                else
                {
                    animationWhenEnterBill(1.0, whenBillValid: true)
                }
            }
            else
            {
                // Reset views on UI
                setViews(0.0, withTipIndex: 0, withTipAmount: 0.0, withAmount: 0.0, hasReset: true)
                
                self.billTextField.transform = CGAffineTransformIdentity
                // Reset parameters in user default
                animationWhenEnterBill(1.0, whenBillValid: false)
            }
        }
    }
    }
    
    func setViews(billValue: Double, withTipIndex tipIndex:Int, withTipAmount tipAmount:Double, withAmount amount:Double, hasReset isReset:Bool) -> Void
    {
        if !isReset
        {
            billTextField.text = String(format: "%.2f", billValue)
            tipSegment.selectedSegmentIndex = tipIndex
            tipAmountLabel.text = String(format: "%.2f", tipAmount)
            amountLabel.text = String(format: "%.2f",  amount)

        }
        else
        {
            billTextField.text = ""
            tipSegment.selectedSegmentIndex = 0
            tipAmountLabel.text = ""
            amountLabel.text = ""
        }
    }
    
    func setInitializePositionViews(billOffsetX:CGFloat, withTipOffsetY tipOffsetY:CGFloat, withAmountOffsetY amountOffsetY:CGFloat) -> Void
    {
        var billTransform = CGAffineTransformMakeTranslation(billOffsetX, 0)
        var tipTransform = CGAffineTransformMakeTranslation(0, tipOffsetY)
        var amountTransform = CGAffineTransformMakeTranslation(0, amountOffsetY)
        
        billTextField.transform = billTransform
        amountView.transform = amountTransform
        tipSegment.transform = tipTransform
    }
    
    func animationWhenEnterBill(duration:NSTimeInterval, whenBillValid isValid:Bool) -> Void
    {
        if isValid
        {
            UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options:UIViewAnimationOptions.CurveEaseInOut, animations:
            {
                self.amountView.transform = CGAffineTransformIdentity
                self.tipSegment.transform = CGAffineTransformIdentity
            }, completion: nil)
        }
        else
        {
            UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options:UIViewAnimationOptions.CurveEaseInOut, animations:
            {
                let positionOffsetY = self.view.bounds.height
                self.amountView.transform = CGAffineTransformMakeTranslation(0, positionOffsetY)
                self.tipSegment.transform = CGAffineTransformMakeTranslation(0, positionOffsetY)
            }, completion: nil)

        }
    }
    func animationWhenSettingBack(duration:NSTimeInterval, whenHasBill hasBill:Bool)
    {
        self.billTextField.transform = CGAffineTransformIdentity
            UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options:
                UIViewAnimationOptions.CurveEaseInOut, animations:
            {
                    if hasBill{
                    self.amountView.transform = CGAffineTransformIdentity
                    self.tipSegment.transform = CGAffineTransformIdentity
                }
            }, completion: nil)
    }
}

