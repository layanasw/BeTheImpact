import SwiftUI

class AppState: ObservableObject {
    @Published var selectedCards: [(UIImage, String)] = []
    @Published var isSheetExpanded: Bool = false
    @Published var categoryCards: [String: [(String, String)]] = [ // Change from 'let' to '@Published var'
        "طعام": [
            ("pizza", "بِيتزا"),
            ("sandwatch", "شَطِيرَة"),
            ("juice", "عصير"),
            ("fruit", "فواكه"),
            ("rice", "ارُز"),
            ("sweet", "كيك"),
            ("drink", "اشْرَب"),
            ("eat", "آَكُل"),
            ("iwant", "انا اَبْغَى")




        ],
        "بدايه الجمله": [
            ("i want", "انا أبي"),
            ("i dont want", "انا ما أبي"),
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
            ("happy", "أُحِسُّ بالسعاده"),
            ("sad", "أُحِسُّ بالحزن"),
            ("scare", "أُحِسُّ بالخوف"),
            ("angry", "أُحِسُّ بالغضب"),
            ("sick", "أُحِسُّ بالمرض"),
            ("hungry", "أُحِسُّ بالجوعِ")
        ],
        "افعال": [
            ("want to play", "ابي أَلعَب"),
            ("study", "ابي أدْرُس"),
            ("drawing", "ابي أرْسُم"),
            ("go out", "ابي أَطْلَع"),
          
        ],
        "اماكن": [
            ("home", "البيت"),
            ("school", "المَدْرَسَة"),
            ("i want to go", "ابي اروح"),
            ("market", "البْقّالَة"),
            ("out", "برَّا البيت"),
            
          
        ],
        "أشخاص": [
            ("mama", "مَامَا"),
            ("baba", "بابا"),
            ("sister", "اختي"),
            ("brother", "اخي")
        ],
        "أساسيات": [
            ("sad", "ساعدني"),
            ("me", "أنا"),
            ("you", "أنْت"),
            ("him", "هُو"),
            ("her", "هِي"),
            ("them", "هُم"),
            ("same", "متشابه"),
            ("different", "مختلف"),
            ("up", "فَوق"),
            ("down", "تَحت"),
            ("open", "إِفْتَح"),
            ("close", "أَغْلِق"),
        ]
    ]
}
