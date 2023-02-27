//
//  MatchDetailViewController.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import UIKit
import RxSwift

class MatchDetailViewController: UIViewController {

    let bag = DisposeBag()
    
    let viewModel: MatchDetailViewModel
    init(viewModel: MatchDetailViewModel) {
        self.viewModel = viewModel
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
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setupLayout()        
    }
    
    func bind() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(type: MatchTeamsHeader.self, kind: UICollectionView.elementKindSectionHeader)
        collectionView.register(type: PlayerCell.self)
        
        viewModel.players
            .subscribe(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: bag)
    }
    
    func setupLayout() {
        navigationItem.largeTitleDisplayMode = .never
        title = "\(viewModel.match.league.name) \(viewModel.match.serie.name ?? "")"
        
        view.addSubview(collectionView)
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension MatchDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.players.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: PlayerCell.self, indexPath: indexPath)
        
        let player = viewModel.players.value[indexPath.row]
        cell.configure(with: player)
        cell.alignment = indexPath.row % 2 == 0 ? .right : .left
        return cell
    }
}

extension MatchDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(type: MatchTeamsHeader.self, kind: kind, indexPath: indexPath)
            headerView.configure(with: viewModel.match)
            return headerView
        default:
            preconditionFailure("Only headers supported")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  13
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: 54)
    }
}
