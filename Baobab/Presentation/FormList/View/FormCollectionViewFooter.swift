//
//  FormCollectionViewFooter.swift
//  Baobab
//
//  Created by 이정훈 on 7/31/24.
//

import UIKit
import SwiftUI
import SnapKit

final class FormCollectionViewFooter: UICollectionReusableView {
    static let reuseIdentifier = "footerId"
    private let host = UIHostingController(rootView: SectionFooter())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(host.view)
        host.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
