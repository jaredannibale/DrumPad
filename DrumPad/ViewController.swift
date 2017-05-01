//
//  ViewController.swift
//  DrumPad
//
//  Created by Jared Annibale on 4/24/17.
//  Copyright © 2017 Jared Annibale. All rights reserved.
//

import UIKit
import AVFoundation


struct Theme {
    var name: String
    var colors: [UIColor]
}

var themes = [Theme]()

let bostonCollege = Theme(name: "Boston College", colors: [
    UIColor.init(red: 128/255, green: 0/255, blue: 0/255, alpha: 1),
    UIColor.init(red: 128/255, green: 0/255, blue: 0/255, alpha: 1),
    UIColor.init(red: 218/255, green: 165/255, blue: 32/255, alpha: 1),
    UIColor.init(red: 218/255, green: 165/255, blue: 32/255, alpha: 1),
    UIColor.init(red: 128/255, green: 0/255, blue: 0/255, alpha: 1),
    UIColor.init(red: 128/255, green: 0/255, blue: 0/255, alpha: 1)
    ])

let classicBlack = Theme(name: "Classic Black", colors: [
    UIColor.black, UIColor.black, UIColor.black, UIColor.black, UIColor.black, UIColor.black])

let rainbowTheme = Theme(name: "Rainbow", colors: [
    UIColor.init(red: 255/255, green: 0/255, blue: 0/255, alpha: 1),
    UIColor.init(red: 255/255, green: 137/255, blue: 0/255, alpha: 1),
    UIColor.init(red: 255/255, green: 247/255, blue: 0/255, alpha: 1),
    UIColor.init(red: 23/255, green: 255/255, blue: 46/255, alpha: 1),
    UIColor.init(red: 23/255, green: 46/255, blue: 255/255, alpha: 1),
    UIColor.init(red: 155/255, green: 23/255, blue: 255/255, alpha: 1)
    ])

let oceanTheme = Theme(name: "Ocean", colors: [
    UIColor.init(red: 23/255, green: 170/255, blue: 255/255, alpha: 1),
    UIColor.init(red: 139/255, green: 211/255, blue: 253/255, alpha: 1),
    UIColor.init(red: 11/255, green: 240/255, blue: 255/255, alpha: 1),
    UIColor.init(red: 183/255, green: 255/255, blue: 251/255, alpha: 1),
    UIColor.init(red: 95/255, green: 202/255, blue: 255/255, alpha: 1),
    UIColor.init(red: 8/255, green: 122/255, blue: 236/255, alpha: 1)
    ])

