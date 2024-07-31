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
    
    func makeUIView(context: Context) -> UICollectionView {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        listConfiguration.backgroundColor = .listFooterGray
        listConfiguration.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        collectionView.register(FormCollectionViewCell.self, forCellWithReuseIdentifier: FormCollectionViewCell.reuseIdentifier)
        collectionView.delegate = context.coordinator
        collectionView.dataSource = context.coordinator
        
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormCollectionViewCell.reuseIdentifier, for: indexPath) as! FormCollectionViewCell
            
            guard let content = parent.viewModel.forms?[indexPath.section] else {
                fatalError("Could not configuration cell contents")
            }
            
            cell.content = content
            cell.backgroundColor = .white
            
            return cell
        }
    }
}

#Preview {
    NavigationStack {
        FormCollectionView<ReceivingFormsViewModel>()
            .environmentObject(AppDI.shared.receivingFormsViewModel)
    }
}
