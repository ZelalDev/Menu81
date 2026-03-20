# 🍽️ Menü 81

> KYK yurtlarında kalan üniversite öğrencileri için günlük yemek takip uygulaması.

<p align="center">
  <img src="Screenshots/home.png" alt="Menü 81 Ana Ekran" width="300"/>
</p>

---

## 📱 Uygulama Hakkında

**Menü 81**, Türkiye'deki KYK (Kredi ve Yurtlar Kurumu) yurtlarında kalan üniversite öğrencilerinin günlük **kahvaltı** ve **akşam yemeği** menülerini kolayca takip etmelerini sağlayan bir iOS uygulamasıdır.

Uygulama açıldığı anda seni **bugünün menüsü** karşılar — gereksiz adım yok, hızlı ve sade.

---

## ✨ Özellikler

- 📅 **Günlük Menü Görünümü** — Uygulama açılınca direkt bugünün menüsü ekrana gelir
- 🔄 **Tarih Şeridi** — Yatay kaydırılabilir tarih çubuğuyla diğer günlere kolayca geçiş
- 🌅 **Öğün Ayrımı** — Kahvaltı ve akşam yemeği görsel olarak net biçimde birbirinden ayrılmış
- 🔥 **Kalori Bilgisi** — Her öğün için ayrı kalori + günlük toplam kalori gösterimi
- 🌙 **Dark Mode Desteği** — Sistem temasını otomatik takip eder
- ⚡ **Hızlı & Sade** — Minimalist tasarım, gereksiz adım yok

---

## 🛠️ Teknoloji

| Katman | Teknoloji |
|---|---|
| Dil | Swift 5.9+ |
| UI Framework | SwiftUI |
| Mimari | MVVM |
| Veri | Yerel JSON (ileride uzak API) |
| Min. iOS | iOS 17.0 |

---

## 📁 Proje Yapısı

```
Menu81/
├── Menü81App.swift              # Uygulama giriş noktası
│
├── Models/
│   └── Menu.swift               # Menu, Meal, MealType modelleri
│
├── ViewModels/
│   └── MenuViewModel.swift      # Veri yükleme ve durum yönetimi
│
├── Views/
│   ├── HomeView.swift           # Ana ekran
│   ├── Components/
│   │   ├── DayTabView.swift     # Yatay tarih şeridi
│   │   ├── MealCardView.swift   # Öğün kartı bileşeni
│   │   └── MenuDayView.swift    # Günlük tam görünüm
│   └── Styles/
│       └── AppTheme.swift       # Renkler, spacing, tipografi
│
├── Utilities/
│   └── DateExtensions.swift     # Türkçe tarih formatlama
│
└── Resources/
    └── menu_data.json           # Örnek menü verisi
```

---

## 🚀 Kurulum

### Gereksinimler

- macOS 14.0+
- Xcode 15.0+
- iOS 17.0+ (simülatör veya gerçek cihaz)

### Adımlar

```bash
# 1. Repoyu klonla
git clone https://github.com/kullanici-adin/menu81.git

# 2. Xcode ile aç
cd menu81
open Menu81.xcodeproj
```

3. Xcode'da hedef cihazı seç (simülatör veya gerçek iPhone)
4. `Cmd + R` ile çalıştır

> Harici bağımlılık yok — CocoaPods veya Swift Package Manager kurulumu gerekmez.

---

## 📊 Veri Yapısı

Menü verisi aşağıdaki JSON formatında tutulmaktadır:

```json
{
  "menus": [
    {
      "date": "2025-06-09",
      "breakfast": {
        "items": ["Beyaz Peynir", "Zeytin", "Çay"],
        "calories": 480
      },
      "dinner": {
        "items": ["Mercimek Çorbası", "Tavuk Sote", "Ekmek"],
        "calories": 720
      },
      "totalCalories": 1200
    }
  ]
}
```

---

## 🗺️ Yol Haritası

- [x] Yerel JSON ile temel menü görüntüleme
- [x] Yatay tarih şeridi navigasyonu
- [x] Kahvaltı / akşam yemeği kart tasarımı
- [x] Kalori bilgisi gösterimi
- [x] Dark mode desteği
- [ ] Uzak API entegrasyonu
- [ ] Widget desteği (iOS Lock Screen & Home Screen)
- [ ] Favori yemek işaretleme
- [ ] Bildirim desteği (öğün saatlerinde hatırlatma)
- [ ] Tüm iller için yurt menüsü desteği

---

## 🤝 Katkı

Pull request'ler memnuniyetle karşılanır. Büyük değişiklikler için önce bir issue açman önerilir.

1. Forkladıktan sonra feature branch oluştur (`git checkout -b feature/yeni-ozellik`)
2. Değişikliklerini commit et (`git commit -m 'feat: yeni özellik eklendi'`)
3. Branch'ini push et (`git push origin feature/yeni-ozellik`)
4. Pull Request aç

---

## 📄 Lisans

Bu proje [MIT Lisansı](LICENSE) ile lisanslanmıştır.

---

<p align="center">
  Türkiye'deki tüm yurt öğrencileri için ❤️ ile yapılmıştır.
</p>
