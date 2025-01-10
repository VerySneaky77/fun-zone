//
//  NoteWriterViewController.swift
//  funZone
//
//  Created by admin on 1/3/25.
//

import UIKit
import CoreData

class NoteWriterController: UIViewController, UITextFieldDelegate {
    var saveTarget = TempNote()
    var loadTarget = TempNote()
    
    @IBOutlet weak var noteNameTextbox: UITextField!
    @IBOutlet weak var noteInput: UITextView!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var buttonClear: UIButton!
    
    @IBAction func clearNoteInput() {
        noteInput.text = ""
    }
    
    @IBAction func checkOnNoteName(_ sender: UITextField) {
        inputValidation()
        
    }
    
    func inputValidation()  {
        guard
            noteNameTextbox.text!.count >= 1
        else {
            buttonSave.isEnabled = false
            return
        }
        buttonSave.isEnabled = true
        return
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if !loadTarget.isEmpty {
            noteNameTextbox.text = loadTarget.name
            noteInput.text = loadTarget.content
            
            buttonSave.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = loadTarget.index
        
        guard let name = noteNameTextbox.text, let content = noteInput.text, name != ""
        else {
            print("Unable to save the note content")
            return
        }
        
        saveTarget.name = name
        saveTarget.content = content
        saveTarget.index = index
    }
    
    override func viewWillDisappear (_ animated: Bool) {
        noteInput.text = ""
        noteNameTextbox.text = ""
    }
}
