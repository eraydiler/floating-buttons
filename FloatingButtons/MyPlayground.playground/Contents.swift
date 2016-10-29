//: Playground - noun: a place where people can play

import UIKit
import PureLayout
import PlaygroundSupport


class PlaygroundViewController: UIViewController {

    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)

        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1.0
    }

    override func viewDidLoad() {
        let myButton = UIButton(forAutoLayout: ())

        myButton.setTitle("Click me!", for: .normal)
        myButton.setTitleColor(UIColor.gray, for: .highlighted)

        myButton.addTarget(self,
                           action: #selector(PlaygroundViewController.didTapMyButton),
                           for: .touchUpInside)

        view.addSubview(myButton)

        myButton.autoCenterInSuperview()

        self.view.layoutIfNeeded()
    }

    override func viewDidAppear(_ animated: Bool) {
        var parentView = UIView()

        if let navigationControllerView = self.navigationController?.view {
            parentView = navigationControllerView
        } else {
            parentView = self.view
        }

        var menuOptionsView: OptionsView?

        let optionTypes: [OptionButtonType] = [.Option1, .Option2, .Option3, .Option4, .Option5]

        menuOptionsView = OptionsView(parentView: parentView,
                                      optionTypes: optionTypes,
                                      spaceBetweenButtons: 40.0,
                                      menuPosition: .TopRight)

        menuOptionsView?.delegate = self
    }

    func didTapMyButton(button: UIButton) {
        let nextController = TargetViewController()

        self.navigationController?.pushViewController(nextController, animated: true)
    }
}


extension PlaygroundViewController: OptionViewDelegate {
    func menuOptionViewDidTapMenuOptionButton(button: OptionButton) {

    }
}

let controller = PlaygroundViewController()
let navController = UINavigationController(rootViewController: controller)

PlaygroundPage.current.liveView = navController
PlaygroundPage.current.needsIndefiniteExecution = true

