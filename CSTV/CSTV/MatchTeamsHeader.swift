//
//  MatchTeamsHeader.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import UIKit

class MatchTeamsHeader: UICollectionReusableView {
        
    private lazy var teamsView: MatchTeamsView = {
        let view = MatchTeamsView(frame: .zero)
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 12)
        view.textColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        backgroundColor = .backgroundDarkBlue
        
        addSubview(teamsView)
        teamsView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        teamsView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        addSubview(dateLabel)
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: teamsView.bottomAnchor, constant: 20).isActive = true
    }
}

extension MatchTeamsHeader: ViewConfigurable {
    typealias Content = Match

    func configure(with content: Match) {
        teamsView.configure(with: content)
        dateLabel.text = content.parsedDate
    }
}
