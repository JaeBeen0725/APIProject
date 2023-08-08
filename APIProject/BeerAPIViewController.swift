//
//  BeerAPIViewController.swift
//  APIProject
//
//  Created by Jae Oh on 2023/08/08.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher
class BeerAPIViewController: UIViewController {

    @IBOutlet var beerimage: UIImageView!
    @IBOutlet var beerLabel: UILabel!
    @IBOutlet var beerTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
beer()
        
    }
    
//    let url = URL(string:"https://i.pinimg.com/564x/2c/be/96/2cbe96d76b9015626c26e3f08b87ce9a.jpg")
//    actorImageView.kf.setImage(with: url)
    func beer() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                    print("JSON: \(json)")
                
                let imageUrl = URL(string:json[0]["image_url"].stringValue)
                let name = json[0]["name"].stringValue
                let description = json[0]["description"].stringValue
                
                self.beerimage.kf.setImage(with: imageUrl)
                self.beerLabel.text = name
                self.beerTextView.text = description
            case .failure(let error):
                print(error)
            }
        }
    }
}
