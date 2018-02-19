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
    @IBOutlet weak var statusBar: UIView!
    @IBOutlet weak var buttonSetView: UIView!
    @IBOutlet weak var lottoLabel: UILabel!
    
    private var numberArray = [Int]()
    private var drawedNumberArray = [Int]()
    private var timer = Timer()
    private var count = [1,5,24,9,40,33]
    private var isTimerRunning = true
    private var numberManager = NumberManager()
    
    private var num = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setThema()
        self.setNumberArray()
        self.setTimer()
        
          print(NSHomeDirectory())
    }
    
    func setThema() {
        let hex = "50E3C2"
        self.statusBar.backgroundColor = UIColor(hex: hex)
        self.buttonSetView.backgroundColor = UIColor(hex: hex)
        self.lottoLabel.textColor = UIColor(hex: hex)
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
        let drawNum = Int(arc4random_uniform(number))
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
    @IBAction func save(_ sender: Any) {
        for i in 0...5 {
            if i == 5 {
                num += String(drawedNumberArray[i])
            } else {
                num += String(drawedNumberArray[i])
                num += "    "
            }
        }
        let number = Number()
        number.lottoNum = num
        numberManager.save(objc: number)
    }
    
}

