//
//  PartyViewModel.swift
//  Demo
//
//  Created by Daniel Rodriguez on 6/25/21.
//  Copyright © 2021 mac-00018. All rights reserved.
//

import Foundation
import SwiftUI

//class guestController {
//    func getCards(completion:@escaping (([PartyFullView]) -> ()), parties: [Party]) {
//        var fullCardViews: [PartyFullView]
//        ForEach (parties) { party in
//            var new_card = PartyFullView(partyName: party.name, hostName: party.host, description: party.description, date: party.date)
//            fullCardViews.append(new_card)
//        }
//    }s
//}

class apiCall {
    let apiIP = "http://192.168.1.170:5000"
    
    func getHostedParties(completion:@escaping ([Party]) -> (), token: String) {
        guard let url = URL(string: apiIP + "/party/host") else { return }
        var partyRequest = URLRequest(url: url)
        partyRequest.addValue(token, forHTTPHeaderField: "x-access-tokens")
        
        URLSession.shared.dataTask(with: partyRequest) { (data, _, _) in
            let parties = try? JSONDecoder().decode([Party].self, from: data!)
            if (parties == nil) {
                print("No invited parties found!")
            }
            
            // fails and returns json if user has no token
            DispatchQueue.main.async {
                completion(parties ?? [])
            }
        }
        .resume()
    }
    
    func getInvitedParties(completion:@escaping ([Party]) -> (), token: String) {
        guard let url = URL(string: apiIP + "/party/guest") else { return }
        var partyRequest = URLRequest(url: url)
        partyRequest.addValue(token, forHTTPHeaderField: "x-access-tokens")
        
        URLSession.shared.dataTask(with: partyRequest) { (data, response, _) in
            // catch Swift.DecodingError: user not logged in so API returns {"message":"not logged in"}
            let parties = try? JSONDecoder().decode([Party].self, from: data!)
            //let parties = try! JSONSerialization.jsonObject(with: data!, options: [])
            if (parties == nil) {
                print("No invited parties found!")
            }
            
            // fails and returns a json message if user has no token
            DispatchQueue.main.async {
                completion(parties ?? [])
            }
        }
        .resume()
    }
    
    func createParty(completion:@escaping (HTTPURLResponse) -> Void, name: String, desc: String, date: String, publicity: Bool, userlist: [String], token: String) {
        guard let url = URL(string: apiIP + "/party/create") else { return }
        var joinPartyRequest = URLRequest(url: url)
        var publicity_lvl: String
        var query: Dictionary? = [:]
        
        if (publicity == true) {
            publicity_lvl = "open_with_blacklist"
            query = ["name" : name, "description" : desc, "date" : date, "publicity" : publicity_lvl, "blacklist" : userlist]

        }
        else {
            publicity_lvl = "whitelist_only"
            query = ["name" : name, "description" : desc, "date" : date, "publicity" : publicity_lvl, "whitelist": userlist]
        }
        
        joinPartyRequest.httpMethod = "POST"
        joinPartyRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        joinPartyRequest.addValue(token, forHTTPHeaderField: "x-access-tokens")
        joinPartyRequest.httpBody = try! JSONSerialization.data(withJSONObject: query, options: [])

        URLSession.shared.dataTask(with: joinPartyRequest) { (data, response, error) in
            
            DispatchQueue.main.async {
                completion(response as! HTTPURLResponse)
            }
        }
        .resume()
    }
    
    func joinParty(completion:@escaping (HTTPURLResponse) -> Void, code: String, token: String) {
        guard let url = URL(string: apiIP + "/party/guest/join") else { return }
        var joinPartyRequest = URLRequest(url: url)
        let query = ["invite_code" : code]
        joinPartyRequest.httpMethod = "POST"
        joinPartyRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        joinPartyRequest.addValue(token, forHTTPHeaderField: "x-access-tokens")
        joinPartyRequest.httpBody = try! JSONSerialization.data(withJSONObject: query, options: [])

        URLSession.shared.dataTask(with: joinPartyRequest) { (data, response, error) in
            
            DispatchQueue.main.async {
                completion(response as! HTTPURLResponse)
            }
        }
        .resume()
    }
    
