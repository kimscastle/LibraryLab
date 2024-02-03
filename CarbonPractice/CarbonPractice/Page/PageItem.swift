//
//  PageItem.swift
//  CarbonPractice
//
//  Created by uiskim on 2/3/24.
//

import UIKit

import Carbon
import SnapKit

struct PageItem: Component {
    var title: String
    
    func render(in content: PageComponent) {
        content.titleLabel.text = title
    }
    
    func renderContent() -> PageComponent {
        .init()
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        .init(width: AppSize.width, height: 200)
    }
}

final class PageComponent: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .blue
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
