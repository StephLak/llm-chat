import 'package:get/get.dart';
import 'package:worklyn_task/internalization/english_strings.dart';

class AppStrings extends Translations {
  // Home Screen
  static const String chat = 'chat';
  static const String tasks = 'tasks';
  static const String settings = 'settings';

  // Chat
  static const String chatHint = 'chatHint';
  static const String success = 'success';
  static const String error = 'error';
  static const String genericErrorMessage = 'genericErrorMessage';
  static const String today = 'today';
  static const String taskCreated = 'taskCreated';
  static const String editTask = 'editTask';
  static const String delete = 'delete';
  static const String chooseDate = 'chooseDate';
  static const String addSubtask = 'addSubtask';
  static const String tomorrow = 'tomorrow';
  static const String noDate = 'noDate';

  @override
  Map<String, Map<String, String>> get keys => {
    // English
    'en': EnglishStrings.getStrings(),
  };
}
