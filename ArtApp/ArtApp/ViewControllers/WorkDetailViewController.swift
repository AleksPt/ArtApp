//
//  WorkDetailViewController.swift
//  ArtApp
//
//  Created by Алексей on 30.05.2024.
//

import UIKit

final class WorkDetailViewController: UIViewController {
    
    // MARK: - Private properties
    private let nameWorkLabel = UILabel()
    private let workImageView = UIImageView()
    private let infoTextView = UITextView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
    
    // MARK: - Public methods
    func configure(_ item: Work) {
        nameWorkLabel.text = item.title
        workImageView.image = UIImage(named: item.image)
        infoTextView.text = item.info
    }
}

//MARK: - Setup View
extension WorkDetailViewController {
    func setupView() {
        view.backgroundColor = .black
        view.alpha = 0.99
        setupNameWorkLabel()
        setupWorkImageView()
        setupInfoTextview()
    }
    
    func setupNameWorkLabel() {
        view.addSubview(nameWorkLabel)
        nameWorkLabel.translatesAutoresizingMaskIntoConstraints = false
        nameWorkLabel.font = .systemFont(ofSize: 30, weight: .bold)
        nameWorkLabel.textAlignment = .center
        nameWorkLabel.numberOfLines = 0
        nameWorkLabel.textColor = .white
    }
    
    func setupWorkImageView() {
        view.addSubview(workImageView)
        workImageView.translatesAutoresizingMaskIntoConstraints = false
        workImageView.contentMode = .scaleAspectFit
    }
    
    func setupInfoTextview() {
        view.addSubview(infoTextView)
        infoTextView.translatesAutoresizingMaskIntoConstraints = false
        infoTextView.font = .systemFont(ofSize: 14)
        infoTextView.textColor = .white
        infoTextView.backgroundColor = .none
        infoTextView.isEditable = false
    }
}

// MARK: - Set Constraints
extension WorkDetailViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            nameWorkLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            nameWorkLabel.leadingAnchor.constraint(equalTo: workImageView.leadingAnchor),
            nameWorkLabel.trailingAnchor.constraint(equalTo: workImageView.trailingAnchor),
            
            workImageView.topAnchor.constraint(equalTo: nameWorkLabel.bottomAnchor, constant: 25),
            workImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            workImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            infoTextView.topAnchor.constraint(equalTo: workImageView.bottomAnchor, constant: 10),
            infoTextView.leadingAnchor.constraint(equalTo: workImageView.leadingAnchor),
            infoTextView.trailingAnchor.constraint(equalTo: workImageView.trailingAnchor),
            infoTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
