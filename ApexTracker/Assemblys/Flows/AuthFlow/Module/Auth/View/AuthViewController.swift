//
//  AuthAuthViewController.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 01/05/2020.
//  Copyright © 2020 me. All rights reserved.
//

import UIKit
import Foundation

class AuthViewController: UIViewController, AuthViewCoordinatorOutput {
    
    // MARK: AuthViewCoordinatorOutput
    var onSignInTapped: ((UserSession) -> Void)?
    
    // MARK: Properties:
    var output: AuthViewOutput!
    
    // MARK: Outlets:
    @IBOutlet weak var nicknameTextField: CustomCollectionTextField!
    @IBOutlet weak var logInButton: UIButton!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    private func configureView() {
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .white
        }
        createLargeLabelInCenter(withTitle: "Profile", withFont: UIFont(name: "Inter-Bold", size: 22) ?? UIFont.systemFont(ofSize: 22))
    }
    
    private func addObserversToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func configureTextField() {
        nicknameTextField.delegate = self
        nicknameTextField.returnKeyType = .done
    }
    
    private func hideKeyboard() {
        nicknameTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillChange(notification: Notification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if logInButton.frame.maxY > (view.frame.height - keyboardSize.height) {
//                self.view.frame.origin.y -= logInButton.frame.maxY - (view.frame.height - keyboardSize.height)
//            }
////            if self.view.frame.origin.y == 0 {
////                self.view.frame.origin.y -= keyboardSize.height
////            }
//        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
//        if self.view.frame.origin.y != 0 {
//            self.view.frame.origin.y = 0
//        }
    }
}

// MARK: AuthViewInput
extension AuthViewController: AuthViewInput {
    func setupInitialState() {
        configureView()
        configureTextField()
        addObserversToKeyboard()
    }
}

// MARK: NavigationBarConfigurationProtocol
extension AuthViewController: NavigationBarConfigurationProtocol {
    
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        output.loginWithSessionInfo(withSessionInfo: SessionInfo(userId: "someId", platform: .PC))
        hideKeyboard()
        return true
    }
}

// MARK: DarkModeAdaptation
extension AuthViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection!.userInterfaceStyle == .light {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .white
        }
    }
    
}
