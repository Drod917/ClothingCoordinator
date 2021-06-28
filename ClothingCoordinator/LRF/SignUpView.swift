//
//  SignUpView.swift
//  DemoSwiftUI
//
//  Created by mac-00018 on 10/10/19.
//  Copyright © 2019 mac-00018. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @State var users: [User] = []
    
    @EnvironmentObject var settings: UserSettings
    @State var name: String = ""
    @State var email: String = ""
    @State var password = ""
    @State var confirmPassword = ""
    
    
    @State var alertMsg = ""
    @State var selection: Int = 1
    @State var integers: [String] = ["0", "1", "2", "3", "4", "5"]
    
    @State var date = Date()
    
    @State var emailExists : Bool = false
    
    @State var showImagePicker: Bool = false
    @State var showCamera: Bool = false
    @State var image: Image? = nil
    
    @State var showAlert = false
    @State var showActionSheet: Bool = false
    
    @State var signupSelection: Int? = nil
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var birthDate = Date()
    
    var alert: Alert {
        Alert(title: Text(""), message: Text(alertMsg), dismissButton: .default(Text("OK")))
    }
    
    var body: some View {
        
//        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
        
        ScrollView {
            
            VStack {
                
                VStack {
                    
                    Spacer(minLength: 20)
                    
                    HStack {
                        
                        Image("ic_user")
                            .padding(.leading, 20)
                        
                        TextField("Name", text: $name)
                            .frame(height: 40, alignment: .center)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .imageScale(.small)
                        
                        
                    }
                    seperator()
                }
                
                VStack {
                    
                    HStack {
                        
                        Image("ic_email")
                            .padding(.leading, 20)
                        
                        TextField("Email", text: $email)
                            .frame(height: 40, alignment: .center)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .imageScale(.small)
                            .keyboardType(.emailAddress)
                            .autocapitalization(UITextAutocapitalizationType.none)
                        
                    }
                    seperator()
                }
                
                VStack {
                    
                    HStack {
                        
                        Image("ic_password")
                            .padding(.leading, 20)
                        
                        SecureField("Password", text: $password)
                            .frame(height: 40, alignment: .center)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .imageScale(.small)
                        
                    }
                    seperator()
                }
                
                VStack {
                    
                    HStack {
                        
                        Image("ic_password")
                            .padding(.leading, 20)
                        
                        SecureField("Confirm Password", text: $confirmPassword)
                            .frame(height: 40, alignment: .center)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .imageScale(.small)
                        
                    }
                    seperator()
                }
                
               
                VStack {
                    
//                    VStack {
//
//                        NavigationLink(destination: LoginView(), tag: 1, selection: $signupSelection) {
//                            Button(action: {
//                                if  self.isValidInputs() {
//                                    print("Signup tapped")
//                                    self.signupSelection = 1
//                                }
//
//                            }) {
//                                HStack {
//                                    buttonWithBackground(btnText: "SUBMIT")
//                                }
//                            }
//
//                        }
//                    }
                 
                    Button(action: {

                        if self.isValidInputs() {
//                            self.presentationMode.wrappedValue.dismiss()
//                            UserDefaults.standard.set(true, forKey: "Loggedin")
//                            UserDefaults.standard.synchronize()
//                            self.settings.loggedIn = true
                            apiCall().registerUser(completion: {
                                (response) in
                                //print(response.statusCode)
                                if (response.statusCode == 406)
                                {
                                    self.alertMsg = "Email address is already associated with an existing account."
                                    self.showAlert.toggle()
                                }
                                else
                                {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }, name: name, email: email, password: password)
                        }
                    }) {

                        buttonWithBackground(btnText: "SignUp")
                    }
                    .padding(.bottom, (UIScreen.main.bounds.width * 30) / 414)
                    .alert(isPresented: $showAlert, content: { self.alert })
                }
            
            }
            
        }.navigationBarTitle("SignUp")
            .font(.system(size: 20, weight: .semibold, design: .default))
            .padding(.top, 40)
            .alert(isPresented: $showAlert, content: { self.alert })
    }
    
    fileprivate func isValidInputs() -> Bool {
        
        if self.name == "" {
            self.alertMsg = "First name can't be blank."
            self.showAlert.toggle()
            return false
        } else if self.email == "" {
            self.alertMsg = "Email can't be blank."
            self.showAlert.toggle()
            return false
        } else if !self.email.isValidEmail {
            self.alertMsg = "Email is not valid."
            self.showAlert.toggle()
            return false
        } else if self.password == "" {
            self.alertMsg = "Password can't be blank."
            self.showAlert.toggle()
            return false
        } else if !(self.password.isValidPassword) {
            self.alertMsg = "Please enter valid password"
            self.showAlert.toggle()
            return false
        } else if self.confirmPassword == "" {
            self.alertMsg = "Confirm password can't be blank."
            self.showAlert.toggle()
            return false
        } else if self.password != self.confirmPassword {
            self.alertMsg = "Password and confirm password dose not matched."
            self.showAlert.toggle()
            return false
        }
        
        return true
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
