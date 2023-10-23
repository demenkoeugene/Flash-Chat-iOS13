//
//  Constant.swift
//  Flash Chat iOS13
//
//  Created by Eugene Demenko on 23.10.2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import Foundation


struct Constant {
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LogInToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
