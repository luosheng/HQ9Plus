//
//  main.swift
//  HQ9+
//
//  Created by Luo Sheng on 15/10/27.
//  Copyright © 2015年 Pop Tap. All rights reserved.
//

import Foundation

struct HQ9Plus {
    
    static var beerSong: String {
        let beers = 99.stride(to: 0, by: -1).map { num in
            "\(num.bottleString) on the wall,\n" +
            "\(num.bottleString).\n" +
            "Take one down, pass it around,\n" +
            "\((num - 1).bottleString) on the wall.\n"
        }
        return beers.reduce("", combine: +)
    }
    
    enum Operation: Character {
        case Hello = "H"
        case Quine = "Q"
        case Nine = "9"
        case Plus = "+"
        
        func execute() {
            switch self {
            case .Hello:
                print("Hello, world!")
                break
            case .Quine:
                print(HQ9Plus.source)
                break
            case .Nine:
                print(HQ9Plus.beerSong)
                break
            case .Plus:
                HQ9Plus.counter++
                break
            }
        }
    }
    
    enum Error: ErrorType {
        case InvalidOperation
    }
    
    static var counter = 0
    static var source: String = ""
    
    init(source: String) {
        HQ9Plus.source = source
    }
    
    func interprete() throws {
        try HQ9Plus.source.uppercaseString.characters.forEach { c in
            guard let operation = Operation(rawValue: c) else {
                throw Error.InvalidOperation
            }
            operation.execute()
        }
    }
}

extension Int {
    var bottleString: String {
        let quantity = self > 0 ? "\(self)" : "No"
        let plural = self == 1 ? "" : "s"
        return "\(quantity) bottle\(plural) of beer"
    }
}

try! HQ9Plus(source: "HQ9+").interprete()
