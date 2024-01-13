# SerpApiTestApp

This demo application, written in SwiftUI was created to test out SerpApi's Google flights API found here: https://serpapi.com/google-flights-api. 

Data is populated to Firestore from a Python script that's being run in Pythonista via scheduled iOS Shortcuts on an iPad Pro. The SwiftUI application is then pulling down the Firestore data and using it to generate a graph for viewing on MacOS. 
