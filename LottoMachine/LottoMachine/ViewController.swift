//
//  ViewController.swift
//  LottoMachine
//
//  Created by lee on 2018. 1. 25..
//  Copyright © 2018년 smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var silverLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var purpleLabel: UILabel!
    @IBOutlet weak var goldLabel: UILabel!
    
    private var numberArray = [Int]()
    private var drawedNumberArray = [Int]()
    private var timer = Timer()
    private var count = [1,5,24,9,40,33]
    private var isTimerRunning = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNumberArray()
        setTimer()
    }
    
    func setNumberArray() {
        numberArray = [Int]()
        for i in 1...45 {
            numberArray.append(i)
        }
    }
    
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        animation()
    }
    
    func setDrawedArray() {
        drawedNumberArray = [Int]()
    }
    
    func drawNumber() -> Int {
        let number = UInt32(numberArray.count)
        print("num :",number)
        let drawNum = Int(arc4random_uniform(number))
        print("draw :",drawNum)
        let saveNumber = numberArray[drawNum]
        numberArray.remove(at: drawNum)
        return saveNumber
    }
    
    func drawAll() {
        setNumberArray()
        setDrawedArray()
        for _ in 1...6 {
            drawedNumberArray.append(drawNumber())
        }
        drawedNumberArray.sort()
    }
    
    func animation() {
        for i in 0...5 {
            if count[i] == 46 {
                count[i] = 1
            }
        }
        goldLabel.text = "\(count[0])"
        greenLabel.text = "\(count[1])"
        silverLabel.text = "\(count[2])"
        redLabel.text = "\(count[3])"
        blueLabel.text = "\(count[4])"
        purpleLabel.text = "\(count[5])"
        
        for i in 0...5 {
            count[i] += 1
        }
        
    }
    
    @IBAction func drawAll(_ sender: Any) {
        if isTimerRunning == true {
            drawAll()
            timer.invalidate()
            goldLabel.text = "\(drawedNumberArray[0])"
            greenLabel.text = "\(drawedNumberArray[1])"
            silverLabel.text = "\(drawedNumberArray[2])"
            redLabel.text = "\(drawedNumberArray[3])"
            blueLabel.text = "\(drawedNumberArray[4])"
            purpleLabel.text = "\(drawedNumberArray[5])"
            isTimerRunning = false
        }
    }
    @IBAction func reset(_ sender: Any) {
        if isTimerRunning == false {
            setTimer()
            isTimerRunning = true
        }
    }
    
}

