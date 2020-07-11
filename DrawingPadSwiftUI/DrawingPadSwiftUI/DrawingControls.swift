//
//  DrawingControls.swift
//  DrawingPadSwiftUI
//
//  Created by Martin Mitrevski on 19.07.19.
//  Copyright © 2019 Mitrevski. All rights reserved.
//

import SwiftUI

struct DrawingControls: View {
    @Binding var drawings: [Drawing]
    
    private let spacing: CGFloat = 40
    
    private let service = Service()
    
    var body: some View {
        HStack(spacing: spacing) {
            Button("Undo") {
                if self.drawings.count > 0 {
                    self.drawings.removeLast()
                }
            }
            Button("Clear") {
                self.drawings = [Drawing]()
            }
            Button("Send") {
                self.sendAllPoints()
                
            }
        }
        .frame(height: 200)
    }
    
    private func sendAllPoints() {
        var allPoints = [CGPoint]()
        for i in self.drawings {
            for j in i.points {
                allPoints.append(j)
            }
        }
        
        service.sendData(allPoints: allPoints) { (isSend) in
            if (isSend) {
                self.drawings = [Drawing]()
                print("Success!")
            }  else {
//                print("Failed to send drawing points!")
            }
        }
    }
}
