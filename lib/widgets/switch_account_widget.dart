import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/home/home_cubit.dart';
import 'package:travel_hero/src/application/home/home_state.dart';
import 'package:travel_hero/src/application/main/cubit/account_type_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:widgets_book/widgets_book.dart';

class SwitchAccountWidget extends StatelessWidget {
  const SwitchAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            children: [
              Icon(Icons.help_outline, color: AppColors.selectionColorText),
              const Gap(6),
              Text(
                'Switch account',
                style: subTitleStyle?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.selectionColorText,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        BlocBuilder<AccountTypeCubit, AccountType>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.accountBackColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, homeState) {
                  return IgnorePointer(
                    ignoring: homeState is HomeLoading,
                    child: Row(
                      children: [
                        _buildAccountButton(
                          context: context,
                          label: 'Travel Hero',
                          icon: Assets.icons.icTravelHero,
                          isSelected: state == AccountType.travelHero,
                          onTap: () => context
                              .read<AccountTypeCubit>()
                              .switchAccount(AccountType.travelHero, context),
                        ),
                        const Gap(8),
                        _buildAccountButton(
                          context: context,
                          label: 'Traveler',
                          icon: Assets.icons.icTraveller,
                          isSelected: state == AccountType.traveler,
                          onTap: () => context
                              .read<AccountTypeCubit>()
                              .switchAccount(AccountType.traveler, context),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAccountButton({
    required BuildContext context,
    required String label,
    required SvgGenImage icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(
            vertical: isSelected ? 16 : 12,
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.white : AppColors.transparent,
            borderRadius: BorderRadius.circular(32),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon.svg(
                colorFilter: ColorFilter.mode(
                  isSelected ? AppColors.primaryNormal : AppColors.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
              const Gap(4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: subTitleStyle?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? AppColors.primaryNormal
                          : AppColors.black,
                      fontSize: 14,
                    ) ??
                    TextStyle(),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
