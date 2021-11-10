//
//  ZIP.swift
//  File manager CLI
//
//  Created by Леонид Лукашевич on 10.11.2021.
//

import Foundation

class ZIP {
    
    func show() {
        let documentsUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first

        guard let documentsUrl = documentsUrl else {
            print("Error: The Desktop path is unavailible")
            return
        }
        
        self.menu(documentsUrl.path)
//
//        print("Enter a name of file")
//        let filename = readLine()
//
//        guard let filename = filename else {
//            print("Error: Invalid filename")
//            self.show()
//            return
//        }
//
//        let pathWithFilename = documentsUrl.appendingPathComponent(filename + ".xml")
//
//        self.menu(pathWithFilename)
    }
    
    private func menu(_ path: String) {
        print(
            """
            
                    ZIP
            1. Show all files on the desktop
            2. Make a ZIP
            3. UnMake a ZIP
            4. Go to main menu
            
            """)
        let number = readLine()
        
        guard let number = Int(number!) else {
            print("Error: Invalid number\n")
            self.menu(path)
            return
        }
        
        switch number {
        case 1:
            do {
                let contents = try FileManager.default.contentsOfDirectory(atPath: path)
                var i = 0
                for content in contents {
                    print("\(i): \(content)")
                    i += 1
                }
            } catch {
                print(error.localizedDescription)
            }
        case 2:
            break
        case 4:
            Interface().show()
            return
        default:
            print("Error: Number out of range\n")
        }
        
        self.menu(path)
    }
}
