//
//  HeaderArtistDetail.swift
//  ArtApp
//
//  Created by Алексей on 31.05.2024.
//

import UIKit

final class HeaderArtistDetail: UICollectionReusableView {
    
    // MARK: - Private properties
    private let portraitImageView = UIImageView()
    private let bioTextView = UITextView()
    
    // MARK: - Override methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        DispatchQueue.main.asyncAfter(deadline: (.now() + .milliseconds(500))) {
                self.bioTextView.flashScrollIndicators()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func configureHeader(_ artist: Artist) {
        portraitImageView.image = UIImage(named: artist.image)
        bioTextView.text = artist.bio
    }
    
    // MARK: - Private methods
    private func setupView() {
        setupPortraitImageView()
        setupBioTextView()
        setConstraints()
    }
    
    // MARK: - Private methods
    private func setupPortraitImageView() {
        addSubview(portraitImageView)
        portraitImageView.translatesAutoresizingMaskIntoConstraints = false
        portraitImageView.clipsToBounds = true
        portraitImageView.contentMode = .scaleAspectFill
        portraitImageView.layer.cornerRadius = 15
    }
    
    private func setupBioTextView() {
        addSubview(bioTextView)
        bioTextView.translatesAutoresizingMaskIntoConstraints = false
        bioTextView.font = .systemFont(ofSize: 14)
        bioTextView.isEditable = false
        bioTextView.textColor = .black
        bioTextView.backgroundColor = .none
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            portraitImageView.topAnchor.constraint(equalTo: topAnchor),
            portraitImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            portraitImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            portraitImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.5),
            
            bioTextView.topAnchor.constraint(equalTo: portraitImageView.bottomAnchor, constant: 5),
            bioTextView.leadingAnchor.constraint(equalTo: portraitImageView.leadingAnchor, constant: 5),
            bioTextView.trailingAnchor.constraint(equalTo: portraitImageView.trailingAnchor, constant: -5),
            bioTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25)
        ])
    }
}
