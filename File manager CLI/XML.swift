//
//  XML.swift
//  File manager CLI
//
//  Created by Леонид Лукашевич on 10.11.2021.
//

import Foundation

class XML {
    
    func show() {
        let documentsUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first
        
        guard let documentsUrl = documentsUrl else {
            print("Error: The Desktop path is unavailible")
            return
        }
        
        print("Enter a name of file")
        let filename = readLine()
        
        guard let filename = filename else {
            print("Error: Invalid filename")
            self.show()
            return
        }
        
        let pathWithFilename = documentsUrl.appendingPathComponent(filename + ".xml")
        
        self.menu(pathWithFilename)
    }
    
    private func menu(_ url: URL) {
        print(
            """
                    XML
            1. Write to the XML file
            2. Read from the XML file
            3. Delete the XML file
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
            break
        case 3:
            self.delete(url)
            break
        case 4:
            Interface().show()
            return
        default:
            print("Error: Number out of range\n")
        }
        
        self.menu(url)
    }
    
    private func write(_ url: URL) {
        
        let root = XMLElement(name: "root")
        let xml = XMLDocument(rootElement: root)
        fillOutXML(url, root)
        
        do {
            try xml.xmlString.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
        
        self.menu(url)
    }
    
    private func fillOutXML(_ url: URL, _ root: XMLElement) {
        var current = root
        
        while true {
            print("""
                
                Now you got an \(current.name ?? "") element
                1. Get all childs
                2. Select a child
                3. Add a child
                4. Set a value
                5. Return to root
                6. Go back?.  
                
                """)
            let choice = readLine()

            guard let choice = Int(choice!) else {
                print("Error: Invalid number\n")
                continue
            }

            switch choice {
            case 1:
                print(current.children ?? "No one")
            case 2:
                var i = 0
                for child in current.children ?? [] {
                    print("\(i): \(child)")
                    i += 1
                }
                
                print("Enter a number of child")
                let number = readLine()
                
                guard let number = Int(number!), let childName = current.child(at: number)?.name else {
                    print("Error: Invalid child name\n")
                    continue
                }
                
                current = current.elements(forName: childName).first!
            case 3:
                print("Enter a child name")
                let childName = readLine()
                
                guard let childName = childName else {
                    print("Error: Invalid child name\n")
                    continue
                }
                current.addChild(XMLElement(name: childName))
            case 4:
                print("Enter a string value")
                let value = readLine()
                
                guard let value = value else {
                    print("Error: Invalid value\n")
                    continue
                }
                current.stringValue = value
            case 5:
                current = root
            case 6:
                return
            default:
                print("Error: Number out of range\n")
            }
        }
    }
    
    private func read(_ url: URL) {
        do {
            let data = try NSData(contentsOf: url, options: []) as Data
            let fileContent = try XMLDocument(data: data, options: [])
            print(fileContent)
        } catch {
            print(error.localizedDescription)
        }

        self.menu(url)
    }

    private func delete(_ url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Error: \(error.localizedDescription)")
        }

        self.menu(url)
    }
}
