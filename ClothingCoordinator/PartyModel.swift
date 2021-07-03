//
//  GuestModel.swift
//  Demo
//
//  Created by Daniel Rodriguez on 6/25/21.
//  Copyright © 2021 mac-00018. All rights reserved.
//

import SwiftUI

//struct Address: Codable, Identifiable {
//    let id = UUID()
//    let street: String
//}
//
//struct Company: Codable, Identifiable {
//    let id = UUID()
//    let catchPhrase: String
//}

struct User: Codable, Identifiable {
    let id = UUID()
    let name: String
    let email: String
}

struct GuestList: Codable, Identifiable {
    let id = UUID()
    let party_ids: [Int]
}

struct Party: Codable, Identifiable {
    let id = UUID()
    let name: String
    let host: String
    let description: String
    let date: String
}

struct LoggedInfo: Codable, Identifiable {
    let id = UUID()
    let token: String
    let userid: Int
}
