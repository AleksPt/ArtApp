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
    private var filteredArtist = [Artist]()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let search = UISearchController()
    private let plugImageView = UIImageView()
    private let plugLabel = UILabel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        fetchArtists()
    }

    // MARK: - Private methods
    private func fetchArtists() {
        networkService.fetchArtists { [weak self] artists in
            guard let artists else {
                print("artists is empty")
                return
            }
            
            self?.artists = artists.artists
            self?.filteredArtist = artists.artists
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func isHiddenPlug() {
        plugImageView.isHidden = filteredArtist.isEmpty ? false : true
        plugLabel.isHidden = filteredArtist.isEmpty ? false : true
    }
    
    private func goToCreateNewArtistVC() -> UIAction {
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            let vc = CreateNewArtistViewController()
            vc.completionSaveNewArtist = { [weak self] newArtist in
                guard let self else { return }
                artists.insert(newArtist, at: 0)
                filteredArtist = artists
                tableView.reloadData()
            }
            present(vc, animated: true)
        }
        return action
    }

}

// MARK: - Setup View
extension MainViewController {
    func setupView() {
        view.backgroundColor = .systemGroupedBackground
        title = "All artists"
        setupNavigationItems()
        setupTableView()
        setupSearch()
        setupPlug()
    }
    
    func setupNavigationItems() {
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            systemItem: .add,
            primaryAction: goToCreateNewArtistVC()
        )
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: -30, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MainCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupSearch() {
        search.searchBar.placeholder = "I'm looking..."
        search.searchBar.searchBarStyle = .minimal
        search.searchResultsUpdater = self
    }
    
    func setupPlug() {
        view.addSubview(plugImageView)
        plugImageView.isHidden = true
        plugImageView.image = .notFound
        plugImageView.frame = CGRect(
            x: view.center.x - 25,
            y: view.center.y - 25,
            width: 50,
            height: 50
        )
        
        view.addSubview(plugLabel)
        plugLabel.text = "I couldn't find anything :("
        plugLabel.isHidden = true
        plugLabel.textAlignment = .center
        plugLabel.font = .systemFont(ofSize: 12)
        plugLabel.frame = CGRect(
            x: 0,
            y: plugImageView.frame.maxY + 10,
            width: view.frame.width,
            height: 12
        )
    }

}

// MARK: - Set Constraints
extension MainViewController {
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
        filteredArtist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as? MainCell else {
            return UITableViewCell()
        }
        
        let artistIndex = filteredArtist[indexPath.row]
        cell.configureCell(artist: artistIndex)
        
        cell.separatorInset = .zero
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

// MARK: - Table View Delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ArtistDetailViewController()
        vc.configure(filteredArtist[indexPath.item])
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}

// MARK: - UISearchResultsUpdating {
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else {
            return
        }
        if query.isEmpty {
            filteredArtist = artists
            isHiddenPlug()
        } else {
            filteredArtist = artists.filter {
                $0.name.lowercased().contains(query.lowercased())
            }
            isHiddenPlug()
        }
        
        tableView.reloadData()
    }
}
