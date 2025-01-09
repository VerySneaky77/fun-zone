//
//  NoteWriterViewController.swift
//  funZone
//
//  Created by admin on 1/3/25.
//

import UIKit

class NoteWriterController: UIViewController, UITextFieldDelegate {
    var saveTarget: Note?
    var loadTarget: Note?
    
    @IBOutlet weak var noteNameTextbox: UITextField!
    @IBOutlet weak var noteInput: UITextView!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var buttonClear: UIButton!
    
    @IBAction func segueToNoteWriterView(_ segue: UIStoryboardSegue) {
        guard let noteViewController = segue.source as? UICustomTableViewNotes,
              let loadTarget = noteViewController.noteSelected
        else{
            return
        }
        
        noteNameTextbox.text = loadTarget.name
        noteInput.text = loadTarget.content
    }
    
    @IBAction func clearNoteInput() {
        noteNameTextbox.text = ""
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let noteObj = Note()
        
        guard noteNameTextbox.text != nil, noteInput.text != nil
        else {
            print("Unable to save the note content")
            return
        }
        
        if noteInput.text.isEmpty {
            let alert = UIAlertController(title: "No Note Çontent", message: "Note will save without content", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        noteObj.name = noteNameTextbox.text
        noteObj.content = noteInput.text
        saveTarget = noteObj
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let noteContent = noteInput.text {
            noteInput.text = ""
        }
    }
}
