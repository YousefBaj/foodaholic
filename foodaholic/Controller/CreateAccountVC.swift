
import UIKit
import FirebaseAuth
import Firebase


class CreateAccountVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5 , 0.5 , 0.5 , 1]"
    var bgColor: UIColor?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
             avatarName = UserDataService.instance.avatarName
            userImg.image = UIImage(named: avatarName)
            
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
           
            
        }
    }
    
    @IBAction func createAccntPressed(_ sender: Any) {
        
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        
        
        guard let name = usernameTxt.text , usernameTxt.text != "" else { return }
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let pass = passTxt.text , passTxt.text != "" else { return }
        
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if error == nil{
              
                let ref = Database.database().reference()
                
                ref.child("user/\(user!.user.uid)").setValue(["name":name , "avatarName": self.avatarName , "avatarColor": self.avatarColor])
                UserDataService.instance.setUserData(id: user!.user.uid, color: self.avatarColor, avatarName: self.avatarName, email: email, name: name, catCount: 0)
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CANGE, object: nil)
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                self.performSegue(withIdentifier: TO_CHCK, sender: nil)

            }else{
                
                print(error.debugDescription)
            //   MessageBox.showMsg(Message: error!.localizedDescription, MyVC: self)
            }
        }
        
        
        
        
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatarColor = "[\(r), \(g), \(b), 1]"
        UIView.animate(withDuration: 0.2){
            self.userImg.backgroundColor = self.bgColor
        }
       
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    
    func setupView() {
        spinner.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes:[NSAttributedString.Key.foregroundColor: smackPurplePlaceholder] )
          emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes:[NSAttributedString.Key.foregroundColor: smackPurplePlaceholder] )
          passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes:[NSAttributedString.Key.foregroundColor: smackPurplePlaceholder] )
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        
        
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    

}
