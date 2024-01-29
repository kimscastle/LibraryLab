//
//  TodoCustomTest.swift
//  CarbonPracticeTests
//
//  Created by uiskim on 1/29/24.
//

import XCTest

import Carbon
@testable import CarbonPractice

final class TodoCustomTest: XCTestCase {
    
    var todoCustomVC: TodoCustomViewController!

    override func setUpWithError() throws {
        self.todoCustomVC = TodoCustomViewController()
    }

    override func tearDownWithError() throws {
        self.todoCustomVC = nil
    }

    func test_데이터의_갯수와_cell의갯수가_일치하는지() {
        //given
        self.todoCustomVC.datas = [
            .init(title: "1번task", isFinished: false),
            .init(title: "2번task", isFinished: false),
            .init(title: "3번task", isFinished: false)
        ]
        //when
        self.todoCustomVC.loadViewIfNeeded()
        
        //then
        let expectNumberOfCells = 3
        let numberOfCells = self.todoCustomVC.renderer.adapter.tableView(self.todoCustomVC.tableView, numberOfRowsInSection: 0)
        
        XCTAssertEqual(expectNumberOfCells, numberOfCells)
    }
    
    func test_데이터가없으면_emptyView가_잘뜨는지() {
        //given
        self.todoCustomVC.datas = []
        
        //when
        self.todoCustomVC.loadViewIfNeeded()
        
        //then
        let numberOfItemInSection = self.todoCustomVC.renderer.adapter.tableView(self.todoCustomVC.tableView, numberOfRowsInSection: 0)
        
        
        let emptyViewCell = self.todoCustomVC.renderer.adapter.tableView(self.todoCustomVC.tableView, cellForRowAt: .init(row: 0, section: 0)) as! UITableViewComponentCell
        
        XCTAssertNotNil(emptyViewCell.renderedComponent?.as(EmptyItem.self))
        XCTAssertEqual(numberOfItemInSection, 1)
    }
    
    func test_삭제버튼이_잘_동작하는지() {
        //given
        self.todoCustomVC.datas = [
            .init(title: "1번task", isFinished: false),
            .init(title: "2번task", isFinished: false),
            .init(title: "3번task", isFinished: false)
        ]
        //when
        self.todoCustomVC.loadViewIfNeeded()
        
        //then
        let firstCell = self.todoCustomVC.renderer.adapter.tableView(self.todoCustomVC.tableView, cellForRowAt: .init(row: 0, section: 0)) as! UITableViewComponentCell
        
        let firstItem = firstCell.renderedComponent!.as(TodoCustomItem.self)
        
        let firstComponent = firstItem!.renderContent()
        firstItem?.render(in: firstComponent)
        
        firstComponent.deleteButton.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(self.todoCustomVC.datas.count, 2)
        
    }
    
    func test_모든요소를삭제했을때_emptyView가_잘나오는지() {
        //given
        self.todoCustomVC.datas = [
            .init(title: "1번task", isFinished: false)
        ]
        //when
        self.todoCustomVC.loadViewIfNeeded()
        
        //then
        let firstCell = self.todoCustomVC.renderer.adapter.tableView(self.todoCustomVC.tableView, cellForRowAt: .init(row: 0, section: 0)) as! UITableViewComponentCell
        
        // 아이템하나있는데 그걸삭제함
        let firstItem = firstCell.renderedComponent!.as(TodoCustomItem.self)
        
        let firstComponent = firstItem!.renderContent()
        firstItem?.render(in: firstComponent)
        
        firstComponent.deleteButton.sendActions(for: .touchUpInside)
        
        // 아이템의 갯수는 0개가되어야함
        XCTAssertEqual(self.todoCustomVC.datas.count, 0)
        
        // emptyview는남아있어야해서 cell의 갯수는 1개남아있어야함
        let numberOfCellsWhenAllElementDeleted = self.todoCustomVC.renderer.adapter.tableView(self.todoCustomVC.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfCellsWhenAllElementDeleted, 1)
        
        let emptyViewCell = self.todoCustomVC.renderer.adapter.tableView(self.todoCustomVC.tableView, cellForRowAt: .init(row: 0, section: 0)) as! UITableViewComponentCell
        
        // 남은cell이 EmptyItem이어야함
        XCTAssertNotNil(emptyViewCell.renderedComponent?.as(EmptyItem.self))
    }
    
    func test_할일체크_버튼이_잘_작동하는지() {
        //given
        self.todoCustomVC.datas = [
            .init(title: "1번task", isFinished: false),
            .init(title: "2번task", isFinished: false),
            .init(title: "3번task", isFinished: false)
        ]
        //when
        self.todoCustomVC.loadViewIfNeeded()
        
        //then
        let firstCell = self.todoCustomVC.renderer.adapter.tableView(self.todoCustomVC.tableView, cellForRowAt: .init(row: 0, section: 0)) as! UITableViewComponentCell
        
        let firstItem = firstCell.renderedComponent!.as(TodoCustomItem.self)
        
        let firstComponent = firstItem!.renderContent()
        firstItem?.render(in: firstComponent)
        
        firstComponent.checkButton.sendActions(for: .touchUpInside)
        
        // 갯수는 동일해야함
        XCTAssertEqual(self.todoCustomVC.datas.count, 3)
        XCTAssertTrue(self.todoCustomVC.datas[0].isFinished)
        XCTAssertFalse(self.todoCustomVC.datas[1].isFinished)
        
        // UI에 반영되었나 확인
        let firstCellAfterTapped = self.todoCustomVC.renderer.adapter.tableView(self.todoCustomVC.tableView, cellForRowAt: .init(row: 0, section: 0)) as! UITableViewComponentCell
        
        let firstItemAfterTapped = firstCellAfterTapped.renderedComponent!.as(TodoCustomItem.self)
        
        let firstComponetAfterTapped = firstItemAfterTapped!.renderContent()
        
        firstItemAfterTapped?.render(in: firstComponetAfterTapped)

        XCTAssertEqual(firstComponetAfterTapped.checkButton.titleLabel?.text, "완료")
    }
}
