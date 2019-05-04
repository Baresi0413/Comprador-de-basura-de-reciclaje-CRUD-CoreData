
import UIKit
import CoreData

class AddOrEditContactViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    var titleText = "Add Contact"
    var contact:NSManagedObject? = nil
    var indexPathForContact: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = titleText
        
        if contact != nil {
            nameTextField.text = contact!.value(forKey: "name") as? String
            phoneNumberTextField.text = contact!.value(forKey: "phoneNumber") as? String
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func saveAndClose(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToContactListSegue", sender: self)
    }
    
    @IBAction func close(_ sender: UIButton) {
        nameTextField.text = nil
        phoneNumberTextField.text = nil
        performSegue(withIdentifier: "unwindToContactListSegue", sender: self)
    }
    
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
