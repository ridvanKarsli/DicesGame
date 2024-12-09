//
//  GameScane.swift
//  DicesGame
//
//  Created by Rıdvan Karslı on 25.06.2024.
//

import UIKit

class GameScaneVC: UIViewController {
    
    @IBOutlet weak var firstGamerName: UILabel!
    @IBOutlet weak var secondGamerName: UILabel!
    @IBOutlet weak var firstGamerImage: UIImageView!
    @IBOutlet weak var secondGamerImage: UIImageView!
    @IBOutlet weak var firstGamerScore: UILabel!
    @IBOutlet weak var secondGamerScore: UILabel!
    @IBOutlet weak var firstGamerDicesSum: UILabel!
    @IBOutlet weak var secondGamerDicesSum: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var throwButton: UIButton!
    @IBOutlet weak var firstDice: UILabel!
    @IBOutlet weak var secondDice: UILabel!
    
    var firstGamerScoreVar : Int = 0
    var secondGamerScoreVar : Int = 0
    var firstGamerDicesSumVar : Int = 0
    var secondGamerDicesSumVar : Int = 0
    var timeForFirstGamer : Bool = true
    var winnerName = "first gamer"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controlGamersData()
        
    }
     
    @IBAction func throwButtonClicked(_ sender: Any) {
        let firstDiceRandom = arc4random_uniform(6)+1
        let secondDiceRandom = arc4random_uniform(6)+1
        
        firstDice.text = String(firstDiceRandom)
        secondDice.text = String(secondDiceRandom)
        
        if timeForFirstGamer {
            
            firstGamerDicesSumVar = Int(firstDiceRandom + secondDiceRandom)
            firstGamerDicesSum.text = String(firstGamerDicesSumVar)
            timeForFirstGamer = false
        }else{
            
            secondGamerDicesSumVar = Int(firstDiceRandom + secondDiceRandom)
            secondGamerDicesSum.text = String(secondGamerDicesSumVar)
            timeForFirstGamer = true
            
            //ilk tur bitti
            
            if(firstGamerDicesSumVar > secondGamerDicesSumVar){
                firstGamerScoreVar += 1
                firstGamerScore.text = String(firstGamerScoreVar)
                informationLabel.text = "bu turu first gamer kazandı"
            }else if(firstGamerDicesSumVar < secondGamerDicesSumVar){
                secondGamerScoreVar += 1
                secondGamerScore.text = String(secondGamerScoreVar)
                informationLabel.text = "bu turu second gamer kazandı"
            }else{
                informationLabel.text = "berabere"
            }
            
            if (firstGamerScoreVar == 3 || secondGamerScoreVar == 3){
                //oyun bitti
                if (firstGamerScoreVar > secondGamerScoreVar) {
                    informationLabel.text = "first gamer kazandı"
                    winnerName = firstGamerName.text!
                }else{
                    informationLabel.text = "seconda gamer kazandı"
                    winnerName = secondGamerName.text!
                }
                alertMessage(winner: winnerName)
            }
            
        }
        
    }
    
    func alertMessage(winner : String){
        let alert = UIAlertController(title: "The winner is \(winner)", message: "Would you like to play again?", preferredStyle: UIAlertController.Style.alert)
        let yesBtn = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { UIAlertAction in
            self.firstGamerScoreVar = 0
            self.secondGamerScoreVar = 0
            self.firstGamerDicesSumVar = 0
            self.secondGamerDicesSumVar = 0
            self.timeForFirstGamer = true
            
            self.firstGamerScore.text = "0"
            self.secondGamerScore.text = "0"
            self.firstGamerDicesSum.text = "0"
            self.secondGamerDicesSum.text = "0"
            self.firstDice.text = ""
            self.secondDice.text = ""
        }
        alert.addAction(yesBtn)
        present(alert,animated: true)
    }
    
    
    func controlGamersData(){
        
        if let gettedFirstGamerData = UserDefaults.standard.data(forKey: "firstGamerImage"){
            if let gettedFirstGamerImage = UIImage(data: gettedFirstGamerData){
                firstGamerImage.image = gettedFirstGamerImage
            }
        }
        
        if let gettedfirstGamerName = UserDefaults.standard.string(forKey: "firstGamerName"){
            firstGamerName.text = gettedfirstGamerName
        }
        
        if let gettedSecondGamerData = UserDefaults.standard.data(forKey: "secondGamerImage"){
            if let gettedSecondGamerImage = UIImage(data: gettedSecondGamerData){
                secondGamerImage.image = gettedSecondGamerImage
            }
        }
        
        if let gettedSecondGamerName = UserDefaults.standard.string(forKey: "secondGamerName"){
            secondGamerName.text = gettedSecondGamerName
        }
        
    }
}
