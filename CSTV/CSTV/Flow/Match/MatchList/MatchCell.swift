//
//  MatchCell.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import UIKit
import Kingfisher

class MatchCell: UITableViewCell {
    
    typealias Content = Match

    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.backgroundLightBlue
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 10)
        view.textColor = .white
        return view
    }()
    
    private lazy var teamsView: MatchTeamsView = {
        let view = MatchTeamsView(frame: .zero)
        return view
    }()
    
    private lazy var dateContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.backgroundGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMaxYCorner]
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.2)
        return view
    }()
    
    private lazy var leagueImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .imagePlaceholderGray
        return view
    }()
    
    private lazy var leagueLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 8)
        view.textColor = .white
        return view
    }()
        
    public var dateText: String? {
        didSet {
            dateLabel.text = dateText
        }
    }
    
    public var leagueName: String? {
        didSet {
            leagueLabel.text = leagueName
        }
    }
    
    public var leagueImageURL: URL? {
        didSet {
            leagueImageView.kf.setImage(with: leagueImageURL)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .backgroundDarkBlue
        selectionStyle = .none
        
        self.addSubview(containerView)
        containerView.addSubview(dateContainerView)
        containerView.addSubview(teamsView)
        containerView.addSubview(separatorView)
        containerView.addSubview(leagueImageView)
        containerView.addSubview(leagueLabel)
        
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        dateContainerView.addSubview(dateLabel)
        
        dateContainerView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        dateContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: dateContainerView.topAnchor, constant: 8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: dateContainerView.bottomAnchor, constant: -8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: dateContainerView.leadingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: dateContainerView.trailingAnchor, constant: -8).isActive = true

        teamsView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        teamsView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 43).isActive = true
        
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: teamsView.bottomAnchor, constant: 18).isActive = true
        
        leagueImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        leagueImageView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 8).isActive = true
        leagueImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
        leagueImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        leagueImageView.heightAnchor.constraint(equalTo: leagueImageView.widthAnchor).isActive = true
        
        leagueLabel.leadingAnchor.constraint(equalTo: leagueImageView.trailingAnchor, constant: 8).isActive = true
        leagueLabel.centerYAnchor.constraint(equalTo: leagueImageView.centerYAnchor).isActive = true
        
        // Used for spacing between cells
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -23).isActive = true
    }
}

extension MatchCell: ViewConfigurable {
    func configure(with content: Match) {
                
        teamsView.configure(with: content)
        dateText = content.parsedDate
        leagueName = "\(content.league.name) \(content.serie.name ?? "")"
        
        if let url = try? content.league.imageURL?.asURL() {
            leagueImageURL = url
            leagueImageView.backgroundColor = .clear
            leagueImageView.layer.cornerRadius = 0
            leagueImageView.clipsToBounds = false
        } else {
            leagueImageURL = nil
            leagueImageView.backgroundColor = .imagePlaceholderGray
            leagueImageView.layer.cornerRadius = 16 / 2
            leagueImageView.clipsToBounds = true
        }
        
        switch content.parsedStatus {
        case .running:
            dateContainerView.backgroundColor = .backgroundRed
        default:
            dateContainerView.backgroundColor = .backgroundGray
        }
    }
}