let salmonTheme = Theme(name: "Salmon", colors: [
     UIColor.init(red: 250/255, green: 128/255, blue: 114/255, alpha: 1),
     UIColor.init(red: 250/255, green: 128/255, blue: 114/255, alpha: 1),
     UIColor.init(red: 250/255, green: 128/255, blue: 114/255, alpha: 1),
     UIColor.init(red: 250/255, green: 128/255, blue: 114/255, alpha: 1),
     UIColor.init(red: 250/255, green: 128/255, blue: 114/255, alpha: 1),
     UIColor.init(red: 250/255, green: 128/255, blue: 114/255, alpha: 1),
])

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var drumOne: UIImageView!
    @IBOutlet weak var drumTwo: UIImageView!
    @IBOutlet weak var drumThree: UIImageView!
    @IBOutlet weak var drumFour: UIImageView!
    @IBOutlet weak var drumFive: UIImageView!
    @IBOutlet weak var drumSix: UIImageView!
    
    var audioPlayerOne = AVAudioPlayer()
    var audioPlayerTwo = AVAudioPlayer()
    var audioPlayerThree = AVAudioPlayer()
    var audioPlayerFour = AVAudioPlayer()
    var audioPlayerFive = AVAudioPlayer()
    var audioPlayerSix = AVAudioPlayer()
    
    var soundOne = "Clap 1"
    var soundTwo = "Kick 1"
    var soundThree = "HiHat 1"
    var soundFour = "Cowbell 1"
    var soundFive = "Kick 2"
    var soundSix = "Snare 1"
    
    var selectedTheme = bostonCollege
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themes.append(bostonCollege)
        themes.append(classicBlack)
        themes.append(rainbowTheme)
        themes.append(oceanTheme)
        themes.append(salmonTheme)
        
        updateColors(selectedTheme: selectedTheme)
        
        self.drumOne.isUserInteractionEnabled = true
        self.drumTwo.isUserInteractionEnabled = true
        self.drumThree.isUserInteractionEnabled = true
        self.drumFour.isUserInteractionEnabled = true
        self.drumFive.isUserInteractionEnabled = true
        self.drumSix.isUserInteractionEnabled = true
        
        let longOne = UILongPressGestureRecognizer(target: self, action: #selector(longPress(recognizer:)))
        longOne.minimumPressDuration = 0.4
        
        let longTwo = UILongPressGestureRecognizer(target: self, action: #selector(longPress(recognizer:)))
        longTwo.minimumPressDuration = 0.4
        
        let longThree = UILongPressGestureRecognizer(target: self, action: #selector(longPress(recognizer:)))
        longTwo.minimumPressDuration = 0.4
        
        let longFour = UILongPressGestureRecognizer(target: self, action: #selector(longPress(recognizer:)))
        longTwo.minimumPressDuration = 0.4
        
        let longFive = UILongPressGestureRecognizer(target: self, action: #selector(longPress(recognizer:)))
        longTwo.minimumPressDuration = 0.4
        
        let longSix = UILongPressGestureRecognizer(target: self, action: #selector(longPress(recognizer:)))
        longTwo.minimumPressDuration = 0.4

        
        drumOne.addGestureRecognizer(longOne)
        drumTwo.addGestureRecognizer(longTwo)
        drumThree.addGestureRecognizer(longThree)
        drumFour.addGestureRecognizer(longFour)
        drumFive.addGestureRecognizer(longFive)
        drumSix.addGestureRecognizer(longSix)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func drumOnePressed(_ sender: UITapGestureRecognizer) {
//        drumBounce(imageClicked: drumOne)
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.playSound(soundName: self.soundOne, audioPlayer: &self.audioPlayerOne)
        }
    }
    
    @IBAction func drumTwoPressed(_ sender: UITapGestureRecognizer) {
//        drumBounce(imageClicked: drumTwo)'
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.playSound(soundName: self.soundTwo, audioPlayer: &self.audioPlayerTwo)
        }
    }
    
    @IBAction func drumThreePressed(_ sender: UITapGestureRecognizer) {
//        drumBounce(imageClicked: drumThree)
        DispatchQueue.global(qos: .userInteractive).async {
            self.playSound(soundName: self.soundThree, audioPlayer: &self.audioPlayerThree)
        }
    }
    
    @IBAction func drumFourPressed(_ sender: UITapGestureRecognizer) {
//        drumBounce(imageClicked: drumFour)
        DispatchQueue.global(qos: .userInteractive).async {
            self.playSound(soundName: self.soundFour, audioPlayer: &self.audioPlayerFour)
        }
    }
    
    @IBAction func drumFivePressed(_ sender: UITapGestureRecognizer) {
//        drumBounce(imageClicked: drumFive)
        DispatchQueue.global(qos: .userInteractive).async {
            self.playSound(soundName: self.soundFive, audioPlayer: &self.audioPlayerFive)
        }
    }
    
    @IBAction func drumSixPressed(_ sender: UITapGestureRecognizer) {
//        drumBounce(imageClicked: drumSix)
        DispatchQueue.global(qos: .userInteractive).async {
            self.playSound(soundName: self.soundSix, audioPlayer: &self.audioPlayerSix)
        }
    }
    
    
    func drumBounce(imageClicked: UIImageView) {
        let bounds = imageClicked.bounds
        let shrinkValue: CGFloat = 5
        let imageTransparency = imageClicked.alpha
        
        // shrink imageClicked by shrinkValue
        imageClicked.bounds = CGRect(
            
            x: imageClicked.bounds.origin.x + shrinkValue,
            y: imageClicked.bounds.origin.y + shrinkValue,
            width: imageClicked.bounds.size.width - shrinkValue,
            height: imageClicked.bounds.size.height - shrinkValue)
        
        // set transparency to .3
        imageClicked.alpha = 0.8
        
        
        UIView.animate(withDuration: 0.000001, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: {imageClicked.bounds = bounds; imageClicked.alpha = imageTransparency}, completion: nil)
    }
    
    
    
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        
        if let sound = NSDataAsset(name: soundName) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("Error: Data from \(soundName) could not be played as an audio file.")
            }
        } else {
            print("Error: Could not load data file.")
        }
        
        
    }
    
    @IBAction func customizeButtonPressed(_ sender: UIButton) {
        let controller  = ThemeViewController()
        controller.parentController = self
        controller.selectedTheme = selectedTheme
         print("Theme is now \(selectedTheme)")
        
        let navController = UINavigationController(rootViewController: controller)
        self.present(navController, animated: true, completion: nil)

    }
    
    func updateColors(selectedTheme: Theme) {
        
        
        var index = 1
        for color in selectedTheme.colors {
            
            if index == drumOne.tag {
                drumOne.backgroundColor = color
            } else if index == drumTwo.tag {
                drumTwo.backgroundColor = color
            } else if index == drumThree.tag {
                drumThree.backgroundColor = color
            } else if index == drumFour.tag {
                drumFour.backgroundColor = color
            } else if index == drumFive.tag {
                drumFive.backgroundColor = color
            } else if index == drumSix.tag {
                drumSix.backgroundColor = color
            }
            
            index += 1
        }
        
        self.selectedTheme = selectedTheme
        
        if selectedTheme.name == "Boston College" {
            titleLabel.textColor =  UIColor.init(red: 128/255, green: 0/255, blue: 0/255, alpha: 1)
        } else if selectedTheme.name == "Classic Black" {
            titleLabel.textColor = UIColor.black
        } else if selectedTheme.name == "Rainbow" {
            titleLabel.textColor = UIColor.red
        } else if selectedTheme.name == "Ocean" {
            titleLabel.textColor = UIColor.blue
        } else if selectedTheme.name == "Salmon" {
            titleLabel.textColor =  UIColor.init(red: 250/255, green: 128/255, blue: 114/255, alpha: 1)
        }
        
       
    }

    
    func longPress(recognizer: UILongPressGestureRecognizer) {
        
        print("long press occurred")
        
        if recognizer.state == .began {
            
            let drumSelected = recognizer.view!.tag
            
            var selectedName = ""
            
            switch (drumSelected) {
            case 1:
                selectedName = soundOne
            case 2:
                selectedName = soundTwo
            case 3:
                selectedName = soundThree
            case 4:
                selectedName = soundFour
            case 5:
                selectedName = soundFive
            case 6:
                selectedName = soundSix
            default:
                selectedName = ""
            }
            
            
            let controller  = SoundsViewController()
            controller.parentController = self
            controller.selectedName = selectedName
            controller.tag = drumSelected
            
            
            let navController = UINavigationController(rootViewController: controller)
            self.present(navController, animated: true, completion: nil)
        }
        
        
    }
    
}

