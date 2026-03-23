//
//  ViewModel.swift
//  TaskLab
//
//  Created by Carlos Perez Ponce on 4/3/26.
//

import SwiftUI

final class CocinarViewModel: ObservableObject {
    
    private var cancellables: Set<Task<Void, Never>> = []
    
    init() {
        print("init CocinarViewModel")
    }
    
    deinit {
        print("deinit CocinarViewModel")
    }
    
    func preparar() {
        let task = Task { [weak self] in
            do {
                try await self?.abrirGas()
                try await self?.encenderFogones()
            } catch {
                print("Task cancelled: \(error)")
            }
        }
        cancellables.insert(task)
    }
    
    func cancel() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func abrirGas() async throws {
        print("Iniciar: \(#function)")
        try Task.checkCancellation()
        try? await Task.sleep(for: .seconds(5))
        print("Terminar: \(#function)")
    }
    
    private func encenderFogones() async throws {
        print("Iniciar: \(#function)")
        try Task.checkCancellation()
        try? await Task.sleep(for: .seconds(5))
        print("Terminar: \(#function)")
    }
}
