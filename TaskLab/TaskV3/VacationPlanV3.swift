/**
 V3: Se usa weak reference
    - Al navegar atrás, loadDestinationInfo se cancela
    - calculateFlightCosts sigue ejecutándose
    - calculateHotelCosts ya no llega a comenzar
    - ViewModel se destruye cuando acaba  calculateFlightCosts
 */
import SwiftUI

struct VacationPlanV3: View {
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Mars") {
                    VacationDetailsV3()
                }
            }
            .navigationTitle("Vacation trips")
        }
    }
}

struct VacationDetailsV3: View {
    @StateObject var viewModel = VacationViewModelV3()
    
    var body: some View {
        VStack {
            if viewModel.loadingDestinationInfo {
                Text("Loading...")
            } else {
                Image("mars")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
                    .padding()
            }
            
            Button("Estimate budget") {
                viewModel.calculateCheapestBudget()
            }
            .disabled(viewModel.loadingDestinationInfo)
            .buttonStyle(.bordered)
            .padding()
            
            if viewModel.loadingFlightsInfo {
                Text("Searching flights...")
            }
            if viewModel.loadingHotelsInfo {
                Text("Searching hotels...")
            }
            
            Spacer()
        }
        .navigationTitle("Mars")
        .task {
            await viewModel.onLoad()
        }
    }
}

#Preview {
    VacationPlanV3()
}
