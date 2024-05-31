//
//  CreateNewArtistViewContoller.swift
//  ArtApp
//
//  Created by Алексей on 31.05.2024.
//

import UIKit

enum Constants {
    static let colorPlaceholder = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
}

final class CreateNewArtistViewController: UIViewController {

    // MARK: - Public properties
    var completionSaveNewArtist: ((Artist)->())?
    
    // MARK: - Private properties
    private let closeButton = UIButton()
    private let customView = UIView()
    private let nameArtistTextField = UITextField()
    private let bioTextView = UITextView()
    private let saveButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
    
    @objc private func closeVC() {
        dismiss(animated: true)
    }
    
    @objc private func saveNewArtist() {
        guard let text = nameArtistTextField.text, !text.isReallyEmpty else {
            return
        }
        
        let newArtist = Artist(
            name: text,
            bio: bioTextView.text,
            image: "0",
            works: [Work(title: "title", image: "0", info: "info")]
        )
     
        completionSaveNewArtist?(newArtist)
        closeVC()
    }
    
    @objc private func keyboardIsHidden() {
        nameArtistTextField.resignFirstResponder()
        bioTextView.resignFirstResponder()
    }
}

// MARK: - Setup View
private extension CreateNewArtistViewController {
    func setupView() {
        view.backgroundColor = .white
        setupCloseButton()
        setupCustomView()
        setupNameArtisTextField()
        setupBioTextView()
        setupSaveButton()
    }
    
    func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.tintColor = .black
    }
    
    func setupCustomView() {
        view.addSubview(customView)
        customView.addSubview(nameArtistTextField)
        customView.addSubview(bioTextView)
        customView.addSubview(saveButton)
        customView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupNameArtisTextField() {
        nameArtistTextField.becomeFirstResponder()
        nameArtistTextField.placeholder = "Enter the artist name"
        nameArtistTextField.borderStyle = .roundedRect
        nameArtistTextField.addInputAccessoryView(target: self, selector: #selector(keyboardIsHidden))
        nameArtistTextField.clearButtonMode = .always
        nameArtistTextField.autocorrectionType = .no
        nameArtistTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupBioTextView() {
        bioTextView.delegate = self
        bioTextView.text = "Enter the artist biography"
        bioTextView.textColor = Constants.colorPlaceholder
        bioTextView.font = .systemFont(ofSize: 16)
        bioTextView.layer.borderWidth = 0.5
        bioTextView.layer.cornerRadius = 5
        bioTextView.layer.borderColor = Constants.colorPlaceholder.cgColor
        bioTextView.translatesAutoresizingMaskIntoConstraints = false
        bioTextView.addInputAccessoryView(target: self, selector: #selector(keyboardIsHidden))
    }
    
    func setupSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.backgroundColor = .systemBlue
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(saveNewArtist), for: .touchUpInside)
    }
    
}

// MARK: - Set Constraints
private extension CreateNewArtistViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            
            customView.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            customView.bottomAnchor.constraint(equalTo: saveButton.bottomAnchor),
            
            nameArtistTextField.topAnchor.constraint(equalTo: customView.centerYAnchor),
            nameArtistTextField.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            nameArtistTextField.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            
            bioTextView.topAnchor.constraint(equalTo: nameArtistTextField.bottomAnchor, constant: 10),
            bioTextView.leadingAnchor.constraint(equalTo: nameArtistTextField.leadingAnchor),
            bioTextView.trailingAnchor.constraint(equalTo: nameArtistTextField.trailingAnchor),
            bioTextView.heightAnchor.constraint(equalToConstant: 100),
            
            saveButton.topAnchor.constraint(equalTo: bioTextView.bottomAnchor, constant: 15),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.leadingAnchor.constraint(equalTo: nameArtistTextField.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: nameArtistTextField.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

// MARK: - Text Field Delegate
extension CreateNewArtistViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Text View Delegate
extension CreateNewArtistViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == Constants.colorPlaceholder {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter the artist biography"
            textView.textColor = Constants.colorPlaceholder
        }
    }
}
