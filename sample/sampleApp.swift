import SwiftUI

@main
struct sampleApp: App {
    // The @State variable to hold the authentication state.
    @State private var isAuthenticated: Bool = false

    var body: some Scene {
        WindowGroup {
            // Check the state and show the appropriate view.
            if isAuthenticated {
                // Pass the binding down to the BodyView so it can handle logout.
                BodyView(isAuthenticated: $isAuthenticated)
            } else {
                // Pass the binding down to the ContentView so it can handle login.
                ContentView(isAuthenticated: $isAuthenticated)
            }
        }
    }
}
