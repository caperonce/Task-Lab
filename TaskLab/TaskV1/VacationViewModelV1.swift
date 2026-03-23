import SwiftUI

@MainActor
final class VacationViewModelV1: ObservableObject {
    
    @Published var loadingDestinationInfo: Bool = false
    @Published var loadingFlightsInfo: Bool = false
    @Published var loadingHotelsInfo: Bool = false
    
    init() {
        print("init VacationViewModelV1")
    }
    
    deinit {
        print("deinit VacationViewModelV1")
    }
    
    func onLoad() {
        Task {
            await loadDestinationInfo()
        }
    }
    
    private func loadDestinationInfo() async {
        loadingDestinationInfo = true
        print("Loading destination data...")
        try? await Task.sleep(for: .seconds(3))
        print("Finished loading data.")
        loadingDestinationInfo = false
    }
    
    func calculateCheapestBudget() {
        Task {
            await self.calculateFlightCosts()
            await self.calculateHotelCosts()
        }
    }
    
    private func calculateFlightCosts() async {
        loadingFlightsInfo = true
        print("Start: \(#function)")
        try? await Task.sleep(for: .seconds(5))
        print("End: \(#function)")
        loadingFlightsInfo = false
    }

    private func calculateHotelCosts() async {
        loadingHotelsInfo = true
        print("Start: \(#function)")
        try? await Task.sleep(for: .seconds(5))
        print("End: \(#function)")
        loadingHotelsInfo = false
    }
}
