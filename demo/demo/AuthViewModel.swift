//
//  AuthViewModel.swift
//  demo
//
//  Created by Emir Seçer on 7.07.2024.
//

import Foundation
import SwiftUI
import Combine

class AuthViewModel :
    ObservableObject {
    @Published var isAuthenticated = false
    
    func logın() {
        isAuthenticated = true
    }
    func logout() {
        isAuthenticated = false 
    }
}
