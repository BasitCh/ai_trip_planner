import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:travel_hero/src/application/intro/loader_cubit.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/widgets/shader_mask.dart';
import 'package:widgets_book/widgets_book.dart';

class AppBoxLoading extends StatefulWidget {
  const AppBoxLoading({super.key, this.title, this.subTitle});
  final String? title;
  final String? subTitle;

  @override
  State<AppBoxLoading> createState() => _AppBoxLoadingState();
}

class _AppBoxLoadingState extends State<AppBoxLoading> {
  late String? title;
  late String? subTitle;
  @override
  void initState() {
    title= widget.title;
    subTitle = widget.subTitle;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoaderCubit(),
      child:  AppBoxLoadingDetail(title: title,subTitle:subTitle ,),
    );
  }
}

class AppBoxLoadingDetail extends StatefulWidget {
  const AppBoxLoadingDetail({super.key, this.title, this.subTitle});
  final String? title;
  final String? subTitle;
  @override
  _AppBoxLoadingDetailState createState() => _AppBoxLoadingDetailState();
}

class _AppBoxLoadingDetailState extends State<AppBoxLoadingDetail>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _spreadAnimation;
  late Timer _timer;

  final Color boxColor = Color(0xFF141414); // Box color.

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _spreadAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Periodic timer to update the animation step.
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      context.read<LoaderCubit>().nextStep();
      _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Stack(
            children: [
              // Animated Boxes Section
            Positioned(
            left: 30.w,
            right: 30.w,
            //top: 400,
            bottom: 400.h,
                child: BlocBuilder<LoaderCubit, int>(
                  builder: (context, currentStep) {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 400),
                      child: _buildStep(currentStep),
                    );
                  },
                ),
              ),
              Positioned(
                left: 30.w,
                right: 30.w,
                //top: 400,
                bottom: 290.h,
                child: Column(
                  children: [
                    Gap(20),
                    AppShaderMask(
                      text: widget.title??'Creating Your Account',
                    ),
                    Gap(8),
                    Text(
                        widget.subTitle??'One moment please, we\'re creating environment for you',
                        style: subTitleStyle?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textTertiary5, fontSize: 9)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep(int currentStep) {
    if (currentStep == 0) {
      // Single Box with scaling.
      return ScaleTransition(
        scale: _spreadAnimation,
        child: _buildBox(20, boxColor),
      );
    } else if (currentStep == 1) {
      // 4 Boxes (2x2 Grid).
      return _buildGrid(2, 15, boxColor);
    } else if (currentStep == 2) {
      // 9 Boxes (3x3 Grid).
      return _buildGrid(3, 10, boxColor);
    }
    return Container();
  }

  Widget _buildGrid(int gridSize, double boxSize, Color color) {
    double gridSpacing = boxSize * 1.5;

    return ScaleTransition(
      scale: _spreadAnimation, // Scale the entire grid.
      child: SizedBox(
        width: gridSize * gridSpacing,
        height: gridSize * gridSpacing,
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(gridSize * gridSize, (index) {
            int row = index ~/ gridSize;
            int col = index % gridSize;

            double dx = (col - (gridSize - 1) / 2) * gridSpacing;
            double dy = (row - (gridSize - 1) / 2) * gridSpacing;

            return Transform.translate(
              offset: Offset(dx, dy),
              child: ScaleTransition(
                scale: _spreadAnimation,
                child: _buildBox(boxSize, color),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildBox(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
