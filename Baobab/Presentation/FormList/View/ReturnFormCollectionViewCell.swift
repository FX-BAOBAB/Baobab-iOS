//
//  ReturnFormCollectionViewCell.swift
//  Baobab
//
//  Created by 이정훈 on 8/1/24.
//

import UIKit
import SwiftUI
import SnapKit

final class ReturnFormCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ReturnFormCell"
    private(set) var host: UIHostingController<ReturnFormListRow>?
    var content: ReturnForm? {
        didSet {
            if let content = content {
                host?.rootView = ReturnFormListRow(form: content)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let rootView = ReturnFormListRow(form: nil)
        host = UIHostingController(rootView: rootView)
        
        guard let host else {
            return
        }
        
        host.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(host.view)
        
        host.view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        host.view.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
    }
}

