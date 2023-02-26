//
//  MatchDetailViewController.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import UIKit

class MatchDetailViewController: UIViewController {

    let match: Match
    
    init(match: Match) {
        self.match = match
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setupLayout()
    }
    
    func bind() {
    }
    
    func setupLayout() {
        view.backgroundColor = .red
        title = "\(match.league.name) \(match.serie.name ?? "")"
    }
}
