import Foundation
import Combine

class AuthService {
    
    func handleCreateAccount(session: UserSession,
                             alertMessage: inout String,
                             showingAlert: inout Bool) {
        session.viewType = .signup
        alertMessage = "Coming soon!"
        showingAlert = true
    }
    
    func handleLogin(username: String,
                     password: String,
                     session: UserSession,
                     alertMessage: @escaping (String) -> Void,
                     showingAlert: @escaping (Bool) -> Void) {
        
        guard !username.isEmpty, !password.isEmpty else {
            alertMessage("Please fill in all fields.")
            showingAlert(true)
            return
        }
        
        let loginRequest = LoginRequestDTO(username: username, password: password)
        guard let jsonData = try? JSONEncoder().encode(loginRequest) else {
            alertMessage("Encoding failed.")
            showingAlert(true)
            return
        }
        
        let urlString = "https://springapi-b2z9.onrender.com/api/v1/user-account/getUserAccountv3"
        guard let url = URL(string: urlString) else {
            alertMessage("Invalid URL.")
            showingAlert(true)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    alertMessage("Error: \(error.localizedDescription)")
                    showingAlert(true)
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                DispatchQueue.main.async {
                    alertMessage("Server error: \(httpResponse.statusCode)")
                    showingAlert(true)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    alertMessage("No data received.")
                    showingAlert(true)
                }
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(LoginAccountResponseDTO.self, from: data)
                DispatchQueue.main.async {
                    if decodedResponse.status == "OK" {
                        session.isAuthenticated = true
                        session.viewType = .register
                        session.user = decodedResponse.userDetails
                        alertMessage("Welcome, \(decodedResponse.userDetails.username)!")
                    } else {
                        session.isAuthenticated = false
                        session.viewType = .login
                        alertMessage(decodedResponse.message)
                    }
                    showingAlert(true)
                }
            } catch {
                DispatchQueue.main.async {
                    alertMessage("Decoding failed: \(error.localizedDescription)")
                    showingAlert(true)
                }
            }
        }.resume()
    }
}
