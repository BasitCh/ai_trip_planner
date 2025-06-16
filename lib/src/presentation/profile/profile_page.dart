import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/profile/image_picker_cubit.dart';
import 'package:travel_hero/src/application/profile/update_profile_cubit.dart';
import 'package:travel_hero/src/presentation/profile/widgets/profile_sub_page.dart';
import 'package:travel_hero/src/presentation/profile/widgets/upload_cover_bottomsheet.dart';
import 'package:travel_hero/widgets/profile_top_bar.dart';
import 'package:widgets_book/widgets_book.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileTopBar(
              onTapEditProfile: () {
            showUploadOptions(context);
            },
              isUploadCover: true,
            ),
              BlocListener<ImagePickerCubit, ImagePickerState>(
                listener: (context, state) {
                  if (state is ImagePickerError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                  if(state is ImagePickerCropped){
                    context.read<UpdateProfileCubit>().updateCoverPicture(state.croppedImage);
                  }
                },child: SizedBox.shrink(),
              ),
              ProfileSubPage(),
            ],
          )),
    );
  }
}
