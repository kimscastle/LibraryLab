//
//  PageHeaderItem.swift
//  CarbonPractice
//
//  Created by uiskim on 2/3/24.
//

import UIKit

import Carbon
import SnapKit

struct PageHeaderItem: IdentifiableComponent {
    let id = UUID()
    let input: [Int]
    
    func render(in content: PageHeaderComponent) {
        content.inputData = input
        content.render()
    }
    
    func renderContent() -> PageHeaderComponent {
        .init()
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        .init(width: AppSize.width, height: 200)
    }
    
}

final class PageHeaderComponent: UIView {
    
    var inputData: [Int] = []
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    let renderer = Renderer(adapter: UICollectionViewFlowLayoutAdapter(), updater: UICollectionViewUpdater())
    
    init() {
        super.init(frame: .zero)
        renderer.target = collectionView
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func render() {
        renderer.render {
            Section(id: "Page") {
                Group(of: inputData) { input in
                    PageItem(title: "\(input)")
                        .identified(by: \.title)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
