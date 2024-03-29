//
//  HomeViewController.swift
//  CarbonPractice
//
//  Created by uiskim on 2024/01/15.
//

import UIKit

import Carbon
import SnapKit

final class HomeViewController: UIViewController {
    enum Destination {
        case hello, pangram, kyoto, emoji, todo, form, page, identi
    }
    
    let tableview = UITableView()
    
    let renderer = Renderer(adapter: UITableViewAdapter(), updater: UITableViewUpdater())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setUI()
        setTableView()
    }
    
    deinit {
        print("homeVC가 메모리에서 해제되었습니다")
    }
}

private extension HomeViewController {
    func setNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Home"
    }
    
    func setUI() {
        view.backgroundColor = .white
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setTableView() {
        tableview.separatorStyle = .none
        renderer.target = tableview
        renderer.render {
            Header(title: "예시 앱 모음")
            HomeItem(title: "👋 Hello") { [weak self] in
                self?.push(.hello)
            }
            
            HomeItem(title: "🔠 Pangram") { [weak self] in
                self?.push(.pangram)
            }
            
            HomeItem(title: "⛩ Kyoto") { [weak self] in
                self?.push(.kyoto)
            }
            
            HomeItem(title: "😀 Shuffle Emoji") { [weak self] in
                self?.push(.emoji)
            }
            
            HomeItem(title: "📋 Todo App") { [weak self] in
                self?.push(.todo)
            }
            
            HomeItem(title: "👤 Profile Form") { [weak self] in
                self?.push(.form)
            }
            
            HomeItem(title: "🗒️ Page") { [weak self] in
                self?.push(.page)
            }
            
            HomeItem(title: "🆔 identi") { [weak self] in
                self?.push(.identi)
            }
        }
    }
    
    func push(_ destination: Destination) {
        let controller: UIViewController
        switch destination {
        case .hello:
            controller = HelloViewController()
        case .pangram:
            controller = PangramViewController()
        case .kyoto:
            controller = KyotoViewController()
        case .todo:
            let vc = TodoCustomViewController()
            vc.datas = [
                .init(title: "기상", isFinished: false),
                .init(title: "이불정리", isFinished: true),
                .init(title: "물먹기", isFinished: true)
            ]
            controller = vc
        case .page:
            controller = PageViewController()
        case.identi:
            controller = IdTestViewController()
        default:
            controller = HelloViewController()
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

