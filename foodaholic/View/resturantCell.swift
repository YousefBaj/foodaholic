

import UIKit
import Firebase
import SwiftyJSON

class resturantCell: UITableViewCell {

    var ref = Database.database().reference()
 
    @IBOutlet weak var resName: UILabel!
    
    @IBOutlet weak var rating: RatingControl!
    
    
    @IBOutlet weak var resImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
    
    
    func configureCell(index: Int, res: resProfile){
       
       
            self.resName.text = res.name
      
        
            resImg.image = res.photo
        rating.rating = res.rating
    }
    
    
    func setUpView(){
       
        self.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.cornerRadius = 3
        self.clipsToBounds = true
        
        
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.6
            self.layer.shadowOffset =  CGSize(width: 1, height: 1)
  //        self.header.layer.shadowRadius = 10.0
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            self.layer.shouldRasterize = true
            
        
        
      
    }

}
