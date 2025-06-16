import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class CustomSwitchSetting extends StatefulWidget {
  final VoidCallback? onChange;
  final bool isSwitched;
  const CustomSwitchSetting({super.key,this.onChange,this.isSwitched=false});

  @override
  State<CustomSwitchSetting> createState() => _CustomSwitchSettingState();
}

class _CustomSwitchSettingState extends State<CustomSwitchSetting> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onChange, // Toggle Cubit state on tap
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
              width: 47,
              height: 23,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.dividerColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.dividerColor.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ],
              )),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: widget.isSwitched ? 22 : 0,
            // Move button
            right: widget.isSwitched ? 0 : 22,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: widget.isSwitched?AppColors.primaryNormal:AppColors.lightBlackText,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.isSwitched?AppColors.primaryNormal.withOpacity(0.4):AppColors.lightBlackText.withOpacity(0.4),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
