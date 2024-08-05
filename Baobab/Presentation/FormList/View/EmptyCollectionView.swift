//
//  EmptyCollectionView.swift
//  Baobab
//
//  Created by 이정훈 on 8/2/24.
//

import UIKit
import SnapKit

extension UICollectionView {
    func setBackgroundView(title: String) {
        let backgroundView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.width, height: self.bounds.height))
        backgroundView.backgroundColor = .listFooterGray
        
        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = title
            label.textAlignment = .center
            label.font = UIFont.preferredFont(forTextStyle: .body)
            label.textColor = .gray
            
            return label
        }()
        
        backgroundView.addSubview(messageLabel)
        self.backgroundView = backgroundView
        
        messageLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
