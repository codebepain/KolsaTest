# KolsaTest

## Описание

KolsaTest — это тестовое iOS-приложение для отображения списка товаров с возможностью сортировки и просмотра подробной информации о каждом товаре. Данные о товарах загружаются из локального JSON-файла.

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
- `Modules/ProductList/` — основной модуль со списком товаров (View, ViewModel, Model, Services)
- `Modules/ProductDetail/` — модуль с деталями товара
- `Common/UI/` — общие UI-компоненты
- `DI/` — контейнер и сборка зависимостей
- `Extensions/` — расширения UIKit
- `Resources/` — ассеты, Info.plist, LaunchScreen, products.json

## Запуск проекта

1. Откройте `KolsaTest.xcodeproj` в Xcode (минимальная версия Xcode — 15, iOS Deployment Target — 18.0).
2. Соберите и запустите проект на симуляторе или устройстве.

## Автор
Владимир Орлов 