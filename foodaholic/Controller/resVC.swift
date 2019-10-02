//
//  resVC.swift
//  Smack
//
//  Created by yousef bj on 25/03/2019.
//  Copyright © 2019 Jonny B. All rights reserved.
//

import UIKit
import os.log
import Firebase
import SwiftyJSON


class resVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return (res?.comment.count)!
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as? comment{
            
            
            cell.configureCell(commentText: (res?.comment[indexPath.section])!)
            return cell
        }else {
            return UITableViewCell()
        }
        
        
        
    }
    

    @IBOutlet weak var resName: UILabel!
    
    
    @IBOutlet weak var header: headerView!
    @IBOutlet weak var resImg: UIImageView!
    
    @IBOutlet weak var resCat: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var rating: RatingControl!
    
    
    var res: resProfile?
    
    let ref = Database.database().reference()
    let user = Auth.auth().currentUser
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        header.dropShadow()
     
            
            // Set up views if editing an existing Meal.
            if let res = res {
            
               resName.text = res.name
               resImg.image = res.photo
               resCat.text = res.cat
                
            self.ref.child("user/\(user!.uid)/rate").observeSingleEvent(of: .value, with: { (snapshot) in
                let data1 = JSON(snapshot.value as Any)
              
                if  data1["\(res.id)"].int != nil {
                    
                     self.rating.rating = data1["\(res.id)"].int! 
                }else {
                  
                       self.rating.rating = 0
                }
                
            })
                
            }
        
        var addComment = UIButton(frame: CGRect(x: tableView.frame.width - 50 , y: 600 , width: 50, height: 50))
        
        addComment.setBackgroundImage(UIImage(named: "add"), for: .normal)
          addComment.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
       self.view.addSubview(addComment)
            
        
         
        
    }
    
    @IBAction func backPressed(_ sender: Any) {
        if(rating.rating == 0){
             ref.child("user/\(user!.uid)/rate/\(res!.id)").setValue(0)
        }else{
        ref.child("user/\(user!.uid)/rate/\(res!.id)").setValue(rating.rating)
     
        }
           dismiss(animated: true, completion: nil)
    }
    
    @IBAction func mapPressed(_ sender: Any) {
        
      
            //redirect to safari because the user doesn't have Instagram
        if let url = URL(string: "https://www.google.com/maps/search/\(res!.searchName)") {
            UIApplication.shared.open(url, options: [:])
        }

    
}
    
    
    @objc func buttonClicked(sender : UIButton){
        
       performSegue(withIdentifier: TO_ADDCOMMENT, sender: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        
        
        guard let resDetailViewController = segue.destination as? addCommentVC else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
       
        
        
        
        let selectedRes = self.res
        resDetailViewController.resProfile = selectedRes
      
        
    }
    
   
}




