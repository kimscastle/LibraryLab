//
//  KyotoTopItem.swift
//  CarbonPractice
//
//  Created by uiskim on 2024/01/21.
//

import UIKit

import Carbon
import SnapKit

struct KyotoTopItem: IdentifiableComponent {
    var id: String {
        return "TokyoTopItem"
    }
    
    func render(in content: KyotoTopComponent) {}
    
    func renderContent() -> KyotoTopComponent {
        return KyotoTopComponent()
    }
}

final class KyotoTopComponent: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "KyotoKinkakuJi"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.text = "Kinkaku-ji"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.text = "Kinkaku-j, officially named Rokuon-ji (鹿苑寺, literally Deer Garden Temple), is a Zen Buddhist temple in Kyoto, Japan.It is one of the most ptage Sites.Kinkaku-j, officially named Rokuon-ji (鹿苑寺, literally Deer Garden Temple), is a Zen Buddhist temple in Kyoto, Japan.It is one of the most ptage Sites."
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(180)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
        
    }
}

