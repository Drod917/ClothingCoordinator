//
//  HostView.swift
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
    @State var selectedParty: Party!
    @State var token: String = ""
    @State var showJoinParty: Bool = false
        
    var body: some View {
        
        NavigationView {
            ScrollView {
                ForEach(parties) { party in
                    Button(action: {
                        selectedParty = party
                    }) {
                        PartyCardView(partyName: "\(party.name)", hostName: party.host, description: "\(party.description)", date: party.date)
                    }
                    .sheet(item: $selectedParty, onDismiss: {
                        apiCall().getInvitedParties(completion:  {     (parties) in
                                    self.parties = parties
                                },
                                token: token)
                        }) { party in
                        PartyFullView(partyName: "\(party.name)", hostName: party.host, description: "\(party.description)", date: party.date, inviteCode: party.inviteCode, host: false)
                    }
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                }
                HStack {
                    Button(action: {
                        showJoinParty = true
                    }) {
                        Image(systemName: "plus.circle")
                            .padding(.top, 20)
                    }
                    .sheet(isPresented: $showJoinParty, onDismiss: {
                        apiCall().getInvitedParties(completion:  {     (parties) in
                                    self.parties = parties
                                },
                                token: token)
                        }) {
                        JoinPartyView()
                    }
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                }
            }
            .navigationBarTitle("Guest List")
            .onAppear {
                token = UserDefaults.standard.string(forKey: "token") ?? "No token found"
                
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
