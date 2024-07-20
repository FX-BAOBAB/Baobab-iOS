//
//  EmailDuplicationCheckUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/20/24.
//

import Combine

protocol EmailDuplicationCheckUseCase {
    func execute(param: [String: Any]) -> AnyPublisher<Bool, any Error>
}

final class EmailDuplicationCheckUseCaseImpl: EmailDuplicationCheckUseCase {
    private let repository: SignUpRepository
    
    init(repository: SignUpRepository) {
        self.repository = repository
    }
    
    func execute(param: [String: Any]) -> AnyPublisher<Bool, any Error> {
        return repository.requestEmailDuplicationCheck(param: param)
    }
}
