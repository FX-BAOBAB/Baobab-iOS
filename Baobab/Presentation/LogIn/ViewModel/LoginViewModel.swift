//
//  LogInViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 7/1/24.
//

import Combine

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isKeepLoggedIn: Bool = false
}
