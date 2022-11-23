//
//  ContentView.swift
//  Beautiful Weather App
//
//  Created by Nikita on 22.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            
            if let location = locationManager.location {
                if let weather = weather {
                    Text("Weather data fetched")
                } else {
                    LoadingView()
                        .task {
                            do {
                                try await weatherManager.getCurrentWeather(lat: location.latitude, long: location.longitude)
                            } catch {
                                print("Error getting weather")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
            
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
