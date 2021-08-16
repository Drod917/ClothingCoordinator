//
//  HeaderView.swift
//  SwiftDrawer_Example
//
//  Created by Millman on 2019/7/1.
//  Copyright © 2019 CocoaPods. All rights reserved.
//
import SwiftUI

struct HeaderView : View {
    @EnvironmentObject var settings: UserSettings
    @State var username: String = ""
    @State var email: String = ""
    
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .frame(width: 50, height: 50, alignment: .trailing)
            VStack(alignment: .leading) {
                Text(self.settings.username)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                Text(self.settings.email)
            }
            .frame(width: 175, height: 50)
            .onAppear {
                username = UserDefaults.standard.string(forKey: "username") ?? "No user found"
                email = UserDefaults.standard.string(forKey: "email") ?? "No email found"
                self.settings.username = username
                self.settings.email = email
            }
        }
    }
}

#if DEBUG
struct HeaderView_Previews : PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
#endif
