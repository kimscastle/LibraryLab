//
//  HomeItem.swift
//  CarbonPractice
//
//  Created by uiskim on 2024/01/15.
//

import UIKit

import Carbon
import SnapKit

struct HomeItem: IdentifiableComponent {
    var title: String
    var onSelect: () -> Void
    var id: String {
        return title
    }
    func renderContent() -> HomeItemContent {
        return HomeItemContent()
    }
    func render(in content: HomeItemContent) {
        content.titleLable.text = title
        content.onSelect = onSelect
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        .init(width: AppSize.width, height: 50)
    }
}

final class HomeItemContent: UIControl {
    let titleLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    var onSelect: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        setUI()
        self.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.addSubview(titleLable)
        titleLable.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    @objc func tapped() {
        onSelect?()
    }
    
}
