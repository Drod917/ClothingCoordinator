//
//  OnboardingView.swift
//  SwiftUIWorkingDemo
//
//  Created by mac-00015 on 18/10/19.
//  Copyright © 2019 mac-00015. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    
    var subViews = [
        UIHostingController(rootView: Subview(imageString: "First")),
        UIHostingController(rootView: Subview(imageString: "Second")),
        UIHostingController(rootView: Subview(imageString: "Third"))
    ]
    
    var titles = ["Welcome!", "Create a Party!\nInvite Your Friends", "Join Parties and Show Off!"]
        
    var captions =  ["Clothing coordinator makes sure you don't wear the same thing as anyone else.", "Whether it's a wedding party, a formal dinner, or a secret get-together!", "Let everyone know what you'll be wearing!"]
    
    @State var currentPageIndex = 0
    @EnvironmentObject var dataOnboard: DataOnboarding
    @EnvironmentObject var userOnboard: UserOnboard
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            PageViewController(currentPageIndex: $currentPageIndex,viewControllers: subViews)
                .frame(height: (UIScreen.main.bounds.width * 500) / 414)
            
            Spacer()
            
            Group {
                
                Text(titles[currentPageIndex])
                    .font(.title)
                
                Text(captions[currentPageIndex])
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(width: 300, height: 50, alignment: .leading)
                    .lineLimit(nil)
            }.padding([.leading, .trailing])
            
            HStack {
                
                PageControl(numberOfPages: subViews.count, currentPageIndex: $currentPageIndex)
                
                Spacer()
                
                Button(action: {
                    
                    if self.currentPageIndex + 1 == self.subViews.count {
//                        self.currentPageIndex = 0
                        
                        //if using with proprty wrapper
//                        self.dataOnboard.onboardComlete = true
                        
                        //if using with out property wrapper
                        self.userOnboard.onboardComplete = true
                    } else {
                        self.currentPageIndex += 1
                    }
                }) {
                    Image(systemName: "arrow.right")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .padding()
                        .background(lightblueColor)
                        .clipShape(Circle())
                }
            }.padding()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
