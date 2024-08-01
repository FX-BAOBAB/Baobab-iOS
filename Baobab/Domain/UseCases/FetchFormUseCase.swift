//
//  FetchFormUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/29/24.
//

import Combine

protocol FetchFormUseCase {
    func executeForReceiving() -> AnyPublisher<[FormData], any Error>
    func executeForReturn() -> AnyPublisher<[FormData], any Error>
    func executeForShipping() -> AnyPublisher<[FormData], any Error>
}

final class FetchFormUseCaseImpl: FetchFormUseCase {
    private let repository: FormRepository
    private let fetchProcessStatusUseCase: FetchProcessStatusUseCase
    
    init(fetchProcessStatusUseCase: FetchProcessStatusUseCase, repository: FormRepository) {
        self.fetchProcessStatusUseCase = fetchProcessStatusUseCase
        self.repository = repository
    }
    
    func executeForReceiving() -> AnyPublisher<[FormData], any Error> {
        return repository.fetchReceivingForms()
            .flatMap { [weak self] forms -> AnyPublisher<[FormData], any Error> in
                guard let self else {
                    return Just(forms)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
                
                return fetchProcessStatus(forms: forms, type: .receiving)
            }
            .eraseToAnyPublisher()
    }
    
    func executeForReturn() -> AnyPublisher<[FormData], any Error> {
        return repository.fetchReturnForms()
    }
    
    func executeForShipping() -> AnyPublisher<[FormData], any Error> {
        return repository.fetchShippingForms()
            .flatMap { [weak self] forms -> AnyPublisher<[FormData], any Error> in
                guard let self else {
                    return Just(forms)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
                
                return fetchProcessStatus(forms: forms, type: .shipping)
            }
            .eraseToAnyPublisher()
    }
}

extension FetchFormUseCaseImpl {
    private struct IdentifiedReponse {
        let index: Int
        let processStatus: ProcessStatus
    }
    
    private func fetchProcessStatus(forms: [FormData], type: FormType) -> AnyPublisher<[FormData], any Error> {
        var forms = forms
        var publishers = [AnyPublisher<IdentifiedReponse, any Error>]()
        
        //각각의 요청서 id를 이용하여 요청서의 진행 상태를 가져옴
        //생성된 publisher는 하나의 배열에 담아 모든 결과가 도착할 때까지 대기
        for (i, form) in forms.enumerated() {
            switch type {
            case .receiving:
                let publisher = fetchProcessStatusUseCase.executeForReceiving(id: form.id)
                    .map {
                        IdentifiedReponse(index: i, processStatus: $0)
                    }
                    .eraseToAnyPublisher()
                
                publishers.append(publisher)
            case .shipping:
                let publisher = fetchProcessStatusUseCase.executeForShipping(id: form.id)
                    .map {
                        IdentifiedReponse(index: i, processStatus: $0)
                    }
                    .eraseToAnyPublisher()
                
                publishers.append(publisher)
            }
        }
        
        //전달 받은 요청서 진행상태에 따라 새로운 FormData 배열 반환
        return Publishers.MergeMany(publishers)
            .collect()
            .map { identifiedReponse in
                identifiedReponse.forEach {
                    forms[$0.index].statusPercentile = Double($0.processStatus.current) / Double($0.processStatus.total)
                }
                
                return forms
            }
            .eraseToAnyPublisher()
    }
}
