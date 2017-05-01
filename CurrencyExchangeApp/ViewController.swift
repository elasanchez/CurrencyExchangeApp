//
//  ViewController.swift
//  CurrencyExchangeApp
//
//  Created by Luigi on 4/30/17.
//  Copyright © 2017 Luigi. All rights reserved.
//

import UIKit

//let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//let filename = "/favorites.txt"
//let absPath = path.appending(filename)

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

   

    @IBOutlet var homePicker: UIPickerView!
    
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var foreignDisplayLabel: UILabel!
    

  
    var currencyDict = ["USD": "United Dollar", "CAD" : "CANADA","EUR" : "EURO", "JPN" : "YEN", "KRW" : "WON"]
    var homeCurrencyId : [String] = ["USD"]
    var foreignCurrencyId: [String] = ["USD"]
    
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
        
        
        //load data from the model/ text file 
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let filename = "favorites.txt"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        {
            let path = dir.appendingPathComponent(filename)
            print(path)
            //reading
            do {
                let file = try String(contentsOf: path, encoding: String.Encoding.utf8)
                var myData:[String] = file.components(separatedBy: .newlines)
                
                //load currency from file
                for i in myData.startIndex..<myData.endIndex-1
                {
                    //print(myData[i])
                    data._currencySymbol.insert(myData[i])
                    data._rates.append(i)
                }
                //clear the list first
                
                homeCurrencyId.removeAll()
                foreignCurrencyId.removeAll()
                
                
                //populate the singleton data pattern
                if(!data._currencySymbol.isEmpty)
                {
                    for fav in data._currencySymbol
                    {
//                        print(">\(fav)")
                        homeCurrencyId.append(fav)
                        foreignCurrencyId.append(fav)
                        
                    }
                    
                }
            }
            catch
            {/* error handling here */
                
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
            catch {/* error handling here */}
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
        displayLabel.text! = homeCurrency
        foreignDisplayLabel.text! = foreignCurrency
    }
    
    //swipe func
    func handleSwipe(_ sender: UIGestureRecognizer) {
        self.performSegue(withIdentifier: "favorite", sender: self)
    }
    
    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue)
    {
        
    }
    
 
    
    
}

