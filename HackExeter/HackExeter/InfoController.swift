//
//  InfoController.swift
//  HackExeter
//
//  Created by Aalap Patel on 4/15/17.
//  Copyright © 2017 Aalap Patel. All rights reserved.
//

import UIKit

class InfoController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = Int(UIScreen.main.bounds.width)
        let height = Int(UIScreen.main.bounds.height)
        let top = 0
        
        
        func makeLabel(label: UILabel, text: String, rect: CGRect, font: UIFont) {
            label.frame = rect
            label.text = text
            label.font = font
            label.textColor = UIColor.black
            label.textAlignment = NSTextAlignment.center
            self.view.addSubview(label)
        }
        
        makeLabel(label: UILabel(), text: "Information", rect: CGRect(x: width/2-150, y: 50, width: 300, height: 50), font: UIFont(name: "HelveticaNeue-Thin", size: 35)!)
        
        let purpose = UITextView(frame: CGRect(x: 0 , y: top + (height/6), width: width, height: height))
        purpose.isUserInteractionEnabled = false
        purpose.text = "The purpose of this app is to help you stay off your phone. Phone usage is taking over our lives, so it is important to limit it. By using this app, hopefully you are able to live in the present and make your day more productive! \n\nTo use the app:\n 1. Press the start button \n 2. Lock your phone\n3. Stay focused\n You will accumulate experience points until you stop the timer. If you start the timer and exit the app, the timer will be reset."
        purpose.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        purpose.textAlignment = .center
        
        self.view.addSubview(purpose)
        
        let creators = UILabel(frame:CGRect(x:0, y: height - 125, width: width, height: 50))
        creators.text = "Creators"
        creators.font = UIFont(name: "HelveticaNeue-Thin", size: 35)
        creators.textAlignment = .center
        self.view.addSubview(creators)
        
        let name1 = UILabel(frame: CGRect(x:0, y: height - 70, width: width, height: 30))
        name1.text = "Aalap Patel, Johan Sajan"
        name1.font = UIFont(name: "HelveticaNeue-Thin", size: 20)
        name1.textAlignment = .center
        self.view.addSubview(name1)
        
        
        makeButton(fileName: "Back.png", frame: CGRect(x: 13, y: 50, width: 50, height: 50), selector: #selector(self.backPressed))
    }
    
    func backPressed() {
        self.performSegue(withIdentifier: "infoToMain", sender: self)
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
}
