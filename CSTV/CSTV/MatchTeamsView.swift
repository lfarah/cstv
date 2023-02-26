//
//  MatchTeamsView.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import UIKit

class MatchTeamsView: UIView {
    private lazy var team1Label: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 10)
        view.textColor = .white
        return view
    }()
    
    private lazy var vsTitleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 12)
        view.textColor = .lightGray
        view.text = "vs"
        return view
    }()
    
    private lazy var team2Label: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 10)
        view.textColor = .white
        return view
    }()
    
    private lazy var team1ImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var team2ImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var matchStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .equalCentering
        view.axis = .horizontal
        view.alignment = .top
        view.spacing = 20
        return view
    }()
    
    private lazy var team1StackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fill
        view.axis = .vertical
        view.alignment = .fill
        view.spacing = 10
        return view
    }()
    
    private lazy var team2StackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fill
        view.axis = .vertical
        view.alignment = .fill
        view.spacing = 10
        return view
    }()

    public var team1Name: String? {
        didSet {
            team1Label.text = team1Name
        }
    }
    
    public var team2Name: String? {
        didSet {
            team2Label.text = team2Name
        }
    }
    
    public var team1ImageURL: URL? {
        didSet {
            team1ImageView.kf.setImage(with: team1ImageURL)
        }
    }
    
    public var team2ImageURL: URL? {
        didSet {
            team2ImageView.kf.setImage(with: team2ImageURL)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bind()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(matchStackView)
        
        team1StackView.addArrangedSubview(team1ImageView)
        team1StackView.addArrangedSubview(team1Label)
        
        team2StackView.addArrangedSubview(team2ImageView)
        team2StackView.addArrangedSubview(team2Label)
        
        matchStackView.addArrangedSubview(team1StackView)
        matchStackView.addArrangedSubview(vsTitleLabel)
        matchStackView.addArrangedSubview(team2StackView)
        
        team1ImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        team1ImageView.heightAnchor.constraint(equalTo: team1ImageView.widthAnchor).isActive = true
        
        vsTitleLabel.heightAnchor.constraint(equalTo: matchStackView.heightAnchor).isActive = true
        
        team2ImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        team2ImageView.heightAnchor.constraint(equalTo: team2ImageView.widthAnchor).isActive = true
        
        matchStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        matchStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        matchStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        matchStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func bind() {
        
    }
}

extension MatchTeamsView: ViewConfigurable {
    typealias Content = Match
    
    func configure(with content: Match) {
        let team1 = content.team1
        let team2 = content.team2

        team1Name = team1?.name ?? "TBD"
        team2Name = team2?.name ?? "TBD"

        if let url = try? team1?.imageURL?.asURL() {
            team1ImageURL = url
            team1ImageView.backgroundColor = .clear
            team1ImageView.layer.cornerRadius = 0
            team1ImageView.clipsToBounds = false
        } else {
            team1ImageURL = nil
            team1ImageView.backgroundColor = .lightGray
            team1ImageView.layer.cornerRadius = 60 / 2
            team1ImageView.clipsToBounds = true
        }
        
        if let url = try? team2?.imageURL?.asURL() {
            team2ImageURL = url
            team2ImageView.backgroundColor = .clear
            team2ImageView.layer.cornerRadius = 0
            team2ImageView.clipsToBounds = false
        } else {
            team2ImageURL = nil
            team2ImageView.backgroundColor = .lightGray
            team2ImageView.layer.cornerRadius = 60 / 2
            team2ImageView.clipsToBounds = true
        }
    }
}
