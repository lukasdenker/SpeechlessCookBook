//
//  LDRecipe.swift
//  SpeechlessCookBook
//
//  Created by Lukas on 20.06.15.
//  Copyright (c) 2015 Lukas. All rights reserved.
//

import UIKit

class LDRecipe: NSObject {
    
    var name:String!
    var icon:UIImage!
    var recipeType:RecipeType!
    var duration:Int!
    var difficulty:Int!
    var incredientImage:UIImage!
    var preparationImage:UIImage!
    var arrayWithAnimationElements:[String]!
    
    init(name:String, icon:UIImage, recipeType:RecipeType, duration:Int, difficulty:Int,incredientImage:UIImage, preparationImage:UIImage, arrayWithAnimationElements:[String]) {

        super.init()

        self.name = name
        self.icon = icon
        self.recipeType = recipeType
        self.duration = duration
        self.difficulty = difficulty
        self.incredientImage = incredientImage
        self.preparationImage = preparationImage
        self.arrayWithAnimationElements = arrayWithAnimationElements
    
    }
    
    
   
}
