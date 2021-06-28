//
//  SliderView.swift
//  Demo
//
//  Created by Daniel Rodriguez on 6/23/21.
//  Copyright © 2021 mac-00018. All rights reserved.
//

import SwiftUI
import SwiftDrawer
struct SliderView : View, SliderProtocol {
    @EnvironmentObject var settings: UserSettings
    @EnvironmentObject public var drawerControl: DrawerControl
    
    let type: SliderType
    init(type: SliderType) {
        self.type = type
    }
    var body: some View {
        
        NavigationView {
            VStack {
                HeaderView()
                    .padding()
                                
                Button(action: {
                    self.drawerControl.setMain(view: GuestView())
                    self.drawerControl.show(type: .leftRear, isShow: false)
                }) {
                    buttonWithBackground(btnText: "Guest")
                }
                .padding(.bottom)

                Button(action: {
                    self.drawerControl.setMain(view: HostView())
                    self.drawerControl.show(type: .leftRear, isShow: false)
                }) {
                    buttonWithBackground(btnText: "Host")
                }
                .padding(.bottom)
                
                Button(action: {
                        // For use with property wrapper
                        UserDefaults.standard.set(false, forKey: "Loggedin")
                        UserDefaults.standard.synchronize()
                        self.settings.loggedIn = false
                        // ==========
                        
                        // For use with property wrapper
                        //                self.dataStore.loggedIn = false
                        // ==========
                }) {
                    buttonWithBackground(btnText: "LOGOUT")
                }
            }
            .padding(.bottom, 600)
            //.padding(.trailing, 25)
        }
//            HeaderView()
//
//            SliderCell(imgName: "home", title: "Home").onTapGesture {
//                self.drawerControl.setMain(view: HomeView())
//                self.drawerControl.show(type: .leftRear, isShow: false)
//            }.onAppear {
//
//            }
//
//            SliderCell(imgName: "account", title: "Account").onTapGesture {
//                self.drawerControl.setMain(view: AccountView())
//                self.drawerControl.show(type: .leftRear, isShow: false)
//            }

        
        
    }
}


#if DEBUG
struct SliderView_Previews : PreviewProvider {
    static var previews: some View {
        SliderView(type: .leftRear)
    }
}
#endif
