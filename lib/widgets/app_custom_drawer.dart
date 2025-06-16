import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/application/chat/unread_message_count_cubit.dart';
import 'package:travel_hero/src/application/login_register/app_user_cubit.dart';
import 'package:travel_hero/src/application/main/cubit/drawer_cubit.dart';
import 'package:travel_hero/src/application/main/cubit/main_navbar_cubit.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:travel_hero/widgets/switch_account_widget.dart';
import 'package:widgets_book/widgets_book.dart';

class AppCustomDrawer extends StatefulWidget {
  const AppCustomDrawer({super.key});

  @override
  State<AppCustomDrawer> createState() => _AppCustomDrawerState();
}

class _AppCustomDrawerState extends State<AppCustomDrawer> {
  @override
  void initState() {
    super.initState();
    context.read<DrawerCubit>().countRequestsUnreadCount(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(121),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath:
                            context.read<AppUserCubit>().state?.pictureUrl ??
                                "",
                        radius: BorderRadius.circular(50),
                        height: 54,
                        width: 54,
                      ),
                      const Gap(16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.read<AppUserCubit>().state?.username ?? '',
                            style: subTitleStyle?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColorLightGrey,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            context.read<AppUserCubit>().state?.userEmail ?? '',
                            style: subTitleStyle?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.selectionColorText,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                BlocBuilder<DrawerCubit, NavigationItem>(
                  builder: (context, selectedItem) {
                    final drawerCubit = context.read<DrawerCubit>();
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 800),
                      switchInCurve: Curves.easeInOutCubic,
                      switchOutCurve: Curves.easeInOutCubic,
                      transitionBuilder: (child, animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1.5, 0.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: isTravelerMode
                          ? _buildDrawerWithDynamicHeight(
                              context, "Travel Hero", drawerCubit.heroNavItems)
                          : _buildDrawerWithDynamicHeight(context, "Traveler",
                              drawerCubit.travelerNavItems),
                    );
                  },
                ),
                const Gap(12),
                SizedBox(
                  height: 41,
                  child: AppButton.lightRed(
                    onPressed: () {
                      context.pushNamed(NavigationPath.promptPageRouteUri);
                    },
                    radius: 30,
                    child: Text(
                      'Create a Trip Plan',
                      textAlign: TextAlign.center,
                      style: titleMediumSaira?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                          fontSize: 15),
                    ),
                  ),
                ),
                const Gap(214),
                const SwitchAccountWidget(),
                const Gap(24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerWithDynamicHeight(
    BuildContext context,
    String modeTitle,
    Map<NavigationItem, Map<String, dynamic>> navItems,
  ) {

    return AnimatedSize(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(24),
          Text(
            modeTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            key: ValueKey(navItems),
            itemCount: navItems.length,
            itemBuilder: (context, index) {
              final item = navItems.keys.elementAt(index);
              final data = navItems[item]!;

              return AnimatedSize(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                child: _buildNavItem(
                  icon: data["icon"],
                  item: item,
                  title: data["title"],
                  badgeCount: data["badge"],
                  isSelected: context.read<DrawerCubit>().state == item,
                  onTap: () {
                    context.read<DrawerCubit>().selectItem(item, context);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required SvgGenImage icon,
    required String title,
    required int badgeCount,
    required bool isSelected,
    required VoidCallback onTap,
    required NavigationItem item,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? AppColors.primaryNormal : AppColors.transparent,
      ),
      child: ListTile(
        leading: icon.svg(
          colorFilter: ColorFilter.mode(
            isSelected ? AppColors.white : AppColors.unSelectedLabel,
            BlendMode.srcIn,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            title,
            style: subTitleStyle?.copyWith(
              fontWeight: FontWeight.w600,
              color:
                  isSelected ? AppColors.white : AppColors.selectionColorText,
              fontSize: 13,
            ),
          ),
        ),
        trailing: item == NavigationItem.chats
            ? BlocBuilder<UnreadMessageCountCubit, int>(
                builder: (context, unreadCount) {
                return unreadCount > 0
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: isSelected
                              ? AppColors.white
                              : item == NavigationItem.chats
                                  ? AppColors.chatBagBackColor
                                  : AppColors.primaryNormal,
                        ),
                        child: Text(
                          unreadCount.toString(),
                          style: subTitleStyle?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? AppColors.selectionColorText
                                : item == NavigationItem.chats
                                    ? AppColors.selectionColorText
                                    : AppColors.white,
                            fontSize: 10,
                          ),
                        ),
                      )
                    : SizedBox.shrink();
              })
            : badgeCount > 0
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isSelected
                          ? AppColors.white
                          : item == NavigationItem.chats
                              ? AppColors.chatBagBackColor
                              : AppColors.primaryNormal,
                    ),
                    child: Text(
                      badgeCount.toString(),
                      style: subTitleStyle?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? AppColors.selectionColorText
                            : item == NavigationItem.chats
                                ? AppColors.selectionColorText
                                : AppColors.white,
                        fontSize: 10,
                      ),
                    ),
                  )
                : null,
        onTap: onTap,
      ),
    );
  }
}
