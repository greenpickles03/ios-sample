import SwiftUI

struct UserDetailsRegistrationView: View {
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var address: String = ""     // ✅ fixed typo
    @State private var contactNumber: String = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @EnvironmentObject var session: UserSession
    private var userDetailsService = UserDetailsService()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea(edges: .all)
                    
                ZStack {
                    Color(.sRGB, red: 173/255, green: 235/255, blue: 179/255)
                        .navigationBarTitleDisplayMode(.inline)
                        .cornerRadius(20)
                        .padding()
                    
                    VStack(spacing:20) {
                        Text("Registration")
                            .font(.title.bold())
                            .foregroundColor(.black)
                            .padding(.top,30)
                    
                        TextField("",
                            text: $firstName,
                            prompt: Text("Firstname").foregroundColor(.gray)
                        )
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .shadow(radius: 2)
                        .padding(.horizontal,35)
                        .textInputAutocapitalization(.never)
                        
                        TextField("",
                            text: $lastName,
                            prompt: Text("Lastname").foregroundColor(.gray)
                        )
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .shadow(radius: 2)
                        .padding(.horizontal,35)
                        .textInputAutocapitalization(.never)
                        
                        TextField("",
                            text: $email,
                            prompt: Text("Email").foregroundColor(.gray)
                        )
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .shadow(radius: 2)
                        .padding(.horizontal,35)
                        .textInputAutocapitalization(.never)
                        
                        TextField("",
                            text: $address,
                            prompt: Text("Address").foregroundColor(.gray)
                        )
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled(false)
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .shadow(radius: 2)
                        .padding(.horizontal, 35)
                        .textInputAutocapitalization(.never)
                        
                        TextField("",
                            text: $contactNumber,
                            prompt: Text("Contact Number").foregroundColor(.gray)
                        )
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .shadow(radius: 2)
                        .padding(.horizontal,35)
                            
                        Button(action: {
                            userDetailsService.createUserDetails(
                                firstName: firstName,
                                lastName: lastName,
                                address: address,
                                email: email,
                                contactNumber: contactNumber,
                                session: session,
                                alertMessage: { message in alertMessage = message },
                                showingAlert: { show in showingAlert = show }
                            )
                        }) {
                            Text("Register User Details")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal,35)
                        }

                        Spacer()
                    }
                }
            }
        }
        // ✅ Now the alert will actually show
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

#Preview {
    UserDetailsRegistrationView()
        .environmentObject(UserSession()) // ✅ required
}
