//
//  MapView.swift
//  Move
//
//  Created by Silviu Preoteasa on 30.08.2022.
//

import SwiftUI
import MapKit



struct MapContainerScreen: View{
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            ScooterMapView(viewModel: viewModel.mapViewModel)
            HStack {
                Button {
                    print("menu")
                } label: {
                    Image(ImagesEnum.goToMenuPin.rawValue)
                }
                .buttonStyle(.simpleMapButton)
                
                Spacer()
                
                Button {
                    print("center")
                } label: {
                    Image(ImagesEnum.centerMapOnUserPin.rawValue)
                }
                .buttonStyle(.simpleMapButton)
            }.padding(.vertical, 64)
                .padding(.horizontal, 24)
            
            selectedScooterView
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding(.vertical, 46)
                
        }.onAppear{
            viewModel.loadScooters()
        }
    }
    @ViewBuilder
    var selectedScooterView: some View {
        if let selectedScooter = viewModel.selectedScooter {
            withAnimation {
                ScooterCardView(scooterData: selectedScooter.scooterData)
            }
        }
    }
}


extension MapContainerScreen {
    class ViewModel: ObservableObject {
        @Published var selectedScooter: ScooterAnnotation?
        var mapViewModel: ScooterMapViewModel = .init()
        
        init () {
//            mapViewModel = ScooterMapViewModel(scooters: ScooterAnnotation.requestMockData())
            mapViewModel.onSelectedScooter = { scooter in
                self.selectedScooter = scooter
            }
            
            mapViewModel.onDeselectedScooter = {
                self.selectedScooter = nil
            }
            
        }
        
        func loadScooters() {
            mapViewModel.scooters = ScooterAnnotation.requestMockData()
        }
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapContainerScreen()
            .ignoresSafeArea()
    }
}