//
//  comment.swift
//  Smack
//
//  Created by yousef bj on 06/04/2019.
//  Copyright © 2019 Jonny B. All rights reserved.
//

import UIKit

class comment: UITableViewCell {

   
    
    @IBOutlet weak var comment: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         //commentText.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBOutlet weak var commentheght: NSLayoutConstraint!
    func configureCell(commentText: String){
        
      comment.text = commentText
       
        
        
    }
   
    
    
   
    
    
   
    
}


