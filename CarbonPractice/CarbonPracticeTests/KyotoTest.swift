//
//  KyotoTest.swift
//  CarbonPracticeTests
//
//  Created by uiskim on 2024/01/21.
//

import XCTest

import Carbon
import MagazineLayout
@testable import CarbonPractice

final class KyotoTest: XCTestCase {
    
    var kyotoVC: KyotoViewController!

    override func setUpWithError() throws {
        self.kyotoVC = KyotoViewController()
    }

    override func tearDownWithError() throws {
        self.kyotoVC = nil
    }

    func test_데이터가없을때_기본데이터가잘들어가는지() {
        //when
        self.kyotoVC.loadViewIfNeeded()
        
        //then
        let section0Header = self.kyotoVC.renderer.adapter.supplementaryViewNode(forElementKind: MagazineLayout.SupplementaryViewKind.sectionHeader, collectionView: self.kyotoVC.collectionView, at: .init(row: 0, section: 0))!
        let section0HeaderItem = section0Header.component(as: KyotoTopItem.self)
        let section0HeaderComponent = section0HeaderItem?.renderContent()
        
        let section1Header = self.kyotoVC.renderer.adapter.supplementaryViewNode(forElementKind: MagazineLayout.SupplementaryViewKind.sectionHeader, collectionView: self.kyotoVC.collectionView, at: .init(row: 0, section: 1))!
        
        let section1HeaderItem = section1Header.component(as: Header.self)
        let section1HeaderComponent = section1HeaderItem?.renderContent()
        section1HeaderItem?.render(in: section1HeaderComponent!)
        
        XCTAssertEqual(section0HeaderComponent?.titleLabel.text!, "Kinkaku-ji")
        XCTAssertEqual(section1HeaderComponent?.titleLabel.text!, "가고싶은곳")
    }
    
    func test_방문하지않은장소가_잘_필터링되는지() {
        //given
        let testData: [KyotoData] = [
            .init(title: "Fushimi Inari-taisha", image: .init(named: "KyotoFushimiInari")!),
            .init(title: "Arashiyama", image: .init(named: "KyotoArashiyama")!),
            .init(title: "KyotoByodoIn", image: .init(named: "KyotoByodoIn")!),
            .init(title: "Gion", image: .init(named: "KyotoGion")!, isVisited: true),
            .init(title: "KyotoKiyomizuDera", image: .init(named: "KyotoKiyomizuDera")!),
        ]
        //when
        self.kyotoVC.loadViewIfNeeded()
        kyotoVC.data = testData
        
        let expectCount = testData.filter { !$0.isVisited }.count
        
        //then
        let itemCount = kyotoVC.renderer.adapter.collectionView(self.kyotoVC.collectionView, numberOfItemsInSection: 1)
        
        XCTAssertEqual(expectCount, itemCount)
    }
    
    func test_방문하지않은장소가_UI에_잘_반영되는지() {
        //given
        let testData: [KyotoData] = [
            .init(title: "Fushimi Inari-taisha", image: .init(named: "KyotoFushimiInari")!),
            .init(title: "Arashiyama", image: .init(named: "KyotoArashiyama")!),
            .init(title: "KyotoByodoIn", image: .init(named: "KyotoByodoIn")!, isVisited: true),
            .init(title: "Gion", image: .init(named: "KyotoGion")!, isVisited: true),
            .init(title: "KyotoKiyomizuDera", image: .init(named: "KyotoKiyomizuDera")!, isVisited: true)
        ]
        //when
        self.kyotoVC.loadViewIfNeeded()
        kyotoVC.data = testData
        
        //then
        let cell0 = self.kyotoVC.renderer.adapter.collectionView(self.kyotoVC.collectionView, cellForItemAt: .init(row: 0, section: 1)) as! MagazineLayoutCollectionViewCell
        let cell1 = self.kyotoVC.renderer.adapter.collectionView(self.kyotoVC.collectionView, cellForItemAt: .init(row: 1, section: 1)) as! MagazineLayoutCollectionViewCell
        let cell0Item = cell0.renderedComponent?.as(KyotoImageItem.self)
        let cell1Item = cell1.renderedComponent?.as(KyotoImageItem.self)
        let cell0Componet = cell0Item?.renderContent()
        let cell1Componet = cell1Item?.renderContent()
        
        cell0Item?.render(in: cell0Componet!)
        cell1Item?.render(in: cell1Componet!)
        XCTAssertEqual("Fushimi Inari-taisha", cell0Componet?.titleLabel.text!)
        XCTAssertEqual("Arashiyama", cell1Componet?.titleLabel.text!)
    }
}
