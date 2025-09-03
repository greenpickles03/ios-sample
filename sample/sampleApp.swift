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
            }
        }
    }
}
