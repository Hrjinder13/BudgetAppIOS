//
//  SignupView.swift
//  BudgetApp
//
//  Created by Harjinder Pal Singh on 2/5/2023.
//


import SwiftUI

enum ProfileSection: String, CaseIterable {
    case signUp = "Sign Up"
    case signIn = "Sign In"
}

struct SignUpView: View {
    @EnvironmentObject private var authModel: AuthViewModel
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var isNewUser = false
    @State var segmentationSelection : ProfileSection = .signIn
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
                .frame(maxWidth: .infinity)
            }
            if segmentationSelection == .signIn {
                Section {
                    VStack(alignment: .center) {
                        Button(
                            action: {
                                //
                            },
                            label: {
                                
                                Text("Forgot Password")
                                    .foregroundColor(.gray)
                                    .underline()
                                
                            }
                        )
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
                password: password
            )
        } else {
            authModel.signIn(
                emailAddress: emailAddress,
                password: password
            )
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
