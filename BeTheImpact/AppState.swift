import SwiftUI

class AppState: ObservableObject {
    @Published var selectedCards: [(UIImage, String)] = []
    @Published var isSheetExpanded: Bool = false
    @Published var categoryCards: [String: [(String, String)]] = [ // Change from 'let' to '@Published var'
        "طعام": [
            ("pizza", "بيتزا"),
            ("sandwatch", "ساندوتش"),
            ("juice", "عصير"),
            ("fruit", "فواكه"),
            ("rice", "ارز"),
            ("sweet", "كيك")
        ],
        "مشاعر": [
            ("happy", "احس بالسعاده"),
            ("sad", "احس بالحزن"),
            ("scare", "احس بالخوف"),
            ("angry", "احس بالغضب"),
            ("sick", "احس بالمرض"),
            ("hungry", "احس بالجوع")
        ],
        "أشخاص": [
            ("mam", "ماما"),
            ("dad", "بابا"),
            ("sister", "اختي"),
            ("brother", "اخوي")
        ]
    ]
}
