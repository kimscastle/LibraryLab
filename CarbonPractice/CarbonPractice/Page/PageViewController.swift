//
//  PageViewController.swift
//  CarbonPractice
//
//  Created by uiskim on 2/3/24.
//

import UIKit

import Carbon
import SnapKit

class PageViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    var renderer = Renderer(adapter: UITableViewAdapter(), updater: UITableViewUpdater())
    
    var inputListData: [Int] = []
    var inputHeaderData: [Int] = []
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("섞어!", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "안녕하세요"
        self.view.backgroundColor = .white
        renderer.target = tableView
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(button)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
        button.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(30)
        }
        render()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) { [weak self] in
            self?.inputListData = [1,2,3,4,5,6,7,8,9,10]
            self?.inputHeaderData = [1,2,3,4]
            self?.render()
        }
    }
    
    func render() {
        renderer.render {
            Section(id: "caruselSection", header: PageHeaderItem(input: inputHeaderData)) {
                Group(of: inputListData) { index in
                    HelloItem(title: "\(index)")
                }
            }
        }
    }
    
    @objc func tap() {
        self.inputListData = [3,6,2,5,1,7,8,9,10]
        self.inputHeaderData = [1,2,34,5,6,7]
        render()
    }
}
