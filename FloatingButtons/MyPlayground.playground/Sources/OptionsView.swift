import UIKit
import PureLayout

public enum OptionButtonType: String {
    case Option1 = "Option 1"
    case Option2 = "Option 2"
    case Option3 = "Option 3"
    case Option4 = "Option 4"
    case Option5 = "Option 5"

    case Unknown
}

public enum MenuPosition: Int {
    case TopLeft = 0
    case BottomLeft
    case BottomRight
    case TopRight
}

public class OptionButton: UIButton {
    var optionType: OptionButtonType!

    init(optionType: OptionButtonType) {
        super.init(frame: CGRect.zero)

        self.optionType = optionType
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
public protocol OptionViewDelegate {
    func menuOptionViewDidTapMenuOptionButton(button: OptionButton)
}

public class OptionsView: UIView {
    private var darkContentView: UIView!
    public var parentView: UIView!
    public var optionTypes: [OptionButtonType]!
    public var spaceBetweenButtons: CGFloat = 30.0
    public var menuPostition: MenuPosition = .TopRight

    private lazy var optionViews: [UIView] = {
        return [UIView]()
    }()

    private lazy var optionButtons: [UIButton] = {
        return [UIButton]()
    }()

    lazy var menuButton: UIButton = {
        let menuButton = UIButton()

                menuButton.backgroundColor = UIColor.blue
                menuButton.layer.cornerRadius = 10.0
        //        menuButton.setImage(UIImage(named: "icon-dots"), forState: .Normal)
        //        menuButton.setImage(UIImage(named: "icon-close"), forState: .selected)
        menuButton.addTarget(self,
                             action: #selector(OptionsView.didTapMenuButton),
                             for: .touchUpInside)

        self.parentView.addSubview(menuButton)

        menuButton.autoSetDimensions(to: CGSize(width: 20.0, height: 20.0))

        switch (self.menuPostition) {
        case .TopLeft:
            menuButton.autoPinEdge(toSuperviewEdge: .top, withInset: 15.0)
            menuButton.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)

            break
        case .BottomLeft:
            menuButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 15.0)
            menuButton.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)

            break
        case .BottomRight:
            menuButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 15.0)
            menuButton.autoPinEdge(toSuperviewEdge: .right, withInset: 15.0)

            break
        case .TopRight:
            menuButton.autoPinEdge(toSuperviewEdge: .top, withInset: 15.0)
            menuButton.autoPinEdge(toSuperviewEdge: .right, withInset: 15.0)

