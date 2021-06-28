//
//  GuestView.swift
//  Clothing Coordinator
//
//  Created by Daniel Rodriguez on 6/21/21.
//

import SwiftUI
import SwiftDrawer

struct GuestView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var parties: [Party] = []
    @State private var showEditing = false
        
    var body: some View {
        
        NavigationView {
            ScrollView {
                ForEach(parties, id: \.id) { party in
                    Button(action: {
                        showEditing = true
                    }) {
                        PartyCardView(partyName: "\(party.partyName)", hostName: party.hostId, description: "\(party.description)", date: party.date)
                    }
                    .sheet(isPresented: $showEditing) {
                        PartyFullView(partyName: "\(party.partyName)", hostName: party.hostId, description: "\(party.description).", date: party.date)
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
                apiCall().getParties { (parties) in
                    self.parties = parties
                }
            }
        }
    }
}

struct GuestView_Previews: PreviewProvider {
    static var previews: some View {
        GuestView()
            
    }
}
