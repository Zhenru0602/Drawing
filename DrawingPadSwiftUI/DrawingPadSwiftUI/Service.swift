//
//  Service.swift
//  DrawingPadSwiftUI
//
//  Created by Zhenru Huang on 7/7/20.
//  Copyright © 2020 Mitrevski. All rights reserved.
//

import Foundation
import CoreGraphics

class Service {
    let endpoint = URL(string: "url")
    
    func sendData(allPoints: [CGPoint], completion: @escaping (Bool) -> Void) {
        
        guard let endpoint = endpoint  else {
            completion(false)
            return
        }
        
        var request  = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        let allPointString = allPointsToString(allPoints: allPoints)
        print(allPointString)
        data.append(allPointString.data(using: .utf8)!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        URLSession.shared.uploadTask(with: request, from: data) { (_, res, err) in
            if (err == nil) {
                completion(true)
            } else {
                completion(false)
            }
        }.resume()
    }
    
    private func allPointsToString(allPoints: [CGPoint]) -> String {
        var str = ""
        
        for i in allPoints {
            str += "(\(i.x),\(i.y)) "
        }
        return str
    }
}
