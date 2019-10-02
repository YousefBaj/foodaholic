
//
//  addCommentVC.swift
//  foodaholic
//
//  Created by yousef bj on 12/04/2019.
//  Copyright © 2019 Jonny B. All rights reserved.
//

import UIKit
import os.log
import Firebase

class addCommentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(addCommentVC.closeTap(_:)))
        bgview.addGestureRecognizer(closeTouch)
    }

    @IBOutlet weak var bgview: UIView!
    
    @IBOutlet weak var comment: UITextView!
    
    var resProfile: resProfile?
    
    @IBAction func addComment(_ sender: Any) {
        let ref = Database.database().reference()
        if comment.text != "" {
        resProfile?.comment.append(comment.text)
            
            print(resProfile?.cat)
            print(resProfile?.id)
            ref.child("restaurant/cat/\(resProfile!.cat)/\(resProfile!.id)/comments/").setValue( resProfile!.comment)
            dismiss(animated: true, completion: nil)
        }
        
        
        
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}
