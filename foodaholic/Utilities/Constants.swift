//
//  Constants.swift
//  Smack
//
//  Created by Jonny B on 7/14/17.
//  Copyright © 2017 Jonny B. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()



// Colors
let smackPurplePlaceholder = #colorLiteral(red: 0.01083394513, green: 0.2279010713, blue: 0.3835885525, alpha: 1)

// Notification Constants
let NOTIF_USER_DATA_DID_CANGE = Notification.Name("notifUserDataCanged")

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"
let TO_REPORT = "toreport"
let TO_CHCK = "tocheckcat"
let TO_RES_PROFILE = "toresprofile"
let TO_FRONT = "checkSign"
let TO_ADDCOMMENT = "addcomment"
