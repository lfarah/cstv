import UIKit

var greeting = "Hello, playground"

let dateFormatter: DateFormatter = {
    let relativeDateFormatter = DateFormatter()
    relativeDateFormatter.timeStyle = .short
    relativeDateFormatter.dateStyle = .short
    relativeDateFormatter.
    relativeDateFormatter.locale = Locale(identifier: "pt_BR")
//    relativeDateFormatter.doesRelativeDateFormatting = true
    return relativeDateFormatter
}()

dateFormatter.string(from: Date(timeIntervalSinceNow: 1000000))
