//
//  SignUpView.swift
//  sample
//
//  Created by Neil on 9/3/25.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var selectionOption = "Active"
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertTitle: String = ""
    
    let option = ["Active", "Inactive"]
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Sign Up")
                    .font(.largeTitle)
                    .bold(true)
                
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .padding(.horizontal)
                
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Text("Selected: \(selectionOption)")
                    .font(.headline)
                
                Picker("Select an option", selection: $selectionOption) {
                                ForEach(option, id: \.self) { option in
                                    Text(option)
                                }
                            }
                            .pickerStyle(.menu) // ✅ shows as dropdown instead of wheel
                            .padding()
                
                Button() {
                    createAccount()
                } label: {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                
                
                Spacer()
            }
            .padding()
            .alert(isPresented: $showingAlert){
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")))
            }
        }
        
    }
    func createAccount() {
        
        
        guard !username.isEmpty, !password.isEmpty else {
            alertMessage = "Please fill in all fields."
            showingAlert = true
            return
        }
    }
}

#Preview {
    SignUpView()
}
