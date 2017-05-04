//
//  CurrencyDataModel.swift
//  CurrencyExchangeApp
//
//  Created by Luigi on 4/30/17.
//  Copyright © 2017 Luigi. All rights reserved.
//

import Foundation



//favorites will be the model of the currency exchange
class favorites
{
    //MARK: singleton
    static let shared = favorites()
    
    var _exchangeRateNames = ["USDUSD","USDJPY", "USDEUR", "USDCAD", "USDKRW", "JPYUSD", "JPYJPY", "JPYEUR", "JPYCAD", "JPYKRW", "EURUSD", "EURJPY", "EUREUR", "EURCAD", "EURKRW", "CADUSD", "CADJPY", "CADEUR", "CADCAD", "CADKRW", "KRWUSD", "KRWJPY", "KRWEUR", "KRWCAD", "KRWKRW"]
    
    var _exchangeRateDict = [String: Float]()
    var _currencySymbol:Set<String>
    var _rates: [Float]
    
    var exchangeDict: [String: Float]
    {
        get
        {
            return self._exchangeRateDict
        }
        set
        {
            _exchangeRateDict = newValue
        }
    }
    
    var currencyName: [String]
    {
        get
        {
            return self._exchangeRateNames
        }
    }
    
    var currencySymbol:Set<String>
    {
        get
        {
            return self._currencySymbol
        }
        set
        {
            _currencySymbol = newValue
        }
    }
    
    
    var rates: [Float]
    {
        get
        {
            return self._rates
        }
        set
        {
            _rates = newValue
        }
    }
    

    init(_ currencySymbol:Set<String> = ["USD"], _ rates: [Float] = [1])
    {
        
        self._currencySymbol = currencySymbol
        self._rates = rates
//        self._exchangeRateDict = exchangeDict
        
    }
    
    
    func isEmpty() -> Bool
    {
        if(_currencySymbol.isEmpty)
        {
            return true;
        }
        else
        {
            return false;
        }
        
    }
        
    
}
