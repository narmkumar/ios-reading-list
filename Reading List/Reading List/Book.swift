//
//  Book.swift
//  Reading List
//
//  Created by Niranjan Kumar on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool = false
    
}
