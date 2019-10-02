//
//  resProfile.swift
//  Smack
//
//  Created by yousef bj on 28/03/2019.
//  Copyright © 2019 Jonny B. All rights reserved.
//

import Foundation


class resProfile {
    
    
    //MARK: Properties
    var id: String
    var name: String
    var cat: String
    var photo: UIImage?
    var rating: Int
    var searchName : String
    var comment : [String]
    
    
    //MARK: Initialization
    
    init?(name: String,cat: String,photo: UIImage?,id: String,rating: Int, searchName: String, comment: [String]) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.cat = cat
        self.id = id
        self.rating = rating
        self.searchName = searchName
        self.comment = comment
    }
}

    

