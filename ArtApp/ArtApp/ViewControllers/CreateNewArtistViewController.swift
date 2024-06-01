//
//  CreateNewArtistViewContoller.swift
//  ArtApp
//
//  Created by Алексей on 31.05.2024.
//

import UIKit

enum Constants {
    static let colorPlaceholder = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    static let heightItemCollection: CGFloat = (UIScreen.main.bounds.width - 50) / 3
    static let bioTextViewPlaceholder = "Enter the artist biography"
}

final class CreateNewArtistViewController: UIViewController {
    
    // MARK: - Public properties
    var completionSaveNewArtist: ((Artist)->())?
    
    // MARK: - Private properties
    private let artistImageView = UIImageView()
    private let nameArtistTextField = UITextField()
    private let bioTextView = UITextView()
    private let saveButton = UIButton(type: .system)
    private let imagePicker = UIImagePickerController()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInsetReference = .fromLayoutMargins
        layout.itemSize = CGSize(
            width: Constants.heightItemCollection,
            height: Constants.heightItemCollection
        )
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    private var newArtist: Artist?
    private var workImages = [UIImage]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
    
    @objc private func saveNewArtist() {
        guard let text = nameArtistTextField.text, !text.isReallyEmpty else {
            return
        }
        
        // TODO: - Correct save new artist
        let newArtist = Artist(
            name: text,
            bio: bioTextView.text == Constants.bioTextViewPlaceholder ? "" : bioTextView.text,
            image: "",
            works: [Work]()
        )
        
        completionSaveNewArtist?(newArtist)
        navigationController?.popViewController(animated: true)
    }
    @objc private func keyboardIsHidden() {
        view.endEditing(true)
    }
}

// MARK: - Setup View
private extension CreateNewArtistViewController {
    func setupView() {
        view.backgroundColor = .white
        setupArtistImageView()
        setupNameArtisTextField()
        setupBioTextView()
        setupSaveButton()
        setupImagePicker()
        setupCollection()
    }
    
    func setupArtistImageView() {
        view.addSubview(artistImageView)
        artistImageView.translatesAutoresizingMaskIntoConstraints = false
        artistImageView.contentMode = .scaleAspectFill
        artistImageView.clipsToBounds = true
        artistImageView.layer.cornerRadius = Constants.heightItemCollection / 2
        artistImageView.image = ._4
    }
    
    func setupNameArtisTextField() {
        view.addSubview(nameArtistTextField)
        nameArtistTextField.placeholder = "Enter the artist name"
        nameArtistTextField.borderStyle = .roundedRect
        nameArtistTextField.delegate = self
        nameArtistTextField.addInputAccessoryView(target: self, selector: #selector(keyboardIsHidden))
        nameArtistTextField.clearButtonMode = .always
        nameArtistTextField.autocorrectionType = .no
        nameArtistTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupBioTextView() {
        view.addSubview(bioTextView)
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
        view.addSubview(saveButton)
        saveButton.setTitle("Save new artist", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.backgroundColor = .systemBlue
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(saveNewArtist), for: .touchUpInside)
    }
    
    func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    
    func setupCollection() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            DidUploadImageForNewArtistCell.self,
            forCellWithReuseIdentifier: DidUploadImageForNewArtistCell.description()
        )
        collectionView.register(
            WillUploadImageForNewArtistCell.self,
            forCellWithReuseIdentifier: WillUploadImageForNewArtistCell.description()
        )
    }
    
}

// MARK: - Set Constraints
private extension CreateNewArtistViewController {
    func setConstraints() {
        setConstraintsArtistImageView()
        setConstraintsTextField()
        setConstraintsTextView()
        setConstraintsSaveButton()
        setConstraintsCollection()
    }
    
    func setConstraintsArtistImageView() {
        NSLayoutConstraint.activate([
            artistImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            artistImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            artistImageView.heightAnchor.constraint(equalToConstant: Constants.heightItemCollection),
            artistImageView.widthAnchor.constraint(equalToConstant: Constants.heightItemCollection)
        ])
    }
    
    func setConstraintsTextField() {
        NSLayoutConstraint.activate([
            nameArtistTextField.topAnchor.constraint(equalTo: artistImageView.bottomAnchor, constant: 20),
            nameArtistTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            nameArtistTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -25),
            nameArtistTextField.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    func setConstraintsTextView() {
        NSLayoutConstraint.activate([
            bioTextView.topAnchor.constraint(equalTo: nameArtistTextField.bottomAnchor, constant: 10),
            bioTextView.leadingAnchor.constraint(equalTo: nameArtistTextField.leadingAnchor),
            bioTextView.trailingAnchor.constraint(equalTo: nameArtistTextField.trailingAnchor),
            bioTextView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func setConstraintsSaveButton() {
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 15),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.leadingAnchor.constraint(equalTo: nameArtistTextField.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: nameArtistTextField.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    func setConstraintsCollection() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: bioTextView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: bioTextView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: bioTextView.bottomAnchor, constant: 15),
            collectionView.heightAnchor.constraint(equalToConstant: Constants.heightItemCollection + 20),
            
        ])
    }
    
}

// MARK: - Text Field Delegate
extension CreateNewArtistViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bioTextView.becomeFirstResponder()
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
            textView.text = Constants.bioTextViewPlaceholder
            textView.textColor = Constants.colorPlaceholder
        }
    }
}

// MARK: - Image Picker Delegate & Navigation Controller Delegate
extension CreateNewArtistViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            workImages.append(image)
            collectionView.reloadData()
            collectionView.scrollToItem(
                at: IndexPath(row: workImages.count, section: 0),
                at: .right,
                animated: true
            )
        }
        
        imagePicker.dismiss(animated: true)
    }
}

// MARK: Collection View Data Source
extension CreateNewArtistViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        workImages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item != workImages.count {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DidUploadImageForNewArtistCell.description(), for: indexPath) as? DidUploadImageForNewArtistCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(image: workImages[indexPath.item])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WillUploadImageForNewArtistCell.description(), for: indexPath) as? WillUploadImageForNewArtistCell else {
                return UICollectionViewCell()
            }
            
            return cell
        }
        
        
    }
}

// MARK: - Collection View Delegate
extension CreateNewArtistViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == workImages.count {
            present(imagePicker, animated: true)
        }
        keyboardIsHidden()
    }
}
