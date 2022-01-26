//
//  DescriptionNewTableViewCell.swift
//  InfobaeProgrammatic
//
//  Created by Vanesa Korbenfeld on 25/01/2022.
//

import UIKit

class DescriptionNewTableViewCell: UITableViewCell {
    var imageName: String?

    lazy var titleNew = createTitleNew()
    lazy var descriptionNew = createDescriptionNew()
    lazy var imageNew = createImageNew()
    
    func createTitleNew() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }
    
    func createDescriptionNew() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }
    
    func createImageNew() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName ?? "new")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
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
            
            titleNew.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
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
            imageNew.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
        ])
    }
}

class InfoNew {
    var titleText: String
    var descriptionText: String
    var imageName: String
    
    init(imageName: String, titleText: String, descriptionText: String) {
        self.imageName = imageName
        self.titleText = titleText
        self.descriptionText = descriptionText
    }
}
