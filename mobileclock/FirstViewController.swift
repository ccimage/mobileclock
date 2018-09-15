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
        changeImageSize(fromPortrait: false);
        doTimer();
        
        swipeRec1.direction = UISwipeGestureRecognizerDirection.down;
        swipeRec2.direction = UISwipeGestureRecognizerDirection.up;
        tapRec.addTarget(self, action: #selector(FirstViewController.tappedView));
        swipeRec1.addTarget(self, action: Selector(("swipeViewDown:")));
        swipeRec2.addTarget(self, action: Selector(("swipeViewUp:")));
        mainView.addGestureRecognizer(tapRec);
        mainView.addGestureRecognizer(swipeRec1);
        mainView.addGestureRecognizer(swipeRec2);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        setTabBarVisible(visible: !tabBarIsVisible(), animated: true)

        pointImageView.image = UIImage(named: String(format: "%@_number_11.png", theme));
    }

    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        let fromPortrait:Bool = (fromInterfaceOrientation == UIInterfaceOrientation.portrait) || (fromInterfaceOrientation == UIInterfaceOrientation.portraitUpsideDown);
        changeImageSize(fromPortrait: fromPortrait);
    }
    
    func changeImageSize(fromPortrait:Bool){
        let screenBounds:CGRect = UIScreen.main.bounds;
        let width = screenBounds.size.width;
        var height = screenBounds.size.height;
        var eachWidth = width / 5;
        if(fromPortrait && width < height){
            eachWidth = height / 5;
            height = width;
        }

        hourImageView1.frame = CGRect(origin:CGPoint(x:0, y:0), size:CGSize(width:eachWidth, height:height));
        hourImageView2.frame = CGRect(origin:CGPoint(x:eachWidth, y:0), size:CGSize(width:eachWidth, height:height));
        pointImageView.frame = CGRect(origin:CGPoint(x:eachWidth * 2, y:0), size:CGSize(width:eachWidth, height:height));
        minuteImageView1.frame = CGRect(origin:CGPoint(x:eachWidth * 3, y:0), size:CGSize(width:eachWidth, height:height));
        minuteImageView2.frame = CGRect(origin:CGPoint(x:eachWidth * 4, y:0), size:CGSize(width:eachWidth, height:height));
        
    }
    func doTimer(){
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFireMethod), userInfo: nil, repeats:true);
        timer.fire()
    }
    func timerFireMethod(timer: Timer) {
        let now = NSDate();
        
        let cal = NSCalendar(calendarIdentifier: NSCalendar.Identifier.chinese);
        
        let datecomp1:NSDateComponents = cal!.components(NSCalendar.Unit.hour, from: now as Date) as NSDateComponents;
        let datecomp2:NSDateComponents = cal!.components(NSCalendar.Unit.minute, from: now as Date) as NSDateComponents;
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
        
        pointImageView.isHidden = !pointImageView.isHidden;

    }
    func setTabBarVisible(visible:Bool, animated:Bool) {
        if (tabBarIsVisible() == visible) { return }
        let frame = self.tabBarController?.tabBar.frame;
        let offsetY : CGFloat = (visible ? -49.0 : 49.0);
        
        let duration:TimeInterval = (animated ? 0.3 : 0.0);
        if frame != nil {
            UIView.animate(withDuration: duration) {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY)
                return
            }
        }
    }
    func tabBarIsVisible() -> Bool{
        let y1: CGFloat = (self.tabBarController?.tabBar.frame.origin.y)!;
        let y2: CGFloat = self.view.frame.maxY;
        return y1 < y2;
    }
    func tappedView(){
        setTabBarVisible(visible: !tabBarIsVisible(), animated: true)
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

