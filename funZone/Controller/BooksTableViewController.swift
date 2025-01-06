//
//  BooksTableViewController.swift
//  funZone
//
//  Created by admin on 1/5/25.
//

import UIKit

class UICustomTableViewBooks: UIViewController, UITableViewDelegate,UITableViewDataSource {
    let alertTitle = UIAlertController(title: "New Book Title", message: "Enter new book title", preferredStyle: .alert)

    @IBOutlet weak var buttonNew: UIButton!
    @IBOutlet weak var tableBooks: UITableView!
    // arbitrary file id, [name/title, icon name]
    var dataTitles : [String] = []
    var dataIcons : [String] = []
    
    func numberOfSections(in tableView : UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTitles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBooks", for: indexPath) as! UICustomTableCell
        
        cell.cellTitle?.text = dataTitles[indexPath.row]
        cell.cellIcon.image = UIImage(named: dataIcons[0])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            dataTitles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBAction func addTableEntry(_ sender: Any) {
        self.present(alertTitle, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        tableBooks.delegate = self
        tableBooks.dataSource = self
        dataTitles = []
        dataIcons = ["iconBooks"]
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let confirmNew = UIAlertAction(title: "OK", style: .default) { action in
            guard let text = self.alertTitle.textFields?.first?.text
            else {
                print("Invalid input")
                return
            }
            var indexPath : IndexPath
            self.dataTitles.append(text)
            indexPath = IndexPath(row: (self.dataTitles.count - 1), section: 0)
            self.tableBooks.insertRows(at: [indexPath], with: .fade)
        }
        
        confirmNew.isEnabled = false
        alertTitle.addAction(confirmNew)
        alertTitle.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertTitle.addTextField { (textField) in
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main, using: {_ in
                //text has changed, enable/disable button
                let charCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                
                confirmNew.isEnabled = charCount > 0
            })
        }
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
}
