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

        Observable.zip(service.loadRunningMatches().catchAndReturn([]), service.loadUpcomingMatches().catchAndReturn([]))
            .map { $0.0 + $0.1 }
            .subscribe(onNext: { [weak self] matches in
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
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MatchCell.self, forCellReuseIdentifier: "MatchCell")
    }
    
    func setupUI() {
        title = "Partidas"
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .backgroundDarkBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

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
        
        let match = matches[indexPath.row]
        cell.configure(with: match)
        return cell
    }
}

extension MatchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let match = matches[indexPath.row]
        let detailVC = MatchDetailViewController(match: match)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
