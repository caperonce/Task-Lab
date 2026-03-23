/**
 V6: Se navega hacia delante sin cancelar tareas
    - El ViewModel no se destruye. La weak reference no va a tener impacto alguno
    - Si no cancelamos las tasks (por ejemplo en el .onDisappear) calculateFlightCosts y calculateHotelCosts seguirán ejecutándose
 */
import SwiftUI

struct VacationPlanV6: View {
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Mars") {
                    VacationDetailsV6()
                }
            }
            .navigationTitle("Vacation trips")
        }
    }
}

struct VacationDetailsV6: View {
    @StateObject var viewModel = VacationViewModelV6()
    
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
                        DestinationDetailsV6()
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
    }
}

struct DestinationDetailsV6: View {
    
    var body: some View {
        Text("Welcome to Mars!")
    }
}

#Preview {
    VacationPlanV6()
}
