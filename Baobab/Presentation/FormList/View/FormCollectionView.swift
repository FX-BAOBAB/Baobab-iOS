//
//  FormCollectionView.swift
//  Baobab
//
//  Created by 이정훈 on 7/30/24.
//

import UIKit
import SwiftUI

struct FormCollectionView<T: FormsViewModel>: UIViewRepresentable {
    @EnvironmentObject private var viewModel: T
    let formType: FormType
    
    func makeUIView(context: Context) -> UICollectionView {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        listConfiguration.backgroundColor = .listFooterGray
        listConfiguration.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        collectionView.register(ReceivingFormCollectionViewCell.self, forCellWithReuseIdentifier: ReceivingFormCollectionViewCell.reuseIdentifier)
        collectionView.register(ShippingFormCollectionViewCell.self, forCellWithReuseIdentifier: ShippingFormCollectionViewCell.reuseIdentifier)
        collectionView.register(ReturnFormCollectionViewCell.self, forCellWithReuseIdentifier: ReturnFormCollectionViewCell.reuseIdentifier)
        collectionView.delegate = context.coordinator
        collectionView.dataSource = context.coordinator
        
        if viewModel.forms?.isEmpty == true {
            collectionView.setBackgroundView(title: "요청서 정보가 없어요 :(")
        }
        
        return collectionView
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        uiView.reloadData()
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    final class Coordinator: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
        private var parent: FormCollectionView
        
        init(_ parent: FormCollectionView) {
            self.parent = parent
        }
        
        //MARK: - 각 Section 별 item 개수
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }
        
        //MARK: - CollectionView의 Section 개수
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            guard let forms = parent.viewModel.forms else {
                return 0
            }
            
            return forms.count
        }
        
        //MARK: - cell 구성
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            switch parent.formType {
            case .receivingForm:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReceivingFormCollectionViewCell.reuseIdentifier, for: indexPath) as! ReceivingFormCollectionViewCell
                
                guard let content = parent.viewModel.forms?[indexPath.section] as? ReceivingForm else {
                    fatalError("Could not configuration cell contents")
                }
                
                cell.content = content
                cell.backgroundColor = .white
                
                return cell
            case .shippingForm:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShippingFormCollectionViewCell.reuseIdentifier, for: indexPath) as! ShippingFormCollectionViewCell
                
                guard let content = parent.viewModel.forms?[indexPath.section] as? ShippingForm else {
                    fatalError("Could not configuration cell contents")
                }
                
                cell.content = content
                cell.backgroundColor = .white
                
                return cell
            case .returnForm:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReturnFormCollectionViewCell.reuseIdentifier, for: indexPath) as! ReturnFormCollectionViewCell
                
                guard let content = parent.viewModel.forms?[indexPath.section] as? ReturnForm else {
                    fatalError("Could not configuration cell contents")
                }
                
                cell.content = content
                cell.backgroundColor = .white
                
                return cell
            }
        }
    }
}

#Preview {
    NavigationStack {
        FormCollectionView<ReceivingFormsViewModel>(formType: .receivingForm)
            .environmentObject(AppDI.shared.receivingFormsViewModel)
    }
}
