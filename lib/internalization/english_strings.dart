import 'package:worklyn_task/internalization/app_strings.dart';

class EnglishStrings {
  static Map<String, String> getStrings() {
    return {
      // Home screen
      AppStrings.chat: 'Chat',
      AppStrings.tasks: 'Tasks',
      AppStrings.settings: 'Settings',

      // Chat
      AppStrings.chatHint: 'What can i do for you?',
      AppStrings.success: 'Success',
      AppStrings.error: 'Error',
      AppStrings.genericErrorMessage:
          'There has been an error. Please retry later.',
      AppStrings.today: 'Today',
      AppStrings.taskCreated: 'Task Created',
      AppStrings.editTask: 'Edit task',
      AppStrings.delete: 'Delete',
      AppStrings.chooseDate: 'Choose date',
      AppStrings.addSubtask: 'Add subtask',
      AppStrings.tomorrow: 'Tomorrow',
      AppStrings.noDate: 'No date',
    };
  }
}
