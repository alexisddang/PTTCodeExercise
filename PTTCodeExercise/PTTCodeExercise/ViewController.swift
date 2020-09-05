//
//  ViewController.swift
//  PTTCodeExercise
//
//  Created by Alexis Ang on 9/1/20.
//  Copyright © 2020 Alexis Ang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var subButton: UIButton!
    
    @IBOutlet weak var instrButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting rounded corners for buttons
        addButton.layer.cornerRadius = 10.0
        subButton.layer.cornerRadius = 10.0
        instrButton.layer.cornerRadius = 10.0
    }

    
    @IBAction func instrTap(_ sender: Any) {
        // Presenting Instruction screen
        let instrVC = storyboard?.instantiateViewController(identifier: "instrVC") as! InstructionViewController
        present(instrVC, animated: true)
    }
    
    @IBAction func addTap(_ sender: Any) {
        // Presenting Addition screen
        let addVC = storyboard?.instantiateViewController(identifier: "addVC") as! AddViewController
        present(addVC, animated: true)
    }
    
    @IBAction func subTap(_ sender: Any) {
        // Presenting Subtraction screen
        let subVC = storyboard?.instantiateViewController(identifier: "subVC") as! SubViewController
        present(subVC, animated: true)
    }
    
}

