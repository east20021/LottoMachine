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
    @IBOutlet weak var boundaryView: UIView!
    
    private var timer = Timer()
    
    private var numberArray = [Int]()
    private var drawedNumberArray = [Int]()
    
    private var count = [1,5,24,9,40,33]
    private var isTimerRunning = true
    
    private var numberManager = NumberManager()
    private let themaColor = ThemaColorManager()
    
    private var num = ""
    private var savedNum = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setThema()
        self.setTimer()
        
        for i in 1...45 {
            numberArray.append(i)
        }
        
        print(NSHomeDirectory())
        
    }
    
    func setThema() {
        let hex = themaColor.hex
        self.statusBar.backgroundColor = UIColor(hex: hex)
        self.boundaryView.backgroundColor = UIColor(hex: hex)
    }
    
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        animation()
    }
    
    func drawAll() {
        var numArr = numberArray
        drawedNumberArray = []
        for _ in 1...6 {
            let number = UInt32(numArr.count)
            let drawNum = Int(arc4random_uniform(number))
            drawedNumberArray.append(numArr.remove(at: drawNum))
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
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
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
        num = ""
    }
    
    @IBAction func save(_ sender: Any) {
        if isTimerRunning != true {
            for i in 0...5 {
                if i == 5 {
                    num += String(drawedNumberArray[i])
                } else {
                    num += String(drawedNumberArray[i])
                    num += "    "
                }
            }
            
            if savedNum != num {
                let number = Number()
                number.lottoNum = num
                numberManager.save(objc: number)
                savedNum = num
                num = ""
                self.alert(title: "저장되었습니다", message:"" )
            } else {
                self.alert(title: "이미 저장된 번호입니다.", message: "")
                num = ""
            }
        } else {
            self.alert(title: "stop을 누르고 저장해 주세요", message: "")
        }
    }
}

