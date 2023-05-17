//
//  ContentView.swift
//  SwiftUIWeatherApp
//
//  Created by Ben Pearman on 2023-02-02.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, Color(.link), .pink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    HeaderView()
                    HourlyView()
                    DailyView()
                    
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
