/**
 V4: Se usa cancel sin weak reference
    - Al navegar atrás, loadDestinationInfo se cancela
    - calculateFlightCosts se cancela inmediatamente
    - calculateHotelCosts ya no se llega a ejecutar porque el Task.checkCancellation de calculateFlightCosts interrumple el flujo
    - Si gestionamos el error en el Task.sleep con try?, en calculateFlightCosts se cancela el sleep, pero no lanza error, provocando que la función termine por completo. calculateHotelCosts intenta comenzar, pero al estar la task cancelada, lanza error y no se ejecuta
    - ViewModel se destruye siempre inmediatamente
 */
import SwiftUI

struct VacationPlanV4: View {
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Mars") {
                    VacationDetailsV4()
                }
            }
            .navigationTitle("Vacation trips")
        }
    }
}

struct VacationDetailsV4: View {
    @StateObject var viewModel = VacationViewModelV4()
    
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
        .onDisappear() {
            viewModel.cancel()
        }
    }
}

#Preview {
    VacationPlanV4()
}
