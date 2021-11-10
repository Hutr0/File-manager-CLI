//
//  JSON.swift
//  File manager CLI
//
//  Created by Леонид Лукашевич on 09.11.2021.
//

import Foundation

class JSON {
    
    func show() {
        let documentsUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask)[0] as NSURL
        
        print("Enter a name of file")
        let name = readLine()
        
        guard let name = name else {
            print("Error: Invalid name")
            self.show()
            return
        }
        
        let pathWithFilename = documentsUrl.appendingPathComponent(name + ".json")
        
        guard let pathWithFilename = pathWithFilename else {
            print("Error: Invalid url")
            self.show()
            return
        }
        
        self.menu(pathWithFilename)
    }
    
    private func menu(_ url: URL) {
        print(
            """
                    JSON
            1. Write to the JSON file
            2. Read from the JSON file
            3. Delete the JSON file
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
    
    private func write(_ url: URL) {
        
        print("What is your name?")
        let name = readLine()
        
        print("What is your surname?")
        let surname = readLine()
        
        print("Enter your number")
        let number = readLine()
        
        guard let name = name,
              let surname = surname,
              let number = number
        else {
            print("Error: The enered data is invalid")
            write(url)
            return
        }
        
        let jsonModel = jsonFile(name: name, surname: surname, number: number, meals: getMeals(url))
        let data = try! JSONEncoder().encode(jsonModel)
        let jsonString = String(data: data, encoding: .utf8)

        do {
            try jsonString!.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getMeals(_ url: URL) -> [Meal] {
        print("""
            Choose your meals
            1. Breakfast
            2. Dinner
            3. Lunch
            4. Go to next step
            
            """)
        
        var meals: [Meal] = []
        while true {
            let mealsChoice = readLine()
            
            guard let mealsChoice = Int(mealsChoice!) else {
                print("Error: Invalid number\n")
                continue
            }
            
            switch mealsChoice {
            case 1:
                meals.append(.breakfast)
            case 2:
                meals.append(.dinner)
            case 3:
                meals.append(.lunch)
            case 4:
                return meals
            default:
                print("Error: Number out of range\n")
            }
            print("Another?..")
        }
    }
    
    private func read(_ url: URL) {
        do {
            let data = try NSData(contentsOf: url, options: []) as Data
            let fileContent = try JSONDecoder().decode(jsonFile.self, from: data)
            print(fileContent)
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
