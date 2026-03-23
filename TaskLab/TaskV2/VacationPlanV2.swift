/**
 V2: Se .task()
    - Al navegar atrás, loadDestinationInfo se cancela
    - calculateFlightCosts y calculateHotelCosts siguen ejecutándose
    - ViewModel se destruye cuando acaban las tasks calculateFlightCosts y calculateHotelCosts
 */
import SwiftUI

struct VacationPlanV2: View {

    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Mars") {
                    VacationDetailsV2()
                }
            }
            .navigationTitle("Vacation trips")
        }
    }
}

struct VacationDetailsV2: View {
    
    @StateObject var viewModel = VacationViewModelV2()
    
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
    VacationPlanV2()
}
