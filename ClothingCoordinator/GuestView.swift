//
//  GuestView.swift
//  Clothing Coordinator
//
//  Created by Daniel Rodriguez on 6/21/21.
//

import SwiftUI
import SwiftDrawer

struct GuestView: View {
    @EnvironmentObject var settings: UserSettings
    @Environment(\.colorScheme) var colorScheme
    @State var parties: [Party] = []
    @State private var showEditing = false
    @State var token: String = ""
        
    var body: some View {
        
        NavigationView {
            ScrollView {
                ForEach(parties, id: \.id) { party in
                    Button(action: {
                        showEditing = true
                    }) {
                        PartyCardView(partyName: "\(party.name)", hostName: String(party.host), description: "\(party.description)", date: party.date)
                    }
                    .sheet(isPresented: $showEditing) {
                        PartyFullView(partyName: "\(party.name)", hostName: String(party.host), description: "\(party.description).", date: party.date)
                    }
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                }
                HStack {
                    Image(systemName: "plus.circle")
                        .padding(.top, 20)
                }
            }
            .navigationBarTitle("Guest List")
            .onAppear {
                token = UserDefaults.standard.string(forKey: "token") ?? "No token found"
                //token = settings.token
                
                apiCall().getInvitedParties(completion:  {     (parties) in
                        self.parties = parties
                    },
                token: token)
            }
        }
    }
}

struct GuestView_Previews: PreviewProvider {
    static var previews: some View {
        GuestView()
            
    }
}
