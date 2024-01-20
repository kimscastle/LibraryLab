//
//  HelloViewController.swift
//  CarbonPractice
//
//  Created by uiskim on 2024/01/16.
//

import UIKit

import Carbon
import SnapKit

final class HelloViewController: UIViewController {
    
    var toggle = false {
        didSet {
            render()
        }
    }
    
    let tableView = UITableView()
    let renderer = Renderer(adapter: UITableViewAdapter(), updater: UITableViewUpdater())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setUI()
        setTableView()
        render()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches)
        super.touchesEnded(touches, with: event)
        self.toggle.toggle()
    }
    
    deinit {
        print("helloVC가 메모리에서 해제되었습니다")
    }
    
    func render() {
        renderer.render {
            Header(title: "GREET")
            if toggle {
                HelloItem(title: "의성2")
                HelloItem(title: "의성1")
                HelloItem(title: "의성3")
            } else {
                HelloItem(title: "의성1")
                HelloItem(title: "의성3")
            }
            Footer(title: "👋 Greeting from Carbon")
        }
    }
}

private extension HelloViewController {
    func setNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Hello"
    }
    
    func setUI() {
        self.view.backgroundColor = .black
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(200)
        }
    }
    
    func setTableView() {
        tableView.separatorStyle = .none
        renderer.target = tableView
        renderer.adapter.didSelect = { context in
            print(context.indexPath)
        }
    }
}
