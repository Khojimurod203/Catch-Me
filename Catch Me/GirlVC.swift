//
//  GirlVC.swift
//  Catch Me
//
//  Created by Kojimurod Omonkulov on 03/04/25.
//

import UIKit

class GirlVC: UIViewController {
    
    // variables we need
    var score = 0
    var counter = 0
    var highScore = 0
    var timer = Timer()
    var hideTimer = Timer()
    var girlArray = [UIImageView]()
    
    // Labels
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    /// Image views
    @IBOutlet weak var girl1: UIImageView!
    @IBOutlet weak var girl2: UIImageView!
    @IBOutlet weak var girl3: UIImageView!
    @IBOutlet weak var girl4: UIImageView!
    @IBOutlet weak var girl5: UIImageView!
    @IBOutlet weak var girl6: UIImageView!
    @IBOutlet weak var girl7: UIImageView!
    @IBOutlet weak var girl8: UIImageView!
    @IBOutlet weak var girl9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        girl1.isUserInteractionEnabled = true
        girl2.isUserInteractionEnabled = true
        girl3.isUserInteractionEnabled = true
        girl4.isUserInteractionEnabled = true
        girl5.isUserInteractionEnabled = true
        girl6.isUserInteractionEnabled = true
        girl7.isUserInteractionEnabled = true
        girl8.isUserInteractionEnabled = true
        girl9.isUserInteractionEnabled = true
        highScoreLabel.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(girlScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(girlScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(girlScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(girlScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(girlScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(girlScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(girlScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(girlScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(girlScore))
        let recognizerHighScore = UITapGestureRecognizer(target: self, action: #selector(restHighScore))
        
        girl1.addGestureRecognizer(recognizer1)
        girl2.addGestureRecognizer(recognizer2)
        girl3.addGestureRecognizer(recognizer3)
        girl4.addGestureRecognizer(recognizer4)
        girl5.addGestureRecognizer(recognizer5)
        girl6.addGestureRecognizer(recognizer6)
        girl7.addGestureRecognizer(recognizer7)
        girl8.addGestureRecognizer(recognizer8)
        girl9.addGestureRecognizer(recognizer9)
        highScoreLabel.addGestureRecognizer(recognizerHighScore)
        
        /// girlArray
        girlArray = [girl1, girl2, girl3, girl4, girl5, girl6, girl7, girl8, girl9]
        
        // set score label
        
        scoreLabel.text = "Score: \(score)"
        
        // set highScore label
        let storedHighScore = UserDefaults.standard.integer(forKey: "HS")
        if storedHighScore == nil{
            highScore = 0
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        
        // set timers
        counter = 30
        timeLabel.text = "Time: \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(hideGirl), userInfo: nil, repeats: true)
        hideGirl()
        
        
      
        
        
        
    }// --> end of viewDidLoad 

      // score func
    @objc func girlScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
     // hide girl func
    @objc func hideGirl(){
        for girl in girlArray{
            girl.isHidden = true
         }
        
        let random = Int(arc4random_uniform(UInt32(girlArray.count - 1)))
        girlArray[random].isHidden = false
    }
    
   
    
    /// counter func
    @objc func countDown(){
        
        counter -= 1
        timeLabel.text = "Time: \(counter)"
        if counter <= 20 && counter >= 10{
            timeLabel.textColor = UIColor.systemYellow
        }else if counter <= 9  && counter >= 0{
            timeLabel.textColor = UIColor.systemRed
        }
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            
            for girl in girlArray{
                girl.isHidden = true
            }
             
            ///high score
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "High Score: \(highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "HS")
            }
            
            // alert message
            
            let alert = UIAlertController(title: "Time is Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let noAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel)
            
            //replay btn
            
            let replayAct = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default){ UIAlertAction in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 20
                self.timeLabel.text = "Time: \(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.hideGirl), userInfo: nil, repeats: true)
            }// end of replay func
            alert.addAction(noAction)
            alert.addAction(replayAct)
            self.present(alert, animated: true, completion: nil)
        }
        
    }// end of count down

    ///rest highScore
    @objc func restHighScore(){
        highScore = 0
        highScoreLabel.text = "High Score: \(highScore)"
    }
}
