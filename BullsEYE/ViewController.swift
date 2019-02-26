//
//  ViewController.swift
//  BullsEYE
//
//  Created by Jay Yabsley on 25/2/19.
//  Copyright © 2019 Jay Yabsley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //INSTANCED VAR
    var currentSliderValue: Int = 0
    var randomGeneratedNumber: Int = 0
    var currentScore: Int = 0
    var currentRound: Int = 0
    @IBOutlet weak var sliderComponent: UISlider!
    @IBOutlet weak var randomNumberLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var currentRoundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StartNewRound()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func ShowAlert() {
        
        let currentRoundPoints = CalculateScore(distance: CalculateDistanceFromNumber())
        currentScore += currentRoundPoints
        let alertMessage = "Slider currently set to \(currentSliderValue)\n Random number generated: \(randomGeneratedNumber)\nScore Awared \(currentRoundPoints)"
        let alertWindow = UIAlertController(title: "Hello World", message: alertMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Answer", style: .default, handler: nil)
        alertWindow.addAction(alertAction)
        
        present(alertWindow, animated: true, completion: nil)
        
        StartNewRound()
    }
    
    @IBAction func PromptReset() {
        let alertWindow = UIAlertController(title: "Reset", message: "Are you sure?", preferredStyle: .actionSheet)
        let alertConfirmAction = UIAlertAction(title: "Confirm", style: .destructive, handler: {(action) -> Void in
                self.ResetGame()
            })
        let alertCancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertWindow.addAction(alertConfirmAction)
        alertWindow.addAction(alertCancelAction)
        present(alertWindow, animated: true, completion: nil)
    }
    
    @IBAction func StoreSliderValue(_ sliderObject: UISlider) {
        currentSliderValue = Int(sliderObject.value.rounded())
    }
    
    func ResetGame(){
        currentSliderValue = 0
        randomGeneratedNumber = 0
        currentScore = 0
        currentRound = 0
        StartNewRound()
    }
    
    func CalculateScore(distance: Int) -> Int {
        let PerfectScore = 500
        if (distance == 0) {
            return PerfectScore
        }
        return PerfectScore / distance
    }
    
    func CalculateDistanceFromNumber() -> Int {
        var distanceFromRandomValue = currentSliderValue - randomGeneratedNumber
        
        if (distanceFromRandomValue < 0) {
            distanceFromRandomValue = distanceFromRandomValue * -1
        }
        
        return distanceFromRandomValue
    }
    
    func ResetSlider(value: Float) {
        currentSliderValue = Int(value)
        sliderComponent.value = Float(currentSliderValue)
    }
    
    func UpdateLabels() {
        randomNumberLabel.text = String(randomGeneratedNumber)
        currentScoreLabel.text = String(currentScore)
        currentRoundLabel.text = String(currentRound)
    }
    
    func StartNewRound() {
        randomGeneratedNumber = Int.random(in: 1...100)
        ResetSlider(value: 50)
        currentRound += 1
        UpdateLabels()
    }
    
}

