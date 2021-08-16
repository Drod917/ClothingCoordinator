//
//  CardImageView.swift
//  Clothing Coordinator
//
//  Created by Daniel Rodriguez on 6/21/21.
//

import SwiftUI

struct PartyCardView: View {
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
        ZStack {
            if (Color(UIColor.systemBackground) == Color.white) {
                Rectangle()
                    .fill(Color(UIColor.systemBackground))
            }
            else {
                Rectangle()
                    .fill(Color(UIColor.systemBackground))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3).foregroundColor(.white))
            }
            VStack {
                HStack {
                    Image("\(images[randomNum])")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 125)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                    VStack {
                        Text("\(partyName)")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .frame(height: 50)
                        Spacer()
                        Text("Host:\n\(hostName)")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .padding(.bottom, 20)
                            .frame(width: 150, height: 50)
                        Text("\(date)")
                            .font(.system(size: 10,
                                design: .rounded))
                    }
                    .frame(width: 150, height: 100)
                }
                .padding(.bottom, 10)
                HStack {
                    // 70 Character maximum
                    Text("\(description)")
                        .font(.system(size: 14, design: .rounded))
                        .frame(width: 200, alignment: .leading)
                    Spacer()
                        .frame(width: 120)
                }
            }
            .padding()
        }
        .aspectRatio(CGSize(width:16, height:9), contentMode: .fit)
        .cornerRadius(10)
        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
        .shadow(color: Color(UIColor.systemBackground) == Color.white ? Color.white : Color.gray,
                radius: 7)
    }
}

struct PartyCardView_Previews: PreviewProvider {
    static var previews: some View {
        PartyCardView(partyName: "Daniel's Birthday", hostName: "Daniel", description: "Here is where the description goes.", date: "01/01/1970")
            .preferredColorScheme(.light)
    }
}
