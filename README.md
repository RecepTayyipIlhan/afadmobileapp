# afad_app

generate files:
`dart run build_runner build`

deploy on web:

```
flutter pub get
flutter build web --target lib/main_afad.dart
firebase deploy --only hosting
```