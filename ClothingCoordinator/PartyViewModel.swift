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
    func getParties(completion:@escaping ([Party]) -> (), token: String) {
        guard let url = URL(string: "http://192.168.1.170:5000/parties") else { return }
        var partyRequest = URLRequest(url: url)
        partyRequest.addValue(token, forHTTPHeaderField: "x-access-tokens")
        
        URLSession.shared.dataTask(with: partyRequest) { (data, _, _) in
            let parties = try! JSONDecoder().decode([Party].self, from: data!)
            //let parties = try! JSONSerialization.jsonObject(with: data!, options: [])
            
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
        registerRequest.httpMethod = "POST"
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
    
    func loginUser(completion: @escaping (Token, HTTPURLResponse) -> (), email: String, password: String) {
        guard let url = URL(string: "http://192.168.1.170:5000/login") else { return }
        //let query = ["email": email, "password": password]
        var registerRequest = URLRequest(url: url)
        registerRequest.httpMethod = "POST"
        registerRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let str = "\(email):\(password)"
        let utf8str = str.data(using: .utf8)
        let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        registerRequest.setValue("Basic " + base64Encoded!, forHTTPHeaderField: "Authorization")
        //registerRequest.httpBody = try! JSONSerialization.data(withJSONObject: query, options: [])
        
        URLSession.shared.dataTask(with: registerRequest) { (data, response, error) in
            let token = try! JSONDecoder().decode(Token.self, from: data!)
            print(token)
            
            DispatchQueue.main.async {
                completion(token, response as! HTTPURLResponse)
            }
        }
        .resume()
    }
}
