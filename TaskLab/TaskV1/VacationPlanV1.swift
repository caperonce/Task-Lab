/**
 V1: No se usa .task()
    - Al navegar atrás, las task siguen ejecutándose (loadDestinationInfo, calculateFlightCosts y calculateHotelCosts
    - ViewModel se destruye cuando acaban las tasks
 */
import SwiftUI

struct VacationPlanV1: View {

    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Mars") {
                    VacationDetailsV1()
                }
            }
            .navigationTitle("Vacation trips")
        }
    }
}

struct VacationDetailsV1: View {
    
    @StateObject var viewModel = VacationViewModelV1()
    
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
        .onAppear {
            viewModel.onLoad()
        }
    }
}

#Preview {
    VacationPlanV1()
}
