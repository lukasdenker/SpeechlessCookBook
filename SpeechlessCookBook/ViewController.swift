//
//  ViewController.swift
//  SpeechlessCookBook
//
//  Created by Lukas on 17.06.15.
//  Copyright (c) 2015 Lukas. All rights reserved.
//




/* TODO:

- create navigation-Component with properties of recipe which will be updated if contentOffset changes to recipeView
- overView/tableOfContents as overlay -> not at position 0
- new button for incredients description -> navigation



was steht hier HALLOOOOOO

*/



import UIKit
import CoreMotion



enum RecipeType {
    case mainDish
    case dessert
}


enum AnimationDirection {
    case SameDirection
    case OppositeDirection
}



let NAVIGATION_WIDTH = 44
let APP_HEIGHT = 768
let APP_WIDTH = 1024

let baseX:CGFloat = 400


class ViewController: UIViewController, UIScrollViewDelegate {
    
    var contentScrollView:UIScrollView!
    var navigation:UIView!
    var mainMenuButton:UIButton!
    var recipeMetaDataView:UIImageView!
    var switchButton:UIButton!
    
    let motionQueue = NSOperationQueue()
    let motionManager = CMMotionManager()
    
    var animationObject:UIView!

    
//    var burger:LDReciptViewController!
    
