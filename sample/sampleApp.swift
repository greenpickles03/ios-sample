import SwiftUI

@main
struct sampleApp: App {
    @StateObject private var session = UserSession()   // ✅ single source of truth

    var body: some Scene {
        WindowGroup {
            switch session.viewType {
                case .body:
                    BodyView()
                        .environmentObject(session)

                case .login:
                    ContentView()
                        .environmentObject(session)

                case .signup:
                    SignUpView()
                        .environmentObject(session)
                case .dashboard:
                    DashboardView()
                        .environmentObject(session)
                case .register:
                    UserDetailsRegistrationView()
                        .environmentObject(session)
            @unknown default:
                fatalError("Unknown view type")
            
            }
            
        }
    }
}
