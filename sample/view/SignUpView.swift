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
    
    @EnvironmentObject var session: UserSession   // ✅ shared state
    
    let option = ["Active", "Inactive"]
    var body: some View {
        NavigationStack {
            ZStack{
                Color(.systemBlue).edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Text("Sign Up")
                        .font(.largeTitle)
                        .bold(true)
                    
                    TextField("", text: $username,
                              prompt: Text("Username").foregroundColor(.gray))
                        .padding(12)
                        .background(Color.white)        // always white background
                        .cornerRadius(10)
                        .foregroundColor(.black)        // text color
                        .shadow(radius: 2)              // subtle shadow
                        .padding(.horizontal)
                        .textInputAutocapitalization(.never)
                    
                    
                    SecureField("Password", text: $password,
                                prompt: Text("Username").foregroundColor(.gray))
                          .padding(12)
                          .background(Color.white)        // always white background
                          .cornerRadius(10)
                          .foregroundColor(.black)        // text color
                          .shadow(radius: 2)              // subtle shadow
                          .padding(.horizontal)
                          .textInputAutocapitalization(.never)
                    
                    Text("Selected: \(selectionOption)")
                        .font(.headline)
                        .foregroundColor(.black)
                        .bold(true)
                    
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
                    
                    Button() {
                        cancelAccount()
                    } label: {
                        Text("Cancell")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    
                    Spacer()
                }
                .padding()
                .background(Color.white)          // card background
                .cornerRadius(20)
                .shadow(radius: 5)                // subtle shadow
                .padding()
            }
            .alert(isPresented: $showingAlert){
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")))
            }
        }
        
    }
    
    func cancelAccount() {
        session.viewType = .login
    }
    func createAccount() {
        
        
        guard !username.isEmpty, !password.isEmpty else {
            alertMessage = "Please fill in all fields."
            showingAlert = true
            return
        }
        
        let registerDTO = RegisterRequestDTO(username: username,password: password, status:"Active")
        guard let jsonData = try? JSONEncoder().encode(registerDTO) else {
            alertMessage = "Encoding failed."
            showingAlert = true
            return
        }
        
        let urlString = "https://springapi-b2z9.onrender.com/api/v1/user-account/createUserAccount"
        guard let url = URL(string: urlString) else {
            alertMessage = "Invalid URL."
            showingAlert = true
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    alertMessage = "Error: \(error.localizedDescription)"
                    showingAlert = true
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                DispatchQueue.main.async {
                    alertMessage = "Server error: \(httpResponse.statusCode)"
                    showingAlert = true
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    alertMessage = "No data received."
                    showingAlert = true
                }
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(RegisterResponseDTO.self, from: data)
                DispatchQueue.main.async {
                    if decodedResponse.status == "OK" {
                       
                        alertMessage = "Welcome, \(decodedResponse.userDetails.username) \(decodedResponse.userDetails.password)!"
                    } else {
                        alertMessage = decodedResponse.message
                        alertTitle = "Successfully"
                        session.viewType = .login
                    }
                    showingAlert = true
                }
            } catch {
                DispatchQueue.main.async {
                    alertMessage = "Decoding failed: \(error.localizedDescription)"
                    showingAlert = true
                }
            }
        }.resume()
    }
}

#Preview {
    SignUpView()
}
