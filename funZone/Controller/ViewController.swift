//
//  ViewController.swift
//  funZone
//
//  Created by admin on 12/26/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let loginRequisites = LoginAttributes(minLengthPassword: 6, minLengthUsername: 4, maxLengthPassword: 20, maxLengthUsername: 30)
    
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputPass: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    
    @IBAction func checkUsername(_ sender: UITextField) {
        inputValidation()
    }
    
    @IBAction func checkPassword(_ sender: UITextField) {
        inputValidation()
    }
    
    func inputValidation()  {
        guard
            inputName.text!.count >= loginRequisites.minLengthUsername, inputName.text!.count <= loginRequisites.maxLengthUsername,
            inputPass.text!.count >= loginRequisites.minLengthPassword, inputPass.text!.count <= loginRequisites.maxLengthPassword
        else {
            buttonLogin.isEnabled = false
            return
        }
        buttonLogin.isEnabled = true
        return
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputName.delegate = self
        inputPass.delegate = self
        // Do any additional setup after loading the view.
    }


}

