import SwiftUI

class AppState: ObservableObject {
    @Published var selectedCards: [(UIImage, String)] = []
    @Published var isSheetExpanded: Bool = false
    @Published var categoryCards: [String: [(String, String)]] = [ // Change from 'let' to '@Published var'
        "طعام": [
            ("pizza", "بيتزا"),
            ("sandwatch", "شطيرة"),
            ("juice", "عصير"),
            ("fruit", "فواكه"),
            ("rice", "ارز"),
            ("sweet", "كيك"),
            ("drink", "اشرب"),
            ("eat", "اكل"),
            ("iwant", "انا ابغى")




        ],
        "بدايه الجمله": [
            ("i want", "انا ابغى"),
            ("i dont want", "ما ابغى"),
            ("i see", "انا اشوف"),
            ("i love", "انا احب"),
          
        ],
        "محادثه": [
            ("no", "لا"),
            ("yes", "نعم"),
            ("hello", "السلام عليكم"),
            ("ok", "طيب"),
            ("thanks", "شكرا"),
            ("im fine", "انا بخير"),
            ("why", "ليش"),
            ("where", "وين"),
            ("when", "متى"),
            ("who", "مين"),
        ],
        "مشاعر": [
            ("happy", "احس بالسعاده"),
            ("sad", "احس بالحزن"),
            ("scare", "احس بالخوف"),
            ("angry", "احس بالغضب"),
            ("sick", "احس بالمرض"),
            ("hungry", "احس بالجوع")
        ],
        "افعال": [
            ("want to play", "ابغى العب"),
            ("study", "ابغى ادرس"),
            ("drawing", "ابغى ارسم"),
            ("go out", "ابغى اطلع"),
          
        ],
        "اماكن": [
            ("home", "البيت"),
            ("school", "المدرسة"),
            ("i want to go", "ابغى اروح"),
            ("market", "البقالة"),
            ("out", "برا البيت"),
            
          
        ],
        "أشخاص": [
            ("mama", "ماما"),
            ("baba", "بابا"),
            ("sister", "اختي"),
            ("brother", "اخي")
        ],
        "أساسيات": [
            ("sad", "ساعدني"),
            ("me", "انا"),
            ("you", "انت"),
            ("him", "هو"),
            ("her", "هي"),
            ("them", "هم"),
            ("same", "متشابه"),
            ("different", "مختلف"),
            ("up", "فوق"),
            ("down", "تحت"),
            ("open", "افتح"),
            ("close", "اغلق"),
        ]
    ]
}
