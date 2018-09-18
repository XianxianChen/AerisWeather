//
//  ViewController.swift
//  AerisWeather
//
//  Created by C4Q on 9/18/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var zipCode: String! {
        didSet {
            if zipCode != "" {
                UserDefaults.standard.setValue(zipCode, forKeyPath: "zipCode")
            }
            loadWeathers(from: zipCode)
        }
    }
    var weathers = [DayWeather]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    @IBOutlet weak var textField: UITextField!
    
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
         self.collectionView.reloadData()
        if sender.currentTitle == "Get Celsius" {
            sender.setTitle("Get Fahrenheit", for: .normal)
        } else {
            sender.setTitle("Get Celsius", for: .normal)
        }
    }
    func loadWeathers(from zipCode: String) {
        let completion: (InfoDict) -> Void = {(onlineInfo: InfoDict) in
            self.weathers = onlineInfo.periods
        }
        WeatherAPIClient.manager.getWeather(from: zipCode, completionHandler: completion, errorHandler: {print($0)})
    }
   

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text != nil else {return false}
        self.zipCode = textField.text!
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if "".contains(string) {
            return true
        }
        if !"1234567890".contains(string) {
            return false
        }
        
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    
}
extension ViewController:  UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weathers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.init(red: 0.49, green: 0.75, blue: 0.91, alpha: 1)
        let date = weathers[indexPath.row].validTime.components(separatedBy: "T")[0]
        cell.dateLabel.text = date
        let highTemp = weathers[indexPath.row].maxTempF
        let lowTemp = weathers[indexPath.row].minTempF
        let maxTempC = weathers[indexPath.row].maxTempC
        let minTempC = weathers[indexPath.row].minTempC
        
       if self.button.currentTitle == "Get Celsius" {
        cell.maxLabel.text = "High: \(highTemp)℉"
        cell.lowLabel.text = "Low: \(lowTemp)℉"
       } else {
        cell.maxLabel.text = "High: \(maxTempC)°C"
        cell.lowLabel.text = "Low: \(minTempC)°C"
        }
        let icon = weathers[indexPath.row].icon
        cell.imageView.image = UIImage(named: icon)
        
        return cell
    }
    
    
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    
}

