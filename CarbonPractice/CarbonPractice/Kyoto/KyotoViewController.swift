//
//  KyotoViewController.swift
//  CarbonPractice
//
//  Created by uiskim on 2024/01/21.
//

import UIKit

import Carbon
import SnapKit
import MagazineLayout

struct KyotoData {
    var title: String
    var image: UIImage
    var isVisited: Bool = false
}

final class KyotoViewController: UIViewController {
    
    enum ID {
        case top
        case photot
    }
    
    var data: [KyotoData]? {
        didSet {
            guard let data = self.data else { return }
            render(input: data)
        }
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: MagazineLayout())
    let renderer = Renderer(adapter: KyotoMagazineLayoutAdapter(), updater: UICollectionViewUpdater())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Kyoto"
        collectionView.isScrollEnabled = true
        renderer.target = collectionView
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        render(input: [])
    }
    

    
    func render(input: [KyotoData]) {
        renderer.render {
            Section(
                id: ID.top,
                header: KyotoTopItem()
            )
            Section(id: ID.photot, header: Header(title: "가고싶은곳")) {
                Group(of: input.filter { !$0.isVisited }) { data in
                    KyotoImageItem(title: data.title, image: data.image)
                }
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.performBatchUpdates(nil)
    }
}
