import Foundation
import Combine

class UserDetailsService {
    
    func createUserDetails(
        firstName: String,
        lastName: String,
        address: String,
        email: String,
        contactNumber: String,
        session: UserSession,
        alertMessage: @escaping (String) -> Void,
        showingAlert: @escaping (Bool) -> Void
    ) {
        
        // ✅ Validate inputs
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !address.isEmpty,
              !contactNumber.isEmpty,
              !email.isEmpty else {
            alertMessage("Please fill in all fields!!")
            showingAlert(true)
            return
        }
        
        // ✅ Ensure we have a logged-in user
        guard let userId = session.user?.userId else {
            alertMessage("User not logged in.")
            showingAlert(true)
            return
        }
        
        // ✅ Build request body
        let createUserDetailRequestDTO = CreateUserDetailsRequestDTO(
            userAccountId: userId,
            firstName: firstName,
            lastName: lastName,
            address: address,
            email: email,
            contactNumber: contactNumber
        )
        
        guard let jsonData = try? JSONEncoder().encode(createUserDetailRequestDTO) else {
            alertMessage("Encoding failed.")
            showingAlert(true)
            return
        }
        
        // ✅ URL
        let urlString = "https://springapi-b2z9.onrender.com/api/v1/user-details/createUserDetails"
        guard let url = URL(string: urlString) else {
            alertMessage("Invalid URL.")
            showingAlert(true)
            return
        }
        
        // ✅ Request
        var request = URLRequest(url: url)
        print(request)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept") // 👈 helps with Spring APIs
        request.httpBody = jsonData
        
        // ✅ Network call
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    alertMessage("Error: \(error.localizedDescription)")
                    showingAlert(true)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    alertMessage("Invalid server response.")
                    showingAlert(true)
                }
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
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
                let decodedResponse = try JSONDecoder().decode(UserDetailsResponseDTOList.self, from: data)
                print("decoddedResponse: \(decodedResponse)")
                DispatchQueue.main.async {
                    if decodedResponse.status == "OK",
                       let details = decodedResponse.userDetails {
                        
                        session.isAuthenticated = true
                        session.viewType = .dashboard
                        session.userDetails = details
                        alertMessage("Created user details for \(details.firstName)!")
                        
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
