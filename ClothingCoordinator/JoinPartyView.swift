//
//  JoinPartyView.swift
//  Clothing Coordinator
//
//  Created by Daniel Rodriguez on 6/21/21.
//

import SwiftUI

struct JoinPartyView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    @State var inviteCode: String = ""
    @State var token: String = ""
    @State var alertMsg = ""
    @State var alertTitle = ""
    @State var showAlert: Bool = false
    
    var alert: Alert {
        Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("OK")))
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Enter an invite code")
            TextField("Invite Code", text: $inviteCode)
                .frame(height: (UIScreen.main.bounds.width * 40) / 414, alignment: .center)
                .padding(.leading, (UIScreen.main.bounds.width * 10) / 414)
                .padding(.trailing, (UIScreen.main.bounds.width * 10) / 414)
                .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .regular, design: .default))
                .imageScale(.small)
                .autocapitalization(UITextAutocapitalizationType.none)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 2)
                )
                .padding(EdgeInsets(top: 0, leading: 40, bottom: 30, trailing: 40))
            Button(action: {
                apiCall().joinParty(completion: {
                    response in
                    
                    // Parse response
                    if (response.statusCode == 200) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    else if (response.statusCode == 404) {
                        self.alertTitle = "Invalid code " + inviteCode
                        self.alertMsg = "Party doesn't exist."
                        self.showAlert.toggle()
                    }
                    else if (response.statusCode == 403) {
                        self.alertTitle = "Not on the list"
                        self.alertMsg = "You aren't allowed in this party."
                        self.showAlert.toggle()
                    }
                    else if (response.statusCode == 401) {
                        self.alertTitle = "Already joined"
                        self.alertMsg = "You're already in this party."
                        self.showAlert.toggle()
                    }
                    else {
                        print(response.statusCode)
                    }
                }, code: inviteCode, token: token)
            }) {
                buttonWithBackground(btnText: "Join")
                
            }
        }
        .alert(isPresented: $showAlert, content: { self.alert })
        .onAppear {
            token = UserDefaults.standard.string(forKey: "token") ?? "No token found"
        }
    }
}

struct JoinParty_Previews: PreviewProvider {
    static var previews: some View {
        JoinPartyView()
    }
}
