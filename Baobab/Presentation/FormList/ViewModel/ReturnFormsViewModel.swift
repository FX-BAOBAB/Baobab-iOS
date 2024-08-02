//
//  ReturnFormsViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 8/1/24.
//

import Combine

final class ReturnFormsViewModel: FormsViewModel {
    @Published var forms: [ReturnForm]?
    
    private let usecase: FetchFormUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchFormUseCase) {
        self.usecase = usecase
        forms = ReturnForm.sampleData
    }
    
    func fetchForms() {
        usecase.executeForReturn()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetching return forms has been completed")
                case .failure(let error):
                    print("ReturnFormsViewModel.fetchForms() error : ", error)
                }
            }, receiveValue: { [weak self] in
                self?.forms = $0
            })
            .store(in: &cancellables)
    }
}
