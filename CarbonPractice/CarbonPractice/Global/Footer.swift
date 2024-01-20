//
//  Footer.swift
//  CarbonPractice
//
//  Created by uiskim on 2024/01/16.
//

import UIKit

import Carbon
import SnapKit

struct Footer: IdentifiableComponent {
    typealias Content = FooterContent
    
    var title: String
    var id: String {
        return title
    }
    

    func renderContent() -> FooterContent {
        return .init()
    }
    
    func render(in content: FooterContent) {
        content.titleLabel.text = title
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return .init(width: AppSize.width, height: 30)
    }
}

final class FooterContent: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
