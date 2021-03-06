//
//  CreatePartyView.swift
//  Clothing Coordinator
//
//  Created by Daniel Rodriguez on 6/21/21.
//

import SwiftUI

struct CreatePartyView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    
    @State var partyName: String = ""
    @State var partyDesc: String = ""
    @State var partyDate: String = ""
    
    
    @State var token: String = ""
    
    @State var alertMsg = ""
    @State var alertTitle = ""
    @State var showAlert: Bool = false
    @State var isPublic: Bool = true
    @State var userlist: [String] = []
    
    var alert: Alert {
        Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("OK")))
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Enter party details")
            TextField("Party name", text: $partyName)
                .frame(height: (UIScreen.main.bounds.width * 40) / 414, alignment: .center)
                .padding(.leading, (UIScreen.main.bounds.width * 10) / 414)
                .padding(.trailing, (UIScreen.main.bounds.width * 10) / 414)
                .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .regular, design: .default))
                .imageScale(.small)
                .autocapitalization(UITextAutocapitalizationType.none)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                )
                .padding(EdgeInsets(top: 0, leading: 40, bottom: 5, trailing: 40))
            TextField("Description", text: $partyDesc)
                .frame(height: (UIScreen.main.bounds.width * 40) / 414, alignment: .center)
                .padding(.leading, (UIScreen.main.bounds.width * 10) / 414)
                .padding(.trailing, (UIScreen.main.bounds.width * 10) / 414)
                .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .regular, design: .default))
                .imageScale(.small)
                .autocapitalization(UITextAutocapitalizationType.none)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                )
                .padding(EdgeInsets(top: 0, leading: 40, bottom: 5, trailing: 40))
            TextField("Date", text: $partyDate)
                .frame(height: (UIScreen.main.bounds.width * 40) / 414, alignment: .center)
                .padding(.leading, (UIScreen.main.bounds.width * 10) / 414)
                .padding(.trailing, (UIScreen.main.bounds.width * 10) / 414)
                .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .regular, design: .default))
                .imageScale(.small)
                .autocapitalization(UITextAutocapitalizationType.none)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                )
                .padding(EdgeInsets(top: 0, leading: 40, bottom: 20, trailing: 40))
            Toggle("Public", isOn: $isPublic)
                .padding(.leading, (UIScreen.main.bounds.width * 250) / 414)
                .padding(.trailing, (UIScreen.main.bounds.width * 50) / 414)
                .padding(.bottom, 20)
            
            Text(isPublic ? "Blacklist" : "Whitelist")
                .padding(.trailing, (UIScreen.main.bounds.width * 235) / 414)
            
            List {
                ForEach(0..<userlist.count, id:\.self) {
                    i in
                    TextField("Enter user", text: $userlist[i])
                }
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 150, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 1)
            )
            .padding(EdgeInsets(top: 0, leading: 50, bottom: 10, trailing: 50))
            
            Button(action: {
                userlist.append("")
            }) {
                Image(systemName: "plus.circle")
            }
            .padding(.leading, 300)

            
            Button(action: {
                apiCall().createParty(completion: {
                    response in
                    
                    // Parse response
                    if (response.statusCode == 200) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    else if (response.statusCode == 406) {
                        self.alertTitle = "Party exists"
                        self.alertMsg = "Party already exists."
                        self.showAlert.toggle()
                    }
                    else {
                        print(response.statusCode)
                        print("sending token: \(token)")
                    }
                }, name: partyName, desc: partyDesc, date: partyDate, publicity: isPublic, userlist: userlist, token: token)
            }) {
                buttonWithBackground(btnText: "Create")
            }
        }
        .alert(isPresented: $showAlert, content: { self.alert })
        .onAppear {
            token = UserDefaults.standard.string(forKey: "token") ?? "No token found"
        }
    }
}

struct CreatePartyView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePartyView(token: "")
    }
}
