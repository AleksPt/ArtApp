//
//  ArtistDetailViewController.swift
//  ArtApp
//
//  Created by Алексей on 30.05.2024.
//

import UIKit

final class ArtistDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
}

extension ArtistDetailViewController {
    func setupView() {
        title = "ArtistDetailVC"
        view.backgroundColor = .systemGroupedBackground
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
