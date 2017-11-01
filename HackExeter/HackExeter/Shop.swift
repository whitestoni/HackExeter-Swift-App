//
//  Shop.swift
//  HackExeter
//
//  Created by Aalap Patel on 4/15/17.
//  Copyright © 2017 Aalap Patel. All rights reserved.
//


import UIKit

class Shop: UIView {
    
    let width = Int(UIScreen.main.bounds.width)
    var descrip: String!
    var isComplete = false
    var price = UIButton()
    
    
    init(frame: CGRect, text: String, full: Bool) {
        descrip = text
        super.init(frame: frame)
        layer.borderWidth = 1
        layer.borderColor = ViewController.appColor.cgColor
        layer.cornerRadius = 5
        
       /*
        price.frame = CGRect(x: 230, y: frame.height/2-25, width: 100, height: 30)
        price.titleLabel?.text = "50"
         
        price.titleLabel?.textColor = UIColor.white
       
        price.addTarget(self, action: #selector(self.backPressed), for: .touchUpInside)
        price.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        self.addSubview(price)
        */
    
        price.setTitle("50", for: .normal)
        price.addTarget(self, action: #selector(self.buyPressed), for: .touchUpInside)
        price.backgroundColor = ViewController.appColor
        price.titleLabel?.font = UIFont(name:"Helvetica", size: 25)
        price.sizeToFit()
        price.frame = CGRect(x: 230, y: frame.height/2-5, width: 100, height: 30)

        price.layer.cornerRadius = price.frame.size.width/6
        price.clipsToBounds = true
        self.addSubview(price)

        
        makeLabel(label: UILabel(), text: descrip, rect: CGRect(x: 30, y: frame.height/2-75, width: frame.width-75, height: 100), font: UIFont(name: "HelveticaNeue-Thin", size: 19)!)
        

    }
    
    
    func updateXP(){
        
    }
   
   
    func buyPressed() {
        if (User.sharedUser.totalXP >= 50){
            User.sharedUser.totalXP -= 50
            updateXP()
        }
        else {
            let alertController = UIAlertController(title: "You don't have enough XP!", message: "Your time has been reset.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .default ) { action in print("canceled") }
            alertController.addAction(cancelAction)
            
          
        }
    }

    
    // Displays the title text of the tab in the center of the header
    func makeLabel(label: UILabel, text: String, rect: CGRect, font: UIFont) {
        label.frame = rect
        label.text = text
        label.font = font
        label.textColor = ViewController.appColor
        self.addSubview(label)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
