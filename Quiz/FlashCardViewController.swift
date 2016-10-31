//
//  FlashCardViewController.swift
//  Quiz
//
//  Created by Jeremy Conley on 10/15/16.
//  Copyright © 2016 JeremyConley. All rights reserved.
//

import UIKit
import Canvas
import Firebase
import FirebaseDatabase

class FlashCardViewController: UIViewController {
    
    var subject: String?
    
    
    //Outlets
    @IBOutlet weak var leftAnimView: CSAnimationView!
    @IBOutlet weak var rightAnimView: CSAnimationView!
    @IBOutlet weak var cardAnimView: CSAnimationView!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var flipButton: UIButton!
    @IBOutlet weak var flashTextLabel: UILabel!
    
    var questions = [String]()
    var answers = [String]()
    
    //Firebase
    let ref = FIRDatabase.database().reference(withPath: "quizzes")
    var questionsToRef: String?
    var questions2 = [FIRDataSnapshot]()
    
    //Card count and position
    var cardCounter = 0
    var questionCount: Int?
    enum CardPosition {
        case Front
        case Back
    }
    var cardPosition = CardPosition.Front
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flipButton.layer.cornerRadius = 20
        self.title = subject!
        
        
        //Firebase
        if subject! == "History" {
            questionsToRef = "americanHistory"
        } else if subject! == "English" {
            questionsToRef = "english"
        }else if subject! == "Physics" {
            questionsToRef = "physics"
        }else if subject! == "Math" {
            questionsToRef = "math"
        }else if subject! == "Science" {
            questionsToRef = "science"
        }
        
       
        
        ref.child(questionsToRef!).observe(.value, with: { snapshot in
            for item in snapshot.children{
               self.questions2.append(item as! FIRDataSnapshot)
            }
            
            print(self.questions2.count)
            
            for question in self.questions2 {
                let q = question.childSnapshot(forPath: "q")
                let a = question.childSnapshot(forPath: "a")
                self.questions.append((q.value as? String)!)
                self.answers.append((a.value as? String)!)
            }
            
            //Setup Number of questions
            self.questionCount = self.questions.count
            //Setup first question text
            self.flashTextLabel.text = self.questions[self.cardCounter]
        })

        // Do any additional setup after loading the view
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextCard(){
        print("next")
        print (cardCounter)
        if (cardCounter >= questionCount! - 1){
            print("No masssss")
        } else {
            cardCounter += 1
            if (cardPosition == .Front){
                //Questions Facing
                flashTextLabel.text = questions[cardCounter]
            } else {
                //Answers Facing
                flashTextLabel.text = answers[cardCounter]
            }
            rightAnimView.type = "pop"
            rightAnimView.startCanvasAnimation()
            cardAnimView.duration = 1
            cardAnimView.type = "bounceLeft"
            cardAnimView.startCanvasAnimation()
        }
        
    }
    
    func previousCard(){
        print("previous")
        print (cardCounter)
        if (cardCounter <= 0){
            print("Can't go back")
        } else {
            cardCounter -= 1
            if (cardPosition == .Front){
                //Questions Facing
                flashTextLabel.text = questions[cardCounter]
            } else {
                //Answers Facing
                flashTextLabel.text = answers[cardCounter]
            }
            leftAnimView.type = "pop"
            leftAnimView.startCanvasAnimation()
            cardAnimView.duration = 1
            cardAnimView.type = "bounceRight"
            cardAnimView.startCanvasAnimation()
        }
    }
    
    func flipCard(){
        if cardPosition == .Back {
            //Flipped to see Question
            flipButton.setTitle("See Answer", for: .normal)
            cardPosition = .Front
            flashTextLabel.text = questions[cardCounter]
        } else {
            //Flipped to see Answer
            flipButton.setTitle("See Question", for: .normal)
            cardPosition = .Back
            flashTextLabel.text = answers[cardCounter]
        }
        cardAnimView.duration = 0.5
        cardAnimView.type = "shake"
        cardAnimView.startCanvasAnimation()
    }
    
    @IBAction func leftTapped(_ sender: AnyObject) {
        previousCard()
        
    }
    @IBAction func rightTapped(_ sender: AnyObject) {
        nextCard()
    }
    
    @IBAction func flipTapped(_ sender: AnyObject) {
        flipCard()
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
