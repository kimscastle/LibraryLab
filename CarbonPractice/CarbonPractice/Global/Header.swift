//
//  Header.swift
//  CarbonPractice
//
//  Created by uiskim on 2024/01/16.
//

import UIKit

import Carbon
import SnapKit

struct Header: IdentifiableComponent {
    var title: String
    var id: String {
        return title
    }
    func render(in content: HeaderContent) {
        content.titleLabel.text = title
    }
    
    func renderContent() -> HeaderContent {
        return .init()
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        .init(width: AppSize.width, height: 50)
    }
}

final class HeaderContent: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
    }
}
