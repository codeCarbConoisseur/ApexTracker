//
//  NewsItemCollectionViewCell.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 06.05.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import UIKit

class NewsItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: Outlets:
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var contentViewWIdthConstraint: NSLayoutConstraint!
    // MARK: Properties:
    private var link: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        // Initialization code
    }
    
    private func configureView() {
        layer.cornerRadius = 12.0
        layer.borderWidth = 0.0
        layer.shadowOffset = CGSize(width: 0, height: 0.6)
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
        view.layer.cornerRadius = 12.0
        imageView.cornerRadius = 12.0
        imageView.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        if self.traitCollection.userInterfaceStyle == .dark {
            layer.shadowColor = UIColor.white.cgColor
            view.backgroundColor = .black
        } else {
            layer.shadowColor = UIColor.black.cgColor
            view.backgroundColor = .white
        }
        infoTextView.textContainer.lineFragmentPadding = 0;
        infoTextView.textContainerInset = UIEdgeInsets.zero;
    }
    
    func setupUI(imageUrlString: String, titleLabelText: String, link: String, description: String) {
        self.imageView.loadImage(by: imageUrlString)
        self.titleLabel.text = titleLabelText
        self.link = link
        self.infoTextView.text = description
    }
    
}

// MARK: DarkModeAdaptation
extension NewsItemCollectionViewCell {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection!.userInterfaceStyle == .light {
            layer.shadowColor = UIColor.white.cgColor
            view.backgroundColor = .black
        } else {
            layer.shadowColor = UIColor.black.cgColor
            view.backgroundColor = .white
        }
    }

}
