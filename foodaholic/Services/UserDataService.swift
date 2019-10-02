

import Foundation

class UserDataService{
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    public private(set) var catCount = 0
    public private(set) var table : UITableView = UITableView()
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String, catCount: Int){
        self.id = id
        self.name = name
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.catCount = catCount
       
 
    }
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
    func setcatCount(catCount: Int){
        self.catCount = catCount
    }
    
    func setcatTable(table: UITableView){
        self.table = table
    }
    func returnUIColor(components: String) -> UIColor{
        
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma   = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        guard let rUnwrapped = r else {return defaultColor }
        guard let gUnwrapped = g else {return defaultColor }
        guard let bUnwrapped = b else {return defaultColor }
        guard let aUnwrapped = a else {return defaultColor }
        
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newUIColor

    }
    
    func logoutUser() {
        
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        catCount = 0
        table = UITableView()
        table.reloadData()
        
       
    }
    
}
