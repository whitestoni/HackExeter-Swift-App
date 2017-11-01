//
//  ViewController.swift
//  HackExeter
//
//  Created by Aalap Patel on 4/15/17.
//  Copyright © 2017 Aalap Patel. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    let width = Int(UIScreen.main.bounds.width) //declares a variable to the width of the screen
    let height = Int(UIScreen.main.bounds.height) //declares a variable for the height of the screen
    let center = Int(UIScreen.main.bounds.height/2) //declares a variable for the center of the y axis
    var imageView = UIImageView(image: UIImage(named: "bunny.jpg")) //set up the image view for the avatar
    let levelLabel = UILabel()
    var xpBar = UIView()
    var xpProgress = UIView()
    let xpLabel = UILabel()
    

    static var appColor = UIColor(hexString: "#BB65D1")
    //uses the UIColor extension to declare the app color to be used
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imageView.frame = CGRect(x: width/2-75, y: 100, width: 150, height: 150) //sets the frame of the image view for the avatar
        imageView.layer.cornerRadius = imageView.frame.size.width/2 //makes the image circular
        imageView.clipsToBounds = true //crops out the image as a circle
        imageView.layer.borderColor = ViewController.appColor.cgColor //sets the color for the border of the image
        imageView.layer.borderWidth = 2.0 //sets the width of the border for the avatar image
        if let imageData = UserDefaults.standard.object(forKey: "imageView") as? Data {
            imageView.image = UIImage(data: imageData)
        }
        
        
        self.view.addSubview(imageView) //adds the image to the screen
        
        makeLabel(label: levelLabel, text: "Level \(User.sharedUser.level)", rect: CGRect(x: width/2 - 100, y: 300, width: 200, height: 50), font: UIFont(name:"HelveticaNeue-Thin", size: 50)!)
        //uses the makelabel function to create the level label
        
        makeButton(fileName: "Shop.png", frame: CGRect(x: 13, y: height - 50, width: 40, height: 40), selector: #selector(self.shopPressed(_:)))
        
        
        makeButton(fileName: "Trophy.png", frame: CGRect(x: 13, y: 27, width: 40, height: 40), selector: #selector(self.trophyPressed(_:)))
        //uses the makebutton function to add the achievements button
        
        makeButton(fileName: "Info.png", frame: CGRect(x: width-53, y: 27, width: 40, height: 40), selector: #selector(self.infoPressed(_:)))
        //uses the makebutton function to add the information button
        
        
        makeButton(fileName: "Edit.png", frame: CGRect(x: width/2+80, y: width/2-30, width: 30, height: 30), selector: #selector(self.chooseImage(_:)))
        //uses the makebutton function to add the edit button for the avatar image
        
        
        
        xpBar = UIView(frame: CGRect(x: width/2-150, y: 400, width: 300, height: 15))
        //sets the frame of the experience points bar
        
        xpBar.backgroundColor = UIColor.white //sets the background color of the experience points bar
        xpBar.layer.borderWidth = 1 //sets the border width of the experience points bar
        xpBar.layer.borderColor = ViewController.appColor.cgColor //sets the color to match the app
        xpBar.layer.cornerRadius = xpBar.bounds.height/2 //sets the corner radius of the experience points bar
        self.view.addSubview(xpBar) //adds the experience bar to the screen
        
        xpProgress = UIView(frame: CGRect(x: width/2-150, y: 400, width: 3*User.sharedUser.xp/User.sharedUser.level, height: 15))
        xpProgress.backgroundColor = ViewController.appColor
        let maskPath = UIBezierPath(roundedRect: xpProgress.bounds, byRoundingCorners: [.bottomLeft, .topLeft], cornerRadii: CGSize(width: xpProgress.bounds.height/2, height: xpProgress.bounds.height/2))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        xpProgress.layer.mask = shape
        self.view.addSubview(xpProgress)
        
        makeLabel(label: xpLabel, text: "\(User.sharedUser.xp) / \(User.sharedUser.level*100)", rect: CGRect(x: width/2-50, y: 430, width: 100, height: 40), font: UIFont(name:"HelveticaNeue-Thin", size: 17)!)
        xpLabel.textColor = ViewController.appColor
        
        let startButton = UIButton()
        startButton.frame = CGRect(x: width/2-75, y: center + 200, width: 150, height: 40)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(ViewController.appColor, for: .normal)
        startButton.addTarget(self, action: #selector(self.startPressed(_:)), for:.touchUpInside)
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = ViewController.appColor.cgColor
        startButton.layer.cornerRadius = 5
        startButton.titleLabel?.font = UIFont(name:"HelveticaNeue-Thin", size: 20)
        self.view.addSubview(startButton)
        
        let longPressGestureRecogn = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        longPressGestureRecogn.minimumPressDuration = 1.0
        startButton.addGestureRecognizer(longPressGestureRecogn)
    
    }
   
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
    
   
    
    
    func longTap(_ sender: UIGestureRecognizer){
        
        let actionSheet = UIAlertController(title: "Change the app color!", message: "You have unlocked an easter egg!", preferredStyle: .actionSheet)
        
        
        
        actionSheet.addAction(UIAlertAction(title: "Red", style: .default, handler: { (action:UIAlertAction) in
            ViewController.appColor = UIColor.red
            let alertController = UIAlertController(title: "Color Changed!", message: "Go to any page to save your changes.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .default ) { action in print("canceled") }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true) {}

            
            
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Blue", style: .default, handler: { (action:UIAlertAction) in
            ViewController.appColor = UIColor.blue
            let alertController = UIAlertController(title: "Color Changed!", message: "Go to any page to save your changes.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .default ) { action in print("canceled") }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true) {}

            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Green", style: .default, handler: { (action:UIAlertAction) in
            ViewController.appColor = UIColor(hexString: "03bc4a")
            let alertController = UIAlertController(title: "Color Changed!", message: "Go to any page to save your changes.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .default ) { action in print("canceled") }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true) {}

            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Purple", style: .default, handler: { (action:UIAlertAction) in
            ViewController.appColor = UIColor(hexString: "BB65D1")
            let alertController = UIAlertController(title: "Color Changed!", message: "Go to any page to save your changes.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .default ) { action in print("canceled") }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true) {}

            
        }))
        actionSheet.addAction(UIAlertAction(title: "Orange", style: .default, handler: { (action:UIAlertAction) in
            ViewController.appColor = UIColor(hexString: "f79d20")
            let alertController = UIAlertController(title: "Color Changed!", message: "Go to any page to save your changes.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .default ) { action in print("canceled") }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true) {}
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Pink", style: .default, handler: { (action:UIAlertAction) in
            ViewController.appColor = UIColor(hexString: "e055bd")
            let alertController = UIAlertController(title: "Color Changed!", message: "Go to any page to save your changes.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .default ) { action in print("canceled") }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true) {}
            
            
        }))


          actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        

        if sender.state == .ended {
            print("UIGestureRecognizerStateEnded")
            //Do Whatever You want on End of Gesture
        }
        else if sender.state == .began {
            print("UIGestureRecognizerStateBegan.")
            self.present(actionSheet, animated: true, completion: nil)
            //Do Whatever You want on Began of Gesture
        }
    }
    func startPressed(_ sender: UIButton!) {
        self.performSegue(withIdentifier: "toTimer", sender: self)
    
    }
    
    
    
    func trophyPressed(_ sender: UIButton!) {
        self.performSegue(withIdentifier: "toAchieve", sender: self)
    }
    func shopPressed(_ sender: UIButton!) {
        self.performSegue(withIdentifier: "toShop", sender: self)
    }
    
    func infoPressed(_ sender: UIButton!) {
        self.performSegue(withIdentifier: "toInfo", sender: self)
    }
    
    
    func chooseImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("Camera not available")
            }
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
       
        
        
        
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        imageView.image = image
        UserDefaults.standard.set(UIImagePNGRepresentation(image), forKey: "imageView")
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    // Saves the User singleton object onto the device
    static func saveData() {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: User.sharedUser)
        UserDefaults.standard.set(savedData, forKey: "user")
    }
    
    // Erases all data from this app on the device
    func resetData() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
    
    
}




extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
}
}
