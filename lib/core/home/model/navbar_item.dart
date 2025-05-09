import 'package:worklyn_task/constants/app_icons.dart';

// Navbar Item Model
class NavbarItem {
  final String icon;
  final String label;

  NavbarItem({required this.icon, required this.label});
}

// Home Navbar Item
class NavbarItems {
  static List<NavbarItem> all = [
    NavbarItem(icon: AppIcons.chat, label: 'Chat'),
    NavbarItem(icon: AppIcons.tasks, label: 'Tasks'),
    NavbarItem(icon: AppIcons.settings, label: 'Settings'),
  ];
}
