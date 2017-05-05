//
//  ViewController.swift
//  CurrencyExchangeApp
//
//  Created by Luigi on 4/30/17.
//  Copyright © 2017 Luigi. All rights reserved.
//

import UIKit

/*
            MAIN VIEW CONTROLLER
 */

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var homePicker: UIPickerView!
    
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var foreignDisplayLabel: UILabel!

    @IBOutlet var homeTextField: UITextField!
    
    @IBOutlet var foreignTextField: UITextField!
    
    var homeCurrencyId : [String] = [""]
    var foreignCurrencyId: [String] = [""]
    
    var homeCurrency : String  = ""
    var foreignCurrency: String = ""
    
    let data = favorites.shared
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        //  let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        
        swipeLeft.direction = .left
        //swipeRight.direction = .right
        
        view.addGestureRecognizer(swipeLeft)
        //view.addGestureRecognizer(swipeRight)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //get data before loading everything else
        getData()
        
        let filename = "favorites.txt"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        {
            let path = dir.appendingPathComponent(filename)
    
            //reading
            do {
                let file = try String(contentsOf: path, encoding: String.Encoding.utf8)
                var myData:[String] = file.components(separatedBy: .newlines)
                
                //load currency from file
                for i in myData.startIndex..<myData.endIndex-1
                {
                    //print(myData[i])
                    data._currencySymbol.insert(myData[i])
                }
                //clear the list first
                
                homeCurrencyId.removeAll()
                foreignCurrencyId.removeAll()
                
                
                //populate the singleton data pattern
                if(!data._currencySymbol.isEmpty)
                {
                    for fav in data._currencySymbol
                    {
                        homeCurrencyId.append(fav)
                        foreignCurrencyId.append(fav)
                    }
                    
                    homeCurrency = homeCurrencyId[0]
                    foreignCurrency = foreignCurrencyId[0]
                }
            }
            catch
            {/* error handling here */
                print("Error reading the file.")
            }
        }
        
        self.homePicker.reloadAllComponents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //automatically save data once view disappears
        
        var file  = ""
        let filename = "favorites.txt"
        
        for fav in data._currencySymbol
        {
            file.append(fav)
            if !fav.isEmpty
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
                //print(file)
            }
            catch
            {
                /* error handling here */
                print("Error writing on file.")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(component == 0)
        {
            return homeCurrencyId[row]
        }
        else
        {
            return foreignCurrencyId[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
        if(component == 0)
        {
            return self.homeCurrencyId.count
        }
        else
        {
            return self.foreignCurrencyId.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        
        if(!data._currencySymbol.isEmpty)
        {
            //Home currency
            if(component == 0)
            {
                switch(row)
                {
                case 0:
                        self.homeCurrency = homeCurrencyId[row]
                case 1:
                        self.homeCurrency = homeCurrencyId[row]
                case 2:
                         self.homeCurrency = homeCurrencyId[row]
                default:
                        self.homeCurrency = homeCurrencyId[row]
                }
                
            }
            if(component == 1) // Foreign Currency
            {
                switch(row)
                {
                case 0:
                    self.foreignCurrency = foreignCurrencyId[row]
                case 1:
                    self.foreignCurrency = foreignCurrencyId[row]
                case 2:
                    self.foreignCurrency = foreignCurrencyId[row]
                default:
                    self.foreignCurrency = foreignCurrencyId[row]
                }
            }
        }
    }
    
    @IBAction func convertButton(_ sender: Any)
    {
        var foreignValue: Float
        let homeForeignString = homeCurrency + foreignCurrency
        displayLabel.text! = homeCurrency
        foreignDisplayLabel.text! = foreignCurrency
        
        if(homeTextField.text! != "")
        {
            let homeValue = removeSpecialCharsFromString(homeTextField.text!)
            if(homeValue != "")
            {
                foreignValue = Float(homeValue)!
                let rate = self.data._exchangeRateDict[homeForeignString]!
                foreignValue = foreignValue * rate
                
                let foreignValueString = String.localizedStringWithFormat("%.2f %@",foreignValue,"")

                let hSymbol = findSymbol(homeCurrency)
                let fSymbol = findSymbol(foreignCurrency)
                homeTextField.text! = hSymbol + " \(homeValue)"
                foreignTextField.text! = fSymbol + foreignValueString
            }
            else{
                homeTextField.text! = "Invalid Entry"
                foreignTextField.text! = "No result"
            }
        }
    }
    //remove characters that is not in the set
    func removeSpecialCharsFromString(_ text: String) -> String {
        let okayChars : Set<Character> =
            Set("0123456789".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    func findSymbol(_ currency : String) -> String
    {
        switch currency
        {
            case "USD":
                return "$"
            case "CAD":
                return "C$"
            case "EUR":
                return "€"
            case "JPY":
                return "¥"
            default:
                return "￦"
        }
    }
    
    //swipe func
    func handleSwipe(_ sender: UIGestureRecognizer) {
        self.performSegue(withIdentifier: "favorite", sender: self)
    }
    
    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue)
    {
        //unwind
    }
 
    func getData()
    {
        let myYQL = YQL()
        let queryString = "select * from yahoo.finance.xchange where pair in (\"USDUSD\",\"USDJPY\", \"USDEUR\", \"USDCAD\", \"USDKRW\", \"JPYUSD\", \"JPYJPY\", \"JPYEUR\", \"JPYCAD\", \"JPYKRW\", \"EURUSD\", \"EURJPY\", \"EUREUR\", \"EURCAD\", \"EURKRW\", \"CADUSD\", \"CADJPY\", \"CADEUR\", \"CADCAD\", \"CADKRW\", \"KRWUSD\", \"KRWJPY\", \"KRWEUR\", \"KRWCAD\", \"KRWKRW\")"
        
        // Network session is asyncronous so use a closure to act upon data once data is returned
        myYQL.query(queryString){ jsonDict in
            // With the resulting jsonDict, pull values out
            // jsonDict["query"] results in an Any? object
            // to extract data, cast to a new dictionary (or other data type)
            // repeat this process to pull out more specific information
            let queryDict = jsonDict["query"] as! [String: Any]
            //print(queryDict["count"]!)
            //print(queryDict["results"]!)
            
            let result = queryDict["results"]! as! [String:Any]
            //print(result["rate"]!)
            let rate = result["rate"]! as! [[String: Any]]
            
            var index = 0
            
            for _ in 0..<25
            {
                let name = rate[index]["id"] as! String
                
                if let ob = rate[index]["Rate"]! as? String
                {
                    let obFloat = Float(ob)
            
                    self.data._rates.append(obFloat!)
                    self.data._exchangeRateDict[name]  = obFloat!
                }
                index = index + 1
            }
        }
    }
}

