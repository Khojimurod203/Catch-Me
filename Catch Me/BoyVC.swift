//
//  BoyVC.swift
//  Catch Me
//
//  Created by Kojimurod Omonkulov on 03/04/25.
//

import UIKit

class BoyVC: UIViewController {
  //variables we need
    var score =  0
    var counter = 0
    var highScore = 0
    var timer = Timer()
    var hideTimer = Timer()
    var boyArray = [UIImageView]()
     
    
    //Label
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
   
    //image Views
    @IBOutlet weak var boy1: UIImageView!
    @IBOutlet weak var boy2: UIImageView!
    @IBOutlet weak var boy3: UIImageView!
    @IBOutlet weak var boy4: UIImageView!
    @IBOutlet weak var boy5: UIImageView!
    @IBOutlet weak var boy6: UIImageView!
    @IBOutlet weak var boy7: UIImageView!
    @IBOutlet weak var boy8: UIImageView!
    @IBOutlet weak var boy9: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //user interaction
        boy1.isUserInteractionEnabled = true
        boy2.isUserInteractionEnabled = true
        boy3.isUserInteractionEnabled = true
        boy4.isUserInteractionEnabled = true
        boy5.isUserInteractionEnabled = true
        boy6.isUserInteractionEnabled = true
        boy7.isUserInteractionEnabled = true
        boy8.isUserInteractionEnabled = true
        boy9.isUserInteractionEnabled = true
        highScoreLabel.isUserInteractionEnabled = true
        
        // set UITapGestureRecognizer
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(boyScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(boyScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(boyScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(boyScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(boyScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(boyScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(boyScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(boyScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(boyScore))
        let recognizerHighScore = UITapGestureRecognizer(target: self, action: #selector(restHighScore))
        
        //Adding Gesture Recognizer
        boy1.addGestureRecognizer(recognizer1)
        boy2.addGestureRecognizer(recognizer2)
        boy3.addGestureRecognizer(recognizer3)
        boy4.addGestureRecognizer(recognizer4)
        boy5.addGestureRecognizer(recognizer5)
        boy6.addGestureRecognizer(recognizer6)
        boy7.addGestureRecognizer(recognizer7)
        boy8.addGestureRecognizer(recognizer8)
        boy9.addGestureRecognizer(recognizer9)
        highScoreLabel.addGestureRecognizer(recognizerHighScore)
       
       // set boy's array
        
        boyArray = [boy1, boy2, boy3, boy4, boy5, boy6, boy7, boy8, boy9]
        
        // set score label
        scoreLabel.text = "Score: \(score)"
        
        //set highScore label
        let storedHighScore = UserDefaults.standard.integer(forKey: "SHS")
        if storedHighScore == nil{
            highScore = 0
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        //update HighScore
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        
        // set timer
        counter = 30
        timeLabel.text = "Time: \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(hideBoy), userInfo: nil, repeats: true)
        hideBoy()
        
       
        
        
    } //--> end of viewDidLoad
    
  
    
    @objc func boyScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    } //end of boyScore
    @objc func hideBoy(){
        for boy in boyArray{
            boy.isHidden = true
         }
        
        let random = Int(arc4random_uniform(UInt32(boyArray.count - 1)))
        boyArray[random].isHidden = false
    }
    
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
            
            for boy in boyArray{
                boy.isHidden = true
            }
            
            // highscore
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "HighScore: \(highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "SHS")
            }
            
          
                
                
            
            //alert message
            let alert = UIAlertController(title: "Time is Up", message: "Do you want play again?", preferredStyle: UIAlertController.Style.alert)
            let noAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel)
            
            //replay btn
            let replayAct = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default){ UIAlertAction in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = "Time: \(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.hideBoy), userInfo: nil, repeats: true)
            }//enf of replay
            
            alert.addAction(noAction)
            alert.addAction(replayAct)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc func restHighScore(){
        highScore = 0
        highScoreLabel.text = "High Score: \(highScore)"
    }
    
   

  
}
