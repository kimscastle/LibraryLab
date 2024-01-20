//
//  PangramTest.swift
//  CarbonPracticeTests
//
//  Created by uiskim on 2024/01/20.
//

import XCTest

import Carbon
@testable import CarbonPractice

final class PangramTest: XCTestCase {
    var pangramVC: PangramViewController!

    override func setUpWithError() throws {
        self.pangramVC = PangramViewController()
    }

    override func tearDownWithError() throws {
        self.pangramVC = nil
    }

    func test_유저가_진입시_A_Z까지의_9개의_section으로_정렬되어있는지() {
        //given
        
        //when
        self.pangramVC.loadViewIfNeeded()
        //then
        let numberOfSection = self.pangramVC.renderer.adapter.numberOfSections(in: self.pangramVC.collectionView)
        XCTAssertEqual(numberOfSection, 9)
    }
    
    func test_유저가진입시_첫번째_섹션의_cell갯수가_3개인지() {
        //when
        self.pangramVC.loadViewIfNeeded()
        //then
        let numberOfCells = self.pangramVC.renderer.adapter.collectionView(self.pangramVC.collectionView, numberOfItemsInSection: 0)
        
        XCTAssertEqual(numberOfCells, 3)
    }
    
    func test_cell하나의_width와_height가_30인지() {
        //when
        self.pangramVC.loadViewIfNeeded()
        
        //then
        let size = self.pangramVC.renderer.adapter.collectionView(self.pangramVC.collectionView, layout: UICollectionViewFlowLayout(), sizeForItemAt: .init(row: 0, section: 0))
        XCTAssertEqual(size, .init(width: 30, height: 30))
    }
    
    func test_첫번째section에_ABC가_잘들어갔는지() {
        //when
        self.pangramVC.loadViewIfNeeded()
        //then
        let firstCell = self.pangramVC.renderer.adapter.collectionView(self.pangramVC.collectionView, cellForItemAt: .init(row: 0, section: 0)) as! UICollectionViewComponentCell
        let secondCell = self.pangramVC.renderer.adapter.collectionView(self.pangramVC.collectionView, cellForItemAt: .init(row: 1, section: 0)) as! UICollectionViewComponentCell
        let thirdCell = self.pangramVC.renderer.adapter.collectionView(self.pangramVC.collectionView, cellForItemAt: .init(row: 2, section: 0)) as! UICollectionViewComponentCell
    
        let firstItem = firstCell.renderedComponent!.as(PangramItem.self)
        let secondItem = secondCell.renderedComponent!.as(PangramItem.self)
        let thirdItem = thirdCell.renderedComponent!.as(PangramItem.self)
        
        let aLabel = firstItem?.renderContent()
        let bLabel = secondItem?.renderContent()
        let cLabel = thirdItem?.renderContent()
        
        
        firstItem?.render(in: aLabel!)
        secondItem?.render(in: bLabel!)
        thirdItem?.render(in: cLabel!)
        
        XCTAssertEqual(aLabel?.text!, "A")
        XCTAssertEqual(bLabel?.text!, "B")
        XCTAssertEqual(cLabel?.text!, "C")
    }
    
    func test_button을_눌렀을_때_잘섞이는지() {
        //when
        self.pangramVC.loadViewIfNeeded()
        self.pangramVC.button.sendActions(for: .touchUpInside)
        
        //then
        let firstCell = self.pangramVC.renderer.adapter.collectionView(self.pangramVC.collectionView, cellForItemAt: .init(row: 0, section: 0)) as! UICollectionViewComponentCell
        let secondCell = self.pangramVC.renderer.adapter.collectionView(self.pangramVC.collectionView, cellForItemAt: .init(row: 1, section: 0)) as! UICollectionViewComponentCell
        let thirdCell = self.pangramVC.renderer.adapter.collectionView(self.pangramVC.collectionView, cellForItemAt: .init(row: 2, section: 0)) as! UICollectionViewComponentCell
    
        let firstItem = firstCell.renderedComponent!.as(PangramItem.self)
        let secondItem = secondCell.renderedComponent!.as(PangramItem.self)
        let thirdItem = thirdCell.renderedComponent!.as(PangramItem.self)
        
        let tLabel = firstItem?.renderContent()
        let hLabel = secondItem?.renderContent()
        let eLabel = thirdItem?.renderContent()
        
        
        firstItem?.render(in: tLabel!)
        secondItem?.render(in: hLabel!)
        thirdItem?.render(in: eLabel!)
        
        XCTAssertFalse(self.pangramVC.isSorted)
        XCTAssertEqual(tLabel?.text!, "T")
        XCTAssertEqual(hLabel?.text!, "H")
        XCTAssertEqual(eLabel?.text!, "E")
    }
}
