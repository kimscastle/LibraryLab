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
        renderer.target = collectionView
        renderer.adapter.didSelect = { context in
            print(context.indexPath)
        }
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.data = [
            .init(title: "Fushimi Inari-taisha", image: .init(named: "KyotoFushimiInari")!),
            .init(title: "Arashiyama", image: .init(named: "KyotoArashiyama")!),
            .init(title: "KyotoByodoIn", image: .init(named: "KyotoByodoIn")!),
            .init(title: "Gion", image: .init(named: "KyotoGion")!),
        ]
    }
    
    struct KyotoData {
        var title: String
        var image: UIImage
        var isVisited: Bool = false
    }
    
    func render(input: [KyotoData]) {
        renderer.render {
            Section(
                id: ID.top,
                header: KyotoTopItem()
            )
            Section(id: ID.photot, header: Header(title: "jsofijsof")) {
                
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
