//
//  PangramViewController.swift
//  CarbonPractice
//
//  Created by uiskim on 2024/01/20.
//

import UIKit

import Carbon
import SnapKit

final class PangramViewController: UIViewController {
    var isSorted = true {
        didSet {
            render()
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 16, bottom: 30, right: 16)
        layout.minimumInteritemSpacing = 24
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    let renderer = Renderer(adapter: UICollectionViewFlowLayoutAdapter(), updater: UICollectionViewUpdater())
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("셔플!", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Pangram"
        collectionView.contentInset.top = 40
        view.addSubview(collectionView)
        view.addSubview(button)

        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(20)
        }
        
        renderer.adapter.didSelect = { context in
            print(context.indexPath)
        }
        
        renderer.target = collectionView
        render()
    }
    
    func render() {
        let pangram = isSorted ? ["ABC", "DEF", "GHI", "JKL", "MNO", "PQR", "STU", "VWY", "XZ"] : ["THE", "QUICK", "BROWN", "FOX", "JUMPS", "OVER", "THE", "LAZY", "DOG"]
        renderer.render {
            Group(of: pangram.enumerated()) { index, word in
                Section(id: index, header: Header(title: "gg")) {
                    Group(of: word) { text in
                        PangramItem(title: String(text))
                    }
                }
            }
        }
    }
    
    @objc func buttonTapped() {
        isSorted.toggle()
    }
}
