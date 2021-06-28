//
//  PartyViewModel.swift
//  Demo
//
//  Created by Daniel Rodriguez on 6/25/21.
//  Copyright © 2021 mac-00018. All rights reserved.
//

import Foundation
import SwiftUI

class apiCall {
    func getParties(completion:@escaping ([Party]) -> ()) {
        guard let url = URL(string: "http://192.168.1.170:5000") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let parties = try! JSONDecoder().decode([Party].self, from: data!)
            print(parties)
            
            DispatchQueue.main.async {
                completion(parties)
            }
        }
        .resume()
    }
    
    func registerUser(completion: @escaping (HTTPURLResponse) -> Void, name: String, email: String, password: String) {
        guard let url = URL(string: "http://192.168.1.170:5000/register") else { return }
        let query = ["name": name, "email": email, "password": password]
        var registerRequest = URLRequest(url: url)
        registerRequest.httpMethod = "PUT"
        registerRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        registerRequest.httpBody = try! JSONSerialization.data(withJSONObject: query, options: [])
        
        URLSession.shared.dataTask(with: registerRequest) { (data, response, error) in
            //let users = try! JSONDecoder().decode([User].self, from: data!)
            
            DispatchQueue.main.async {
                completion(response as! HTTPURLResponse)
            }
        }
        .resume()
    }
}
