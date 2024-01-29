//
//  TodoCustomItem.swift
//  CarbonPractice
//
//  Created by uiskim on 1/29/24.
//

import UIKit

import Carbon
import SnapKit

struct TodoCustomItem: IdentifiableComponent {
    enum Event {
        case check
        case delete
    }
    
    
    var title: String
    var isFinished: Bool
    var onEvent: (Event) -> Void

    var id: String {
        return title
    }
    
    func render(in content: TodoCustomComponent) {
        content.configureCell(title: title, isFinished: isFinished)
        content.checkButtonTapped = {
            self.onEvent(.check)
        }
        content.deleteButtonTapped = {
            self.onEvent(.delete)
        }
    }
    
    func renderContent() -> TodoCustomComponent {
        return .init()
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        .init(width: AppSize.width, height: 80)
    }
}

final class TodoCustomComponent: UIView {
    
    var checkButtonTapped: (() -> Void)?
    var deleteButtonTapped: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(checkButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("지우기", for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTap), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.addSubview(titleLabel)
        self.addSubview(checkButton)
        self.addSubview(deleteButton)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        checkButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(50)
        }
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(50)
        }
    }
    
    func configureCell(title: String, isFinished: Bool) {
        self.titleLabel.text = title
        self.checkButton.setTitle(isFinished ? "완료" : "미완", for: .normal)
    }
    
    @objc func deleteButtonTap() {
        self.deleteButtonTapped?()
    }
    
    @objc func checkButtonTap() {
        self.checkButtonTapped?()
    }
}
