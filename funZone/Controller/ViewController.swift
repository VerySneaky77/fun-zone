//
//  ViewController.swift
//  funZone
//
//  Created by admin on 12/26/24.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    // data
    /*
    var dataItems = [AppUser]()
    var moc: NSManagedObjectContext!
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
     */
    // requisites
    let loginRequisites = LoginAttributes(minLengthPassword: 1, minLengthUsername: 1, maxLengthPassword: 20, maxLengthUsername: 30)
    
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputPass: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonNewUserRegister: UIButton!
    
    @IBAction func checkUsername(_ sender: UITextField) {
        inputValidation()
    }
    
    @IBAction func checkPassword(_ sender: UITextField) {
        inputValidation()
    }
    
    @IBAction func login() {
        /*
        if existingUserCheck() {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
        else {
            let alert = UIAlertController(title: "Invalid Login", message: "If this is a new user, tap 'Sign In' and then log in with new user.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
         */
    }
    
    @IBAction func registerNewUser(_ sender: Any) {
        guard let name = inputName.text, let password = inputPass.text
        else {
            let alert = UIAlertController(title: "Missing Fields", message: "Please enter a username and password", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let alert = UIAlertController(title: "New User Registered", message: "Thank You", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
        return
    }
    /*
    func existingUserCheck() -> Bool {
        if let dataItem = dataItems.first(where: { $0.name == inputName.text! }) {
            return (inputPass.text! == dataItem.password)        } else {
            return false
        }
    }
     */
    
    func inputValidation()  {
        guard
            inputName.text!.count >= loginRequisites.minLengthUsername,
            inputPass.text!.count >= loginRequisites.minLengthPassword
        else {
            buttonLogin.isEnabled = false
            return
        }
        buttonLogin.isEnabled = true
        return
    }
    /*
    func addDataItem(itemName: String, itemPass: String) {
        if let index = dataItems.firstIndex(where: { $0.name == itemName }) {
            dataItems[index].password = itemPass
        }
        else {
            let dataItem = AppUser(context: moc)
            
            dataItem.name = itemName
            dataItem.password = itemPass
        }
        
        appDelegate?.saveContext()
        loadData()
    }
    
    func loadData() {
        let dataRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        dataRequest.sortDescriptors = [sortDescriptor]
        
        do {
            try dataItems = moc.fetch(dataRequest)
        } catch {
            print("Unabled to load data")
        }
    }
     */
    
    // MARK: ViewController functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputName.delegate = self
        inputPass.delegate = self
        // Do any additional setup after loading the view.
    }


}

