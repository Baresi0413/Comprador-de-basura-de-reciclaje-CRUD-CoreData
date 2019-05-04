

import UIKit
import CoreData

class contactDetailViewController: UIViewController {
    
    
    var contact: NSManagedObject? = nil
    var indexPath: IndexPath? = nil
    var isDeleted = false
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var basuraLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = contact?.value(forKey:"name") as? String
        basuraLabel.text = contact?.value(forKey:"basura") as? String
        // Do any additional setup after loading the view.
    }

    @IBAction func deleteBasura(_ sender: UIButton) {
        isDeleted = true
        performSegue(withIdentifier: "unwindDeleteContactSegue", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editBasuraSegue" {
            guard let viewController = segue.destination as? AddOrEditBasuraViewController else {return}
            viewController.titleText = "Edit Contact"
            viewController.contact = contact
            viewController.indexPathForContact = self.indexPath!
        }
        
    }

}
