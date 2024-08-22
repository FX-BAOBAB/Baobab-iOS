//
//  UsedConversionViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 8/21/24.
//

import Combine

final class UsedItemRegistrationViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var price: String = ""
    @Published var description: String = ""
    @Published var isProgress: Bool = false
    @Published var isShowingSuccessView: Bool = false
    @Published var isShowingFailureView: Bool = false
    @Published var isShowingAlert: Bool = false
    
    private let usecase: RegisterAsUsedItemUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: RegisterAsUsedItemUseCase) {
        self.usecase = usecase
    }
    
    func register(itemId: Int) {
        isProgress.toggle()
        
        guard let price = Int(price), checkInputAccuracy() else {
            isProgress.toggle()
            isShowingAlert.toggle()
            return
        }
        
        let params = [
            "result": [
                "resultCode": 0,
                "resultMessage": "string",
                "resultDescription": "string"
            ],
            "body": [
                "title": title,
                "price": price,
                "description": description,
                "goodsId": itemId
              ]
        ] as [String: Any]
        
        usecase.execute(params: params)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Used item registration request has been completed")
                case .failure(let error):
                    print("UsedItemRegistrationViewModel.register(itemId:) error :", error)
                }
            }, receiveValue: { [weak self] in
                self?.isProgress.toggle()
                
                if $0 {
                    self?.isShowingSuccessView.toggle()
                } else {
                    self?.isShowingFailureView.toggle()
                }
                
            })
            .store(in: &cancellables)
    }
    
    private func checkInputAccuracy() -> Bool {
        if title.isEmpty {
            return false
        }
        
        if price.isEmpty {
            return false
        }
        
        if description.isEmpty {
            return false
        }
        
        return true
    }
}