    func deleteParty(completion:@escaping (HTTPURLResponse) -> Void, name: String, token: String) {
        guard let url = URL(string: apiIP + "/party/delete") else { return }
        var deletePartyRequest = URLRequest(url: url)
        let query = ["name" : name]
        deletePartyRequest.httpMethod = "DELETE"
        deletePartyRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        deletePartyRequest.addValue(token, forHTTPHeaderField: "x-access-tokens")
        deletePartyRequest.httpBody = try! JSONSerialization.data(withJSONObject: query, options: [])

        URLSession.shared.dataTask(with: deletePartyRequest) { (data, response, error) in
            
            DispatchQueue.main.async {
                completion(response as! HTTPURLResponse)
            }
        }
        .resume()
    }
    
    func leaveParty(completion:@escaping (HTTPURLResponse) -> Void, name: String, token: String) {
        guard let url = URL(string: apiIP + "/party/guest/leave") else { return }
        var leavePartyRequest = URLRequest(url: url)
        let query = ["party_name" : name]
        leavePartyRequest.httpMethod = "POST"
        leavePartyRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        leavePartyRequest.addValue(token, forHTTPHeaderField: "x-access-tokens")
        leavePartyRequest.httpBody = try! JSONSerialization.data(withJSONObject: query, options: [])

        URLSession.shared.dataTask(with: leavePartyRequest) { (data, response, error) in
            
            DispatchQueue.main.async {
                completion(response as! HTTPURLResponse)
            }
        }
        .resume()
    }
    
    func getUserInfo(completion: @escaping (User) -> (), id: Int, token: String) {
        guard let url = URL(string: apiIP + "/user/" + String(id)) else { return }
        var userInfoRequest = URLRequest(url: url)
        userInfoRequest.httpMethod = "GET"
        userInfoRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        userInfoRequest.addValue(token, forHTTPHeaderField: "x-access-tokens")

        URLSession.shared.dataTask(with: userInfoRequest) { (data, response, error) in
            let user = try! JSONDecoder().decode(User.self, from: data!)
            
            DispatchQueue.main.async {
                completion(user)
            }
        }
        .resume()
    }
    
    func registerUser(completion: @escaping (HTTPURLResponse) -> Void, name: String, email: String, password: String) {
        guard let url = URL(string: apiIP + "/register") else { return }
        let query = ["username": name, "email": email, "password": password]
        print("Register query:\n username: \(name)\n email: \(email)\n pw: \(password)")
        var registerRequest = URLRequest(url: url)
        registerRequest.httpMethod = "POST"
        registerRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        registerRequest.httpBody = try! JSONSerialization.data(withJSONObject: query, options: [])
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 5
        sessionConfig.timeoutIntervalForResource = 10
        let session = URLSession(configuration: sessionConfig)
        
        //URLSession.shared.dataTask(
        session.dataTask(with: registerRequest) { (data, response, error) in
            //let users = try! JSONDecoder().decode([User].self, from: data!)
            if (response != nil) {
                DispatchQueue.main.async {
                    completion(response as! HTTPURLResponse)
                }
            }
            
            if (error as? URLError)?.code == .timedOut {
                // Timed out
                DispatchQueue.main.async {
                    completion(HTTPURLResponse(url: URL(string: "...")!, statusCode: 408, httpVersion: nil, headerFields: nil)!)
                }
            }
        }
        .resume()
    }
    
    func loginUser(completion: @escaping (LoggedInfo, HTTPURLResponse) -> (), username: String, password: String) {
        guard let url = URL(string: apiIP + "/login") else { return }
        //let query = ["email": email, "password": password]
        var loginRequest = URLRequest(url: url)
        loginRequest.httpMethod = "POST"
        loginRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let str = "\(username):\(password)"
        let utf8str = str.data(using: .utf8)
        let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        loginRequest.setValue("Basic " + base64Encoded!, forHTTPHeaderField: "Authorization")
        //registerRequest.httpBody = try! JSONSerialization.data(withJSONObject: query, options: [])
        
        URLSession.shared.dataTask(with: loginRequest) { (data, response, error) in
            let loginInfo = try! JSONDecoder().decode(LoggedInfo.self, from: data!)
            print(loginInfo)
            
            DispatchQueue.main.async {
                completion(loginInfo, response as! HTTPURLResponse)
            }
        }
        .resume()
    }
}
