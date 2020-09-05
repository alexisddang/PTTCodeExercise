//
//  SubViewController.swift
//  PTTCodeExercise
//
//  Created by Alexis Ang on 9/2/20.
//  Copyright © 2020 Alexis Ang. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {

    @IBOutlet weak var submitAns: UIButton!
    
    @IBOutlet var number1: [UILabel]!
    @IBOutlet var number2: [UILabel]!
    @IBOutlet var answer: [UITextField]!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting rounded corner for Check Answers button
        submitAns.layer.cornerRadius = 10.0
        
        // Generate initial random numbers
        var randNumber = Int.random(in: 1...99)
        
        for i in number1 {
            // Set spacing for single digit numbers to keepy layout uniform
            if randNumber >= 1 && randNumber <= 9 {
                i.text = "  \(randNumber)"
            }
            else {
                i.text = "\(randNumber)"
            }
            // Generate the rest of the random numbers for number1 column
            randNumber = Int.random(in: 1...99)
        }
        
        for j in number2 {
            // Set spacing for single digit numbers to keep layout uniform
            if randNumber >= 1 && randNumber <= 9 {
                j.text = "  \(randNumber)"
            }
            else {
                j.text = "\(randNumber)"
            }
            // Generate the rest of the random numbers for number2 column
            randNumber = Int.random(in: 1...99)
        }
        
        configureTextFields()
        
        // [SEE SOURCES] Set UIGestureRecognizer for background tap to dismiss keyboard
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SubViewController.backgroundTap))
               self.contentView.addGestureRecognizer(tapGestureRecognizer)
        // [SEE SOURCES]
        NotificationCenter.default.addObserver(self, selector: #selector(SubViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        // [SEE SOURCES]
        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureTextFields() {
        for i in answer {
            i.delegate = self
        }
    }
    
       // Function to handle actions after user taps Check Answers
    @IBAction func submitTap(_ sender: Any) {
        view.endEditing(true)
        
        var ansCP:[Int] = []
        
        // Loop through number1 and number2 UICollections to access Int values from UILabels
        for (i,j) in zip(number1,number2) {
            // Removing whitespace from labels (specificallY single digit labels)
            let trim1 = i.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let trim2 = j.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            // Convert to Int
            let int1:Int = Int(trim1)!
            let int2:Int = Int(trim2)!
            // Fill empty ansCP array with CP answers
            ansCP.append(int1 - int2)
        }
        
        // Loop through answer UICollection and ansCP array to access Int values
        for (k,l) in zip(answer,ansCP) {
            // Convert user input to Int
            let ansUs = Int(k.text ?? " ")
            // Compare user input to CP answer and change UITextField color accordingly
            if ansUs == l {
                k.backgroundColor = UIColor(red: 8/255, green: 97/255, blue: 41/255, alpha: 0.5)
            }
            else {
                k.backgroundColor = UIColor.red.withAlphaComponent(0.5)
            }
        }
    }
    
    // [SEE SOURCE]
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    // [SEE SOURCE]
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func backgroundTap(_ sender: UITapGestureRecognizer) {
            // go through all of the textfield inside the view, and end editing thus resigning first responder
            // ie. it will trigger a keyboardWillHide notification
            self.view.endEditing(true)
        }
    
}

// Dismisses keyboard with return key
extension SubViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

/*
 SOURCES
 
 To handle scrolling content up when text field covered by keyboard is active and to handle dismissing keyboard with background tap
 https://fluffy.es/move-view-when-keyboard-is-shown/#tldrscroll

*/
