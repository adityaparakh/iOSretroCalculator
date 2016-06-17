//
//  ViewController.swift
//  retroCalculator
//
//  Created by Aditya Parakh on 6/16/16.
//  Copyright © 2016 Aditya Parakh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var BtnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do{
            try BtnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            BtnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    @IBAction func numPressed(btn: UIButton!){
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation((Operation.Divide))
    }
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation((Operation.Multiply))
    }
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation((Operation.Subtract))
    }
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation((Operation.Add))
    }
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation((currentOperation))
    }
    
    func processOperation(op: Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            // Run some math
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
                

            }
                currentOperation = op
        } else{
            // First time it's being pressed 
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        if BtnSound.playing {
            BtnSound.stop()
        }
        
        BtnSound.play()
    }
    
}

