//
//  SessionClass.swift
//  sample
//
//  Created by Neil on 9/3/25.
//

import SwiftUI

class UserSession: ObservableObject {
    
    enum ViewType {
            case login
            case signup
            case body
        }
    
    @Published var isAuthenticated: Bool = false
    @Published var user: UserDetail? = nil
    @Published var viewType: ViewType = .login
}
