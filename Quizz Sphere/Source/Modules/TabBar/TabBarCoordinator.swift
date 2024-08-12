//
//  TabBarCoordinator.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 25.07.24.
//

import UIKit

protocol  TabBarCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabBarCoordinator: NSObject, Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [any Coordinator] = []
    
    var type: CoordinatorType { .tab }
    
    var tabBarController: UITabBarController

        
    required init(_ navigationController: UINavigationController) {
        self.navigationController  = navigationController
        self.tabBarController = .init()
    }
    
    func start() {
        let pages: [TabBarPage] = [.home, .leaderBoard, .profile]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        let controllers: [UINavigationController] = pages.map({getTabController($0)})
    
        prepareTabBarController(withTabControllers: controllers)
    }
    
    deinit {
        print("DEBUG: TabCoordinator deinit")
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        
        tabBarController.setViewControllers(tabControllers, animated: true)
        
        tabBarController.selectedIndex = TabBarPage.home.pageOrderNumber()
        
        tabBarController.tabBar.isTranslucent = false
        
        navigationController.viewControllers = [tabBarController]
        
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        
        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: page.pageIcon(),
                                                     tag: page.pageOrderNumber())
        
        switch page {
        case .home:
            // If needed: Each tab bar flow can have it's own Coordinator.
            let homeViewModel = HomeViewModel()
            let homeVC = HomeVC(homeViewModel: homeViewModel)
            
            homeVC.didSendEventClosure = { event, quiz in
                switch event {
                case .quizTapped:
                    let questionsViewModel = QuestionsViewModel(quiz: quiz)
                    let questionsVC = QuestionsVC(viewModel: questionsViewModel)

                    print(quiz.name)
                    navController.pushViewController(questionsVC, animated: true )
                }
            }
            
            navController.pushViewController(homeVC, animated: true)
        case .leaderBoard:
            let leaderBoardViewModel = LeaderBoardViewModel()
            let leaderBoardVC = LeaderBoardVC(leaderBoardViewModel: leaderBoardViewModel)
            
            navController.pushViewController(leaderBoardVC, animated: true)
        case .profile:
            let profileViewModel = ProfileViewModel()
            let profileVC = ProfileVC(profileViewModel: profileViewModel)
            
            navController.pushViewController(profileVC, animated: true)
        }
        
        return navController
    }
    
    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }

    func selectPage(_ page: TabBarPage) { tabBarController.selectedIndex = page.pageOrderNumber() }
    
    func setSelectedIndex(_ index: Int) {
           guard let page = TabBarPage.init(index: index) else { return }
           
           tabBarController.selectedIndex = page.pageOrderNumber()
       }
}
extension TabBarCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        // Some implementation
    }
}
