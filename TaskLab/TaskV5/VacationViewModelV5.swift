import SwiftUI

@MainActor
final class VacationViewModelV5: ObservableObject {

    @Published var loadingDestinationInfo: Bool = false
    @Published var loadingFlightsInfo: Bool = false
    @Published var loadingHotelsInfo: Bool = false
    private var cancellables: Set<Task<Void, Never>> = []
    
    init() {
        print("init VacationViewModelV5")
    }
    
    deinit {
        print("deinit VacationViewModelV5")
    }
    
    func onLoad() async {
        await loadDestinationInfo()
    }
    
    private func loadDestinationInfo() async {
        loadingDestinationInfo = true
        print("Loading destination data...")
        try? await Task.sleep(for: .seconds(3))
        print("Finished loading data.")
        loadingDestinationInfo = false
    }
    
    func calculateCheapestBudget() {
        let task = Task { [weak self] in
            do {
                try await self?.calculateFlightCosts()
                try await self?.calculateHotelCosts()
            } catch {
                self?.loadingHotelsInfo = false
                self?.loadingFlightsInfo = false
                self?.loadingDestinationInfo = false
                print("Task cancelled: \(error.localizedDescription)")
            }
        }
        cancellables.insert(task)
    }
    
    func cancel() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func calculateFlightCosts() async throws {
        loadingFlightsInfo = true
        print("Start: \(#function)")
        try Task.checkCancellation()
        try await Task.sleep(for: .seconds(5))
        print("End: \(#function)")
        loadingFlightsInfo = false
    }

    private func calculateHotelCosts() async throws {
        loadingHotelsInfo = true
        print("Start: \(#function)")
        try Task.checkCancellation()
        try await Task.sleep(for: .seconds(5))
        print("End: \(#function)")
        loadingHotelsInfo = false
    }
}
