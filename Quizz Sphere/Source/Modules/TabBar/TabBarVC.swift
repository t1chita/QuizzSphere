//
//  HomeVC.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 25.07.24.
//

import UIKit

enum TabBarPage {
    case home
    case leaderBoard
    case profile

    init?(index: Int) {
        switch index {
        case 0:
            self = .home
        case 1:
            self = .leaderBoard
        case 2:
            self = .profile
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .home:
            return "Home"
        case .leaderBoard:
            return "Leaderboard"
        case .profile:
            return "Profile"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .home:
            return 0
        case .leaderBoard:
            return 1
        case .profile:
            return 2
        }
    }

    func pageIcon() -> UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "house.fill")!
        case .leaderBoard:
            return  UIImage(systemName: "trophy.fill")!
        case .profile:
            return  UIImage(systemName: "person.fill")!
        }
    }
    // Add tab icon value
    
    // Add tab icon selected / deselected color
    
    // etc
}
