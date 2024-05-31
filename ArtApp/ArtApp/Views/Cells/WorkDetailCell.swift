//
//  WorkDetailCell.swift
//  ArtApp
//
//  Created by Алексей on 31.05.2024.
//

import UIKit

final class WorkDetailCell: UICollectionViewCell {
    
    // MARK: - Private properties
    private let nameWorkLabel = UILabel()
    private let workImageView = UIImageView()
    private let infoTextView = UITextView()
    
    // MARK: - Override methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    override func prepareForReuse() {
        nameWorkLabel.text = nil
        workImageView.image = nil
        infoTextView.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func configureCell(_ item: Work) {
        nameWorkLabel.text = item.title
        workImageView.image = UIImage(named: item.image)
        infoTextView.text = item.info
    }
}

//MARK: - Setup Cell
extension WorkDetailCell {
    func setupView() {
        backgroundColor = .black
        alpha = 0.99
        setupNameWorkLabel()
        setupWorkImageView()
        setupInfoTextview()
    }
    
    func setupNameWorkLabel() {
        addSubview(nameWorkLabel)
        nameWorkLabel.translatesAutoresizingMaskIntoConstraints = false
        nameWorkLabel.font = .systemFont(ofSize: 30, weight: .bold)
        nameWorkLabel.textAlignment = .center
        nameWorkLabel.numberOfLines = 0
        nameWorkLabel.textColor = .white
    }
    
    func setupWorkImageView() {
        addSubview(workImageView)
        workImageView.translatesAutoresizingMaskIntoConstraints = false
        workImageView.contentMode = .scaleAspectFit
    }
    
    func setupInfoTextview() {
        addSubview(infoTextView)
        infoTextView.translatesAutoresizingMaskIntoConstraints = false
        infoTextView.font = .systemFont(ofSize: 14)
        infoTextView.textColor = .white
        infoTextView.backgroundColor = .none
        infoTextView.isEditable = false
    }
}

// MARK: - Set Constraints
extension WorkDetailCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            nameWorkLabel.topAnchor.constraint(equalTo: topAnchor),
            nameWorkLabel.leadingAnchor.constraint(equalTo: workImageView.leadingAnchor),
            nameWorkLabel.trailingAnchor.constraint(equalTo: workImageView.trailingAnchor),
            
            workImageView.topAnchor.constraint(equalTo: nameWorkLabel.bottomAnchor, constant: 25),
            workImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            workImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            infoTextView.topAnchor.constraint(equalTo: workImageView.bottomAnchor, constant: 10),
            infoTextView.leadingAnchor.constraint(equalTo: workImageView.leadingAnchor),
            infoTextView.trailingAnchor.constraint(equalTo: workImageView.trailingAnchor),
            infoTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
