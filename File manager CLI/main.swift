//
//  main.swift
//  File manager CLI
//
//  Created by Леонид Лукашевич on 09.11.2021.
//

import Foundation

Interface().show()

//
//let jsonModel = jsonFile(name: "Name", surname: "Surname", number: "123", meals: [.breakfast, .dinner])
//let encoder = JSONEncoder()
//let data = try! encoder.encode(jsonModel)
//print(String(data: data, encoding: .utf8))
//
//let jsonString = String(data: data, encoding: .utf8) // "{\"location\": \"the moon\"}"
//if let documentDirectory = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
//    let pathWithFilename = documentDirectory.appendingPathComponent("myJsonString.json")
//    do {
//        try jsonString!.write(to: pathWithFilename,
//                             atomically: true,
//                             encoding: .utf8)
//    } catch {
//        // Handle error
//    }
//
//    do {
//        let data = try NSData(contentsOf: pathWithFilename, options: []) as Data
//        let fileContent = try JSONDecoder().decode(jsonFile.self, from: data)
//        print(fileContent)
//    } catch {
//        // Handle error
//    }
//}


