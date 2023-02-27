//
//  PlayerCell.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import UIKit

enum PlayerCellAlignment {
    case left
    case right
    
    var textAlignment: NSTextAlignment {
        switch self {
        case .left:
            return .left
        case .right:
            return .right
        }
    }
    
    var corners: CACornerMask {
        switch self {
            
        case .left:
            return [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        case .right:
            return [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
    }
}

class PlayerCell: UICollectionViewCell {
    private lazy var nicknameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 14)
        view.textColor = .white
        view.textAlignment = .right
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 12)
        view.textColor = .textSecondary
        view.textAlignment = .right
        return view
    }()

    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .imagePlaceholderGray
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backgroundLightBlue
        view.layer.cornerRadius = 12
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var alignment: PlayerCellAlignment = .right {
        didSet {
            nicknameLabel.textAlignment = alignment.textAlignment
            nameLabel.textAlignment = alignment.textAlignment
            containerView.layer.maskedCorners = alignment.corners

            setupConstraints(alignment: alignment)
        }
    }
        
    func layout() {
        addSubview(containerView)
        
        containerView.addSubview(nicknameLabel)
        containerView.addSubview(nameLabel)
        containerView.addSubview(imageView)
        
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupConstraints(alignment: PlayerCellAlignment) {
        switch alignment {
        case .left:
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 11).isActive = true
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true

            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
            nameLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true

            nicknameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            nicknameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
            nicknameLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        case .right:
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -11).isActive = true
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true

            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            nameLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -16).isActive = true
            nameLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true

            nicknameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            nicknameLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
            nicknameLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        }
    }
}

extension PlayerCell: ViewConfigurable {
    typealias Content = Player
    
    func configure(with content: Player) {
        nicknameLabel.text = content.name
        nameLabel.text = "\(content.firstName) \(content.lastName)"
        imageView.kf.setImage(with: try? content.imageURL?.asURL())
    }
}
