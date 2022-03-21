import UIKit

enum TabbarFlow {
    case today
    case game
    case appTap
    case arcade
    case search
   
}

class TabBarCoordinator: BaseCoordinator {
    private let todayViewCoordinator =  TodayViewCoordinator(navigationController: UINavigationController())
    private let gameViewCoordinator =  GameViewCoordinator(navigationController: UINavigationController())
    private let appTapViewCoordinator =  AppTapViewCoordinator(navigationController: UINavigationController())
    private let arcadeViewCoordinator =  ArcadeViewCoordinator(navigationController: UINavigationController())
    private let searchViewCoordinator =  SearchViewCoordinator(navigationController: UINavigationController())

    private let tabbarController = UITabBarController()
    
    override func start() {
        start(coordinator: todayViewCoordinator)
        start(coordinator: gameViewCoordinator)
        start(coordinator: appTapViewCoordinator)
        start(coordinator: arcadeViewCoordinator)
        start(coordinator: searchViewCoordinator)
        
        todayViewCoordinator.navigationController.tabBarItem = UITabBarItem(title: "투데이", image: UIImage(systemName: "doc.text.image"), tag: 0)
        gameViewCoordinator.navigationController.tabBarItem = UITabBarItem(title: "게임", image: UIImage(named: "tabbar_games"), tag: 1)
        appTapViewCoordinator.navigationController.tabBarItem = UITabBarItem(title: "앱", image: UIImage(named: "tabbar_apps"), tag: 2)
        arcadeViewCoordinator.navigationController.tabBarItem = UITabBarItem(title: "Arcade", image: UIImage(named: "tabbar_arcade"), tag: 3)
        searchViewCoordinator.navigationController.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 4)

        
        tabbarController.viewControllers = [
            todayViewCoordinator.navigationController,
            gameViewCoordinator.navigationController,
            appTapViewCoordinator.navigationController,
            arcadeViewCoordinator.navigationController,
            searchViewCoordinator.navigationController
        ]
        
        
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(tabbarController, animated: false)
    }
    
    func moveTo(flow: TabbarFlow)  {
        switch flow {
        case .today:
            tabbarController.selectedIndex = 0
        case .game:
            tabbarController.selectedIndex = 1
        case .appTap:
            tabbarController.selectedIndex = 2
        case .arcade:
            tabbarController.selectedIndex = 3
        case .search:
            tabbarController.selectedIndex = 4
        }
    }
}

