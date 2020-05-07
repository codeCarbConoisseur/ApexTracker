//
//  NavigationBarProtocol.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 16.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import UIKit

@objc protocol NavigationBarConfigurationProtocol {
    @objc optional func backButtonPressed()
    @objc optional func filterButtonPressed()
    @objc optional func mapButtonPressed()
    @objc optional func addButtonPressed()
    @objc optional func throwOffButtonPressed()
    @objc optional func addPhotoButtonPressed()
    @objc optional func deletePhotoButtonPressed()
}


extension NavigationBarConfigurationProtocol where Self: UIViewController {
    
    func createBackButton() {
        let image = UIImage(named: "greenArrowLeft")!
        let color: UIColor = .black
        createBackButton(textColor: color, image: image)
    }
    
    
    func createLightBackButton() {
        let image = UIImage(named: "whiteArrowLeft")!
        let color: UIColor = .white
        createBackButton(textColor: color, image: image)
    }
    
    
    private func createBackButton(textColor: UIColor, image: UIImage) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 22))
        let backButton = UIButton(frame: CGRect(x: 0, y: 1, width: 12, height: 20))
        backButton.setImage(image, for: .normal)
        backButton.tag = 13
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(NavigationBarConfigurationProtocol.backButtonPressed), for: .touchUpInside)
        let label = UILabel(frame: CGRect(x: backButton.frame.maxX + 8, y: 0, width: 90, height: 22))
        label.text = "Назад"
        label.font =  UIFont(name: "Gilroy-Regular", size: 16)
        label.textColor = textColor
        label.tag = 15
        view.addSubview(label)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NavigationBarConfigurationProtocol.backButtonPressed))
        view.addGestureRecognizer(tapGestureRecognizer)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: view)
    }
    
    
    func changeBackButton(color: UIColor, image: UIImage) {
        if let view = navigationItem.leftBarButtonItem?.customView,
            let label =  view.viewWithTag(15) as? UILabel,
            let backButton = view.viewWithTag(13) as? UIButton {
            label.textColor = color
            backButton.setImage(image, for: .normal)
        }
    }
    
    
    func createBackButtonWithoutLabel() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 22))
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 1, width: 12, height: 20))
        backButton.setImage(UIImage(named: "greenArrowLeft"), for: .normal)
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(NavigationBarConfigurationProtocol.backButtonPressed), for: .touchUpInside)
        
        let label = UILabel(frame: CGRect(x: backButton.frame.maxX + 8, y: 0, width: 90, height: 22))
        label.font =  UIFont(name: "Gilroy-Regular", size: 16)
        view.addSubview(label)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NavigationBarConfigurationProtocol.backButtonPressed))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: view)
    }
    
    
    func createAddButton() {
        let addButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        let addImage = UIImage(named: "plusCircleBlack")
        addButton.setImage(addImage, for: UIControl.State.normal)
        addButton.addTarget(self, action: #selector(NavigationBarConfigurationProtocol.addButtonPressed), for: UIControl.Event.touchUpInside)
        let size: CGFloat = 30
        addButton.frame = CGRect(x: 0, y: 0, width: size, height: size)
        addButton.bounds = CGRect(x: 0, y: 100, width: 0, height: 0)
        addButton.setNeedsLayout()
        let addBarButton = UIBarButtonItem(customView: addButton)
        
        if let _ = self.navigationItem.rightBarButtonItems {
            self.navigationItem.rightBarButtonItems!.append(addBarButton)
        } else {
            self.navigationItem.rightBarButtonItems = [addBarButton]
        }
    }
    
    
    func createFilterButton(isSelected: Bool) {
        let filterButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        let filterImage = isSelected ? UIImage(named: "filterGreenIcon") : UIImage(named: "filterIcon")
        filterButton.setImage(filterImage, for: UIControl.State.normal)
        filterButton.addTarget(self, action: #selector(NavigationBarConfigurationProtocol.filterButtonPressed), for: UIControl.Event.touchUpInside)
        filterButton.frame = CGRect(x: 0, y: 20, width: 30, height: 30)
        filterButton.isUserInteractionEnabled = !isSelected
        let filterBarButton = UIBarButtonItem(customView: filterButton)
        
        if let _ = self.navigationItem.rightBarButtonItems {
            self.navigationItem.rightBarButtonItems!.append(filterBarButton)
        } else {
            self.navigationItem.rightBarButtonItems = [filterBarButton]
        }
    }
    
    
    func createMapButton(isSelected: Bool) {
        let mapButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        let mapImage = isSelected ? UIImage(named: "mapGreenIcon") : UIImage(named: "mapIcon")
        mapButton.setImage(mapImage, for: UIControl.State.normal)
        mapButton.addTarget(self, action: #selector(NavigationBarConfigurationProtocol.mapButtonPressed), for: UIControl.Event.touchUpInside)
        mapButton.isUserInteractionEnabled = !isSelected
        mapButton.frame = CGRect(x: 0, y: 20, width: 30, height: 30)
        let mapBarButton = UIBarButtonItem(customView: mapButton)
        
        if let _ = self.navigationItem.rightBarButtonItems {
            self.navigationItem.rightBarButtonItems!.append(mapBarButton)
        } else {
            self.navigationItem.rightBarButtonItems = [mapBarButton]
        }
    }
    
    
    func createThrowOffButton() {
        let throwOffButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        throwOffButton.setTitle("Сбросить", for: .normal)
        throwOffButton.addTarget(self, action: Selector(("throwOffButtonPressed")), for: UIControl.Event.touchUpInside)
        let size: CGFloat = 30
        throwOffButton.frame = CGRect(x: 0, y: 0, width: size, height: size)
        throwOffButton.setTitleColor(.black, for: .normal)
        throwOffButton.titleLabel?.font = UIFont(name: "Gilroy-Regular", size: 16)
        let throwOffBarButton = UIBarButtonItem(customView: throwOffButton)
        throwOffButton.setNeedsLayout()
        
        if let _ = self.navigationItem.rightBarButtonItems {
            self.navigationItem.rightBarButtonItems!.append(throwOffBarButton)
        } else {
            self.navigationItem.rightBarButtonItems = [throwOffBarButton]
        }
    }
    
    
    func createLargeLabel(title: String) {
        let label: UILabel = UILabel(text: title, font: FontBook.BlocktasticIregular.of(size: 26), textColor: .darkText, textAlignment: .center, numberOfLines: 1)
        let barButtonItem = UIBarButtonItem(customView: label)
        label.setNeedsLayout()
        
        if let _ = self.navigationItem.leftBarButtonItems {
            self.navigationItem.leftBarButtonItems?.append(barButtonItem)
        } else {
            self.navigationItem.leftBarButtonItems = [barButtonItem]
        }
    }
    

    func createLargeLabelInCenter(withTitle title: String, withFont font: UIFont) {
        let label = UILabel(text: title, font: font, textColor: .label, textAlignment: .center, numberOfLines: 1)
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            label.textColor = .darkText
        }
        self.navigationItem.titleView = label
    }

    
    func createLeftView(title: String) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 35))
        view.addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.font =  UIFont(name: "SFProDisplay-Bold", size: 26)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: view)
    }
    
    
    func createRedXBackButton() {
        let backBtnImage = UIImage(named: "RedXBackButton")
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 14.8, height: 14.8))
        backButton.setImage(backBtnImage, for: .normal)
        backButton.addTarget(self, action: #selector(NavigationBarConfigurationProtocol.backButtonPressed), for: .touchUpInside)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NavigationBarConfigurationProtocol.backButtonPressed))
        backButton.addGestureRecognizer(tapGestureRecognizer)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
    }

}
