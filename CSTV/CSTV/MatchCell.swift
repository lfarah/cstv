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
    
    private lazy var dateContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMaxYCorner]
        return view
    }()
    
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
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var leagueLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 8)
        view.textColor = .white
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
        
        // TODO: Move to constants
        
        team1StackView.addArrangedSubview(team1ImageView)
        team1StackView.addArrangedSubview(team1Label)
        
        team2StackView.addArrangedSubview(team2ImageView)
        team2StackView.addArrangedSubview(team2Label)
        
        matchStackView.addArrangedSubview(team1StackView)
        matchStackView.addArrangedSubview(vsTitleLabel)
        matchStackView.addArrangedSubview(team2StackView)
        
        self.addSubview(containerView)
        containerView.addSubview(dateContainerView)
        containerView.addSubview(matchStackView)
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

        team1ImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        team1ImageView.heightAnchor.constraint(equalTo: team1ImageView.widthAnchor).isActive = true
        
        vsTitleLabel.heightAnchor.constraint(equalTo: matchStackView.heightAnchor).isActive = true
        
        team2ImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        team2ImageView.heightAnchor.constraint(equalTo: team2ImageView.widthAnchor).isActive = true
        
        matchStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        matchStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 43).isActive = true
        
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: matchStackView.bottomAnchor, constant: 18).isActive = true
        
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

extension MatchCell: CellConfigurable {
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
        dateText = content.parsedDate
        leagueName = "\(content.league.name) \(content.serie.name ?? "")"
        
        if let url = try? content.league.imageURL?.asURL() {
            leagueImageURL = url
            leagueImageView.backgroundColor = .clear
            leagueImageView.layer.cornerRadius = 0
            leagueImageView.clipsToBounds = false
        } else {
            leagueImageURL = nil
            leagueImageView.backgroundColor = .lightGray
            leagueImageView.layer.cornerRadius = 16 / 2
            leagueImageView.clipsToBounds = true
        }
        
        switch content.parsedStatus {
        case .running:
            dateContainerView.backgroundColor = .red
        default:
            dateContainerView.backgroundColor = .gray
        }
    }
}
