//
//  IdeaNoteApp.swift
//  IdeaNote
//
//  Created by DongQing on 2023/11/14.
//

import SwiftUI

@main
struct IdeaNoteApp: App {
    
    @StateObject var viewModel: NoteViewModel = NoteViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
