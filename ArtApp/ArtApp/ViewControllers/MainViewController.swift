//
//  ViewController.swift
//  ArtApp
//
//  Created by Алексей on 30.05.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Private properties
    private var networkService = NetworkService.shared
    private var artists = [Artist]()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        fetchArtists()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationItem.largeTitleDisplayMode = .never
    }

    private func fetchArtists() {
        networkService.fetchArtists { [weak self] artists in
            guard let artists else {
                print("artists is empty")
                return
            }
            
            self?.artists = artists.artists
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

}

extension MainViewController {
    func setupView() {
        view.backgroundColor = .systemGroupedBackground
        title = "All artists"
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Table View Data Source
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let artistIndex = artists[indexPath.row]
        
        var cellConfiguration = cell.defaultContentConfiguration()
        cellConfiguration.text = artistIndex.name
        cellConfiguration.secondaryText = artistIndex.bio
        cell.contentConfiguration = cellConfiguration
        
        cell.separatorInset = .zero
        
        return cell
    }
}

// MARK: - Table View Delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ArtistDetailViewController()
        vc.configure(artists[indexPath.item])
        navigationController?.pushViewController(vc, animated: true)
    }
}
