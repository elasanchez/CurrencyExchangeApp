//
//  FavCurrencyViewController.swift
//  CurrencyExchangeApp
//
//  Created by Luigi on 4/30/17.
//  Copyright © 2017 Luigi. All rights reserved.
//

import UIKit

class FavCurrencyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

  
    @IBOutlet var favoriteUIPicker: UIPickerView!
    
    @IBOutlet var favoriteDisplayLabel: UILabel!

    @IBOutlet var removedFavoritesDisplayLabel: UILabel!    
  
    var availableCurrency = ["USD", "CAD", "EUR", "JPY", "KRW"]
    let data = favorites.shared
    var currentSelection: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        
        //swipeLeft.direction = .left
        swipeRight.direction = .right
        
        //view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
        
        // Do any additional setup after loading the view.
        
        favoriteUIPicker.delegate = self
        favoriteUIPicker.delegate = self
        
        favoriteDisplayLabel.text = "Favorite: "
        
            for currency in data._currencySymbol
            {
                favoriteDisplayLabel.text?.append(" \(currency) ")
            }
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        //automatically save data once view disappears
        
        var file  = ""
        let filename = "favorites.txt"
        
        for fav in data._currencySymbol
        {
            file.append(fav)
            if !data._currencySymbol.isEmpty
            {
                file.append("\n")
            }
        }
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        {
            let path = dir.appendingPathComponent(filename)
            //writing
            do {
                try file.write(to: path, atomically: false, encoding: String.Encoding.utf8)
//                print(file)
            }
            catch {/* error handling here */
                print("Error writing file")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return availableCurrency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return availableCurrency.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch row {
        case 0:
            self.currentSelection = availableCurrency[row]
        case 1:
            self.currentSelection = availableCurrency[row]
        case 2:
            self.currentSelection = availableCurrency[row]
        case 3:
            self.currentSelection = availableCurrency[row]
        case 4:
            self.currentSelection = availableCurrency[row]
        default:
            self.currentSelection = self.availableCurrency[0]
        }
    }
    
    //swipe func
    func handleSwipe(_ sender: UIGestureRecognizer)
    { 
        self.performSegue(withIdentifier: "unwindToMain", sender: self)
        
    }

    
    @IBAction func addToFavoritesButton(_ sender: Any)
    {
        
        if(!data._currencySymbol.contains(currentSelection))
        {
            data._currencySymbol.insert(currentSelection)
             favoriteDisplayLabel.text?.append(" \(currentSelection) ")
        }
    }
    
    @IBAction func removeFromFavoritesButton(_ sender: Any)
    {
        
        if(data._currencySymbol.count > 1)
        {
            if(data._currencySymbol.contains(currentSelection))
            {
                data._currencySymbol.remove(currentSelection)
                removedFavoritesDisplayLabel.text?.append(" \(currentSelection) ")
            }
        }

    }
}












