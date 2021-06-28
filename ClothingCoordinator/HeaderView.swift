//
//  HeaderView.swift
//  SwiftDrawer_Example
//
//  Created by Millman on 2019/7/1.
//  Copyright © 2019 CocoaPods. All rights reserved.
//
import SwiftUI

struct HeaderView : View {
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .frame(width: 50, height: 50, alignment: .trailing)
            VStack(alignment: .leading) {
                Text("Daniel Rodriguez")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                Text("daniel@rodriguez.com")
            }
            .frame(width: 175, height: 50)
        }
    }
}

#if DEBUG
struct HeaderView_Previews : PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
#endif
