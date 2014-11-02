//
//  MainViewController.swift
//  NEWSATHacker
//
//  Created by Kedan Li on 14/10/25.
//  Copyright (c) 2014年 Kedan Li. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet var main : UIView!
    
    @IBOutlet var menuTable : UIView!

    
    @IBOutlet var satHacker : UILabel!
    @IBOutlet var menu : UIButton!
    
    @IBOutlet var triangle : UIImageView!
    @IBOutlet var choose : UIView!
    @IBOutlet var news: UIView!

    @IBOutlet var scroller : UIScrollView!
    
    @IBOutlet var returnToCenter : UIButton!

    
    var isToTop = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroller.contentSize = CGSizeMake(320, 750)
        scroller.showsVerticalScrollIndicator = false
        
        menu.addTarget(self, action: "showMenu:", forControlEvents: UIControlEvents.TouchUpInside)

        
        var shadowPath = UIBezierPath(rect: main.bounds)
        main.layer.masksToBounds = false;
        main.layer.shadowColor = UIColor.whiteColor().CGColor
        main.layer.shadowOffset = CGSizeMake(3.0, 0.0);
        main.layer.shadowOpacity = 0.5;
        main.layer.shadowPath = shadowPath.CGPath;
        
        //Do any additional setup after loading the view.
        //self.view.backgroundColor = UIColor(red: 240.0/255, green: 242.0/255, blue: 245.0/255, alpha: 1)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 0{
            choose.frame = CGRectMake(scrollView.contentOffset.y, scrollView.contentOffset.y, choose.frame.width, choose.frame.height)
        }else{
            choose.frame = CGRectMake(0, 0, choose.frame.width, choose.frame.height)
        }
        choose.alpha = 1 - scrollView.contentOffset.y / 200
        
        if choose.alpha < 0.9{
            choose.userInteractionEnabled = false
        }else{
            choose.userInteractionEnabled = true
        }
    }
   
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        scrollToTop()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            autoScroll()
        }
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        autoScroll()
    }
    
    func autoScroll(){
        if scroller.contentOffset.y > 150{
            self.scrollToBottom()
        }else{
            self.scrollToTop()
        }
    }
    
    func scrollToTop(){
        scroller.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    func scrollToBottom(){
        scroller.setContentOffset(CGPointMake(0, scroller.contentSize.height - scroller.frame.height), animated: true)
    }
    
    @IBAction func showMenu(sender: AnyObject){
        
        toRight()
        
        self.returnToCenter = UIButton(frame: CGRectMake(0, 0, 320, 568))
        self.returnToCenter.addTarget(self, action: "toMiddle", forControlEvents: UIControlEvents.TouchUpInside)
        self.main.addSubview(returnToCenter)
        
        var gestureReco = UIPanGestureRecognizer(target: self, action: "dragged:")
        self.returnToCenter.addGestureRecognizer(gestureReco)
    }
    
    @IBAction func dragged(recognizer : UIPanGestureRecognizer) {
        
        let translation = recognizer.translationInView(self.view)
        
        println(translation)
        
        if translation.x > 0 && translation.x < 200{
            self.main.frame = CGRectMake(-self.main.frame.width + 120 + translation.x, 0, self.main.frame.width, self.main.frame.height)
            self.menuTable.frame = CGRectMake(-self.main.frame.width + 120 + translation.x, self.menuTable.frame.origin.y, self.menuTable.frame.width, self.menuTable.frame.height)
            self.menu.transform = CGAffineTransformMakeRotation(3.14/2 - (3.14/2) * translation.x / 200)        }
        if recognizer.state == UIGestureRecognizerState.Cancelled || recognizer.state == UIGestureRecognizerState.Failed || recognizer.state == UIGestureRecognizerState.Ended{
            
            toMiddle()
        }
    }
    
    func toMiddle(){
        
        self.returnToCenter.removeFromSuperview()
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            
            self.main.frame = CGRectMake(0, 0, self.main.frame.width, self.main.frame.height)
            self.menuTable.frame = CGRectMake(0, self.menuTable.frame.origin.y, self.menuTable.frame.width, self.menuTable.frame.height)
            self.menu.transform = CGAffineTransformMakeRotation(0)

            }
            , completion: {
                (value: Bool) in
        })
    }
    func toRight(){
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            
            self.main.frame = CGRectMake(-self.main.frame.width + 120, 0, self.main.frame.width, self.main.frame.height)
            self.menuTable.frame = CGRectMake(-self.main.frame.width + 120, self.menuTable.frame.origin.y, self.menuTable.frame.width, self.menuTable.frame.height)
            self.menu.transform = CGAffineTransformMakeRotation(3.14/2)
            
            }
            , completion: {
                (value: Bool) in
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
