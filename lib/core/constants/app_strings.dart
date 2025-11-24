class AppStrings {
  // -----------------------------------------------------------------------
  // 1. Общие элементы интерфейса и заголовки
  // -----------------------------------------------------------------------

  static const String appName = 'Todo';
  static const String addTaskTitle = 'Создание Задачи';
  static const String buttonSave = 'Сохранить';
  static const String buttonCancel = 'Отмена';
  static const String placeholderBody = 'Здесь будут отображаться задачи';


  // -----------------------------------------------------------------------
  // 2. Статусы задач (Главный экран)
  // Соответствуют: К выполнению, В работе, На проверке, Выполнено
  // -----------------------------------------------------------------------

  static const String statusTodo = 'К выполнению';
  static const String statusInProgress = 'В работе';
  static const String statusForReview = 'На проверке';
  static const String statusDone = 'Выполнено';

  // Список всех статусов для удобства
  static const List<String> taskStatuses = [
    statusTodo,
    statusInProgress,
    statusForReview,
    statusDone,
  ];

  // -----------------------------------------------------------------------
  // 3. Элементы экрана добавления/редактирования задачи
  // -----------------------------------------------------------------------

  // Placeholder/Hint для поля ввода задачи (названия)
  static const String hintTaskName = 'Введите название задачи...';

  // Label/Hint для поля ввода срока истекания
  static const String labelDeadline = 'Срок истекания';
}