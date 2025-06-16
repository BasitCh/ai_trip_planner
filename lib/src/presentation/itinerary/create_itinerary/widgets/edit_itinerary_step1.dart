import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:travel_hero/blocs/places/place_cubit.dart';
import 'package:travel_hero/repositories/google_places/models/place_autocomplete_response.dart';
import 'package:travel_hero/src/application/itinerary/create_itinerary_cubit.dart';
import 'package:travel_hero/src/application/create_trip_plan/edit_trip_plan_cubit.dart';
import 'package:travel_hero/src/domain/itinerary/activity.dart';
import 'package:travel_hero/src/infrastructure/utils/utils.dart';
import 'package:travel_hero/widgets/custom_image_view.dart';
import 'package:widgets_book/widgets_book.dart';

final TextEditingController descriptionController = TextEditingController();
final TextEditingController titleController = TextEditingController();
final TextEditingController locationController = TextEditingController();
void initializeCubits(BuildContext context, int selectedDay, int selectedActivity) {
  final createItineraryCubit = context.read<CreateItineraryCubit>();
  final editTripPlanCubit = context.read<EditTripPlanCubit>();
  final placeCubit = context.read<PlaceCubit>();

  placeCubit.clearState();
  final activity = createItineraryCubit.state?.travelItinerary?.dayPlans[selectedDay].activities[selectedActivity];
  editTripPlanCubit.updateActivity(activity);
  locationController.text = activity?.name ?? '';
}
void showBottomSheetStep1(
    BuildContext context, int selectedDay, int selectedActivity) {
  GoogleMapController? googleMapController;
  initializeCubits(context, selectedDay, selectedActivity);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Ensures the modal takes up necessary height
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        // Allows the sheet to adjust based on content
        initialChildSize: 0.85,
        // Start height (60% of screen height)
        minChildSize: 0.4,
        // Minimum height (40% of screen height)
        maxChildSize: 0.9,
        // Maximum height (90% of screen height)
        builder: (context, scrollController) {
          return SingleChildScrollView(
              controller: scrollController,
              child: BlocBuilder<EditTripPlanCubit, Activity?>(
                  builder: (context, state) {
                if (googleMapController != null) {
                  googleMapController!.animateCamera(CameraUpdate.newLatLng(
                      LatLng(state!.coordinates.lat, state.coordinates.lng)));
                }
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Step 1',
                          style: titleMediumSaira?.copyWith(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w900,
                            color: AppColors.black.withOpacity(.20),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Centered horizontally
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Editing ",
                                style: titleMediumSaira?.copyWith(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.black,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 0),
                                color: AppColors.black50,
                                child: Text(
                                  'Day ${selectedDay + 1}',
                                  style: titleMediumSaira?.copyWith(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      // Initial dropdown-like button
                      // GestureDetector(
                      //   onTap: () {
                      //     // Show custom modal
                      //     showGeneralDialog(
                      //       context: context,
                      //       barrierDismissible: true,
                      //       barrierLabel: '',
                      //       transitionDuration: Duration(milliseconds: 300),
                      //       pageBuilder: (context, anim1, anim2) {
                      //         return Center(
                      //           child: Material(
                      //               color: AppColors.transparent,
                      //               borderRadius: BorderRadius.circular(16),
                      //               child: _buildDropdownList(context, 1,state)),
                      //         );
                      //       },
                      //       transitionBuilder: (context, anim1, anim2, child) {
                      //         final curvedValue =
                      //         Curves.easeInOut.transform(anim1.value);
                      //         return Transform.translate(
                      //           offset: Offset(0, -200 + (curvedValue * 355)),
                      //           // Slide from top
                      //           child: Opacity(
                      //             opacity: anim1.value,
                      //             child: child,
                      //           ),
                      //         );
                      //       },
                      //     );
                      //   },
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     // Centered horizontally
                      //     children: [
                      //       Row(
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             "Editing ",
                      //             style: titleMediumSaira?.copyWith(
                      //               fontSize: 22.sp,
                      //               fontWeight: FontWeight.w700,
                      //               color: AppColors.black,
                      //             ),
                      //           ),
                      //           Container(
                      //             padding: EdgeInsets.symmetric(
                      //                 horizontal: 5, vertical: 0),
                      //             color: AppColors.black50,
                      //             child: Text(
                      //               days[0],
                      //               style: titleMediumSaira?.copyWith(
                      //                 fontSize: 22.sp,
                      //                 fontWeight: FontWeight.w700,
                      //                 color: AppColors.black,
                      //               ),
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //       Icon(Icons.arrow_drop_down),
                      //     ],
                      //   ),
                      // ),
                      Text(
                        "Name & Location",
                        style: titleXSmallWhite?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColorGreyNew,
                        ),
                      ),

                      const SizedBox(height: 16),

                      BlocBuilder<PlaceCubit, PlaceState>(
                        builder: (context, statePlaces) {
                          return Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color:
                                              Colors.black.withOpacity(0.25)),
                                    ),
                                    child: Stack(
                                      //crossAxisAlignment: CrossAxisAlignment.start
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 13, top: 13),
                                          child: Text('Title',
                                              style: titleMedium?.copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors
                                                      .selectionColor)),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          child: AppTextField(
                                            onChanged: (value) {
                                              context
                                                  .read<PlaceCubit>()
                                                  .searchPlaces(
                                                      value, null);
                                            },
                                            focusedcolor: BorderSide(
                                              color: AppColors.transparent,
                                            ),
                                            controller: locationController,
                                            fillcolor: AppColors.transparent,
                                            maxLines: 3,
                                            borderRadius: 5,
                                            // contentPadding: EdgeInsets.only(
                                            //     left: 27, right: 80, top: 20, bottom: 20),
                                            hintText: 'Title',

                                            bordersidecolor: BorderSide(
                                              color: AppColors.transparent,
                                            ),
                                            hintStyle: titleMedium?.copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.textColorLightBlack,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (statePlaces is PlaceLoaded &&
                                      statePlaces.places.isNotEmpty)
                                    showLocationSearch(
                                        context, statePlaces.places),
                                  Gap(13.h),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color:
                                              Colors.black.withOpacity(0.25)),
                                    ),
                                    height: 200,
                                    child: GoogleMap(
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(state!.coordinates.lat,
                                            state.coordinates.lng),
                                        zoom: 14,
                                      ),
                                      zoomControlsEnabled: true,

                                      markers: {
                                        Marker(
                                          markerId:
                                              MarkerId('selectedLocation'),
                                          position: LatLng(
                                              state.coordinates.lat,
                                              state.coordinates.lng),
                                        )
                                      },
                                      // onCameraMove: (position) {
                                      //   context.read<EditTripPlanCubit>().setCameraPosition(position.target);
                                      // },
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        googleMapController = controller;
                                        controller.animateCamera(
                                            CameraUpdate.newLatLng(LatLng(
                                                state.coordinates.lat,
                                                state.coordinates.lng)));
                                      },
                                    ),
                                  ),
                                  Gap(13.h),
                                  Wrap(
                                    spacing: 6,
                                    children: [
                                      ...state.images.map<Widget>(
                                          (image) => ImageWidget(image: image,)),
                                      IconButton(
                                        icon: Assets.icons.icAddImage.svg(),
                                        onPressed: () => _pickImage(context),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 16),
                      AppButton.lightRed(
                        radius: 32,
                        onPressed: () {
                          Navigator.pop(context);
                          _showBottomSheetStep2(context, selectedDay,
                              selectedActivity, state!.description);
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            color: AppColors.white,
                            fontFamily: FontFamily.saira,
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: titleMediumSaira?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp,
                              color: AppColors.textPrimary),
                        ),
                      ),
                    ],
                  ),
                );
              }));
        },
      );
    },
  );
}

