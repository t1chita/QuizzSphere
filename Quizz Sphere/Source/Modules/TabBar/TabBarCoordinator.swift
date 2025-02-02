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
    
    let btnMiddle : UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        btn.setTitle("", for: .normal)
        btn.backgroundColor = .blueCard
        btn.layer.cornerRadius = 30
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        
        return btn
    }()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController  = navigationController
        self.tabBarController = .init()
    }
    
    func start() {
        let pages: [TabBarPage] = [.home, .search, .leaderBoard, .profile]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        let controllers: [UINavigationController] = pages.map({getTabController($0)})
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    deinit {
        print("DEBUG: TabCoordinator deinit")
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        let path : UIBezierPath = getPathForTabBar()
        let shape = CAShapeLayer()
        
        tabBarController.delegate = self
        
        tabBarController.setViewControllers(tabControllers, animated: true)
        
        tabBarController.selectedIndex = TabBarPage.home.pageOrderNumber()
        
        tabBarController.tabBar.isTranslucent = false
        
        btnMiddle.frame = CGRect(x: Int(tabBarController.tabBar.bounds.width)/2 - 30, y: -20, width: 60, height: 60)
        
        shape.path = path.cgPath
        shape.lineWidth = 3
        shape.strokeColor = UIColor.customBackground.cgColor
        shape.fillColor = UIColor.customBackground.cgColor
        
        tabBarController.tabBar.layer.insertSublayer(shape, at: 0)
        tabBarController.tabBar.itemWidth = 40
        tabBarController.tabBar.itemPositioning = .centered
        tabBarController.tabBar.itemSpacing = 180
        tabBarController.tabBar.tintColor = .pinkCard
        
        tabBarController.tabBar.backgroundColor = .blueCard
        
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.addSubview(btnMiddle)
        
        btnMiddle.addAction(UIAction(handler: { _ in
            print("DEBUG: Plus Button Tapped")
        }), for: .touchUpInside)
        
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
                    
                    questionsVC.didSendEventClosure = { event, scores, completedQuantity, quantity in
                        switch event {
                        case .goBack:
                            navController.popViewController(animated: true)
                            
                        case .quizCompleted:
                            let resultViewModel = ResultViewModel(userPoints: scores ?? 0,
                                                                  quizQuantity: quantity ?? 0,
                                                                  completedQuizQuantity: completedQuantity ?? 0)
                            
                            let resultVC = ResultVC(viewModel: resultViewModel)
                            
                            resultVC.didSendEventClosure = { event in
                                switch event {
                                case .goBack:
                                    navController.popToRootViewController(animated: true)
                                case .shareResult:
                                    print("Share Result")
                                }
                            }
                            
                            navController.pushViewController(resultVC, animated: true)
                        }
                    }
                    
                    print(quiz.name)
                    navController.pushViewController(questionsVC, animated: true )
                }
            }
            
            navController.pushViewController(homeVC, animated: true)
        case .search:
            let searchViewModel = SearchViewModel()
            let searchVC = SearchVC(viewModel: searchViewModel)
            
            navController.pushViewController(searchVC, animated: true)
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
    
    func getPathForTabBar() -> UIBezierPath {
        let frameWidth = self.tabBarController.tabBar.bounds.width
        let frameHeight = self.tabBarController.tabBar.bounds.height + 40
        let holeWidth = 150
        let holeHeight = 50
        let leftXUntilHole = Int(frameWidth/2) - Int(holeWidth/2)
        
        let path : UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: leftXUntilHole , y: 0)) // 1.Line
        path.addCurve(to: CGPoint(x: leftXUntilHole + (holeWidth/3), y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*6,y: 0), controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*8, y: holeHeight/2)) // part I
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + (2*holeWidth)/3, y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2/5, y: (holeHeight/2)*6/4), controlPoint2: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2 + (holeWidth/3)/3*3/5, y: (holeHeight/2)*6/4)) // part II
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint1: CGPoint(x: leftXUntilHole + (2*holeWidth)/3,y: holeHeight/2), controlPoint2: CGPoint(x: leftXUntilHole + (2*holeWidth)/3 + (holeWidth/3)*2/8, y: 0)) // part III
        path.addLine(to: CGPoint(x: frameWidth, y: 0)) // 2. Line
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight)) // 3. Line
        path.addLine(to: CGPoint(x: 0, y: frameHeight)) // 4. Line
        path.addLine(to: CGPoint(x: 0, y: 0)) // 5. Line
        path.close()
        return path
    }
}
extension TabBarCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        // Some implementation
    }
}
