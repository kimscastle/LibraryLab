//
//  EmptyItem.swift
//  CarbonPractice
//
//  Created by uiskim on 1/29/24.
//

import UIKit

import SnapKit
import Carbon

struct EmptyItem: IdentifiableComponent {
    var title: String
    var id: String {
        return title
    }
    
    func renderContent() -> EmptyContent {
        .init()
    }
    
    func render(in content: EmptyContent) {
        content.title.text = self.title
    }
    func referenceSize(in bounds: CGRect) -> CGSize? {
        .init(width: AppSize.width, height: 300)
    }
}

final class EmptyContent: UIView {
    let title: UILabel = {
        let label = UILabel()
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.addSubview(title)
        title.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
