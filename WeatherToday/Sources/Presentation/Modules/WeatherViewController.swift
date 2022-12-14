//
//  WeatherViewController.swift
//  WeatherToday
//
//  Created by Taher on 20/10/22.
//  Copyright © 2022 Nimble. All rights reserved.
//

import RxSwift
import UIKit

final class WeatherViewController: UIViewController {

    private lazy var cityTextField = UITextField()
    private lazy var temperatureLabel = UILabel()
    private lazy var humidityLabel = UILabel()
    private var landscapeTopConstraint = NSLayoutConstraint()
    private var portraitTopConstraint = NSLayoutConstraint()

    private let disposeBag = DisposeBag()
    private let viewModel: WeatherViewModelProtocol

    init(viewModel: WeatherViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        bindOutput()
        bindInput()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateConstraintForCurrentOrientation()
    }

    private func bindInput() {
        viewModel.input.viewDidLoad()
    }

    private func bindOutput() {
        viewModel.output.temperature
            .emit(to: temperatureLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.humidity
            .emit(to: humidityLabel.rx.text)
            .disposed(by: disposeBag)
    }

    private func setUpView() {
        landscapeTopConstraint = cityTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0)
        portraitTopConstraint = cityTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 260.0)
        view.backgroundColor = .white

        cityTextField.delegate = self
        cityTextField.placeholder = viewModel.output.cityTextFieldPlaceholderText
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
        viewModel.input.didFinishTyping(cityName: cityTextField.text ?? "")
        return false
    }
}
