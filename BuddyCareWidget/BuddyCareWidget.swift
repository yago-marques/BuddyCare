//
//  BuddyCareWidget.swift
//  BuddyCareWidget
//
//  Created by Gabriel Santiago on 20/06/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), timer: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), timer: 0)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let frequency = 8
        for hourOffset in 0 ..< frequency {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entryTimer = Calendar.current.component(.hour, from: currentDate)
            let entry = SimpleEntry(date: entryDate, timer: entryTimer + frequency)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let timer: Int
}

struct BuddyCareWidgetEntryView : View {
    var entry: Provider.Entry

//    let hour = entry.date.

    var body: some View {
        ZStack{
            ContainerRelativeShape()
                .fill(Gradient(colors: [Color("WidgetColorOne"), Color("WidgetColorTwo")]))
            VStack {
                Text("Next bath")
                    .padding(.bottom, -10)
                    .font(.custom("StayPixel-Regular", size: 20))
                    .foregroundColor(.white)
                Image("Soap")
                    .resizable()
                    .frame(width: 80, height: 80)
                Text("\(entry.timer - 9) days")
                    .fontWeight(.bold)
                    .font(.system(size: 20, design: .rounded))
                    .foregroundColor(.white)
                    .font(.system(size: 22))
            }
        }
    }
}

struct BuddyCareWidget: Widget {
    let kind: String = "BuddyCareWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            BuddyCareWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Pet Bath")
        .description("See when's your next pet hygiene time")
    }
}

struct BuddyCareWidget_Previews: PreviewProvider {
    static var previews: some View {
        BuddyCareWidgetEntryView(entry: SimpleEntry(date: Date(), timer: 0))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
