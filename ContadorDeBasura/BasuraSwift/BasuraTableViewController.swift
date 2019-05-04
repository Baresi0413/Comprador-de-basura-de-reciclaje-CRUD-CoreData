

import UIKit
import CoreData

@available(iOS 10.0, *)
class BasuraTableViewController: UITableViewController {
    
    var basura: [NSManagedObject] = []
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        tableView.reloadData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: - Data Source
    
    func fetchData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "basura")
        do {
            basura = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func saveData(name: String, phoneNumber: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "basura", in: managedObjectContext) else {return}
        let contact = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        contact.setValue(name, forKey: "name")
        contact.setValue(phoneNumber, forKey: "basura")
        
        do {
            try managedObjectContext.save()
            self.basura.append(contact)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func updateData(indexPath: IndexPath, name: String, phoneNumber: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let contact = basura[indexPath.row]
        contact.setValue(name, forKey: "name")
        contact.setValue(basura, forKey: "basura")
        
        do {
            try managedObjectContext.save()
            self.basura.remove(at: indexPath.row)
            self.basura.insert(contact, at: indexPath.row)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteData(contact: NSManagedObject, at indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        managedObjectContext.delete(contact)
        do {
            try managedObjectContext.save()
            self.basura.remove(at: indexPath.row)
        }
        catch let error as NSError {
            print("Could not Delete. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basura.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Basura", for: indexPath)
        
        cell.textLabel?.text = (basura[indexPath.row].value(forKey: "name") as! String)
        cell.detailTextLabel?.text = (basura[indexPath.row].value(forKey: "basura") as! String)
        return cell
    }
    
    // Mark: - UnWind Segue
    
    @IBAction func unwindToContactList(segue: UIStoryboardSegue) {
        
        if let viewController = segue.source as? AddOrEditContactViewController {
            
            if (!viewController.nameTextField.text!.isEmpty &&
                !viewController.basuraTextField.text!.isEmpty){
                
                let name = viewController.nameTextField.text!
                let phone = viewController.basuraTextField.text!
                
                
                if let indexPath = viewController.indexPathForContact {
                    // update data
                    updateData(indexPath: indexPath, name: name, basura: phone)
                } else {
                    // save data
                    saveData(name: name, phoneNumber: phone)
                }
                tableView.reloadData()
            }
        } else if let viewcontroller = segue.source as? contactDetailViewController {
            if viewcontroller.isDeleted {
                guard let indexPath: IndexPath = viewcontroller.indexPath else {return}
                let contact = basura[indexPath.row]
                deleteData(contact: contact, at: indexPath)
                tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "basuraDetailSegue" {
            guard let viewController = segue.destination as? contactDetailViewController else { return }
            guard let selectedCellIndex = tableView.indexPathForSelectedRow else {return}
            viewController.basura = basura[selectedCellIndex.row]
            viewController.indexPath = selectedCellIndex
        }
    }
    
}
