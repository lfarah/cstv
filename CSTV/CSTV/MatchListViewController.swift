//
//  MatchListViewController.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import UIKit
import RxSwift

class MatchListViewController: UIViewController {

    let service = MatchService()
    
    let bag = DisposeBag()
    
    let tableView = UITableView()
    
    var matches: [Match] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        service.loadMatches().subscribe(onNext: { [weak self] matches in
            print("matches: \(matches)")
            self?.matches = matches
            self?.tableView.reloadData()
        })
        .disposed(by: bag)
        
        bind()
        setupUI()
    }
    
    func bind() {
        tableView.dataSource = self
        
        tableView.register(MatchCell.self, forCellReuseIdentifier: "MatchCell")
    }
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource
extension MatchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as? MatchCell else {
            preconditionFailure("Cell not registered")
        }
        
        cell.backgroundColor = [UIColor.red, UIColor.blue, UIColor.green].randomElement()
        
        return cell
    }
}
