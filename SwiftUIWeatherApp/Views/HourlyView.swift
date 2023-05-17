//
//  HourlyView.swift
//  SwiftUIWeatherApp
//
//  Created by Ben Pearman on 2023-02-02.
//

import SwiftUI

struct HourlyView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {

                ForEach(viewModel.hourlyData) { model in
                    HourView(model: model)
                }
            }
        }
    }
}

struct HourView: View {
    var model: HourData
    
    var body: some View {
        VStack {
            //image, temp, hour
            AsyncImage(url: URL(string: model.imageURL)!, content: { image in
                image
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }, placeholder: {
                ProgressView()
            })
            .frame(width: 35, height: 35, alignment: .center)
            
            Text(model.temp)
                .foregroundColor(.white)
            Text(model.hour)
                .foregroundColor(.white)
        }
        .padding()
    }
}

struct HourlyView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView()
    }
}
