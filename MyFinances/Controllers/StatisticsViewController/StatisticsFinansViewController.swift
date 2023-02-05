//
//  StatisticsFinansViewController.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 2.02.23.
//

import UIKit
import Charts

class StatisticsFinansViewController: UIViewController {
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var metallPieChart: PieChartView!
    
    private var data: [Currency] = []
    private var readRealm = RealmManager<RealmFinanceType>().read()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPieChart()
        setupMetallPieChart()
        getData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setBackgroundGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.readRealm = RealmManager<RealmFinanceType>().read()
        setupPieChart()
        setupMetallPieChart()
    }
    
    private func setBackgroundGradient() {
        let topColor = UIColor(hue: 0.64, saturation: 0.68, brightness: 0.19, alpha: 1.0).cgColor // #2e3c91
        self.view.setGradientBackground(topColor: topColor, bottomColor: UIColor.black.cgColor)
    }
    
    private func getData() {
        ConverterProvider().getCurrency { currencys in
            self.data = currencys
            self.setupPieChart()
            self.setupMetallPieChart()
        } failure: { error in
            print(error)
        }
    }
    
    private func setupPieChart() {
        var colors: [NSUIColor] = []
        var arr: [PieChartDataEntry] = []
        var value = 0.0
        var bynModel = RealmFinanceType()
        readRealm.forEach { financeModel in
            if let byn = readRealm.first(where: {$0.name == "BYN"}) {
                bynModel = byn
            }
            if financeModel.type == "Деньги" {
                let conversedToByn = Double(convertToByn(value: financeModel.value, financeAbb: financeModel.name))
                guard let conversedFromByn = Double(convertFromByn(value: conversedToByn ?? bynModel.value)) else { return }
                arr.append(PieChartDataEntry(value: conversedFromByn, label: financeModel.name))
                colors.append(extractColorFrom(financeModel))
                value += conversedFromByn
            }
        }
        let dataSet = PieChartDataSet(entries: arr, label: "")
        dataSet.colors = colors
        pieChartView.data = PieChartData(dataSet: dataSet)

        let myString = "\(String(format: "%.2f" , value)) USD"
        let myAttribute = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        pieChartView.centerAttributedText = myAttrString
        pieChartView.rotationEnabled = false
        pieChartView.drawCenterTextEnabled = true
        pieChartView.holeColor = .clear
        pieChartView.noDataText = "Нет данных"
        pieChartView.legend.font = NSUIFont.systemFont(ofSize: 14, weight: .thin)
        pieChartView.legend.textColor = NSUIColor.white
        pieChartView.legend.form = .circle
        
    }
    
    private func setupMetallPieChart() {
        var colors: [NSUIColor] = []
        var arr: [PieChartDataEntry] = []
        var value = 0.0
        readRealm.forEach { financeModel in
            if financeModel.type == "Металлы" {
                arr.append(PieChartDataEntry(value: financeModel.value, label: financeModel.name))
                colors.append(extractColorFrom(financeModel))
                value += financeModel.value
                }
            }
        setupPieChartSettings(arr, colors, "гр", value)
    }
    
    private func setupPieChartSettings(_ arr: [PieChartDataEntry], _ colorArr: [NSUIColor], _ label: String, _ value: Double) {
        let dataSet = PieChartDataSet(entries: arr, label: "")
        dataSet.colors = colorArr
        metallPieChart.data = PieChartData(dataSet: dataSet)
        
        let myString = "\(String(format: "%.2f" , value)) \(label)"
        let myAttribute = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        metallPieChart.centerAttributedText = myAttrString
        metallPieChart.rotationEnabled = false
        metallPieChart.drawCenterTextEnabled = true
        metallPieChart.holeColor = .clear
        metallPieChart.noDataText = "Нет данных"
        metallPieChart.legend.font = NSUIFont.systemFont(ofSize: 14, weight: .thin)
        metallPieChart.legend.textColor = NSUIColor.white
        metallPieChart.legend.form = .circle
    }
    
    private func extractColorFrom(_ model: RealmFinanceType) -> NSUIColor {
        guard let data = model.color else { return NSUIColor()}
        let red = CGFloat(data.colorComponents[0])
        let green = CGFloat(data.colorComponents[1])
        let blue = CGFloat(data.colorComponents[2])
        let alpha = CGFloat(data.colorComponents[3])
        let color = NSUIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        return color
    }
    
    private func convertFromByn(value: Double) -> String {
        guard let currency = data.first(where: { $0.abb == "USD"}) else { return ""}
        let result = value / currency.rate * Double(currency.scale)
    
        return "\(String(format: "%.2f" , result))"
    }
    
    private func convertToByn(value: Double, financeAbb: String) -> String {
        guard let currency = data.first(where: { $0.abb == financeAbb}) else { return ""}
        let result = (value / Double(currency.scale) * currency.rate)
        
        return "\(String(format: "%.2f" , result))"
    }
}
