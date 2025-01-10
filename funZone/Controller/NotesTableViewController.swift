//
//  NotesTableViewController.swift
//  funZone
//
//  Created by admin on 1/3/25.
//

import UIKit
import CoreData

class UICustomTableViewNotes: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // data
    var dataItems = [Note]()
    var moc: NSManagedObjectContext!
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var dataIcons = [String]()
    // segue data
    var noteSelected = TempNote()
    
    @IBOutlet weak var buttonNew: UIButton!
    @IBOutlet weak var tableNotes: UITableView!
    
    @IBAction func unwindToNoteTableView(_ unwindSegue: UIStoryboardSegue) {
        var noteToSave = TempNote()
        
        guard let noteWriterController = unwindSegue.source as? NoteWriterController
        else {
            return
        }
        noteToSave = noteWriterController.saveTarget
        addDataItem(itemName: noteToSave.name, itemContent: noteToSave.content, itemIndex: noteToSave.index)
    }
    
    func numberOfSections(in tableView : UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellNotes", for: indexPath) as! UICustomTableCell
        
        cell.cellTitle?.text = dataItems[indexPath.row].name
        cell.cellIcon.image = UIImage(named: dataIcons[0])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            moc.delete(dataItems[indexPath.row])
            
            appDelegate?.saveContext()
            loadData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func addDataItem(itemName: String, itemContent: String, itemIndex: Int = -1) {
        if itemIndex > -1 {
            dataItems[itemIndex].name = itemName
            dataItems[itemIndex].content = itemContent
        }
        else {
            let dataItem = Note(context: moc)
            
            dataItem.name = itemName
            dataItem.content = itemContent
        }
        
        appDelegate?.saveContext()
        loadData()
        self.tableNotes.reloadData()
    }
    
    func loadData() {
        let dataRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        dataRequest.sortDescriptors = [sortDescriptor]
        
        do {
            try dataItems = moc.fetch(dataRequest)
        } catch {
            print("Unable to load data")
        }
    }
    
    override func viewDidLoad() {
        dataIcons = ["iconNotes"]
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableNotes.delegate = self
        tableNotes.dataSource = self
        moc = appDelegate?.persistentContainer.viewContext
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let selectionIndex = tableNotes.indexPathForSelectedRow {
            tableNotes.deselectRow(at: selectionIndex, animated: animated)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOnLoad" {
            let destination = segue.destination as? NoteWriterController
            let noteIndex = tableNotes.indexPathForSelectedRow?.item
            
            guard let noteName = dataItems[noteIndex!].name, let noteContent = dataItems[noteIndex!].content
            else {
                print("No valid data selected")
                return
            }
            destination?.loadTarget.name = noteName
            destination?.loadTarget.content = noteContent
            destination?.loadTarget.index = noteIndex!
            
        }
    }
}
