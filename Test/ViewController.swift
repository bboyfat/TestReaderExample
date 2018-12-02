//
//  ViewController.swift
//  Test
//
//  Created by Andrey Petrovskiy on 02.12.2018.
//  Copyright © 2018 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import FolioReaderKit

class ViewController: UIViewController {

    @IBOutlet weak var bookOne: UIButton!
    @IBOutlet weak var bookTwo: UIButton!
    
    let folioReader = FolioReader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bookOne?.tag = Epub.bookOne.rawValue
        self.bookTwo?.tag = Epub.bookTwo.rawValue
        
        self.setCover(self.bookOne, index: 0)
        self.setCover(self.bookTwo, index: 1)
    }
    
    
    private func readerConfiguration(forEpub epub: Epub) -> FolioReaderConfig {
        let config = FolioReaderConfig(withIdentifier: epub.readerIdentifier)
        config.shouldHideNavigationOnTap = epub.shouldHideNavigationOnTap
        config.scrollDirection = epub.scrollDirection
        
        config.quoteCustomBackgrounds = []
        if let image = UIImage(named: "demo-bg") {
            let customImageQuote = QuoteImage(withImage: image, alpha: 0.6, backgroundColor: UIColor.black)
            config.quoteCustomBackgrounds.append(customImageQuote)
        }
        
        let textColor = UIColor(red:0.86, green:0.73, blue:0.70, alpha:1.0)
        let customColor = UIColor(red:0.30, green:0.26, blue:0.20, alpha:1.0)
        let customQuote = QuoteImage(withColor: customColor, alpha: 1.0, textColor: textColor)
        config.quoteCustomBackgrounds.append(customQuote)
        
        return config
        
    }
    
    
    fileprivate func open (epub: Epub){
        
        guard let bookPath = epub.bookPath else {
            return
        }
        
        let readerConfiguration = self.readerConfiguration(forEpub: epub)
        folioReader.presentReader(parentViewController: self, withEpubPath: bookPath, andConfig: readerConfiguration, shouldRemoveEpub: false)
        
    }
    
    
    private func setCover(_ button: UIButton?, index: Int){
        guard
            let epub = Epub(rawValue: index),
            let bookPath = epub.bookPath else {return}
        
        do {
            let image = try FolioReader.getCoverImage(bookPath)
            button?.setBackgroundImage(image, for: .normal)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ViewController{
    
    @IBAction func didOpen (_ sender: AnyObject){
        guard let epub = Epub(rawValue: sender.tag) else {return}
        
        self.open(epub: epub)
    }
    
    
}

