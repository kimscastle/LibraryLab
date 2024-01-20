//
//  PangramItem.swift
//  CarbonPractice
//
//  Created by uiskim on 2024/01/20.
//

import UIKit

import Carbon
import SnapKit

struct PangramItem: IdentifiableComponent {
    
    var title: String
    
    var id: String {
        return title
    }
    func render(in content: UILabel) {
        content.text = title
    }
    
    func renderContent() -> UILabel {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.backgroundColor = UIColor.systemGray6
        return label
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return .init(width: 30, height: 30)
    }
}
