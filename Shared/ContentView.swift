//
//  ContentView.swift
//  Shared
//
//  Created by Tomas Gesino on 25/07/2021.
//

import SwiftUI

struct ContentView: View {
    @State var userText: String = ""
    var NOTION_KEY = ""
    var NOTION_DATABASE_ID = ""
    var body: some View {
        ZStack{
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            VStack{
                Text("Simple Notion")
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color("TextColor")/*@END_MENU_TOKEN@*/)
                    .font(.largeTitle)
                    .padding()
                HStack{
                    TextField("text", text: $userText)
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color("TextColor")/*@END_MENU_TOKEN@*/)
                        .background(Color("BackgroundColor"))
                        .padding()
                    Button(action: {post()}, label: {
                        Text("Submit to Notion")
                    })
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color("ShadowColor")/*@END_MENU_TOKEN@*/)
                    .padding()
                    .shadow(color: Color("TextColor"), radius: 10, x: 0, y: 0)
                    
                }
                .padding()
                Spacer()
                Text("v 1.0")
                    .font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/)
                    .padding()
            }
        }
    }
    func post() {
        if userText != "" {
            guard let url = URL(string: "https://api.notion.com/v1/pages") else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("Bearer \(NOTION_KEY)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("2021-05-13", forHTTPHeaderField: "Notion-Version:")
        // TODO: - Figure out how to do body
        /*
             --data "{
                 \"parent\": { \"database_id\": \"$NOTION_DATABASE_ID\" },
                 \"properties\": {
                   \"title\": {
                     \"title\": [
                       {
                         \"text\": {
                           \"content\": \"userText\"
                         }
                       }
                     ]
                   }
                 }
               }"
        */
            request.httpBody = "".data(using: .utf8)!

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                print(error as Any)
            }.resume()
        } else {
            print("error")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
