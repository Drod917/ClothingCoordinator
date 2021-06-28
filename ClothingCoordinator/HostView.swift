//
//  GuestView.swift
//  Clothing Coordinator
//
//  Created by Daniel Rodriguez on 6/21/21.
//

import SwiftUI
import SwiftDrawer

struct HostView: View {
        
    var body: some View {
        
        NavigationView {
            ScrollView {
//                ForEach(parties, id: \.id) { party in
//                    PartyCardView(partyName: "Test", hostName: "Test", description: "Test", date: "Test")
//                }
                HStack {
                    Image(systemName: "plus.circle")
                        .padding(.top, 20)
                }
            }
            .navigationBarTitle("Hosted Parties")
        }
    }
}

struct HostView_Previews: PreviewProvider {
    static var previews: some View {
        HostView()
    }
}
