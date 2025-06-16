import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/login_register/app_user_cubit.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomImageView(
          imagePath: context.read<AppUserCubit>().state?.pictureUrl ?? '',
          height: 48,
          width: 48,
          radius: BorderRadius.circular(50),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<AppUserCubit>().state?.userEmail ?? '',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            SizedBox(height: 2),
            Text(
              context.read<AppUserCubit>().state?.username ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
