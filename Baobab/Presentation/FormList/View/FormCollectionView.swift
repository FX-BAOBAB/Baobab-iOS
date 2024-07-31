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
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.headerMode = .firstItemInSection
        listConfiguration.backgroundColor = .listFooterGray
        listConfiguration.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        collectionView.register(FormCollectionViewCell.self, forCellWithReuseIdentifier: FormCollectionViewCell.reuseIdentifier)
        collectionView.register(FormCollectionViewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
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
        
//        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//            print("here")
//            if kind == UICollectionView.elementKindSectionFooter {
//                guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as? FormCollectionViewFooter else {
//                    fatalError("Failed to load UICollectionView Footer")
//                }
//                
//                return footer
//            } else {
//                fatalError()
//            }
//        }
//        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//            
//            return CGSize(width: collectionView.bounds.size.width, height: 100)
//            
//        }
    }
}

#Preview {
    NavigationStack {
        FormCollectionView<ReceivingFormsViewModel>()
            .environmentObject(AppDI.shared.receivingFormsViewModel)
    }
}
