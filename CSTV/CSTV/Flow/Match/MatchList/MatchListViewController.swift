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
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.backgroundColor = .backgroundDarkBlue
        return view
    }()
    
    private lazy var refreshControl = {
        let view = UIRefreshControl()
        view.tintColor = .white
        return view
    }()
    
    private lazy var spinner = {
        let view = UIActivityIndicatorView(style: .large)
        view.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewModel = MatchListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setupUI()
    }
    
    func bind() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(type: MatchCell.self)
        
        viewModel.matches.subscribe(onNext: { [weak self] values in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
            self?.spinner.startAnimating()
            self?.spinner.isHidden = !values.isEmpty
        })
        .disposed(by: bag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.reload()
            })
            .disposed(by: bag)
    }
    
    func setupUI() {
        title = "Partidas"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .backgroundDarkBlue
        
        tableView.refreshControl = refreshControl
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .backgroundDarkBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .white
        
        view.addSubview(tableView)
        view.addSubview(spinner)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource
extension MatchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.matches.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: MatchCell.self, indexPath: indexPath)
        
        let match = viewModel.matches.value[indexPath.row]
        cell.configure(with: match)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MatchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let match = viewModel.matches.value[indexPath.row]
        
        // If I had more time I would've implemented a Coordinator
        let viewModel = MatchDetailViewModel(match: match)
        let detailVC = MatchDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
