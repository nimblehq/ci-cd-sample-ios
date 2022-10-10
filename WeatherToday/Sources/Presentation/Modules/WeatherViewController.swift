import UIKit
import RxSwift

final class WeatherViewController: UIViewController {

    private lazy var cityTextField: UITextField = UITextField()
    private lazy var temperatureLabel: UILabel = UILabel()
    private lazy var humidityLabel: UILabel = UILabel()
    private var landscapeTopConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var portraitTopConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private let disposeBag = DisposeBag()
    let net = WeatherNetworkAPI()

    init () {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        landscapeTopConstraint =  cityTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0)
        portraitTopConstraint =  cityTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 260.0)
        view.backgroundColor = .white

        cityTextField.delegate = self
        cityTextField.placeholder = "Write city name here"
        cityTextField.borderStyle = .roundedRect
        cityTextField.backgroundColor = .black
        cityTextField.textColor = .white

        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cityTextField)

        NSLayoutConstraint.activate([
            cityTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityTextField.widthAnchor.constraint(equalToConstant: 220.0),
            cityTextField.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        updateConstraintForCurrentOrientation()

        temperatureLabel.text = "Temperature _ ℃"
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .black

        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: cityTextField.topAnchor, constant: 60.0),
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureLabel.widthAnchor.constraint(equalTo: cityTextField.widthAnchor),
            temperatureLabel.heightAnchor.constraint(equalTo: cityTextField.heightAnchor)
        ])

        humidityLabel.text = "Humidity _ %"
        humidityLabel.textAlignment = .center
        humidityLabel.textColor = .black

        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(humidityLabel)
        NSLayoutConstraint.activate([
            humidityLabel.topAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: 40.0),
            humidityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            humidityLabel.widthAnchor.constraint(equalTo: cityTextField.widthAnchor),
            humidityLabel.heightAnchor.constraint(equalTo: cityTextField.heightAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let weatherRepo = WeatherRepository(network: net)
        let usecase = WeatherUseCase(weatherRepository: weatherRepo)
        let d = usecase.getWeather(forCity: "New York").subscribe { event in
            switch event {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }.disposed(by: disposeBag)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateConstraintForCurrentOrientation()
    }

    private func updateConstraintForCurrentOrientation() {
        let isLandscape = UIDevice.current.orientation.isLandscape
        portraitTopConstraint.isActive = false
        landscapeTopConstraint.isActive = false
        portraitTopConstraint.isActive = !isLandscape
        landscapeTopConstraint.isActive = isLandscape
    }
}


extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
