//
//  Epub.swift
//  Test
//
//  Created by Andrey Petrovskiy on 02.12.2018.
//  Copyright © 2018 Andrey Petrovskiy. All rights reserved.
//

import Foundation

import FolioReaderKit

enum Epub: Int{
    case bookOne = 0
    case bookTwo
    
    var name: String{
        switch self{
        case.bookOne: return "Alisa-V-Strane" // Alisa.epub
        case.bookTwo: return "Mobi-Dik"  //Moby-Dik.epub
        }
    }
        
    var shouldHideNavigationOnTap: Bool{
            switch self{
            case.bookOne: return false
            case.bookTwo: return false
            }
        }
    var scrollDirection: FolioReaderScrollDirection {
            switch self{
            case.bookOne: return .horizontal
            case.bookTwo: return .horizontal
            }
        }
    var bookPath: String?{
                return Bundle.main.path(forResource: self.name, ofType: "epub")
            }
        var readerIdentifier: String{
            switch self {
            case .bookOne:
                return "Book One"
            case.bookTwo:
                return "Book Two"
            }
            
        }
    }

