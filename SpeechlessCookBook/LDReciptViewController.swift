//
//  LDReciptViewController.swift
//  SpeechlessCookBook
//
//  Created by Lukas on 20.06.15.
//  Copyright (c) 2015 Lukas. All rights reserved.
//

import UIKit

class LDReciptViewController: UIViewController {
    
    var recipe:LDRecipe!
    var animationView:UIView!
    
    private var preparationImageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        createView()

        preparationImageView.alpha = 0

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func createView () {
        
        
        /* TODO:

        implement burger animation with sensor data

        */
        createAnimationImage()
        
        
        // incredients
        let incredientsImageView = UIImageView(image: recipe.incredientImage)
        self.view.addSubview(incredientsImageView)
        
        // preparation
        preparationImageView = UIImageView(image: recipe.preparationImage)
        self.view.addSubview(preparationImageView)
    
    }
    
    func showPreparation() {
        if preparationImageView.alpha == 0 {
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.preparationImageView.alpha = 1
            })

        }
        else {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.preparationImageView.alpha = 0
            })

        }
    }
    
    private func createAnimationImage() {
    
    animationView = UIView(frame: CGRect(x: 400, y: 50, width: 600, height: 400))
        
        for string in recipe.arrayWithAnimationElements {
        
            let imageView = UIImageView(image: UIImage(named: string))
            imageView.frame = CGRect(x: 0, y: 0, width: 600, height: 400)
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
//            imageView.backgroundColor = UIColor.redColor()
            animationView.addSubview(imageView)
        
        }
//        self.view.addSubview(animationView)
    
    }



}
