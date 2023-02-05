//
//  AddFinanceViewController.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 4.02.23.
//

import UIKit
import Charts

class AddFinanceViewController: UIViewController {
    @IBOutlet weak var imageViewCustomType: UIImageView!
    @IBOutlet weak var textFieldCustomType: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var doneButton: UIButton!
    
    var updateBlock: (()->Void)? = nil
    private(set) var data: [Currency] = []
    private var savingType: SavingType = .money
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBlur()
    }
    
    private func getData() {
        self.spinner.startAnimating()
        ConverterProvider().getCurrency { currencys in
            self.data = currencys
            self.spinner.stopAnimating()
        } failure: { error in
            print(error)
        }
    }

    private func setBlur() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView)
        self.view.sendSubviewToBack(blurEffectView)
    }
    
    func getRandomColor() -> RealmColorClass {
        let myColor = RealmColorClass()
        let cgRandomComponents = UIColor.random.cgColor.components! 
        let floatRandomComponents = cgRandomComponents.map { Float($0) }
        myColor.colorName = "Random"
        myColor.colorComponents.append( floatRandomComponents[0] )
        myColor.colorComponents.append( floatRandomComponents[1] )
        myColor.colorComponents.append( floatRandomComponents[2] )
        myColor.colorComponents.append( floatRandomComponents[3] )
        return myColor
    }
    
    @IBAction func didChangeSegmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                self.savingType = .money
            case 1:
                self.savingType = .metalls
            default: break
        }
    }
    
    @IBAction func doneButtonDidTap(_ sender: Any) {
        if let text = textFieldCustomType.text, text.count != 0 {
            let image = UIImage()
            let imageToSend = image.imageWith(text)
            guard let imageToSend else { return }
            let imageData = imageToSend.pngData()
            let newType = RealmFinanceType()
            newType.name = text
            newType.image = imageData!
            newType.color = getRandomColor()
            newType.type = savingType.rawValue
            RealmManager<RealmFinanceType>().write(object: newType)
            updateBlock!()
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func textFieldDidEditing(_ sender: UITextField) {
        guard let text = sender.text else { return }
        let image = UIImage()
        let imageToPreview = image.imageWith(text)
        imageViewCustomType.image = imageToPreview
    }
}

extension AddFinanceViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
