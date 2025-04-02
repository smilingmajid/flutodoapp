# Flutter Todo App

این پروژه با استفاده از معماری MVC (Model-View-Controller) توسعه داده شده است.

## ساختار پروژه

```
lib/
├── models/         # مدل‌های داده
├── views/          # صفحات و رابط‌های کاربری
├── controllers/    # کنترلرها و منطق برنامه
├── services/       # سرویس‌های خارجی و API
├── utils/          # توابع کمکی و ثابت‌ها
└── widgets/        # ویجت‌های قابل استفاده مجدد
```

## توضیحات پوشه‌ها

### Models
- تعریف ساختار داده‌ها
- کلاس‌های مدل
- مثال: `TodoModel`, `UserModel`

### Views
- صفحات اصلی برنامه
- رابط‌های کاربری
- مثال: `HomePage`, `TodoListPage`

### Controllers
- مدیریت منطق برنامه
- ارتباط بین Model و View
- مثال: `TodoController`, `AuthController`

### Services
- سرویس‌های خارجی
- ارتباط با API‌ها
- مثال: `ApiService`, `DatabaseService`

### Utils
- توابع کمکی
- ثابت‌ها
- مثال: `constants.dart`, `helpers.dart`

### Widgets
- ویجت‌های قابل استفاده مجدد
- کامپوننت‌های مشترک
- مثال: `CustomButton`, `TodoItem`

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
