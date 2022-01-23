//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressiveView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var secondsRemaining = 0
    var totalSeconds = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func update() {
        if(secondsRemaining > 0) {
            // print("\(secondsRemaining) seconds")
            secondsRemaining -= 1
            progressiveView.progress = Float(1) - Float(secondsRemaining) / Float(totalSeconds)
        } else {
            timer.invalidate()
            playSound()
            titleLabel.text = "Done"
        }
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        progressiveView.progress = 0.0
        titleLabel.text = hardness
        
        secondsRemaining = eggTimes[hardness]!
        totalSeconds = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    

}