class ImageWidget extends StatelessWidget {
  final dynamic image;
  const ImageWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            image is String
                ? CustomImageView(
                    imagePath: image, width: 80, height: 80, fit: BoxFit.cover)
                : Image.file(image, width: 80, height: 80, fit: BoxFit.cover),

               Positioned(
                  left: 55,
                  top: 5,
                  child:
                  InkWell(
                      onTap: (){
                        context.read<EditTripPlanCubit>().removeImage(image);
                      },child:
                  Assets.icons.icDeleteWhite.svg()),
            ),
          ],
        ),
      ),
    );
  }
}

void _showBottomSheetStep2(
    BuildContext context, int dayIndex, int activityIndex, String description) {
  final quill.QuillController controller;
// Create an initial document with some text
  final doc = quill.Document()..insert(0, description);
  controller = quill.QuillController(
    document: doc,
    selection: const TextSelection.collapsed(offset: 0),
  );
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.60,
        // Adjust this for initial height
        maxChildSize: 1.0,
        minChildSize: 0.25,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.all(16 // Adjust for keyboard
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Step 2',
                      style: titleMediumSaira?.copyWith(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColors.black.withOpacity(.20),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // Centered horizontally
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Editing ",
                            style: titleMediumSaira?.copyWith(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 0),
                            color: AppColors.black50,
                            child: Text(
                              'Day ${dayIndex + 1}',
                              style: titleMediumSaira?.copyWith(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                  Text(
                    "Description & Type",
                    style: titleXSmallWhite?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColorGreyNew,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.only(bottom: 60),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.borderColorNew,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Column(
                      children: [
                        quill.QuillToolbar.simple(
                          controller: controller,
                          configurations:
                              quill.QuillSimpleToolbarConfigurations(
                                  showFontFamily: false,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey100,
                                    // border: Border.all(
                                    //   color: AppColors.borderColorNew,
                                    // ),
                                    //   color: AppColors.borderColorNew,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12)),
                                    //
                                  ),
                                  showFontSize: true,
                                  showBoldButton: true,
                                  showItalicButton: true,
                                  showUnderLineButton: true,
                                  showAlignmentButtons: true,
                                  multiRowsDisplay: false),
                        ),
                        Gap(60),

                        // Rich Text Editor Area
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.5, color: AppColors.borderColorNew),
                            ),
                          ),
                          //padding: const EdgeInsets.all(12),
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: quill.QuillEditor.basic(
                            controller: controller,
                            configurations: quill.QuillEditorConfigurations(
                              padding: EdgeInsets.all(12),
                            ),
                            //readOnly: false,  // Allow text editing
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppButton.lightRed(
                    radius: 32,
                    onPressed: () {
                      context
                          .read<EditTripPlanCubit>()
                          .updateDescription(controller.document.toPlainText());
                      context.read<CreateItineraryCubit>().updateActivity(
                          activity: context.read<EditTripPlanCubit>().state,
                          activityIndex: activityIndex,
                          dayIndex: dayIndex);
                      Navigator.pop(context);
                      // context.goNamed(NavigationPath.onboardingRouteUri);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: AppColors.white,
                        fontFamily: FontFamily.saira,
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Back',
                      style: titleMediumSaira?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                          color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Future<void> _pickImage(BuildContext context) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null && context.mounted) {
    context.read<EditTripPlanCubit>().addImage(File(pickedFile.path));
  }
}

Widget showLocationSearch(BuildContext context, List<Prediction> predictions) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: AppColors.black.withOpacity(0.25)),
      color: AppColors.lightGreyNew,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 200, // Optional max height
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(), // Prevent unnecessary scrolling
            itemCount: predictions.length,
            itemBuilder: (context, index) {
              final prediction = predictions[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 8),
                  child: Text(
                    prediction.description,
                    style: titleXSmallWhite?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                ),
                subtitle: predictions.length - 1 != index
                    ? Divider(color: AppColors.black.withOpacity(0.25))
                    : SizedBox.shrink(),
                onTap: () async {
                  context.read<EditTripPlanCubit>().fetchCoordinatesFromAddress(
                      prediction.description, locationController);
                  context.read<PlaceCubit>().clearState();
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}

