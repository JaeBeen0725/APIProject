//
//  ViewController.swift
//  APIProject
//
//  Created by Jae Oh on 2023/08/08.
//

import UIKit
import SwiftyJSON
import Alamofire


class ViewController: UIViewController {

    @IBOutlet var showPicker: UITextField!
    @IBOutlet var showLottery: UILabel!
    
    var list : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     lotterylist()
    showPickerView()
        lotteryPicker(row: 0)
        showPicker.text = String(list[0])
    }
    func lotterylist() {
        for num in 1...1079 {
            list.insert(num, at: 0)
        }
        
        
    }
    
    func lotteryPicker(row: Int) {
        showPicker.text = String(list[row])
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(list[row] )"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                var numlist: [Int] = []
                
                for num in 1...6 {
                    
                    let lotteryNumber = json["drwtNo\(num)"].intValue
                 
                    
                      numlist.append(lotteryNumber)
                }
                let bnusNo = json["bnusNo"].intValue
                
                self.showLottery.text = "\(numlist) + \(bnusNo)"
            case .failure(let error):
                print(error)
            }
        }

    }
  
        
      
        
    
}




extension ViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(list[row])
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        lotteryPicker(row: row)
        
    }
    
    func showPickerView() {
        let pv = UIPickerView()
        pv.delegate = self
        showPicker.inputView = pv
    }
 
    
}


