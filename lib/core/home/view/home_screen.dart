import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:worklyn_task/constants/app_colors.dart';
import 'package:worklyn_task/constants/app_text_styles.dart';
import 'package:worklyn_task/core/home/controller/home_controller.dart';
import 'package:worklyn_task/core/home/model/navbar_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.tabIndex.value,
          backgroundColor: AppColors.navBackgroundColor,
          onTap: controller.changeTabIndex,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.textColor,
          selectedLabelStyle: AppTextStyles.mediumTextStyle(),
          unselectedLabelStyle: AppTextStyles.mediumTextStyle(),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          items:
              NavbarItems.all.indexed.map(((int, NavbarItem) item) {
                final (index, navbarItem) = item;
                return BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    navbarItem.icon,
                    color: AppColors.textColor,
                  ),
                  activeIcon: SvgPicture.asset(
                    navbarItem.icon,
                    color: AppColors.primaryColor,
                  ),
                  label: navbarItem.label,
                );
              }).toList(),
        ),

        body: controller.screens[controller.tabIndex.value],
      ),
    );
  }
}
