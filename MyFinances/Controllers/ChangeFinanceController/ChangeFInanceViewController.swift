//
//  ChangeFInanceViewController.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 2.02.23.
//

import UIKit

class ChangeFInanceViewController: UIViewController {
    @IBOutlet var numberButtonCollection: [UIButton]!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var addNotificationView: UIView!
    @IBOutlet weak var addNotificationLabel: UILabel!
    
    private var controllerType: ChangeFinanceControllerType?
    private var inputText: String = ""
    private var financeModel = RealmFinanceType()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNumberButtons()
        setupVc()
        addNotificationView.alpha = 0
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setGradient()
    }
    
    func set(financeModel: RealmFinanceType,controllerType: ChangeFinanceControllerType) {
        self.financeModel = financeModel
        self.controllerType = controllerType
    }
    
    private func setupVc() {
        typeLabel.text = financeModel.name
        numberLabel.text = "\(financeModel.value)"
        addNotificationView.layer.cornerRadius = 8
    }
    
    private func setupNumberButtons() {
        numberButtonCollection.enumerated().forEach { index, button in
            button.clipsToBounds = true
            button.layer.cornerRadius = button.bounds.width / 2
            if self.controllerType == nil {
                button.isEnabled = false
            } else {
                button.isEnabled = true
            }
        }
    }
    
    private func blureOverlay() -> UIView {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return blurView
    }
    
    private func setGradient() {
        let topColor = UIColor(hue: 0.26, saturation: 0.83, brightness: 0.19, alpha: 1.0).cgColor // #73db26
        let bottomColor = UIColor.black.cgColor
        
        self.view.setGradientBackground(topColor: topColor, bottomColor: bottomColor)
    }
    
    @IBAction func numberButtonDidTap(_ sender: UIButton) {
        switch sender.tag {
            case 1001:      inputText += "1"
            case 1002:      inputText += "2"
            case 1003:      inputText += "3"
            case 1004:      inputText += "4"
            case 1005:      inputText += "5"
            case 1006:      inputText += "6"
            case 1007:      inputText += "7"
            case 1008:      inputText += "8"
            case 1009:      inputText += "9"
            case 1000:      inputText += "0"
            case 1011:      inputText += "."
            case 1010:
                if inputText.count >= 1 {
                    inputText.removeLast()
                }
            case 1012:
                updateDataInRealm()
            default:        break
        }
        numberLabel.text = inputText
        
        if inputText.count == 0 {
            numberLabel.text = "0"
        }
    }
    
    private func updateDataInRealm() {
        let realmObject = financeModel
        RealmManager<RealmFinanceType>().update {[weak self] realm in
            guard let self else { return }
            try? realm.write {
                let oldValue = realmObject.value
                guard let value = Double(self.inputText) else { print("Error")
                    return }
                switch self.controllerType {
                    case .plusValue:
                        let plusValue = RealmFinancePlusValueModel()
                        plusValue.plusValues = value
                        plusValue.date = .now
                        realmObject.value = oldValue + value
                        realmObject.plusValues.insert(plusValue, at: 0)
                        self.showNotificationView(value: value, type: .plusValue, savingType: realmObject.name)
                    case .minusValue:
                        let minusValue = RealmFinanceMinusValueModel()
                        minusValue.minusValues = value
                        minusValue.date = .now
                        realmObject.minusValues.insert(minusValue, at: 0)
                        realmObject.value = oldValue - value
                        self.showNotificationView(value: value, type: .minusValue, savingType: realmObject.name)
                    case .none:
                        break
                }
            }
        }
    }
    
    private func showNotificationView(value: Double, type: ChangeFinanceControllerType, savingType: String) {
        addNotificationLabel.text = "Добавлено в статью '\(type.rawValue)' \(value) \(savingType)"
        
        UIView.animate(withDuration: 0.5) {[weak self] in
            guard let self else { return }
            self.addNotificationView.alpha = 1
        } completion: {[weak self] isFinish in
            guard let self else { return }
            if isFinish {
                UIView.animate(withDuration: 0.5, delay: 4) {
                    self.addNotificationView.alpha = 0
                }
            }
        }
    }
    
    @IBAction func didTapOpenButton(_ sender: UIButton) {
        let popVC = MoneyTypesTableViewController(nibName: String(describing: MoneyTypesTableViewController.self), bundle: nil)
        popVC.set(changeControllerDelegate: self)
        popVC.modalPresentationStyle = .popover
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = sender
        popOverVC?.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.maxY, width: 0, height: 0)
        self.present(popVC, animated: true)
    }
    
    @IBAction func plusOrMinusButtonDidTap(_ sender: UIButton) {
        switch sender.tag {
            case 2001:
                self.controllerType = .plusValue
                symbolLabel.text = "+"
                setupNumberButtons()
            case 2002:
                self.controllerType = .minusValue
                symbolLabel.text = "-"
                setupNumberButtons()
            default: break
        }
        numberLabel.text = "0"
        inputText = ""
    }
}

extension ChangeFInanceViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension ChangeFInanceViewController: SetRealmDataDelegate {
    func setData(data: RealmFinanceType) {
        self.financeModel = data
        self.typeLabel.text = data.name
        self.inputText = ""
        self.numberLabel.text = "\(data.value)"
    }
}


