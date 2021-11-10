//
//  File.swift
//  File manager CLI
//
//  Created by Леонид Лукашевич on 09.11.2021.
//

import Foundation

class File {
    
    func show() {
        let documentsUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask)[0] as NSURL
        
        print("Enter a name of file")
        let name = readLine()
        
        guard let name = name else {
            print("Error: Invalid name")
            self.show()
            return
        }
        
        let fileUrl = documentsUrl.appendingPathComponent(name + ".txt")
        
        guard let fileUrl = fileUrl else {
            print("Error: Invalid url")
            self.show()
            return
        }
        
        menu(fileUrl)
    }
    
    private func menu(_ url: URL) {
        print(
            """
                    File
            1. Write to the file
            2. Read from the file
            3. Delete the file
            4. Go to main menu
            
            """)
        let number = readLine()
        
        guard let number = Int(number!) else {
            print("Error: Invalid number\n")
            self.menu(url)
            return
        }
        
        switch number {
        case 1:
            self.write(url)
        case 2:
            self.read(url)
        case 3:
            self.delete(url)
        case 4:
            return
        default:
            print("Error: Number out of range\n")
        }
        
        self.menu(url)
    }
    
    private func write (_ url: URL) {
        print("What do u want to write to the file?")
        let str = readLine()
        
        guard let str = str else {
            print("Error: String is empty")
            self.menu(url)
            return
        }
        
        do {
            try str.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func read(_ url: URL) {
        do {
            let fileContent = try NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
            print("\n\(fileContent)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func delete(_ url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
