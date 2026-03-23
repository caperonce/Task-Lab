/**
 V7: Se navega hacia delante y se cancelan tareas
    - El ViewModel no se destruye. La weak reference no va a tener impacto alguno
    - Cuando se navega hacia adelante, se cancelan calculateFlightCosts y calculateHotelCosts. Interrumpen su ejecución
 */
import SwiftUI

struct VacationPlanV7: View {
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Mars") {
                    VacationDetailsV7()
                }
            }
            .navigationTitle("Vacation trips")
        }
    }
}

struct VacationDetailsV7: View {
    @StateObject var viewModel = VacationViewModelV7()
    
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
            
            NavigationStack {
                List {
                    NavigationLink("Read details") {
                        DestinationDetailsV7()
                    }
                }
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

struct DestinationDetailsV7: View {
    
    var body: some View {
        Text("Welcome to Mars!")
    }
}

#Preview {
    VacationPlanV7()
}
