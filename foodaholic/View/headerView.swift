//
//  headerView.swift
//  Smack
//
//  Created by yousef bj on 31/03/2019.
//  Copyright © 2019 Jonny B. All rights reserved.
//

import UIKit

@IBDesignable
class headerView: UIView {

    
    //Shadow view
    func dropShadow() {
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset =  CGSize(width: 1, height: 1)
        //        self.header.layer.shadowRadius = 10.0
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        
    }
}
