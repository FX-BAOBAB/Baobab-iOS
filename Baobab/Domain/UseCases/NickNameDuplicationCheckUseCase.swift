//
//  NameDuplicationCheckUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/20/24.
//

import Combine

protocol NickNameDuplicationCheckUseCase {
    func execute(params: [String: Any]) -> AnyPublisher<Bool, any Error>
}

final class NickNameDuplicationCheckUseCaseImpl: NickNameDuplicationCheckUseCase {
    private let repository: SignUpRepository
    
    init(repository: SignUpRepository) {
        self.repository = repository
    }
    
    func execute(params: [String : Any]) -> AnyPublisher<Bool, any Error> {
        return repository.requestNickNameDuplicationCheck(params: params)
    }
}
