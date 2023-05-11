//
//  UserAccountView.swift
//  BudgetApp
//
//  Created by Harjinder Pal Singh on 2/5/2023.
//


import SwiftUI

enum ProfileSection: String, CaseIterable {
    case signUp = "Sign Up"
    case signIn = "Sign In"
}

struct UserAccountView: View {
    @EnvironmentObject private var authModel: AuthViewModel
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var isNewUser = false
    @State var segmentationSelection : ProfileSection = .signIn
    @State private var showToast = false
    @State private var errorValue = ""
    @State private var showForgotPassword = false
    @State private var forgotPasswordEmail = ""
    var body: some View {
        Form {
            Section {
                Picker("", selection: $segmentationSelection) {
                    ForEach(ProfileSection.allCases, id: \.self) { option in
                        Text(option.rawValue)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
            }
            Section {
                TextField("Email", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .keyboardType(.default)
            }
            Section {
                VStack(alignment: .center) {
                    Button(
                        action: {
                            actionButtonTapped()
                        },
                        label: {
                            Text(segmentationSelection.rawValue)
                                .bold()
                        }
                        
                    )
                }
                .alert(isPresented: $showToast, content: {
                    Alert(title: Text(errorValue))
                })
                .frame(maxWidth: .infinity)
            }
            
            if segmentationSelection == .signIn {
                Section {
                    VStack(alignment: .center) {
                        Button(
                            action: {
                                showForgotPassword = true
                            },
                            label: {
                                Text("Forgot Password")
                                    .foregroundColor(.gray)
                                    .underline()
                                
                            })
                        .alert("Update Password", isPresented: $showForgotPassword, actions: {
                            TextField(
                                "Email",
                                text: $forgotPasswordEmail
                            )
                            
                            Button("Get reset Link", action: {
                               onTapForgotPassword()
                            })
                            .alert(isPresented: $showToast, content: {
                                Alert(title: Text(errorValue))
                            })
                            
                            Button("Cancel", role: .cancel, action: {
                               print("cancel")
                            })
                        }, message: {
                            Text("Please, enter your new Record")
                        })
                        
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            
        }.navigationTitle(segmentationSelection.rawValue)
    }
    
    private func actionButtonTapped() {
        if segmentationSelection == .signUp {
            authModel.signUp(
                emailAddress: emailAddress,
                password: password) { error in
                    showToast.toggle()
                    errorValue = error.localizedDescription
                }
        } else {
            authModel.signIn(
                emailAddress: emailAddress,
                password: password,
                errorHandler: { error in
                    showToast.toggle()
                    errorValue = error.localizedDescription
                }
            )
        }
    }
    
    private func onTapForgotPassword() {
        authModel
            .forgotPassword(email: forgotPasswordEmail) { error in
                showToast.toggle()
                errorValue = error.localizedDescription
            }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        UserAccountView()
    }
}
