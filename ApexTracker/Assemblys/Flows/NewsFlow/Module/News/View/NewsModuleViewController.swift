//
//  NewsModuleNewsModuleViewController.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 25/04/2020.
//  Copyright © 2020 me. All rights reserved.
//

import UIKit

class NewsModuleViewController: UIViewController, NewsViewCoordinatorOutput {
    
    // MARK: NewsViewCoordinatorOutput
    var onItemSelected: ((Int) -> Void)?
    
    // MARK: Properties:
    var output: NewsModuleViewOutput!
    var news: MozambiqueNewsAPIResponse = MozambiqueNewsAPIResponse() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: Outlets:
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private let spinnerController: UIViewController = SpinnerViewController()
    private lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        return refreshControl
    }()
    
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        //startActivityIndicator()
        output.getData { (data) in
            guard let data = data else { return }
            self.news = data
            print(data)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @objc private func reloadData() {
        output.getData { (data) in
            guard let data = data else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.refresher.endRefreshing()
                }
                return
            }
            self.news = data
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.refresher.endRefreshing()
            }
        }
    }
    
    private func startActivityIndicator() {
        addChild(spinnerController)
        spinnerController.view.frame = view.frame
        view.addSubview(spinnerController.view)
        spinnerController.didMove(toParent: self)
    }
    
    private func stopActivityIndicator() {
        spinnerController.willMove(toParent: nil)
        spinnerController.view.removeFromSuperview()
        spinnerController.removeFromParent()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.registerCell(NewsItemCollectionViewCell.self)
        view.addSubview(collectionView)
        setupConstrainsToCollectionView()
    }
    
    private func configureRefreshControl() {
        if traitCollection.userInterfaceStyle == .dark {
            refresher.tintColor = .white
        } else {
            refresher.tintColor = .black
        }
        collectionView.refreshControl = refresher
    }
    
    private func configureView() {
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .white
        }
        createLargeLabelInCenter(withTitle: "News", withFont: UIFont(name: "Inter-Bold", size: 22) ?? UIFont.systemFont(ofSize: 22))
    }
}

// MARK: NewsModuleViewInput
extension NewsModuleViewController: NewsModuleViewInput {
    
    func showAlert(title: String, message: String, buttonTitle: String, handler: (() -> ()?)?) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: buttonTitle,
            style: .default,
            handler: {action in
                handler?()
        }))
        self.present(alert, animated: true)
    }
    
    
    func activityViewStopAnimating() {
        self.stopActivityIndicator()
    }
    
    func setupInitialState() {
        configureView()
        configureCollectionView()
        configureRefreshControl()
    }
}

// MARK: UICollectionViewDataSource
extension NewsModuleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeue(cell: NewsItemCollectionViewCell.self, indexPath: indexPath) {
            
            cell.setupUI(imageUrlString: news[indexPath.row].img, titleLabelText: news[indexPath.row].title, link: news[indexPath.row].link, description: news[indexPath.row].shortDesc)
            return cell
        } else {
            print("")
            print("ERROR CASTING UICOLLECTIONVIEWCELL")
            print("")
            return UICollectionViewCell()
        }
    }
    
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension NewsModuleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
//        let descriptionText: String = news[indexPath.row].shortDesc
//        let size = CGSize(width: (view.frame.width - 32), height: 400)
//        let attributes = [NSAttributedString.Key.font: UIFont(name: "Inter-Regular", size: 14)]
//        let theRestHeightOfSubiews: CGFloat = (cell.imageView.frame.height + cell.titleLabel.frame.height + cell.linkButton.frame.height + 32)
//        let estimatedFrame = NSString(string: descriptionText).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        return CGSize(width: (self.view.frame.width - 32), height: 400)
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
}


// MARK: SetupConstraints
extension NewsModuleViewController {
    func setupConstrainsToCollectionView() {
        let topConstraint = collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomConstraint = collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftConstraint = collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let rightConstraint = collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
    }
}

// MARK: DarkModeAdaptation
extension NewsModuleViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection!.userInterfaceStyle == .light {
            collectionView.backgroundColor = .black
            refresher.tintColor = .white
        } else {
            collectionView.backgroundColor = .white
            refresher.tintColor = .black
        }
    }
    
}

extension NewsModuleViewController: NavigationBarConfigurationProtocol {
    
}
