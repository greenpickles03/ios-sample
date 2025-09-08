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
        case dashboard
        case register
    }

    @Published var isAuthenticated: Bool = false
    @Published var user: LoginDetail? = nil
    @Published var viewType: ViewType = .login
    @Published var userDetails: UserDetails? = nil
}
