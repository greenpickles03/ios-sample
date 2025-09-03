//
//  UserAccountDTO.swift
//  sample
//
//  Created by Neil on 9/3/25.
//

import Foundation


struct LoginRequestDTO: Codable {
    let username: String
    let password: String
}

struct RegisterRequestDTO: Codable {
    let username: String
    let password: String
    let status: String
}

struct LoginResponseDTO: Codable {
    let userDetails: UserDetail
    let message: String
    let status: String
}

struct UserDetail: Codable {
    let userAccountId: Int
    let userDetailsId: Int
    let incomeId: Int
    let firstName: String
    let lastName: String
    let address: String
    let email: String
    let contactNumber: String
    let username: String
    let password: String
    let status: String
    let incomeAmount: Double
    let incomeDesc: String
    let incomeSource: String
    let incomeDate: String  // keep as String unless you want to parse as Date
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isSender: Bool
}


