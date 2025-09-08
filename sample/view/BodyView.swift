import SwiftUI

struct BodyView: View {
    @EnvironmentObject var session: UserSession
    
    var body: some View {
        NavigationStack {
           
            ZStack{
            
                VStack(spacing: 20) {
                    Text("Login successful!")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    if let user = session.user {
                        Text("Welcome, \(user.username) \(user.userId)")
                            .font(.title2)
                    }
                    
                    Button("Logout") {
                        session.isAuthenticated = false
                        session.viewType = .dashboard
                        session.user = nil
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    
                }
                
                .navigationTitle("Welcome")
                .navigationBarTitleDisplayMode(.large)
                .padding()
                
            }
            .padding()
            .background(Color.gray)          // card background
            .cornerRadius(20)
            .shadow(radius: 5)                // subtle shadow
            .padding()
        }
    }
}

#Preview {
    BodyView()
        .environmentObject(UserSession())  // ✅ same here
}
