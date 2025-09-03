import SwiftUI

struct BodyView: View {
    @EnvironmentObject var session: UserSession
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Login successful!")
                    .font(.largeTitle)
                
                if let user = session.user {
                    Text("Welcome, \(user.firstName) \(user.lastName)")
                        .font(.title2)
                }
                
                Button("Logout") {
                    session.isAuthenticated = false
                    session.viewType = .login
                    session.user = nil
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            .navigationTitle("Welcome")
        }
    }
}

#Preview {
    BodyView()
        .environmentObject(UserSession())  // ✅ same here
}
