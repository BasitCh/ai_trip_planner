import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/login_register/app_user_cubit.dart';
import 'package:travel_hero/src/application/profile/settings/settings_cubit.dart';
import 'package:travel_hero/src/application/profile/settings/settings_state.dart';
import 'package:travel_hero/src/application/profile/update_profile_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/profile/widgets/custom_switch_setting.dart';
import 'package:travel_hero/src/presentation/profile/widgets/upload_cover_bottomsheet.dart';
import 'package:travel_hero/widgets/profile_top_bar.dart';
import 'package:widgets_book/widgets_book.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  late TextEditingController rateController;
  @override
  void dispose() {
    rateController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    rateController = TextEditingController(text:(context.read<AppUserCubit>().state?.tripPlanRate??'0.0').toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: BaseScaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Profile",
            style: titleXSmallWhite?.copyWith(
              color: AppColors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Assets.icons.icNotification.svg(
                colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.backGroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileTopBar(
                isUploadCover: true,
                onTapEditProfile: () {
                  showUploadOptions(context);
                },
              ),
              //Gap(14.h),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionHeader(Assets.icons.icEditRates.svg(), "Edit Rates"),
                    Gap(20.h),
                    Text(
                      'Rate for Single Trip Plan',
                      style: titleXSmallWhite?.copyWith(
                        color: AppColors.lightBlackText,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(20.h),
                    rateInputField(context),
                    Gap(60.h),
                    sectionHeader(Assets.icons.icAccounts.svg(), "Account"),
                    accountOptions(context),
                    Gap(20.h),
                    sectionHeader(Assets.icons.icNotificationSetting.svg(),
                        "Notifications"),
                    notificationOptions(context),
                    Gap(54.h),
                    saveButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionHeader(Widget icon, String title) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 8),
        Text(
          title,
          style: titleXSmallWhite?.copyWith(
            color: AppColors.primaryNormal,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget rateInputField(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return AppTextField(
          keyboardType: TextInputType.number,
          borderRadius: 40,
          textColor: AppColors.black,
          textStyle: titleXSmallWhite?.copyWith(
            color: AppColors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
          readOnly: false,
          bordersidecolor: BorderSide(color: AppColors.lightSageGray),
          fillcolor: AppColors.mutedOliveBrown.withOpacity(0.25),
          controller: rateController,
          prefix: Assets.icons.icDollar.svg(),
          onChanged: (value) {
              context.read<SettingsCubit>().updateTripRate(context,value);}
        );
      },
    );
  }

  Widget accountOptions(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Edit Profile",
                style: titleXSmallWhite?.copyWith(
                  color: AppColors.lightBlackText,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {},
            ),
            // ListTile(
            //   contentPadding: EdgeInsets.zero,
            //   title: Text(
            //     "Change Password",
            //     style: titleXSmallWhite?.copyWith(
            //       color: AppColors.lightBlackText,
            //       fontSize: 20.sp,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            //   onTap: () {},
            // ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Public Profile",
                style: titleXSmallWhite?.copyWith(
                  color: AppColors.lightBlackText,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: CustomSwitchSetting(
                isSwitched: state.isPublicProfile,
                onChange: () {
                  context.read<SettingsCubit>().togglePublicProfile(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget notificationOptions(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Notifications",
                style: titleXSmallWhite?.copyWith(
                  color: AppColors.lightBlackText,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: CustomSwitchSetting(
                isSwitched: state.notificationsEnabled,
                onChange: () {
                  context.read<SettingsCubit>().toggleNotifications(context);
                },
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Emails",
                style: titleXSmallWhite?.copyWith(
                  color: AppColors.lightBlackText,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: CustomSwitchSetting(
                isSwitched: state.emailsEnabled,
                onChange: () {
                  context.read<SettingsCubit>().toggleEmails(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget saveButton() {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState?>(
        builder: (context, updateState) {
      return SizedBox(
        height: 47.h,
        width: double.infinity,
        child: AppButton.lightRed(
          onPressed: () {
            context.read<SettingsCubit>().updateUserAndSave(context);
          },
          radius: 30,
              child: updateState!.isSubmitting
                  ? AppButtonLoading():
              Text(
            'Save',
            style: titleMediumSaira?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
              color: AppColors.white,
            ),
          ),
        ),
      );
    });
  }
}
