//
//  CardImageView.swift
//  Clothing Coordinator
//
//  Created by Daniel Rodriguez on 6/21/21.
//

import SwiftUI

struct PartyFullView: View {
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
                        .padding(.leading)
                    Spacer()
                }
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
                    Alert(title: Text("Are you sure you want to leave \(partyName)?"), message: Text(""), primaryButton: .cancel(Text("Stay")), secondaryButton:.destructive(Text("Leave")))
                })
            }
            .padding(.leading)
            .padding(.trailing)
            Spacer()
        }
        .padding(.top)
    }
}

struct PartyFullView_Previews: PreviewProvider {
    static var previews: some View {
        PartyFullView(partyName: "Daniel's Birthday", hostName: "Daniel", description: "Here is where the description goes.", date: "01/01/1970")
            .preferredColorScheme(.light)
    }
}
