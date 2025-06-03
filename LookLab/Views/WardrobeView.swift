//
//  WardrobeView.swift
//  LookLab
//
//  Created by Cera Wang on 2025-05-25.
//

import SwiftUI

struct WardrobeView: View {
    @State private var expanded = false

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Top: 3D Model Preview
                ModelPreviewView()
                    .frame(height: expanded ? geometry.size.height * 0.8 : geometry.size.height * 0.5)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.height > 50 {
                                    expanded = false
                                } else if value.translation.height < -50 {
                                    expanded = true
                                }
                            }
                    )

                // Bottom: Wardrobe folder view
                WardrobeFolderView()
                    .frame(height: expanded ? geometry.size.height * 0.2 : geometry.size.height * 0.5)
            }
            .animation(.easeInOut, value: expanded)
        }
    }
}

#Preview {
    WardrobeView()
}
