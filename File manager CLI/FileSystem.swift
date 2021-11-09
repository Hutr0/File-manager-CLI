//
//  FileSystem.swift
//  File manager CLI
//
//  Created by Леонид Лукашевич on 09.11.2021.
//

import Foundation

class FileSystem {
    
    func getFileSystemInfo(completion: @escaping ([String]) -> ()) {
        let mountedVolumeURLs = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: nil)
        var info: [String] = []
        
        for volumeURL in mountedVolumeURLs! {
            if let values = try? volumeURL.resourceValues(forKeys: [.nameKey,
                                                                    .volumeNameKey,
                                                                    .volumeTotalCapacityKey,
                                                                    .volumeAvailableCapacityKey,
                                                                    .volumeLocalizedFormatDescriptionKey,
                                                                    .localizedTypeDescriptionKey]) {
                guard let name = values.name,
                      let totalCapacity = values.volumeTotalCapacity,
                      let availableCapacity = values.volumeAvailableCapacity,
                      let formate = values.volumeLocalizedFormatDescription,
                      let type = values.localizedTypeDescription
                else {
                    info.append("Данные о диске недоступны")
                    continue
                }
                
                info.append("""
                    Название: \(name)
                    Объём диска: \(totalCapacity)
                    Свободное место на диске: \(availableCapacity)
                    Тип: \(formate) \(type)\n
                """)
            }
        }
        completion(info)
    }
}
