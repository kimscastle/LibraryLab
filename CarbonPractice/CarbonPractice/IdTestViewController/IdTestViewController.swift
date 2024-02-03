//
//  IdTestViewController.swift
//  CarbonPractice
//
//  Created by uiskim on 2/3/24.
//

import UIKit

import Carbon
import SnapKit

struct pokemonModel {
    let name: String
    let type: String
    let color: UIColor
    let imagename: String
}

final class IdTestViewController: UIViewController {
    
    var toggle = false {
        didSet {
            render()
        }
    }
    
    var pokemonList = [
        pokemonModel(name: "피카츄", type: "전기 포켓몬", color: .orange, imagename: "bolt.fill"),
        pokemonModel(name: "파이리", type: "불 포켓몬", color: .red, imagename: "bolt.fill"),
        pokemonModel(name: "이상해씨", type: "풀 포켓몬", color: .green, imagename: "leaf.fill"),
        pokemonModel(name: "꼬북이", type: "물 포켓몬", color: .blue, imagename: "tortoise.fill")
    ]
    
    var mixList = [
        pokemonModel(name: "피카츄", type: "전기 포켓몬", color: .orange, imagename: "bolt.fill"),
        pokemonModel(name: "파이리", type: "불 포켓몬", color: .red, imagename: "bolt.fill"),
        pokemonModel(name: "이상해씨", type: "풀 포켓몬", color: .green, imagename: "leaf.fill"),
        pokemonModel(name: "꼬북이", type: "물 포켓몬", color: .blue, imagename: "tortoise.fill")
    ]
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("섞어", for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    let tableView = UITableView()
    let renderer = Renderer(adapter: UITableViewAdapter(), updater: UITableViewUpdater())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderer.target = tableView
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }

        render()
        // Do any additional setup after loading the view.
    }
    
    func render() {
        renderer.render {
            Section(id: "포켓몬섹션") {
                Group(of: toggle ? pokemonList : mixList) { pokemon in
                    PokemonItem(name: pokemon.name, type: pokemon.type, nameColor: pokemon.color)
                        .identified(by: \.id)
                }
            }
        }
    }
    
    @objc func tap() {
        self.toggle.toggle()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
