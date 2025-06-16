import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/src/application/login_register/app_user_cubit.dart';
import 'package:travel_hero/src/application/profile/update_profile_cubit.dart';
import 'package:travel_hero/src/domain/login_register/app_user.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:travel_hero/widgets/rating_bar.dart';
import 'package:widgets_book/widgets_book.dart';

class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar(
      {super.key,
      this.initialRating,
      this.onTapEditProfile,
      this.isUploadCover = false,});

  final double? initialRating;
  final VoidCallback? onTapEditProfile;
  final bool isUploadCover;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState?>(
        builder: (context, updateState) {
      return BlocBuilder<AppUserCubit, AppUser?>(builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                state?.coverPhotoUrl == null || state!.coverPhotoUrl!.isEmpty
                    ? Assets.icons.profilePageFrame.svg(fit: BoxFit.fill)
                    : CustomImageView(
                        height: 243.h,
                        width: 430.w,
                        imagePath: state.coverPhotoUrl ?? "",
                        //height: 104,
                        fit: BoxFit.fill,
                      ),

                //width: 104,
                //radius: BorderRadius.circular(50),
                Positioned(
                  left: 22,
                  top: 15,
                  //right: 200,
                  child: Container(
                    height: 110, // Dynamic height
                    //width:110, // Dynamic width
                    padding: EdgeInsets.all(5), // Border width
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: CustomImageView(
                      imagePath: state?.pictureUrl ?? "",
                      height: 104,
                      fit: BoxFit.contain,
                      //width: 104,
                      radius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 20,
                  child: InkWell(
                    onTap: onTapEditProfile??()=>context.pushNamed(NavigationPath.profileSetting),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 13, right: 13, top: 9, bottom: 9),
                          decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.70),
                              borderRadius: BorderRadius.circular(100)),
                          child: isUploadCover
                              ? Row(
                                  children: [
                                    Assets.icons.icUploadCover.svg(),
                                    Gap(5),
                                    updateState!.isSubmitting
                                        ? SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: CircularProgressIndicator(
                                              color: AppColors.primaryNormal,
                                            ))
                                        : Text(
                                            state?.coverPhotoUrl != null && state!.coverPhotoUrl!.isNotEmpty
                                                ? 'Change Cover'
                                                : 'Upload Cover',
                                            style: subTitleStyle?.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textTertiary4,
                                                fontSize: 12)),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Text('Edit Profile',
                                        style: subTitleStyle?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.textTertiary4,
                                            fontSize: 12)),
                                    Gap(2),
                                    Assets.icons.icEdit.svg(),
                                  ],
                                ),
                        ),
                        Gap(5),
                        Visibility(
                            visible:  state?.coverPhotoUrl!=null && isUploadCover && state!.coverPhotoUrl!.isNotEmpty,
                            child: GestureDetector(
                                onTap: (){
                                  context.read<UpdateProfileCubit>().deleteCoverPhoto();
                                },
                                child: Assets.icons.icDelete.svg())),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: state?.coverPhotoUrl != null && state!.coverPhotoUrl!.isNotEmpty,
                  child: Positioned(
                    top: 150,
                    left: 12,
                    right: 12,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state?.username ?? "",
                                style: titleMediumSaira?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: state?.coverPhotoUrl != null
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontSize: 24)),
                            Text(
                              state?.userEmail ?? "",
                              style: subTitleStyle?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: state?.coverPhotoUrl != null
                                      ? AppColors.white
                                      : AppColors.textTertiary4,
                                  fontSize: 12),
                            ),
                            Gap(24),
                            Visibility(
                              visible: state?.coverPhotoUrl == null,
                              child: AppRatingBar(
                                initialRating: initialRating,
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            context
                                .pushNamed(NavigationPath.promptPageRouteUri);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 21.0),
                            child: Assets.icons.icAdd.svg(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: state?.coverPhotoUrl == null || state!.coverPhotoUrl!.isEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(35),
                  Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state?.username ?? "",
                                style: titleMediumSaira?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black,
                                    fontSize: 24)),
                            Text(
                              state?.userEmail ?? "",
                              style: subTitleStyle?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textTertiary4,
                                  fontSize: 12),
                            ),
                            Gap(24),
                            AppRatingBar(
                              initialRating: initialRating,
                            )
                          ],
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            context.pushNamed(NavigationPath.promptPageRouteUri);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 21.0),
                            child: Assets.icons.icAdd.svg(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      });
    });
  }
}
