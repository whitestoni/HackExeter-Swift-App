//
//  ShopController.swift
//  HackExeter
//
//  Created by Aalap Patel on 4/15/17.
//  Copyright © 2017 Aalap Patel. All rights reserved.
//

import UIKit
class ShopController: UIViewController, UIScrollViewDelegate {

    let width = Int(UIScreen.main.bounds.width)
    let height = Int(UIScreen.main.bounds.height)
    var scrollView: UIScrollView!
    var containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    makeLabel(label: UILabel(), text: "Shop", rect: CGRect(x: width/2-150, y: 50, width: 300, height: 50), font: UIFont(name: "HelveticaNeue-Thin", size: 35)!)
    
    makeButton(fileName: "Back.png", frame: CGRect(x: 13, y: 50, width: 50, height: 50), selector: #selector(self.backPressed))
        
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: self.width, height: 4*140)
        containerView = UIView()
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
       
        
        let prizes = ["Gray background color",
                            "Green background color",
                            "Light blue background color"
                           
                            ]

        
        for i in 0..<prizes.count {
            var completed = false
            if User.sharedUser.completedAchievements.contains(i) {
                completed = true
            }
            containerView.addSubview(Shop(frame: CGRect(x: 15, y: i*140, width: width-30, height: 130), text: prizes[i], full: completed))
        }
        
        
        
        makeLabel(label: UILabel(), text: "\(User.sharedUser.totalXP) XP", rect: CGRect(x: width/2-50, y: 100, width: 100, height: 40), font: UIFont(name:"HelveticaNeue-Thin", size: 25)!)
        
        
        
    }
    
    
    
    // Displays the title text of the tab in the center of the header
    func makeLabel(label: UILabel, text: String, rect: CGRect, font: UIFont) {
        label.frame = rect
        label.text = text
        label.font = font
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
    }
    
    // Loads and places a button icon on a specified part of the header
    func makeButton(fileName: String, frame: CGRect, selector: Selector) {
        let image = UIImage(named: fileName)?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: UIButtonType.custom)
        button.frame = frame
        button.setImage(image, for: .normal)
        button.tintColor = ViewController.appColor
        button.addTarget(self, action: selector, for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func buyPressed() {
        if (User.sharedUser.totalXP >= 50){
            User.sharedUser.totalXP -= 50
        }
        else {
            let alertController = UIAlertController(title: "Purchase Failed", message: "You don't have enough XP!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .default ) { action in print("canceled") }
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true) {}
        }
    }

    func backPressed() {
        self.performSegue(withIdentifier: "shopToMain", sender: self)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(x: 0, y: 150, width: self.width, height: self.height-150)
        containerView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
    }

    
    
    

}
