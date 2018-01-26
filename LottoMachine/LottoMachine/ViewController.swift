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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNumberArray()
        setDrawedArray()
    }
    
    func setNumberArray() {
        numberArray = [Int]()
        for i in 1...45 {
            numberArray.append(i)
        }
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
    func setfadeOutnAnimation() {
        goldLabel.alpha = 0.0
        greenLabel.alpha = 0.0
        silverLabel.alpha = 0.0
        redLabel.alpha = 0.0
        blueLabel.alpha = 0.0
        purpleLabel.alpha = 0.0
    }
    func fadeInAnimation() {
        UIView.animate(withDuration: 1, animations:  {
            self.goldLabel.alpha = 1.0
        })
        UIView.animate(withDuration: 2, animations:  {
            self.greenLabel.alpha = 1.0
        })
        UIView.animate(withDuration: 3, animations:  {
            self.silverLabel.alpha = 1.0
        })
        UIView.animate(withDuration: 4, animations:  {
            self.redLabel.alpha = 1.0
        })
        UIView.animate(withDuration: 5, animations:  {
            self.blueLabel.alpha = 1.0
        })
        UIView.animate(withDuration: 6, animations:  {
            self.purpleLabel.alpha = 1.0
        })

    }
    
    @IBAction func drawAll(_ sender: Any) {
        drawAll()
        goldLabel.text = "\(drawedNumberArray[0])"
        greenLabel.text = "\(drawedNumberArray[1])"
        silverLabel.text = "\(drawedNumberArray[2])"
        redLabel.text = "\(drawedNumberArray[3])"
        blueLabel.text = "\(drawedNumberArray[4])"
        purpleLabel.text = "\(drawedNumberArray[5])"
        setfadeOutnAnimation()
        fadeInAnimation()
        
    }
    
}

