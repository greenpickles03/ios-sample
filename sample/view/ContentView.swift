import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    // The binding to the app's authentication state.
    @Binding var isAuthenticated: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()

                TextField("Email or Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
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
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding()
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Login Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("Authentication")
        }
    }
    
    func handleCreateAccount() {
        alertMessage = "Coming soon!"
        showingAlert = true
    }

    func handleLogin() {
        if username.isEmpty || password.isEmpty {
            alertMessage = "Please fill in all fields."
            showingAlert = true
        } else if username == "admin" && password == "admin" {
            // Correct: Just set the state and let the parent view handle the navigation.
            isAuthenticated = true
        } else {
            alertMessage = "Invalid credentials."
            showingAlert = true
        }
    }
}

#Preview {
    // Correctly initialize a binding for the preview.
    struct PreviewWrapper: View {
        @State private var isAuthenticated = false
        var body: some View {
            ContentView(isAuthenticated: $isAuthenticated)
        }
    }
    return PreviewWrapper()
}
