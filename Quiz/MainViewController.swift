//
//  MainViewController.swift
//  Quiz
//
//  Created by Jeremy Conley on 10/15/16.
//  Copyright © 2016 JeremyConley. All rights reserved.
//

import UIKit
import Canvas
import Firebase
import FirebaseAuth

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var physicsButton: UIButton!
    @IBOutlet weak var mathButton: UIButton!
    @IBOutlet weak var scienceButton: UIButton!
    
    
    @IBOutlet weak var historyAnimView: CSAnimationView!
    @IBOutlet weak var englishAnimView: CSAnimationView!
    @IBOutlet weak var physicsAnimView: CSAnimationView!
    @IBOutlet weak var mathAnimView: CSAnimationView!
    @IBOutlet weak var scienceAnimView: CSAnimationView!
    
    var subjectSelected: String?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()?.signInAnonymously() { (user, error) in
            // ...
            if (error == nil){
                //YAY
            } else {
                print(error)
            }
        }
        
        historyButton.layer.cornerRadius = 20
        englishButton.layer.cornerRadius = 20
        physicsButton.layer.cornerRadius = 20
        mathButton.layer.cornerRadius = 20
        scienceButton.layer.cornerRadius = 20

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func historyTapped(_ sender: AnyObject) {
        historyAnimView.type = "pop"
        historyAnimView.startCanvasAnimation()
        print("history")
        subjectSelected = "History"
        performSegue(withIdentifier: "subjectPicked", sender: nil)
    }
    
    @IBAction func englishTapped(_ sender: AnyObject) {
        englishAnimView.type = "pop"
        englishAnimView.startCanvasAnimation()
        print("english")
        subjectSelected = "English"
        performSegue(withIdentifier: "subjectPicked", sender: nil)
    }
    
    @IBAction func physicsTapped(_ sender: AnyObject) {
        physicsAnimView.type = "pop"
        physicsAnimView.startCanvasAnimation()
        print("physics")
        subjectSelected = "Physics"
        performSegue(withIdentifier: "subjectPicked", sender: nil)
    }
    
    @IBAction func mathTapped(_ sender: AnyObject) {
        mathAnimView.type = "pop"
        mathAnimView.startCanvasAnimation()
        print("math")
        subjectSelected = "Math"
        performSegue(withIdentifier: "subjectPicked", sender: nil)
    }
    
    @IBAction func scienceTapped(_ sender: AnyObject) {
        scienceAnimView.type = "pop"
        scienceAnimView.startCanvasAnimation()
        print("science")
        subjectSelected = "Science"
        performSegue(withIdentifier: "subjectPicked", sender: nil)
    }
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! FlashCardViewController
        destinationVC.subject = subjectSelected
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
