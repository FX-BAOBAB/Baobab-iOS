//
//  EmailDuplicationCheckUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/20/24.
//

import Combine

protocol CheckEmailDuplicationUseCase {
    func execute(params: [String: Any]) -> AnyPublisher<Bool, any Error>
}

final class CheckEmailDuplicationUseCaseImpl: CheckEmailDuplicationUseCase {
    private let repository: SignUpRepository
    
    init(repository: SignUpRepository) {
        self.repository = repository
    }
    
    func execute(params: [String: Any]) -> AnyPublisher<Bool, any Error> {
        return repository.requestEmailDuplicationCheck(params: params)
    }
}
