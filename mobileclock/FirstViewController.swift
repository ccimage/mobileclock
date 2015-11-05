//
//  FirstViewController.swift
//  mobileclock
//
//  Created by chuan on 10/28/15.
//  Copyright © 2015 ccimage. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var hourImageView1: UIImageView!
    @IBOutlet weak var hourImageView2: UIImageView!
    @IBOutlet weak var minuteImageView1: UIImageView!
    @IBOutlet weak var minuteImageView2: UIImageView!
    @IBOutlet weak var pointImageView: UIImageView!
    @IBOutlet weak var mainView: UIView!;
    @IBOutlet weak var maskView : UIView!;
    
    let tapRec = UITapGestureRecognizer();
    let swipeRec1 = UISwipeGestureRecognizer();
    let swipeRec2 = UISwipeGestureRecognizer();
    let theme:String = "digital";
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        changeImageSize(false);
        doTimer();
        
        swipeRec1.direction = UISwipeGestureRecognizerDirection.Down;
        swipeRec2.direction = UISwipeGestureRecognizerDirection.Up;
        tapRec.addTarget(self, action: "tappedView");
        swipeRec1.addTarget(self, action: "swipeViewDown:");
        swipeRec2.addTarget(self, action: "swipeViewUp:");
        mainView.addGestureRecognizer(tapRec);
        mainView.addGestureRecognizer(swipeRec1);
        mainView.addGestureRecognizer(swipeRec2);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        setTabBarVisible(!tabBarIsVisible(), animated: true)

        pointImageView.image = UIImage(named: String(format: "%@_number_11.png", theme));
    }

    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        let fromPortrait:Bool = (fromInterfaceOrientation == UIInterfaceOrientation.Portrait) || (fromInterfaceOrientation == UIInterfaceOrientation.PortraitUpsideDown);
        changeImageSize(fromPortrait);
    }
    
    func changeImageSize(fromPortrait:Bool){
        let screenBounds:CGRect = UIScreen.mainScreen().bounds;
        let width = screenBounds.size.width;
        var height = screenBounds.size.height;
        var eachWidth = width / 5;
        if(fromPortrait && width < height){
            eachWidth = height / 5;
            height = width;
        }

        hourImageView1.frame = CGRectMake(0, 0, eachWidth, height);
        hourImageView2.frame = CGRectMake(eachWidth, 0, eachWidth, height);
        pointImageView.frame = CGRectMake(eachWidth * 2, 0, eachWidth, height);
        minuteImageView1.frame = CGRectMake(eachWidth * 3, 0, eachWidth, height);
        minuteImageView2.frame = CGRectMake(eachWidth * 4, 0, eachWidth, height);
        
    }
    func doTimer(){
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerFireMethod:", userInfo: nil, repeats:true);
        timer.fire()
    }
    func timerFireMethod(timer: NSTimer) {
        let now = NSDate();
        
        let cal = NSCalendar(calendarIdentifier: NSChineseCalendar);
        
        let datecomp1:NSDateComponents = cal!.components(NSCalendarUnit.Hour, fromDate: now);
        let datecomp2:NSDateComponents = cal!.components(NSCalendarUnit.Minute, fromDate: now);
        let hour = datecomp1.hour;
        let minute = datecomp2.minute;
        let a:Int = hour/10;
        let b:Int = hour % 10;
        let c:Int = minute/10;
        let d:Int = minute % 10;
        
        hourImageView1.image = UIImage(named: String(format: "%@_number_0%d.png", theme,a));
        hourImageView2.image = UIImage(named: String(format: "%@_number_0%d.png", theme,b));
        minuteImageView1.image = UIImage(named: String(format: "%@_number_0%d.png", theme,c));
        minuteImageView2.image = UIImage(named: String(format: "%@_number_0%d.png", theme,d));
        
        pointImageView.hidden = !pointImageView.hidden;

    }
    func setTabBarVisible(visible:Bool, animated:Bool) {
        if (tabBarIsVisible() == visible) { return }
        let frame = self.tabBarController?.tabBar.frame;
        let offsetY : CGFloat = (visible ? -49.0 : 49.0);
        
        let duration:NSTimeInterval = (animated ? 0.3 : 0.0);
        if frame != nil {
            UIView.animateWithDuration(duration) {
                self.tabBarController?.tabBar.frame = CGRectOffset(frame!, 0, offsetY)
                return
            }
        }
    }
    func tabBarIsVisible() -> Bool{
        let y1 = self.tabBarController?.tabBar.frame.origin.y;
        let y2 = CGRectGetMaxY(self.view.frame);
        return y1 < y2;
    }
    func tappedView(){
        setTabBarVisible(!tabBarIsVisible(), animated: true)
    }
    
    func swipeViewDown(sender:UISwipeGestureRecognizer){
        maskView.alpha+=0.1;
        if(maskView.alpha>=0.8){
            maskView.alpha = 0.8;
        }
    }
    func swipeViewUp(sender:UISwipeGestureRecognizer){
        maskView.alpha-=0.1;
        if(maskView.alpha<=0){
            maskView.alpha = 0;

        }
    }

    
}

