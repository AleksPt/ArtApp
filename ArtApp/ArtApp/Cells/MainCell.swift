//
//  MainCell.swift
//  ArtApp
//
//  Created by Алексей on 31.05.2024.
//

import UIKit

final class MainCell: UITableViewCell {

    // MARK: - Private properties
    private let portrait = UIImageView()
    private let titleLabel = UILabel()
    private let bioLabel = UILabel()
    
    // MARK: - Override methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraint()
    }
    
    override func prepareForReuse() {
        portrait.image = nil
        titleLabel.text = nil
        bioLabel.text = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Public properties
    func configureCell(artist: Artist) {
        portrait.image = UIImage(named: artist.image)
        titleLabel.text = artist.name
        bioLabel.text = artist.bio
    }
}

// MARK: - Setup View
private extension MainCell {
    func setupView() {
        backgroundColor = .white
        setupPortrait()
        setupTitleLabel()
        setupBioLabel()
    }
    
    func setupPortrait() {
        addSubview(portrait)
        portrait.translatesAutoresizingMaskIntoConstraints = false
        portrait.contentMode = .scaleAspectFill
        portrait.clipsToBounds = true
        portrait.layer.cornerRadius = 20
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.numberOfLines = 0
    }
    
    func setupBioLabel() {
        addSubview(bioLabel)
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.font = .systemFont(ofSize: 12)
        bioLabel.numberOfLines = 3
    }
    
}

// MARK: - Set Constraint
private extension MainCell {
    func setConstraint() {
        NSLayoutConstraint.activate([
            portrait.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            portrait.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            portrait.widthAnchor.constraint(equalToConstant: 50),
            portrait.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leadingAnchor.constraint(equalTo: portrait.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: portrait.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            
            bioLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            bioLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
        
        ])
    }
}
