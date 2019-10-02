
import UIKit
import FirebaseAuth
import Firebase
import SwiftyJSON

class foodCatVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        tableView.cellForRow(at: indexPath as IndexPath)?.tintColor = UIColor.black
    
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
        
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "foodCatCell", for: indexPath) as? foodCatCell {
            
          

            cell.configureCell(index: indexPath.row)
            
            return cell
        }else{
            return UITableViewCell()
        }
        
    }
    
   
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    @IBOutlet weak var header: headerView!
    @IBOutlet weak var tabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.dropShadow()
        tabelView.delegate = self
        tabelView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        let indexs = tabelView.indexPathsForSelectedRows
        var count = 0
        let user = Auth.auth().currentUser
        let ref = Database.database().reference()

       
        for index in indexs! {
            
            let cell = tabelView.cellForRow(at: index) as! foodCatCell
          //  print(count)
            
            ref.child("restaurant/cat").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? [String: NSDictionary]
                ref.child("userRes/\(user!.uid)/\(cell.catName.text!)/").setValue(value![cell.catName.text!]!)
               
                ref.child("user/\(user!.uid)/cat/\(count)/").setValue(cell.catName.text!)
                count = count + 1
            })
           
            
        }
     
        UserDataService.instance.setcatCount(catCount: count)
        print("hitre")
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
   

}
