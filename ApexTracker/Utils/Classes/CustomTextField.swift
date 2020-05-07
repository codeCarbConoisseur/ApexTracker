//
//  CustomTextField.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 07.05.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import UIKit

class CustomCollectionTextField: UITextField {
    
    let padding = UIEdgeInsets(top: CustomTextFieldConstants.textFieldTopEdgeInset,
                               left: CustomTextFieldConstants.textFieldLeftEdgeInset,
                               bottom: CustomTextFieldConstants.textFieldBottomEdgeInset,
                               right: CustomTextFieldConstants.textFieldRightEdgeInset)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
        
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
