//
//  WardrobeFolderView.swift
//  LookLab
//
//  Created by Cera Wang on 2025-06-02.
//

import SwiftUI

struct WardrobeFolderView: View {
    // State variables
    // TODO: make into deisgn type later
    @State private var selectedBox: String?
    @State private var renamedTitle: String = ""
    @State private var showRenamePrompt: Bool = false
    
    // TODO: pseudo data for now
    var folders: [Int: [String: String]] = [
        1: [
            "title": "Folder 1",
            "image": "📁"
        ],
        2: [
            "title": "Folder 2",
            "image": "📁"
        ],
        3: [
            "title": "Folder 3",
            "image": "📁"
        ]
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
                                content: value["image"] ?? "",
                                title: value["title"] ?? "",
                                onProjectTapped: {
                                    selectedBox = value["title"] ?? ""// TODO: change to just value, design type
                                },
                                onTitleTapped: {
                                    renamedTitle = value["title"] ?? ""
                                    showRenamePrompt = true
                                }
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
                if let project = selectedBox {
                    CanvasView(project: project)
                }
            }
            .alert("Rename", isPresented: $showRenamePrompt) {
                TextField(renamedTitle, text: $renamedTitle)
                Button("OK", role: .cancel) {
                    // TODO: save rename to db
                }
            }
        }
    }
}

#Preview {
    WardrobeFolderView()
}
