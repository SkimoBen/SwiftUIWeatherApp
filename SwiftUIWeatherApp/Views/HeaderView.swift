//
//  HeaderView.swift
//  SwiftUIWeatherApp
//
//  Created by Ben Pearman on 2023-02-02.
//

import SwURL
import SwiftUI

//the header of the app displays city, icon, and current temp
struct HeaderView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack(spacing: -15) {
            Text(viewModel.headerViewModel.location)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 36))
                .padding()
            
            AsyncImage(url: URL(string: viewModel.headerViewModel.iconURLString), content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }, placeholder: {
                ProgressView()
            })
            .frame(width: 220, height: 220, alignment: .center)
                
// This block is what the tutorial recommends. it used the SwUrl package. But it seems like the Swurl package doesn't work with IOS 16
            
//            RemoteImageView(
//                url: URL(string: viewModel.headerViewModel.iconURLString)!,
//                placeholderImage: Image(systemName: "cloud.sun.fill"),
//                transition: .none
//            )
//            .imageProcessing({ image in
//                return image
//                    .resizable()
//                    .renderingMode(.template)
//                    .aspectRatio(contentMode: .fit)
//            })
            
//            Image(systemName: "cloud.sun.fill")
//                .renderingMode(.original)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width:220, height: 220, alignment: .center)
            
            Text(viewModel.headerViewModel.currentTemp)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 90))
                .padding()
                .padding(.top, -10)
            Text(viewModel.headerViewModel.currentConditions)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 45))
                .padding()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
