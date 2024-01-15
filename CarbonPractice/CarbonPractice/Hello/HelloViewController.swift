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
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setUI()
        setTableView()
    }
}

private extension HelloViewController {
    func setNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Hello"
    }
    
    func setUI() {
        self.view.backgroundColor = .white
    }
    
    func setTableView() {
        
    }
}
