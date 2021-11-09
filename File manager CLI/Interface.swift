//
//  Interface.swift
//  File manager CLI
//
//  Created by Леонид Лукашевич on 09.11.2021.
//

import Foundation

class Interface {
    
    func show() {
        print(
            """
                        Menu
            1. Print info about file system
            2. Go to file menu
            3. Go to JSON menu
            4. ...
            5. Exit
            
            """)
        
        let number = readLine()
        
        guard let number = Int(number!) else {
            print("Error: Invalid number\n")
            self.show()
            return
        }
        
        switch number {
        case 1:
            FileSystem().getFileSystemInfo { info in
                for i in info {
                    print(i)
                }
            }
        case 2:
            File().show()
        case 3:
            JSON().show()
        case 4:
            break
        case 5:
            return
        default:
            print("Error: Number out of range\n")
        }
        
        self.show()
    }
}
