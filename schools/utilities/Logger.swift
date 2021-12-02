//
//  Logger.swift
//  schools
//
//  Created by Emmanuel Oche on 12/1/21.
//

import Foundation

class Logger {
    
    static func info(message msg: String){
        print(msg)
    }
    
    static func error(msg: String, error: NSError){
        print("error: \(msg)")
    }
}
