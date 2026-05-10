# 📚 Student Gradebook (LR06)

Цей проєкт є виконанням лабораторної роботи **LR06: Review Session — Комплексний проєкт (Блок 1)**. Додаток реалізує повноцінний журнал оцінок студента з підтримкою кількох предметів, розрахунком статистики за шкалою **ЄКТС**, фільтрацією, сортуванням та управлінням станом через `Provider`.

🌐 **Live Demo:** [https://studentgradebook-6615a.web.app](https://studentgradebook-6615a.web.app)

---

## 🎯 Виконані завдання

Всі обов'язкові вимоги завдання успішно реалізовані:

1. **Моделі даних:**
   - Клас `Subject` із полями `id`, `name`, `icon`, приватним `_grades` та геттерами `average`, `status`, `stars`. Застосовано **Fail Fast Pattern** — валідація назви та іконки відбувається безпосередньо в ініціалізаційному списку конструктора.
   - Клас `Grade` із полями `id`, `score`, `type`, `description`, `date` та геттерами `scoreText`, `status`. Конструктор валідує діапазон балу (0–100) і непорожність опису.
   - `enum GradeType` з розширенням `GradeTypeExtension` — `label` та `icon` для кожного типу (`Exam`, `Quiz`, `Homework`, `Project`).
   - `enum GradeStatus` реалізує повну **шкалу ЄКТС**: A / B / C / D / E / FX / F.
   - Структура проєкту чітко розбита на тематичні шари: `screens/`, `models/`, `widgets/`, `providers/`, `services/`, `routes/`, `constants/`, `theme/`, `utils/`.

2. **Home Screen — список предметів:**
   - Список побудований на `ListView.builder` — жодного зайвого елемента у пам'яті.
   - Кожна картка виділена в окремий реюзабельний віджет `SubjectCard`, що відображає: emoji-іконку, назву, кількість оцінок, середній бал, зірки-рейтинг та статус ЄКТС.
   - `OverallAverageWidget` показує загальний середній бал по всіх предметах зі зірками та статусом.
   - `StatisticsWidget` відображає кількість оцінок у кожній категорії ЄКТС (A / B / C / D / E / FX / F) у вигляді `Wrap` — коректно переноситься на вузьких екранах.
   - Список реактивно оновлюється через `context.watch<GradebookProvider>()`.

3. **Додавання оцінки:**
   - Відкривається `AddGradeDialog` — `StatefulWidget` із повноцінною `Form` та `GlobalKey<FormState>`.
   - `DropdownButtonFormField` для вибору типу оцінки (Exam / Quiz / Homework / Project).
   - Кнопка вибору дати через `showDatePicker` із перевіркою `if (!mounted) return` після `await`.
   - `AutovalidateMode.onUserInteraction` — валідація вмикається одразу після першого дотику до поля.
   - `TextEditingController` ініціалізуються в `initState()` та коректно знищуються в `dispose()`.

4. **Розрахунки та шкала ЄКТС:**
   - Середній бал предмету — через `fold()` на списку оцінок.
   - Загальний середній бал — через `GradebookStatisticsService.calculateOverallSummary()`.
   - Шкала ЄКТС: **A** (91–100), **B** (83–90.9), **C** (76–82.9), **D** (68–75.9), **E** (61–67.9), **FX** (20–60.9), **F** (0–19.9).
   - Зірковий рейтинг: ⭐⭐⭐⭐⭐ (≥91), ⭐⭐⭐⭐ (≥76), ⭐⭐⭐ (≥61), ⭐⭐ (<61).

5. **Subject Details Screen + видалення:**
   - `SubjectDetailsScreen` — `StatefulWidget` із відображенням emoji, середнього балу, зірок, статусу та кількості оцінок.
   - Список оцінок через `ListView.builder`.
   - Видалення через `Dismissible` (swipe-to-delete) із підтвердженням у `SnackBar`.
   - Після видалення/додавання UI миттєво оновлюється через Provider.

---

## 🌟 Реалізовані бонусні завдання

Окрім базового функціоналу, реалізовано **всі три** опціональні бонусні варіанти:

- [x] **Варіант A: Сортування.** Предмети сортуються по середньому балу (⬇ вищі / ⬆ нижчі) через `HomeSortMenu` у `AppBar`. Оцінки у деталях предмету сортуються по даті та балу (4 режими).
- [x] **Варіант B: Фільтрація.** Оцінки фільтруються по статусу ЄКТС (All / A / B / C / D / E / FX / F) та по типу (All / Exam / Quiz / Homework / Project) через `GradeFiltersBar`.
- [x] **Варіант C: Empty State.** Коли предметів або оцінок немає — відображається `EmptyStateWidget` із іконкою `Icons.inbox`, основним і допоміжним повідомленням.

---

## 🏗️ Додаткові архітектурні рішення

Реалізовано ряд покращень, що виходять за межі вимог завдання:

- **State Management (Provider):** Весь стан журналу зберігається в `GradebookProvider extends ChangeNotifier`. Предмети та оцінки доступні лише через `List.unmodifiable()` — зовнішній код не може мутувати дані напряму.
- **Sealed class `AppError`:** Замість сирих `Exception`, помилки валідації кидаються через типобезпечний `ValidationError extends AppError`. Компілятор гарантує обробку всіх кейсів у `switch`.
- **Сервісний шар:** `GradebookStatisticsService` відповідає виключно за розрахунок статистики; `GradebookSeedService` — за генерацію початкових даних; `DateFormatter` — за форматування дат. Жодна бізнес-логіка не живе у `build()`.
- **Design Tokens:** Всі рядки (`AppStrings`), розміри (`AppDimensions`), мітки фільтрів (`FilterLabels`) та seed-дані (`SeedConstants`) централізовані. Зміна будь-якого значення потребує правки лише в одному місці.
- **Named Routes:** Навігацію централізовано у `AppRoutes.onGenerateRoute`. Усі шляхи зберігаються у `AppRouteNames` як константи.
- **Reusable Widgets:** `SubjectCard`, `GradeListItem`, `SubjectStatsWidget`, `OverallAverageWidget`, `StatisticsWidget`, `EmptyStateWidget`, `SectionHeader` — кожен відповідає за одну задачу та може бути повторно використаний.
- **`dart analyze` — No issues found.** Код відповідає всім правилам `flutter_lints`.

---

## 🚀 Як запустити

1. Переконайтеся, що встановлений [Flutter](https://flutter.dev/docs/get-started/install) версії **3.24.0+**.
2. Відкрийте папку проєкту в терміналі.
3. Оновіть залежності:
   ```bash
   flutter pub get
   ```
4. Запустіть додаток:
   ```bash
   flutter run
   ```
5. Перевірте якість коду:
   ```bash
   dart analyze
   dart format .
   ```

---

## 👤 Автор

| Поле | Деталі |
| :--- | :--- |
| **Студент** | Войтюк Назарій |
| **Група** | КН-311 |
| **Варіант** | B — Student Gradebook |
| **Live Demo** | [studentgradebook-6615a.web.app](https://studentgradebook-6615a.web.app) |
