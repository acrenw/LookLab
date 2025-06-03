//
//  DesignView.swift
//  LookLab
//
//  Created by Cera Wang on 2025-05-25.
//

import SwiftUI

struct DesignView: View {
    // State variables
    // TODO: make into deisgn type later
    @State private var selectedProject: String?
    @State private var renamedTitle: String = ""
    @State private var showRenamePrompt: Bool = false
    
    // TODO: pseudo data for now
    var projects: [Int: [String: String]] = [
        1: [
            "title": "My App",
            "image": "📁"
        ],
        2: [
            "title": "LookLab",
            "image": "🧪"
        ],
        3: [
            "title": "StyleGen",
            "image": "👗"
        ]
    ]
    
    // Define 3 equal columns for project display
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
                VStack {
                    // Button
                    Button (action: {
                        // TODO: create new project method
                    }){
                        Text("+ New Project")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 120)
                    }
                    .background(LinearGradient(colors: [Color(hex: "#FFE591"), Color(hex: "#FF99E5"), Color(hex: "#AD47FF")], startPoint: .bottomLeading, endPoint: .topTrailing))
                    .cornerRadius(12)
                    .padding()
                    
                    // Line
                    Divider()
                        .frame(height: 1)
                        .background(Color(hex: "#FF99E5"))
                        .padding()

                    // My Projects
                    Text("My Projects")
                        .foregroundColor(.white)
                    
                    // Display
                    // TODO: get user projects from view model and display here
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(projects.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                                ProjectView(
                                    content: value["image"] ?? "",
                                    title: value["title"] ?? "",
                                    onProjectTapped: {
                                        selectedProject = value["title"] ?? ""// TODO: change to just value, design type
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
            }
            .navigationDestination(isPresented: Binding(
                get: {selectedProject != nil},
                set: {if !$0 {selectedProject = nil}}
            )) {
                if let project = selectedProject {
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
    DesignView()
}
