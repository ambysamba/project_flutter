# 📰 Flutter News App

Une application mobile développée avec **Flutter** permettant d’afficher les dernières actualités via une interface simple et élégante. Les utilisateurs peuvent consulter des articles, les lire dans une WebView intégrée et ajouter leurs favoris.

---

## 📷 Aperçu

<img src="screenshots/home_screen.png" width="300"/> <img src="screenshots/detail_screen.png" width="300"/>

---

## 🚀 Fonctionnalités

- ✅ Liste d’articles depuis une API ou source web
- 🌐 Lecture intégrée via `WebView`
- ❤️ Gestion des favoris (ajout/suppression en local)
- 💬 Affichage des commentaires (si disponible)
- 📱 Design responsive adapté aux mobiles

---

## 🧰 Technologies utilisées

- **Flutter**
- `webview_flutter`
- `http`
- `provider` ou `setState` (selon ta logique)
- SQLite (pour les favoris, optionnel)

---

## 📦 Installation

```bash
git clone https://github.com/ton-utilisateur/flutter_news.git
cd flutter_news
flutter pub get
```

---

## 📄 Structure du projet

- `lib/` : Code source principal
- `test/` : Tests unitaires
- `screenshots/` : Captures d’écran

---

## 📝 Personnalisation

Ajoutez vos propres sources de news, modèles de données, et UI selon vos besoins.

---

## 🏁 Démarrage rapide

1. Installez Flutter : https://docs.flutter.dev/get-started/install
2. Ouvrez ce dossier dans VS Code
3. Exécutez `flutter pub get` pour installer les dépendances
4. Lancez l’application avec `flutter run`
