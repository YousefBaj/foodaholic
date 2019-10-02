

import UIKit
import FirebaseAuth
import Firebase
import SwiftyJSON

class LoginVC: UIViewController {

    // outlet
   
    @IBOutlet weak var usernameTxt: UITextField!
   
    @IBOutlet weak var passwordTxt: UITextField!
 
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
   
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    
    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = usernameTxt.text , usernameTxt.text != "" else { return }
        guard let pass  = passwordTxt.text , passwordTxt.text != "" else { return }

        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
          
            if error == nil {
                let ref  = Database.database().reference()
                ref.child("user/\(user!.user.uid)").observeSingleEvent(of: .value, with: { (snapshot) in
                    let data = snapshot.value as? [String:Any]
                    let json =  JSON(data as Any)
                    let color = json["avatarColor"].stringValue
                    let avatarName = json["avatarName"].stringValue
                    let name = json["name"].stringValue
                    let cat  = json["cat"].arrayValue
                  
                    UserDataService.instance.setUserData(id: user!.user.uid, color: color, avatarName: avatarName, email: email, name: name, catCount: cat.count )
                 
                })
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CANGE, object: nil)
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                self.dismiss(animated: true, completion: nil)
            }else{
                print(error.debugDescription)
            }
            
        }
        
       
        
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccntBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    
    func setupView() {
        spinner.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes:[NSAttributedString.Key.foregroundColor: smackPurplePlaceholder] )
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes:[NSAttributedString.Key.foregroundColor: smackPurplePlaceholder] )
    }
    
    
}
