//
//  TodoCustomViewController.swift
//  CarbonPractice
//
//  Created by uiskim on 1/29/24.
//

import UIKit

import Carbon
import SnapKit

struct TodoCustom {
    var title: String
    var isFinished: Bool
}

final class TodoCustomViewController: UIViewController {
    
    var datas: [TodoCustom] {
        didSet {
            render()
        }
    }
    
    init(datas: [TodoCustom]) {
        self.datas = datas
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView = UITableView()
    let renderer = Renderer(adapter: UITableViewAdapter(), updater: UITableViewUpdater())

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Todo"
        view.backgroundColor = .white
        renderer.target = tableView
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        render()
    }
    
    func render() {
        renderer.render {
            if !datas.isEmpty {
                Group(of: datas.enumerated()) { index, data in
                    TodoCustomItem(title: data.title, isFinished: data.isFinished) { event in
                        switch event {
                        case .check:
                            self.datas[index].isFinished.toggle()
                        case .delete:
                            self.datas.remove(at: index)
                        }
                    }
                }
            } else {
                EmptyItem(title: "아무것도없습니다")
            }
        }
    }
}
