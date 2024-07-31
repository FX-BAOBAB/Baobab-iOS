//
//  FormCollectionViewCell.swift
//  Baobab
//
//  Created by 이정훈 on 7/30/24.
//

import UIKit
import SwiftUI
import SnapKit

final class FormCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "FormCell"
    private(set) var host: UIHostingController<FormListRow>?
    var content: FormData? {
        didSet {
            if let content = content {
                host?.rootView = FormListRow(form: content)
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
        let rootView = FormListRow(form: nil)
        host = UIHostingController(rootView: rootView)
        
        guard let host else {
            return
        }
        
        host.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(host.view)
        
        host.view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        host.view.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
        }
    }
}
