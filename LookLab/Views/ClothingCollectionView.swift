//
//  ClothingCollectionView.swift
//  LookLab
//
//  Created by Cera Wang on 2025-06-03.
//

import SwiftUI

struct ClothingCollectionView: View {
    // State variables
    // TODO: make into deisgn type later
    @State private var selectedBox: String?
    @State private var renamedTitle: String = ""
    @State private var showRenamePrompt: Bool = false
    
    // Passed in data
    var folder: String // TODO: make into object
    
    // TODO: pseudo data for now
    var folders: [Int: String] = [
        1: "👗",
        2: "👗",
        3: "👗"
    ]
    
    // Define 3 equal columns for box display
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#373539")
                    .ignoresSafeArea()
                
                // Display
                // TODO: get user projects from view model and display here
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(folders.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                            ProjectView(
                                content: value,
                                title: "",
                                onProjectTapped: {
                                    selectedBox = value // TODO: change to just value, design type
                                },
                                onTitleTapped: {}
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationDestination(isPresented: Binding(
                get: {selectedBox != nil},
                set: {if !$0 {selectedBox = nil}}
            )) {
                if let clothing = selectedBox {
                    ClothingView(clothing: clothing)
                }
            }
        }
    }
}

#Preview {
    ClothingCollectionView(folder: "")
}
