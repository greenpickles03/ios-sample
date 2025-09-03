import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @EnvironmentObject var session: UserSession   // ✅ shared state

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()

                TextField("Email or Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .padding(.horizontal)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button(action: {
                    handleLogin()
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Button(action: {
                    handleCreateAccount()
                }) {
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
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Login Status"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationTitle("Authentication")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Handlers
    func handleCreateAccount() {
        session.viewType = .signup
        alertMessage = "Coming soon!"
        showingAlert = true
    }

    func handleLogin() {
        guard !username.isEmpty, !password.isEmpty else {
            alertMessage = "Please fill in all fields."
            showingAlert = true
            return
        }
        
        let loginRequest = LoginRequestDTO(username: username, password: password)
        guard let jsonData = try? JSONEncoder().encode(loginRequest) else {
            alertMessage = "Encoding failed."
            showingAlert = true
            return
        }
        let urlString = "https://springapi-b2z9.onrender.com/api/v1/user-account/getUserAccount"
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
                let decodedResponse = try JSONDecoder().decode(LoginResponseDTO.self, from: data)
                DispatchQueue.main.async {
                    if decodedResponse.status == "OK" {
                        session.isAuthenticated = true
                        session.viewType = .body
                        session.user = decodedResponse.userDetails
                        alertMessage = "Welcome, \(decodedResponse.userDetails.firstName) \(decodedResponse.userDetails.lastName)!"
                    } else {
                        session.isAuthenticated = false
                        session.viewType = .login
                        alertMessage = decodedResponse.message
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
    ContentView()
        .environmentObject(UserSession())  // ✅ fixes missing environment object
}
