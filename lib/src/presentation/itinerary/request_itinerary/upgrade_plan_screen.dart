import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_state.dart';
import 'package:travel_hero/src/application/login_register/app_user_cubit.dart';
import 'package:travel_hero/src/presentation/itinerary/create_itinerary/widgets/plan_card.dart';
import 'package:travel_hero/src/presentation/itinerary/create_itinerary/widgets/user_info.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:widgets_book/widgets_book.dart';

class UpgradePlanScreen extends StatefulWidget {
  const UpgradePlanScreen({super.key});

  @override
  _TripPlanScreenState createState() => _TripPlanScreenState();
}

class _TripPlanScreenState extends State<UpgradePlanScreen> {
  final List<Map<String, dynamic>> plans = [
    {
      "price": "\$50",
      "title": "Unlock Trip Plan",
      "description": "5 Day Trip to Thailand by Paddy Doyle.",
      "benefits": [
        "Comes with one single",
        "Chat with Travel Hero",
        "Get Access to all items in one Trip Plan"
      ],
      "buttonText": "Get the plan",
      "color": Colors.white,
    },
    {
      "price": "\$200 ",
      "title": "Request a Trip Plan",
      "description":
          "Request a new trip plan from your chosen travel hero to any destination.",
      "benefits": [
        "Private consultation",
        "Bespoke trip plan",
        "Chat with your travel hero during the trip for tips"
      ],
      "buttonText": "Request a Trip Plan",
      "color": AppColors.primaryNormal
    }
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _backgroundImage(),
          // Apply Blur Effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // Blur effect
              child: Container(
                color: Colors.black
                    .withValues(alpha: 0.5), // Optional: Add a dark overlay
              ),
            ),
          ),
          _buildCardContainer(context),
          _closeButton(),
        ],
      ),
    );
  }

  Widget _backgroundImage() {
    return BlocBuilder<CreateItineraryCubit, CreateItineraryState?>(
        builder: (context, state) {
          return SizedBox.expand(
            child: CustomImageView(
              imagePath: state!.travelItinerary!.dayPlans.first.activities.first.images.first,
            )
          );
        });


  }

  Widget _buildCardContainer(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter, // Align image at the top center
      clipBehavior: Clip.none, // Allow the image to overflow
      children: [
        // The Main Card Container
        Container(
          width: context.width,
          height: 660.h,
          margin: EdgeInsets.only(top: 50),
          // Create space for the image
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(0), // Remove bottom rounding
              bottomRight: Radius.circular(0),
            ),
            boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60), // Space for the profile image
              UserInfo(),
              Expanded(child: _carouselPlans()),
            ],
          ),
        ),

        // Profile Image Positioned on Top
        Positioned(
          top: 20,
          child: CircleAvatar(
            radius: 50, // Adjust size
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomImageView(
                radius: BorderRadius.circular(50),
                imagePath: context.read<AppUserCubit>().state?.pictureUrl ?? '',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _closeButton() {
    return Positioned(
      top: 50,
      right: 29,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.close, color: Colors.black),
      ),
    );
  }

  Widget _carouselPlans() {
    return CarouselSlider.builder(
      itemCount: plans.length,
      options: CarouselOptions(
        height: context.height,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        autoPlay: false,
        reverse: false,
        pageSnapping: false,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        viewportFraction: 0.7,
        onPageChanged: (index, reason) {
          // setState(() {
          //   _currentIndex = index;
          // });
        },
      ),
      itemBuilder: (context, index, realIndex) {
        return PlanCard(
          price: plans[index]["price"],
          title: plans[index]["title"],
          description: plans[index]["description"],
          benefits: List<String>.from(plans[index]["benefits"]),
          buttonText: plans[index]["buttonText"],
          color: plans[index]["color"],
        );
      },
    );
  }
}
