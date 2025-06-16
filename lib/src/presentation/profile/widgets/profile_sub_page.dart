
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hero/global/global.dart';
import 'package:travel_hero/src/application/profile/update_profile_cubit.dart';
import 'package:travel_hero/src/infrastructure/routes/app_routes.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/src/presentation/profile/widgets/info_card.dart';
import 'package:travel_hero/src/presentation/profile/widgets/menu_option.dart';
import 'package:widgets_book/widgets_book.dart';

class ProfileSubPage extends StatefulWidget {
  const ProfileSubPage({super.key});

  @override
  State<ProfileSubPage> createState() => _ProfileSubPageState();
}

class _ProfileSubPageState extends State<ProfileSubPage> {
  final  menuOptions=MenuOptionType.values;
  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.all(16.0),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         // Wallet Section
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: const [
             InfoCard(label: "Last Payment", amount: "\$500", color: AppColors.textForestGreen),
             InfoCard(label: "Wallet", amount: "\$250", color: AppColors.primaryNormal,borderRadiusGeometry:  BorderRadius.only(
               topRight: Radius.circular(8.0),
               bottomRight: Radius.circular(8.0),
             ),),
           ],
         ),
         Gap(54.h),
         // Edit Profile Button
         SizedBox(
           width: 203.w,
           height: 36.h,
           child: AppButton.outlinePrimaryNormal(
             onPressed: (){
               context.pushNamed(NavigationPath.profileSetting);
             },
             borderRadius:17,
             child: Text('Edit Profile', style: titleMediumSaira?.copyWith(
               fontWeight: FontWeight.w500,
               color: AppColors.primaryNormal,
               fontSize: 14.sp,
             ),


             ),
           )),
         Gap(60.h),

         // Menu Options with navigation
         ListView.builder(
           itemCount: menuOptions.length,
           shrinkWrap: true,
           physics: NeverScrollableScrollPhysics(),
           itemBuilder: (context, index) {
             final option = menuOptions[index];
             return MenuOption(
               icon: option.icon,
               label: option.label,
               color: AppColors.primaryNormal,
               onPressed: ()async {
                 if(menuOptions[index]==MenuOptionType.logOut){
                   await context.read<UpdateProfileCubit>().onLogout();
                 }
                 // Uncomment and customize the navigation logic if needed
                 // Navigator.push(
                 //   context,
                 //   MaterialPageRoute(
                 //     builder: (context) => DummyScreen(title: option.label),
                 //   ),
                 // );
               },
             );
           },
         )
       ],
     ),
   );
  }
}
