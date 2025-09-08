import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @EnvironmentObject var session: UserSession   // ✅ shared state
    
    private let authService = AuthService()

    var body: some View {
        NavigationStack {
            ZStack{
                Color(.systemBlue).edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
            

                    
                    TextField(
                        "",
                        text: $username,
                        prompt: Text("Email or Username")
                            .foregroundColor(.gray) // ✅ placeholder color
                        )
                        .padding(12)
                        .background(Color.white)        // always white background
                        .cornerRadius(10)
                        .foregroundColor(.black)        // text color
                        .shadow(radius: 2)              // subtle shadow
                        .padding(.horizontal)
                        .textInputAutocapitalization(.never)
                        
                


                    SecureField("", text: $password,
                                prompt: Text("Password").foregroundColor(.gray))
                        .padding(12)
                        .background(Color.white)        // always white background
                        .cornerRadius(10)
                        .foregroundColor(.black)        // text color
                        .shadow(radius: 2)              // subtle shadow
                        .padding(.horizontal)
                        .textInputAutocapitalization(.never)

                    Button(action: {
                        authService.handleLogin(
                            username: username,
                            password: password,
                            session: session,
                            alertMessage: { message in alertMessage = message },
                            showingAlert: { show in showingAlert = show }
                        )
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
                        authService.handleCreateAccount(
                            session: session,
                            alertMessage: &alertMessage,
                            showingAlert: &showingAlert
                        )
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
                .background(Color.white)          // card background
                .cornerRadius(20)
                .shadow(radius: 5)                // subtle shadow
                .padding()
            }

            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Login Status"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationTitle("Authentication")
            .navigationBarTitleDisplayMode(.inline)
            .bold(true)
            .font(.headline)
        }
    }
    
    // MARK: - Handlers
    
}

#Preview {
    ContentView()
        .environmentObject(UserSession())  // ✅ fixes missing environment object
}