            break
        }

        return menuButton
    }()

    public var delegate: OptionViewDelegate?

    // MARK: Inits
    public init(parentView view: UIView,
                optionTypes types: [OptionButtonType],
                spaceBetweenButtons space: CGFloat,
                menuPosition position: MenuPosition) {

        super.init(frame: CGRect.zero)

        self.parentView = view
        self.optionTypes = types
        self.spaceBetweenButtons = space
        self.menuPostition = position

        darkContentView = UIView()

        darkContentView.translatesAutoresizingMaskIntoConstraints = false
        darkContentView.alpha = 0.0

        let tapRecognizer = UITapGestureRecognizer(target: self,
                                                   action: #selector(OptionsView.didTriggerTapGestureRecognizer))

        darkContentView.addGestureRecognizer(tapRecognizer)

        parentView.insertSubview(darkContentView, belowSubview: menuButton)

        darkContentView.autoPinEdgesToSuperviewEdges()

        configureButtons()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    public func configureButtons() {
        var previousView: UIView = menuButton

        for i in 0...optionTypes.count - 1 {
            let optionView = UIView()

            optionView.alpha = 0.0

            self.darkContentView.addSubview(optionView)


            if self.menuPostition == .TopLeft
                || self.menuPostition == .BottomLeft {

                optionView.autoPinEdge(.left, to: .left, of: previousView)
            } else {
                optionView.autoPinEdge(.right, to: .right, of: previousView)
            }

            optionView.autoPinEdge(.top, to: .top, of: previousView)


            let optionButton = OptionButton(optionType: .Unknown)

            optionButton.backgroundColor = UIColor.red
            optionButton.layer.cornerRadius = 10.0
            optionButton.addTarget(self,
                                   action: #selector(OptionsView.didTapOptionButton),
                                   for: .touchUpInside)


            let optionType = optionTypes[i]

            optionButton.optionType = optionType

            switch optionType {
            case .Option1: // Create file button
                //                optionButton.setImage(UIImage(named: "icon-file-note"), forState: .Normal)

                break
            case .Option2: // Add to my call list
//                optionButton.setImage(UIImage(named: "icon-add-call-list"), forState: .normal)


                break
            case .Option3: // Add to my relationships
                //                optionButton.setImage(UIImage(named: "icon-relationships"), forState: .Normal)

                break
            case .Option4: // Add to assignments
                //                optionButton.setImage(UIImage(named: "icon-assignments"), forState: .Normal)

                break

            case .Option5:
                //                optionButton.setImage(UIImage(named: "icon-person-to-assignments"), forState: .Normal)

                break

            default:
                break
            }

            optionView.addSubview(optionButton)


            if self.menuPostition == .TopLeft
                || self.menuPostition == .BottomLeft {

                optionButton.autoPinEdge(toSuperviewEdge: .left)
            } else {
                optionButton.autoPinEdge(toSuperviewEdge: .right)
            }

            optionButton.autoPinEdge(toSuperviewEdge: .top)
            optionButton.autoPinEdge(toSuperviewEdge: .bottom)
            optionButton.autoSetDimensions(to: CGSize(width: 20.0, height: 20.0))

            previousView = optionButton
            optionButtons.append(optionButton)
            optionViews.append(optionView)


            let rightLabel = UILabel()

            rightLabel.translatesAutoresizingMaskIntoConstraints = false
            rightLabel.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightRegular)
            rightLabel.textColor = UIColor.white
            rightLabel.text = optionType.rawValue

            optionView.addSubview(rightLabel)

            if self.menuPostition == .TopLeft
                || self.menuPostition == .BottomLeft {

                rightLabel.autoPinEdge(.left, to: .right, of: optionButton, withOffset: 15.0)
                rightLabel.autoPinEdge(toSuperviewEdge: .right)

            } else {
                rightLabel.autoPinEdge(.right, to: .left, of: optionButton, withOffset: -15.0)
                rightLabel.autoPinEdge(toSuperviewEdge: .left)
            }

            rightLabel.autoPinEdge(toSuperviewEdge: .top)
            rightLabel.autoPinEdge(toSuperviewEdge: .bottom)
        }
    }

    // MARK: Show/Hide option buttons
    public func set(selected: Bool, animated: Bool) {
        menuButton.isSelected = selected

        if animated {
            UIView.animate(withDuration: 0.33) {
                self.showOptions(show: selected)
            }
        } else {
            self.showOptions(show: selected)
        }
    }

    public func showOptions(show: Bool) {
        menuButton.backgroundColor = (menuButton.isSelected) ? UIColor.black
                                                             : UIColor.blue

        if show {
            self.darkContentView.alpha = 1.0

            self.backgroundColor = UIColor.black
            self.darkContentView.backgroundColor = UIColor.black.withAlphaComponent(0.7)

            for (index, optionView) in self.optionViews.enumerated() {
                optionView.alpha = 1

                let offset = index + 1

                var translation = spaceBetweenButtons * CGFloat(offset)

                switch (self.menuPostition) {
                case .TopLeft, .TopRight:
                    break
                case .BottomRight, .BottomLeft:
                    translation = translation * -1
                    break
                }

                optionView.transform = CGAffineTransform(translationX: 0.0, y: CGFloat(translation))
            }
        } else {
            self.darkContentView.alpha = 0.0

            self.backgroundColor = UIColor.red
            self.darkContentView.backgroundColor = UIColor.clear

            for optionView in self.optionViews {
                optionView.alpha = 0

                optionView.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
            }
        }
    }
    
    // MARK: Actions
    public func didTapMenuButton(button: UIButton) {
        self.set(selected: !button.isSelected, animated: true)
    }
    
    public func didTapOptionButton(button: OptionButton) {
        delegate?.menuOptionViewDidTapMenuOptionButton(button: button)
    }
    
    public func didTriggerTapGestureRecognizer(recognizer: UITapGestureRecognizer) {
        self.set(selected: !menuButton.isSelected, animated: true)
    }
    
    // MARK: Remove from parentView
    public func removeFromParentView() {
        self.darkContentView.removeFromSuperview()
        self.menuButton.removeFromSuperview()
    }
}
