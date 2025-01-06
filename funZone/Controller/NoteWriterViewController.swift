//
//  NoteWriterViewController.swift
//  funZone
//
//  Created by admin on 1/3/25.
//

import UIKit

class NoteWriterController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var noteNameTextbox: UITextField!
    @IBOutlet weak var noteInput: UITextView!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var buttonClear: UIButton!
    
    @IBAction func saveNoteInput() {
    }
    
    @IBAction func clearNoteInput() {
        noteInput.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }}
