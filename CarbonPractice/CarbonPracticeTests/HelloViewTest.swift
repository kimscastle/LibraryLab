//
//  HelloViewTest.swift
//  CarbonPracticeTests
//
//  Created by uiskim on 2024/01/20.
//

import XCTest
import Carbon
@testable import CarbonPractice

final class HelloViewTest: XCTestCase {
    var helloVC: HelloViewController!

    override func setUpWithError() throws {
        self.helloVC = HelloViewController()
    }

    override func tearDownWithError() throws {
        self.helloVC = nil
    }
    
    func test_helloVC에서_toggle이_false일때_cell이4개인지() {
        //given
        helloVC.toggle = false
        
        //when
        helloVC.loadViewIfNeeded()
        
        //then
        let numberOfCells = helloVC.renderer.adapter.tableView(helloVC.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfCells, 4)
    }
    
    func test_helloVC에서_toggle이_true일때_cell이5개인지() {
        // given
        helloVC.toggle = true
        
        // when
        helloVC.loadViewIfNeeded()
        
        // then
        let numberOfCells = helloVC.renderer.adapter.tableView(helloVC.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfCells, 5)
        
        let header = helloVC.renderer.adapter.tableView(helloVC.tableView, viewForHeaderInSection: 0)
        
        
//        let helloItem0 = header.renderedComponent!.as(HelloItem.self)
//
//        
//        let content0 = helloItem0?.renderContent()
//
//        helloItem0?.render(in: content0!)
//        print(header.titleLabel.text)
    }

    func test_helloVC에서_toggle이_true일때_cell에이름이잘들어갔는지() {
        //given
        helloVC.toggle = true
        
        //when
        helloVC.loadViewIfNeeded()
        
        //then
        let cell0 = helloVC.renderer.adapter.tableView(helloVC.tableView, cellForRowAt: .init(row: 1, section: 0)) as! UITableViewComponentCell
        let cell1 = helloVC.renderer.adapter.tableView(helloVC.tableView, cellForRowAt: .init(row: 2, section: 0)) as! UITableViewComponentCell
        let cell2 = helloVC.renderer.adapter.tableView(helloVC.tableView, cellForRowAt: .init(row: 3, section: 0)) as! UITableViewComponentCell
        
        let helloItem0 = cell0.renderedComponent!.as(HelloItem.self)
        let helloItem1 = cell1.renderedComponent!.as(HelloItem.self)
        let helloItem2 = cell2.renderedComponent!.as(HelloItem.self)
        
        let content0 = helloItem0?.renderContent()
        let content1 = helloItem1?.renderContent()
        let content2 = helloItem2?.renderContent()
        helloItem0?.render(in: content0!)
        helloItem1?.render(in: content1!)
        helloItem2?.render(in: content2!)
        
        XCTAssertEqual(content0?.nameLabel.text!, "의성2")
        XCTAssertEqual(content1?.nameLabel.text!, "의성1")
        XCTAssertEqual(content2?.nameLabel.text!, "의성3")
    }
    
    func test_helloVC에서_toggle이_false일때_cell에이름이잘들어갔는지() {
        //given
        helloVC.toggle = false
        
        //when
        helloVC.loadViewIfNeeded()
        
        //then
        let cell0 = helloVC.renderer.adapter.tableView(helloVC.tableView, cellForRowAt: .init(row: 1, section: 0)) as! UITableViewComponentCell
        let cell1 = helloVC.renderer.adapter.tableView(helloVC.tableView, cellForRowAt: .init(row: 2, section: 0)) as! UITableViewComponentCell

        let helloItem0 = cell0.renderedComponent!.as(HelloItem.self)
        let helloItem1 = cell1.renderedComponent!.as(HelloItem.self)
        
        let content0 = helloItem0?.renderContent()
        let content1 = helloItem1?.renderContent()
        helloItem0?.render(in: content0!)
        helloItem1?.render(in: content1!)
        
        XCTAssertEqual(content0?.nameLabel.text!, "의성1")
        XCTAssertEqual(content1?.nameLabel.text!, "의성3")
    }
    
    func test_VC터치했을때_toggle_true에서_false로_잘_바뀌는지() {
        //given
        helloVC.toggle = true
        //when
        helloVC.touchesEnded(.init(), with: .init())
        
        //then
        XCTAssertEqual(helloVC.toggle, false)
        let numberOfCells = helloVC.renderer.adapter.tableView(helloVC.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfCells, 4)
    }
    
    func test_VC터치했을때_toggle_false에서_true로_잘_바뀌는지() {
        //given
        helloVC.toggle = false
        //when
        helloVC.touchesEnded(.init(), with: .init())
        
        //then
        XCTAssertEqual(helloVC.toggle, true)
        let numberOfCells = helloVC.renderer.adapter.tableView(helloVC.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfCells, 5)
    }
}
