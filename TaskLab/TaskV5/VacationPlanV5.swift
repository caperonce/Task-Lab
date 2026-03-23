/**
 V5: Se usa cancel y weak reference
    - La diferencia con el anterior caso es que el deinit se ejecuta antes que el catch
    - Esto puede provocar efectos no deseados, por ejemplo dependiendo de la gestión del error que necesitemos hacer. Si, por ejemplo, necesitamos restaurar el estado de la app a la cancelación de una task, podríamos haber perdido ya la referencia a self y no completar esa restauración
 */
import SwiftUI

struct VacationPlanV5: View {
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Mars") {
                    VacationDetailsV5()
                }
            }
            .navigationTitle("Vacation trips")
        }
    }
}

struct VacationDetailsV5: View {
    @StateObject var viewModel = VacationViewModelV5()
    
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
    VacationPlanV5()
}
