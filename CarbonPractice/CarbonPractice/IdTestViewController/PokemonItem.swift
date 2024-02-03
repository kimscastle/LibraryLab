//
//  PokemonItem.swift
//  CarbonPractice
//
//  Created by uiskim on 2/3/24.
//

import UIKit

import Carbon
import SnapKit

// id는 differncekit을 위한 요소임 list를 그리는데 필요한 요소
struct PokemonItem: Component {
    // 개별요소를 아얘다르게 인식시키고 싶으면 id값을 UUID로줄수있음
    // 그러면 모든요소가 달라 같은 위치의 뷰더라도 다시 그려지는 모습
//    var id: String {
//        return name
//    }
    // 근데 ukit은 애초에 view를 그릴때 snapshot을 쓰지않기때문에 뷰를 그릴때 같은 요소들을 구분할방법이없음
    // 그래서 만약에 name을 id로하면 name이같은 녀석은 애니매이션을 적용하지않음
    var id = UUID()
    var name: String
    var type: String
    var nameColor: UIColor
    
    func render(in content: PokemonComponent) {
        content.nameLabel.text = name
        content.typelabel.text = type
        content.typelabel.textColor = nameColor
    }
    
    func renderContent() -> PokemonComponent {
        .init()
    }
    
}

final class PokemonComponent: UIView {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let typelabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.addSubview(nameLabel)
        self.addSubview(typelabel)
        nameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        typelabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
