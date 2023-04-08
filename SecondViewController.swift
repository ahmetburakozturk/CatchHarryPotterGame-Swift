//
//  SecondViewController.swift
//  CatchHalseyGame-Swift
//
//  Created by ahmetburakozturk on 7.04.2023.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var imageview9: UIImageView!
    @IBOutlet weak var imageview8: UIImageView!
    @IBOutlet weak var imageview7: UIImageView!
    @IBOutlet weak var imageview6: UIImageView!
    @IBOutlet weak var imageview5: UIImageView!
    @IBOutlet weak var imageview4: UIImageView!
    @IBOutlet weak var imageview3: UIImageView!
    @IBOutlet weak var imageview2: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timerForRound = Timer()
    var timerForJump = Timer()
    var RoundTime = 0
    var imageViewArray = [UIImageView]()
    var score = 0
    var currentImageView = 0
    var gestureRecognizer = UITapGestureRecognizer()
    var highscore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        score = 0
        imageViewArray = [imageView1,imageview2,imageview3,imageview4,imageview5,imageview6,imageview7,imageview8,imageview9]
        RoundTime = 8
        timerForRound = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RemainingTimeCalculate), userInfo: nil, repeats: true)
        timerForJump = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ChangeImageLocation), userInfo: nil, repeats: true)
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onImageClick))
        scoreLabel.text = "Score: 0"
        timeLabel.text = "Time Left: \(RoundTime)"
        for imageView in imageViewArray {
            imageView.isHidden = true
            imageView.isUserInteractionEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let savedHighscore = UserDefaults.standard.object(forKey: "highscore")
        if savedHighscore != nil {
            highscore = savedHighscore as! Int
        }
        highScoreLabel.text = "Highscore: \(highscore)"
    }
    
    
    @objc func RemainingTimeCalculate() {
        
        if RoundTime == 0 {
            timerForRound.invalidate()
            timeLabel.text = "Time is Over!"
            if score >= highscore {
                UserDefaults.standard.set(highscore, forKey: "highscore")
            }
            let alert = UIAlertController(title: "Time Is Over", message: "Your Score: \(score)", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            let playAgainButton = UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default) { (UIAlertAction) in
                print("Tekrar Oyna")
                self.viewDidLoad()
            }
            alert.addAction(okButton)
            alert.addAction(playAgainButton)
            self.present(alert, animated: true)
        } else {
            RoundTime -= 1
            timeLabel.text = "Time Left: \(RoundTime)"
        }
    }
    
    @objc func ChangeImageLocation(){
        
        imageViewArray[currentImageView].removeGestureRecognizer(gestureRecognizer)
        imageViewArray[currentImageView].isHidden = true
        imageViewArray[currentImageView].isUserInteractionEnabled = false
        
        let randomInt = Int.random(in: 0..<9)
        
        imageViewArray[randomInt].isHidden = false
        imageViewArray[randomInt].isUserInteractionEnabled = true
        imageViewArray[randomInt].addGestureRecognizer(gestureRecognizer)
        
        currentImageView = randomInt
        
        if RoundTime == 0 {
            timerForJump.invalidate()
        }
    }
    
    
    @objc func onImageClick() {
        score += 1
        scoreLabel.text = "Score: \(score)"
        if score > highscore {
            highScoreLabel.text = "Highscore: \(score)"
            highscore += 1
        }
    }
    
}
