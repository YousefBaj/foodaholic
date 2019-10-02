
import UIKit

class foodCatCell: UITableViewCell {

    
 
  
    
     let data = ["Chinese","American","Indian","Turkish","Arabic"]
     let emojiArray = ["🇨🇳","🇺🇸","🇮🇳","🇹🇷","🇸🇦",]
    @IBOutlet weak var catName: UILabel!
    
    @IBOutlet weak var emoji: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
       
         
        
    }
    
    
    
    
    
    func configureCell(index: Int){
      
     catName.text = data[index]
        emoji.text = emojiArray[index]
        
    }

}
