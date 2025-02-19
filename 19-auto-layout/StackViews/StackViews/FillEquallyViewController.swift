//
//  FillEquallyViewController.swift
//  StackViews
//
//  Created by Mehmet Tarhan on 14/12/2022.
//

import UIKit

class FillEquallyViewController: UIViewController {
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    private func setupViews() {
        navigationItem.title = "Fill Equally"

        let stackView = createStackView(withOrientation: .vertical)
        stackView.distribution = .fillEqually

        view.addSubview(stackView)

        stackView.addArrangedSubview(createLabel(withText: "Big", size: 128, color: .systemYellow))
        stackView.addArrangedSubview(createLabel(withText: "Med", size: 64, color: .systemOrange))
        stackView.addArrangedSubview(createLabel(withText: "Sml", size: 32, color: .systemGreen))

        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
