import SwiftUI

struct BodyView: View {
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        NavigationStack { // Wrap in NavigationStack to enable back button
            VStack(spacing: 20) {
                Text("Login successful!")
                    .font(.largeTitle)
                
                Button("Logout") {
                    // Set the authentication state to false to return to the LoginView.
                    isAuthenticated = false
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            .navigationTitle("Welcome") // Add a title
        }
    }
}

#Preview {
    // A temporary struct is needed to hold a @State variable for the binding.
    struct PreviewWrapper: View {
        @State private var isAuthenticated = true
        var body: some View {
            BodyView(isAuthenticated: $isAuthenticated)
        }
    }
    return PreviewWrapper()
}
