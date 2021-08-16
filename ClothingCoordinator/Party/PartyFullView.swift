//
//  CardImageView.swift
//  Clothing Coordinator
//
//  Created by Daniel Rodriguez on 6/21/21.
//

import SwiftUI

struct PartyFullView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    let randomNum = Int.random(in: 0...2)
    let images = [
        "party1",
        "party2",
        "party3"
    ]
    @State private var showDelete: Bool = false
    @State var partyName : String
    @State var hostName: String
    @State var description: String
    @State var date: String
    @State var inviteCode: String
    @State var host: Bool
    
    @State var guestlist: [String] = []
    @State var token: String = ""
    
    var body: some View {
        VStack {
            Image("\(images[randomNum])")
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 200)
                .cornerRadius(20)
                .shadow(radius: 5)
            VStack {
                HStack {
                    Text("\(partyName)")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                    Spacer()
                    Text(inviteCode)
                }
                .padding(.leading)
                .padding(.trailing, 20)
                HStack {
                    Text("\(date)")
                        .font(.system(size: 10,
                            design: .rounded))
                        .padding(.leading)
                    Spacer()
                    Text("Host:\n\(hostName)")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .padding(.bottom, 20)
                        .frame(width: 150, height: 50)
                }
            }
            HStack {
                // 70 Character maximum
                Text("\(description)")
                    .font(.system(size: 14, design: .rounded))
                    .frame(width: 200, alignment: .leading)
                Spacer()
                Button(action: {
                    self.showDelete = true
                }) {
                    Image(systemName: "xmark.circle.fill")
                }
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .alert(isPresented: $showDelete, content: {
                    let confirm = Alert.Button.destructive(Text("Confirm")) {
                        let token = UserDefaults.standard.string(forKey: "token") ?? "No token found"
                        
                        if (host == true) {
                            apiCall().deleteParty(completion: {
                                response in
                                if (response.statusCode == 200) {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }, name: partyName, token: token)
                        }
                        else {
                            apiCall().leaveParty(completion: {
                                response in
                                if (response.statusCode == 200) {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }, name: partyName, token: token)
                        }
                        
                    }
                    let cancel = Alert.Button.default(Text("Cancel")) {/*do nothing*/}
                    
                    return Alert(title: Text(host == true ? "Are you sure you want to delete \(partyName)?": "Are you sure you want to leave \(partyName)?"), message: Text(""), primaryButton: confirm, secondaryButton: cancel)
                    })

            }
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom, 40)
            
            Text("Guestlist")
                .padding(.trailing, (UIScreen.main.bounds.width * 235) / 414)
            List {
                ForEach(0..<guestlist.count, id:\.self) {
                    i in
                    Text(guestlist[i])
                }
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 300, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 1)
            )
            .padding(EdgeInsets(top: 0, leading: 50, bottom: 10, trailing: 50))
        }
        .padding(.top)
    }
}

struct PartyFullView_Previews: PreviewProvider {
    static var previews: some View {
        PartyFullView(partyName: "Daniel's Birthday", hostName: "Daniel", description: "Here is where the description goes.", date: "01/01/1970", inviteCode: "xxxXXX", host: true, guestlist: ["test","test2"])
            .preferredColorScheme(.light)
    }
}
