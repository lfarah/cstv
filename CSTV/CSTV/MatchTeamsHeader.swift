//
//  MatchTeamsHeader.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import UIKit

class MatchTeamsHeader: UICollectionReusableView {
        
    lazy var teamsView: MatchTeamsView = {
        let view = MatchTeamsView(frame: .zero)
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
    }
}
