import FirebaseCore
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        configureFireBase()

        let networkApi = WeatherNetworkAPI()
        let weatherRepo = WeatherRepository(network: networkApi)
        let weatherUseCase = WeatherUseCase(weatherRepository: weatherRepo)
        let weatherViewModel: WeatherViewModelProtocol = WeatherViewModel(weatherUseCase: weatherUseCase)
        let weatherViewController = WeatherViewController(viewModel: weatherViewModel)
        let navController = UINavigationController(rootViewController: weatherViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }

    private func configureFireBase() {
        FirebaseApp.configure()
    }
}
