
import UIKit
import FirebaseAuth


class sideMenuVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
   
    @IBOutlet weak var header: headerView!
    
    
    @IBAction func reportPrint(_ sender: Any) {
        
        performSegue(withIdentifier: TO_REPORT, sender: nil)
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header.dropShadow()
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(sideMenuVC.userDataDidChanger(_:)), name: NOTIF_USER_DATA_DID_CANGE, object: nil)
       
       
        
    }
    
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        let user = Auth.auth().currentUser
        if  (user != nil) {
            // show Ptofile page
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile,animated: true, completion: nil)
            
            
        }else{
        
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()    }
    
    @objc func userDataDidChanger(_ notif: Notification){
        setupUserInfo()
    }
    
    
    
    func setupUserInfo(){
        let user = Auth.auth().currentUser
        if  (user != nil) {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        }else{
            loginBtn.setTitle("login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
        
    }
    
    
}
