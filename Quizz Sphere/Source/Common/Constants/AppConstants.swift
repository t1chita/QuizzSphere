//
//  AppConstants.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 26.07.24.
//

import UIKit

public enum AppConstants {
    public enum Font {
        public enum EBGaramond {
            static let regular = UIFont(name: "EBGaramond-Regular", size: FontSize.regularFontSize)
            static let semibold = UIFont(name: "EBGaramond-SemiBold", size: FontSize.semiBoldFontSize)
            static let bold = UIFont(name: "EBGaramond-Bold", size: FontSize.boldFontSize)
        }
        
        private enum FontSize {
            static let boldFontSize: CGFloat = 24
            static let semiBoldFontSize: CGFloat = 18
            static let regularFontSize: CGFloat = 16
        }
        
        public enum FontType {
            case regular
            case semiBold
            case bold
        }
    }
    
    public enum Images {
        public enum SystemNames {
            static let emailIcon: String = "envelope"
            static let passwordIcon: String = "lock"
            static let checkMark: String = "checkmark"
        }
    }
    
    public enum Colors {
        
    }
}
