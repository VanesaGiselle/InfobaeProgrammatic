//
//  NewTableViewCell.swift
//  InfobaeProgrammatic
//
//  Created by Vanesa Korbenfeld on 22/02/2022.
//

import UIKit

class NewTableViewCell: UITableViewCell {
    static let reuseIdentifier = "NewTableViewCell"
    private var viewModel: ViewModel?
    
    struct ViewModel {
        let titleText: String?
        let descriptionText: String?
        let imageUrl: URL
    }
    
    lazy var titleNew: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionNew: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var imageNew: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupNewViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented.")
    }
    
    func setupNewViewCell() {
        
        titleNew.translatesAutoresizingMaskIntoConstraints = false
        descriptionNew.translatesAutoresizingMaskIntoConstraints = false
        imageNew.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(titleNew)
        self.contentView.addSubview(descriptionNew)
        self.contentView.addSubview(imageNew)

        NSLayoutConstraint.activate([
            
            titleNew.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30),
            titleNew.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            titleNew.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            descriptionNew.topAnchor.constraint(equalTo: titleNew.bottomAnchor, constant: 10),
            descriptionNew.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            descriptionNew.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            imageNew.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            imageNew.topAnchor.constraint(equalTo: descriptionNew.bottomAnchor, constant: 10),
            imageNew.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            imageNew.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            imageNew.heightAnchor.constraint(equalToConstant: 200),
            imageNew.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -30)
        ])
    }
    
    func render(viewModel: ViewModel) {
        titleNew.text = viewModel.titleText
        descriptionNew.text = viewModel.descriptionText
        loadNewImage(url: viewModel.imageUrl)
        self.viewModel = viewModel
    }
    
    func loadNewImage(url: URL) {
        imageNew.image = nil
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageNew.image = image
                    }
                }
            }
        }
    }
}
