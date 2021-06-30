//
//  DataStore.swift
//  SwiftUIWorkingDemo
//
//  Created by mac-00015 on 17/10/19.
//  Copyright © 2019 mac-00015. All rights reserved.
//

import SwiftUI
import Combine

final class DataStore: ObservableObject {
    
    let didChange = PassthroughSubject<DataStore, Never>()
    
    @Published var login: Bool = false
    @Published var session_token: String = ""
    
    @UserDefault(key: "loggedIn", defaultValue: false)
    var loggedIn: Bool {
        didSet {
            didChange.send(self)
            self.login = self.loggedIn
        }
    }
    
    @UserDefault(key: "token", defaultValue: "")
    var token: String {
        didSet {
            didChange.send(self)
            self.session_token = self.token
        }
    }
}


final class DataOnboarding: ObservableObject {
    
    let didChange = PassthroughSubject<DataOnboarding, Never>()
    
    @Published var onboard: Bool = false
    
    @UserDefault(key: "onboardComlete", defaultValue: false)
    var onboardComlete: Bool {
        didSet {
            didChange.send(self)
            self.onboard = self.onboardComlete
        }
    }
}
