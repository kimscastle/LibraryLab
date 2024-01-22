//
//  KyotoImageItem.swift
//  CarbonPractice
//
//  Created by uiskim on 2024/01/21.
//

import UIKit

import Carbon
import SnapKit

struct KyotoImageItem: IdentifiableComponent {
    var title: String
    var image: UIImage
    var id: String {
        return title
    }
    func renderContent() -> KyotoImageContent {
        return .init()
    }
    func render(in content: KyotoImageContent) {
        content.imageView.image = image
        content.titleLabel.text = title
    }
}

final class KyotoImageContent: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width).multipliedBy(0.5)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
