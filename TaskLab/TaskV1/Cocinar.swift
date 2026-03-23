//
//  Cocinar.swift
//  TaskLab
//
//  Created by Carlos Perez Ponce on 4/3/26.
//

import SwiftUI

struct Cocinar: View {
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Ir a preparar") {
                    PrepararCocina()
                }
            }
        }
    }
}

struct PrepararCocina: View {
    @StateObject var viewModel = CocinarViewModel()
    
    var body: some View {
        Button("Preparar la cocina") {
            viewModel.preparar()
        }
        .navigationTitle("Preparar la cocina")
        .onDisappear {
            viewModel.cancel()
        }
    }
}

#Preview {
    Cocinar()
}
