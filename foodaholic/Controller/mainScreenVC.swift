
import UIKit
import FirebaseAuth
import Firebase
import SwiftyJSON
import os.log

class mainScreenVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
     
    
     var ref = Database.database().reference()
    
    var user = Auth.auth().currentUser
     var res = [resProfile]()
   
    
    @IBAction func updateTable(_ sender: Any) {
        self.user = Auth.auth().currentUser
        
        self.res.removeAll()
        if user != nil {
            arrays()
        }
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.res.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 1
    }
    
   
    
     func tableView(_ tableView: UITableView, cellForRowAt  indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "resturantCell", for: indexPath) as? resturantCell{
            
            
            cell.configureCell(index: indexPath.row+1,res: self.res[indexPath.section])
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
    
       
            guard let resDetailViewController = segue.destination as? resVC else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedResCell = sender as? resturantCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
        guard let indexPath = tableView.indexPath(for: selectedResCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
        
            let selectedRes = res[indexPath.section]
        resDetailViewController.res = selectedRes
            
      
    }
    
    
    
   
    
   
    
    
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    
  
    @IBOutlet weak var header: headerView!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       tableView.delegate = self
       tableView.dataSource = self
        header.dropShadow()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        if  (user != nil) {
                 arrays()
        }else{
           
        }
            
        }
    
    
    
        func arrays(){
            let ref  = Database.database().reference()
           
            ref.child("user/\(user!.uid)").observeSingleEvent(of: .value, with: { (snapshot) in
                let data = snapshot.value as? [String:Any]
                let json =  JSON(data as Any)
                let color = json["avatarColor"].stringValue
                let avatarName = json["avatarName"].stringValue
                let name = json["name"].stringValue
                let cats  = json["cat"].array
                
                
                for cat in cats! {
                    ref.child("restaurant/cat/\(cat)").observeSingleEvent(of: .value, with: { (snapshot) in
                        let data1 = JSON(snapshot.value as Any)
                       
                      
                        
                        for ids in 1..<data1["ids"].count+1 {
                                let id = data1["ids"]["id\(ids)"].stringValue
                                let name = data1["\(id)"]["name"].stringValue
                                let imgName = data1["\(id)"]["imgName"].stringValue
                                let rate = data1["\(id)"]["rate"].int
                                let searchName = data1["\(id)"]["searchName"].stringValue
                            let comment = data1["\(id)"]["comments"].arrayObject as! [String]
                            let res = resProfile(name: name, cat: cat.string!, photo: UIImage(named: imgName), id: id, rating: rate!, searchName: searchName,comment: comment)
                                self.res.append(res!)
                            }
                         self.res.shuffle()
                         self.tableView.reloadData()
                            })
                        
                
                    print(self.user!.uid)
                    print(color)
                    print(avatarName)
                    print(name)
                    print(cats!.count)
                    
                    UserDataService.instance.setUserData(id: self.user!.uid, color: color, avatarName: avatarName, email: self.user!.email!, name: name, catCount: cats!.count)
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CANGE, object: nil)
                }
            })
            
    }
    
}

