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
    
    var _currencySymbol:Set<String>
    var _rates: [Int]
    
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
    
    
    var rates: [Int]
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
    

    init(_ currencySymbol:Set<String> = ["USD"], _ rates: [Int] = [1])
    {
        
        self._currencySymbol = currencySymbol
        self._rates = rates
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
