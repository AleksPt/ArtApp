//
//  WillUploadImageForNewArtistCell.swift
//  ArtApp
//
//  Created by Алексей on 01.06.2024.
//

import UIKit

final class WillUploadImageForNewArtistCell: UICollectionViewCell {
    
    private let plugView = UIView()
    private let borderView = UIView()
    private let plusImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

// MARK: - Setup Cell
extension WillUploadImageForNewArtistCell {
    func setupCell() {
        setupBorderView()
        setupPlugView()
        setupPlusImageView()
    }
    
    func setupBorderView() {
        addSubview(borderView)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = .clear
        borderView.layer.cornerRadius = 10
        borderView.clipsToBounds = true
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func setupPlugView() {
        borderView.addSubview(plugView)
        plugView.backgroundColor = .customBlue
        plugView.layer.cornerRadius = 7.5
        plugView.clipsToBounds = true
        plugView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setupPlusImageView() {
        plugView.addSubview(plusImageView)
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        plusImageView.image = UIImage(systemName: "plus")
        plusImageView.tintColor = .systemBlue
    }
}

// MARK: - Set Constraints
extension WillUploadImageForNewArtistCell {
    func setupConstraints() {
        setConstraintsBorderView()
        setConstraintsPlugView()
        setConstraintsPlugImageView()
    }
    
    func setConstraintsBorderView() {
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: topAnchor),
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            borderView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setConstraintsPlugView() {
        NSLayoutConstraint.activate([
            plugView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 4),
            plugView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 4),
            plugView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -4),
            plugView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -4)
        ])
    }
    
    func setConstraintsPlugImageView() {
        NSLayoutConstraint.activate([
            plusImageView.centerXAnchor.constraint(equalTo: plugView.centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: plugView.centerYAnchor),
            plusImageView.heightAnchor.constraint(equalTo: plugView.heightAnchor, multiplier: 0.3),
            plusImageView.widthAnchor.constraint(equalTo: plugView.widthAnchor, multiplier: 0.3)
        ])
    }
}
