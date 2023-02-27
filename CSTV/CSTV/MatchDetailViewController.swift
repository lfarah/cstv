//
//  MatchDetailViewController.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import UIKit
import RxSwift

class MatchDetailViewController: UIViewController {

    let match: Match
    
    let service = MatchService()

    let bag = DisposeBag()
    
    init(match: Match) {
        self.match = match
        super.init(nibName: nil, bundle: nil)
    }
    
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .backgroundDarkBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var players: [Player] = []
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setupLayout()
        
        service.loadMatchOpponents(for: match)
            .map { $0.opponents }
            .subscribe(onNext: { [weak self] opponents in
                
                // merging players from both teams into one array. I've used UICollectionViewCompositionalLayout in the past, but time constraints made me take this route.
                let team1Players = opponents.first?.players ?? []
                let team2Players = opponents.last?.players ?? []
                
                self?.players = self?.merge(team1Players, team2Players) ?? []
                self?.collectionView.reloadData()
            })
            .disposed(by: bag)
    }
    
    // TODO: Move to viewModel
    func merge<T>(_ arrays: [T]...) -> [T] {
        guard let longest = arrays.max(by: { $0.count < $1.count })?.count else { return [] }
        var result = [T]()
        for index in 0..<longest {
            for array in arrays {
                guard index < array.count else { continue }
                result.append(array[index])
            }
        }
        return result
    }

    func bind() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MatchTeamsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MatchTeamsHeader")
        collectionView.register(PlayerCell.self, forCellWithReuseIdentifier: "PlayerCell")
    }
    
    func setupLayout() {
        navigationItem.largeTitleDisplayMode = .never
        title = "\(match.league.name) \(match.serie.name ?? "")"
        
        view.addSubview(collectionView)
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension MatchDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCell", for: indexPath) as? PlayerCell else {
            preconditionFailure("PlayerCell not created")
        }
        
        let player = players[indexPath.row]
        cell.configure(with: player)
        cell.alignment = indexPath.row % 2 == 0 ? .right : .left
        return cell
    }
}

extension MatchDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MatchTeamsHeader", for: indexPath) as? MatchTeamsHeader else {
                preconditionFailure("Header not supported")
            }
            headerView.configure(with: match)
            return headerView
        default:
            preconditionFailure("Only headers supported")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  13
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: 54)
    }
}
