# KolsaTest

## Описание

Тестовое iOS-приложение для отображения списка товаров с возможностью сортировки и просмотра подробной информации о каждом товаре. Данные о товарах загружаются из локального JSON-файла.

## Технический стек

- Swift 5
- UIKit
- Combine (для реактивного связывания ViewModel и View)
- Архитектура MVVM
- DI (Dependency Injection) через собственный контейнер
- Storyboard используется только для LaunchScreen
- Работа с локальными ресурсами (JSON)

## Структура проекта

- `App/` — точка входа приложения (AppDelegate, SceneDelegate)
- `Modules/` — модули проекта (`ProductList, ProductDetail`)
- `Common/` — общие компоненты
- `DI/` — контейнер и сборка зависимостей
- `Extensions/` — расширения
- `Resources/` — Assets, Info.plist, LaunchScreen, products.json

## Запуск проекта

1. Откройте `KolsaTest.xcodeproj` в Xcode (минимальная версия Xcode — 15, iOS Deployment Target — 18.0).
2. Соберите и запустите проект на симуляторе или устройстве.
