//
//  ZIP.swift
//  File manager CLI
//
//  Created by Леонид Лукашевич on 10.11.2021.
//

import Foundation
import Zip

class ZIP {
    
    func show() {
        let documentsUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first

        guard let documentsUrl = documentsUrl else {
            print("Error: The Desktop path is unavailible")
            return
        }
        
        self.menu(documentsUrl)
    }
    
    private func menu(_ url: URL) {
        let path = url.path
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
            self.menu(url)
            return
        }
        
        switch number {
        case 1:
            showFilesInDir(path: path)
        case 2:
            showFilesInDir(path: path)
            var pathArray: [URL] = []
            
            print("Choose a file. If you are done, just press Enter...")
            while true {
                let choice = readLine()
                
                if choice == "" {
                    break
                }
                
                guard let choice = Int(choice!) else {
                    print("Error: Invalid number\n")
                    continue
                }
                
                do {
                    let contents = try FileManager.default.contentsOfDirectory(atPath: path)
                    var i = 0
                    for content in contents {
                        if choice == i {
                            pathArray.append(url.appendingPathComponent(content))
                            break
                        }
                        i += 1
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            do {
                try Zip.zipFiles(paths: pathArray,
                                 zipFilePath: url.appendingPathComponent("Array.zip"),
                                 password: nil, progress: nil)
                print("The files have been archived")
            } catch {
                print(error.localizedDescription)
            }
        case 3:
            showFilesInDir(path: path)
            var zipPath: URL?
            
            print("Choose a zip file for unarchive. If you are done, just press Enter...")
            while true {
                if zipPath != nil {
                    break
                }
                
                let choice = readLine()
                
                guard let choice = Int(choice!) else {
                    print("Error: Invalid number\n")
                    continue
                }
                
                do {
                    let contents = try FileManager.default.contentsOfDirectory(atPath: path)
                    var i = 0
                    for content in contents {
                        if choice == i && content.hasSuffix(".zip"){
                            zipPath = url.appendingPathComponent(content)
                            break
                        }
                        i += 1
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
                guard zipPath != nil else {
                    print("Error: Choose zip file")
                    continue
                }
            }
            
            do {
                try Zip.unzipFile(zipPath!, destination: url.appendingPathComponent("Unarchive"), overwrite: true, password: nil, progress: { progress in
                    print(progress)
                })
                print("The zip file has been unarchived")
            } catch {
                print(error.localizedDescription)
            }
        case 4:
            return
        default:
            print("Error: Number out of range\n")
        }
        
        self.menu(url)
    }
    
    private func showFilesInDir(path: String) {
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
    }
}
