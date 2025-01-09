//
//  BooksTableViewController.swift
//  funZone
//
//  Created by admin on 1/5/25.
//

import UIKit
import CoreData

class UICustomTableViewBooks: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // data
    var dataItems = [Book]()
    var moc: NSManagedObjectContext!
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    // alert
    let alertTitle = UIAlertController(title: "New Book Title", message: "Enter new book title", preferredStyle: .alert)

    @IBOutlet weak var buttonNew: UIButton!
    @IBOutlet weak var tableBooks: UITableView!
    var dataIcons : [String] = []
    
    func numberOfSections(in tableView : UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBooks", for: indexPath) as! UICustomTableCell
        let dataItem = dataItems[indexPath.row]
        
        cell.cellTitle?.text = dataItem.title
        cell.cellIcon?.image = UIImage(named: dataIcons[0])
        
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBAction func addTableEntry(_ sender: Any) {
        self.present(alertTitle, animated: true, completion: nil)
    }
    
    func addDataItem(item: String) {
        let dataItem = Book(context: moc)
        
        dataItem.title = item
        appDelegate?.saveContext()
        loadData()
        self.tableBooks.reloadData()
    }
    
    func loadData() {
        let dataRequest: NSFetchRequest<Book> = Book.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        dataRequest.sortDescriptors = [sortDescriptor]
        
        do {
            try dataItems = moc.fetch(dataRequest)
        } catch {
            print("Unabled to load data")
        }
    }
    
    override func viewDidLoad() {
        dataIcons = ["iconBooks"]
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let confirmNew = UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = self.alertTitle.textFields?[0].text
            else {
                print("Invalid input")
                self.alertTitle.textFields![0].text = ""
                return
            }
            self.addDataItem(item: text)
            self.alertTitle.textFields![0].text = ""
        }
        
        let cancelCustom = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Canceled new entry")
            
            guard self.alertTitle.textFields?[0].text != nil
            else {
                return
            }
            self.alertTitle.textFields![0].text = ""
        }
        
        confirmNew.isEnabled = false
        alertTitle.addAction(confirmNew)
        alertTitle.addAction(cancelCustom)
        alertTitle.addTextField { (textField) in
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main, using: {_ in
                //text has changed, enable/disable button
                let charCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                
                confirmNew.isEnabled = charCount > 0
            })
        }
        
        tableBooks.delegate = self
        tableBooks.dataSource = self
        moc = appDelegate?.persistentContainer.viewContext
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadData()
    }
}
