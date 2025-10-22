//
//  TestView.swift
//  AwesomeMailer
//
//  Created by Will Frost on 15/08/2024.
//

import Foundation
import SceneKit
import SwiftUI


//Calcuting the date from today to years end.
func yearProgress() -> Double {
    let currentDate = Date()
    
    // Create a date formatter to set the target date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    // Start of the year
    let startOfYear = dateFormatter.date(from: "2024-01-01")!
    
    // Start of next year
    let startOfNextYear = dateFormatter.date(from: "2027-12-16")!
    
    // Total time interval for the year
    let totalYearInterval = startOfNextYear.timeIntervalSince(startOfYear)
    
    // Time interval from start of year to current date
    let currentInterval = currentDate.timeIntervalSince(startOfYear)
    
    // Calculate the progress
    let progress = (currentInterval / totalYearInterval)
    
    return progress
}



//My Mars Object Struct
struct MarsPlanetView: UIViewRepresentable {
    @State private var dragAmount = CGSize.zero
    
    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        scnView.scene = createScene()
        scnView.autoenablesDefaultLighting = true
        scnView.allowsCameraControl = true
        scnView.backgroundColor = UIColor.clear
        return scnView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {}
    
    func createScene() -> SCNScene {
        let scene = SCNScene()
        
        // Create camera node
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 15, z: 30)
        // Tilt the camera downwards
        cameraNode.eulerAngles.x = -.pi / 6  // Tilt by 30 degrees
        scene.rootNode.addChildNode(cameraNode)
        
        if let url = Bundle.main.url(forResource: "Mars", withExtension: "usdz")
        {
            let customNode = SCNReferenceNode(url: url)!
            customNode.load()
            customNode.position = SCNVector3(0, -2, 0)
            customNode.scale = SCNVector3(15, 15, 15)
            scene.rootNode.addChildNode(customNode)
            
            // Add rotation animation
            let rotateAction = SCNAction.rotateBy(
                x: 5, y: 2 * .pi, z: 0, duration: 50)
            let repeatAction = SCNAction.repeatForever(rotateAction)
            customNode.runAction(repeatAction)
            
        }
        
        return scene
    }
}

//The view the User sees.
struct SceneKit: View {
    //return days left and show year progress bar
    @State private var progress = yearProgress()
    @State private var dragAmount = CGSize.zero
    @State private var wobble = false
    @State private var homeView = false
    @State private var showAlert = true // State to control the alert visibility
    
    var body: some View {
        VStack {
            VStack {
                
                //The top of the Pass
                HStack {
                    Text("Mars Pass")
                        .font(.title)
                        .fontWeight(Font.Weight.heavy)
                        .frame(alignment: .leading)
                        .padding(.top)
                        .padding(.leading)
                        .padding(.trailing)
                    
                    Text(
                        "Estimated time of arrival to the planet: 16th Dec 2024."
                    )
                    .font(.caption)
                    .fontWeight(Font.Weight.light)
                    .frame(alignment: .trailing)
                    .padding(.top)
                    .padding(.trailing)
                    
                }
                
                //The Mars View
                MarsPlanetView()
                    .frame(
                        width: .infinity, height: 300,
                        alignment: .topLeading
                    )
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(20)
                    .padding(.horizontal)
                
                //The Main Words View
                HStack {
                    Image(systemName: "airplane.departure")
                        .padding()
                    ProgressView(value: progress)
                    Image(systemName: "airplane.arrival")
                        .padding()
                }
                
                Text("To Mars")
                    .font(.largeTitle)
                    .fontWeight(Font.Weight.heavy)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.bottom, 5)
                
                Text(
                    "Come to Mars today! For only $100, you can experience the wonders of Mars."
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                Text("$100 Cost")
                    .font(.largeTitle)
                    .fontWeight(Font.Weight.heavy)
                    .padding(.vertical)
            }
            //All the modifiers that allow the card to look like a ticket.
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.orange, .orangeMars]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.9, green: 0.2, blue: 0.2),  // Bright red-orange center
                        Color(red: 0.1, green: 0.1, blue: 0.4),  // Dark blue outer
                    ]),
                    center: .center,
                    startRadius: 50,
                    endRadius: 300
                ).opacity(0.2)
            )
            .cornerRadius(20)
            .padding(.horizontal)
            .offset(dragAmount)
            .animation(
                wobble ? .easeInOut(duration: 0.2) : .none, value: dragAmount
            )
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        //Wobble the tile
                        dragAmount = CGSize(
                            width: gesture.translation.width / 5,
                            height: gesture.translation.height / 5)
                        wobble = true
                    }
                    .onEnded { _ in
                        // Reset to original position
                        dragAmount = .zero
                        wobble = false
                    }
            )
            .rotation3DEffect(
                Angle(degrees: -Double(dragAmount.width / 10)),  // Horizontal tilt
                axis: (x: 0.0, y: 5.0, z: 0.0)
            )
            .rotation3DEffect(
                Angle(degrees: Double(dragAmount.height / 10)),  // Vertical tilt
                axis: (x: 5.0, y: 0.0, z: 0.0)
            )
            .animation(.easeInOut(duration: 0.2), value: dragAmount)
            
            Button(action: {
                //Changed this so that it doesn't take anyone away from the main page.
                homeView = true
            }) {
                Text("Join Mars Pass")
                    .padding(.all)
                    .background(Capsule().fill(Color.blue))
                    .foregroundColor(.white)
                    .padding(.all)
                
            }.frame(alignment: .bottomLeading)
        }  //This is the func that shifts the view
        .fullScreenCover(isPresented: $homeView) {
            HomeView()
        }
        .alert("Swift Feature", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Touch and drag the Mars Pass Card around.")
        }
    }
}

#Preview {
    SceneKit()
}