    var recipesArray:[LDRecipe] = []
    var motherChildViews:[UIView] = []
    var contentViewController:[UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initContentScrollView()
        fillContentScrollView()
        createNavigationView()


        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        

        motionManager.deviceMotionUpdateInterval = 0.05
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {
            motion,error in
            
            if error != nil {
                println("Error: \(error.localizedDescription)")
                return
            }
//            if (self.testView != nil) {
            if self.animationObject != nil {
                let grav = motion.gravity
                
                let x = CGFloat(grav.x)
                let y = CGFloat(grav.y)
                var p = CGPoint(x: x, y: y)
                
                var orientation = UIApplication.sharedApplication().statusBarOrientation
                
                switch orientation {
                case .LandscapeLeft:
                    var t = p.x
                    p.x = 0 - p.y
                    p.y = t
                case .LandscapeRight:
                    var t = p.x
                    p.x = p.y
                    p.y = 0 - t
                case .PortraitUpsideDown:
                    p.x *= -1
                    p.x *= -1
                default: break
                }


                // tolerance movement
                if abs(y) > 0.005 {
                    self.updateRecipeView(y)
//                    println(self.animationObject)

                }
                
                
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    private func updateRecipeView(y:CGFloat) {
    
        var cnt:Int = 0

        for subview in animationObject.subviews {
            
            if let imageview = subview as? UIImageView {
                let delta:CGFloat = CGFloat(y * (CGFloat(cnt*10 + 70)))
                imageview.frame = CGRect(origin: CGPoint(x: delta, y: 0), size: imageview.frame.size)
                
                 cnt++
            }
            
            
            println("\(cnt) : \(subview)")
//            subview.frame = CGRect(x: baseX + delta, y: animationObject.frame.origin.y, width: animationObject.frame.size.width, height: animationObject.frame.size.height)
            
           
            
        }
        
//        let newX = 400 + CGFloat(y*70)
//        self.animationObject.frame = CGRect(x: newX, y: self.animationObject.frame.origin.y, width: self.animationObject.frame.size.width, height: self.animationObject.frame.size.height)
        
//        
//        UIView.animateWithDuration(0.1, animations: { () -> Void in
//        
//            self.animationObject.frame = CGRect(x: newX, y: self.animationObject.frame.origin.y, width: self.animationObject.frame.size.width, height: self.animationObject.frame.size.height)
//            
//        }) { (done) -> Void in
////            UIView.animateWithDuration(0.1, animations: { () -> Void in
////                self.animationObject.frame = CGRect(x: CGFloat(400), y: self.animationObject.frame.origin.y, width: self.animationObject.frame.size.width, height: self.animationObject.frame.size.height)
////            })
//        }
        
        



    }
    


    
    // MARK: - contentScrollView
    
    private func initContentScrollView() {
        contentScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: APP_WIDTH, height: APP_HEIGHT))
        contentScrollView.backgroundColor = UIColor.whiteColor()
        contentScrollView.pagingEnabled = true
        contentScrollView.delegate = self
        self.view.addSubview(contentScrollView)
    
    }
    
    private func createContentViews() {
        
        let overViewViewController = LDIntermediateImageViewController()
        overViewViewController.backgroundImage = UIImage(named: "overView.jpg")
        contentViewController.append(overViewViewController)
        
        
        let woman1ViewController = LDIntermediateImageViewController()
        woman1ViewController.backgroundImage = UIImage(named: "frau_01.jpg")
        contentViewController.append(woman1ViewController)
        
        let woman2ViewController = LDIntermediateImageViewController()
        woman2ViewController.backgroundImage = UIImage(named: "frau_02.jpg")
        contentViewController.append(woman2ViewController)
        
        let burger = LDReciptViewController()
        var animationElements: [UIImage]!
        let elements = ["brotunten2","salat2","salatpiece2","patty2","tomate2","brotoben2"]
        burger.recipe = LDRecipe(name: "burger", icon: UIImage(named: "burgerIcon")!, recipeType: .mainDish, duration: 60, difficulty: 4, incredientImage:UIImage(named: "Iconslist.png")!, preparationImage:UIImage(named: "Icons.png")!, arrayWithAnimationElements:elements)
        contentViewController.append(burger)
        
    }
    
    
    private func fillContentScrollView () {
        
        createContentViews()

        for var i = 0; i < contentViewController.count; i++ {
        
            contentViewController[i].view.frame = CGRect(x: i * APP_WIDTH, y: 0, width: APP_WIDTH, height: APP_HEIGHT)
            contentScrollView.addSubview(contentViewController[i].view)
            
        }
        
        contentScrollView.contentSize = CGSize(width: contentViewController.count * APP_WIDTH, height: APP_HEIGHT)
        
        
        
    
    }
    
    
    // MARK: - Navigation
    
    private func createNavigationView() {

        navigation = UIView(frame: CGRect(x: 0, y: 54, width: 44, height: 7*44))
//        navigation.backgroundColor = UIColor.orangeColor()
        
        mainMenuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 52))
        mainMenuButton.setImage(UIImage(named: "menu"), forState: .Normal)
        mainMenuButton.addTarget(self, action: Selector("mainMenuAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        navigation.addSubview(mainMenuButton)
        
        recipeMetaDataView = UIImageView(image: UIImage(named: "meta.png"))
        recipeMetaDataView.alpha = 0
        recipeMetaDataView.frame = CGRect(x: 0, y: 2*44, width: recipeMetaDataView.frame.size.width, height: recipeMetaDataView.frame.size.height)
        navigation.addSubview(recipeMetaDataView)
        
        switchButton = UIButton(frame: CGRect(x: 0, y: 6*44 - 4, width: 44, height: 52))
        switchButton.setImage(UIImage(named: "change"), forState: .Normal)
        switchButton.addTarget(self, action: Selector("switchAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        switchButton.alpha = 0
        navigation.addSubview(switchButton)
        
        self.view.addSubview(navigation)
    
    }
    
    
    @objc private func mainMenuAction(button:UIButton) {
        
        contentScrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: APP_WIDTH, height: APP_HEIGHT), animated: true)
    
    }
    
    @objc private func switchAction(button:UIButton) {
//        burger.showPreparation()

        if contentViewController[button.tag].isKindOfClass(LDReciptViewController) {
        
            let recipeVC = contentViewController[button.tag] as LDReciptViewController
            recipeVC.showPreparation()
        }
        
        
        
    }
    
    
    private func updateNavigation(contentOffsetX:Int) {
    
        
        if contentOffsetX == 0 {
        
            recipeMetaDataView.alpha = 0
            switchButton.alpha = 0
        }
        else {
        
            let index = contentOffsetX / APP_WIDTH
//            println("index:\(index)")
            if contentViewController[index].isKindOfClass(LDReciptViewController) {
                
                let recipeVC = contentViewController[index] as LDReciptViewController
                
                if animationObject != nil {
                    animationObject.removeFromSuperview()
                    animationObject = recipeVC.animationView
//                    contentScrollView.addSubview(animationObject)
                    self.view.addSubview(animationObject)
                }
                else {
                    animationObject = recipeVC.animationView
                    self.view.addSubview(animationObject)
//                    contentScrollView.addSubview(animationObject)
                }
                
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.recipeMetaDataView.alpha = 1
                    self.switchButton.alpha = 1
                    self.switchButton.tag = index
                })

                
            }
            else {
                
                if animationObject != nil {
                    animationObject.removeFromSuperview()
                    animationObject = nil
                }
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.recipeMetaDataView.alpha = 0
                    self.switchButton.alpha = 0
                })
            }
            
        }
    
    }

    
    // MARK: - delegate
    
    // scrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
    
//        println(scrollView.contentOffset.x)
        updateNavigation(Int(scrollView.contentOffset.x))
        
    }

    
}

