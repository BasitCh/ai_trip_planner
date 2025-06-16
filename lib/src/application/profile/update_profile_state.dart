part of 'update_profile_cubit.dart';

class UpdateProfileState extends Equatable {
  final bool isSubmitting;
  final bool isProfileUpdated;
  final bool isProfilePictureUpdated;
  final Option<Either<ApiError, AppUser>> authFailureOrSuccessOption;
  final String? userName;
  final String? coverPictureUrl;

  const UpdateProfileState({
    this.isSubmitting = false,
    this.isProfileUpdated = false,
    this.isProfilePictureUpdated = false,
    this.authFailureOrSuccessOption = const None(),
    this.userName,
    this.coverPictureUrl,
  });

  UpdateProfileState copyWith({
    bool? isSubmitting,
    bool? isProfileUpdated,
    bool? isProfilePictureUpdated,
    Option<Either<ApiError, AppUser>>? authFailureOrSuccessOption,
    String? userName,
    String? coverPictureUrl,
  }) {
    return UpdateProfileState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isProfileUpdated: isProfileUpdated ?? this.isProfileUpdated,
      isProfilePictureUpdated: isProfilePictureUpdated ?? this.isProfilePictureUpdated,
      authFailureOrSuccessOption: authFailureOrSuccessOption ?? this.authFailureOrSuccessOption,
      userName: userName ?? this.userName,
      coverPictureUrl: coverPictureUrl ?? this.coverPictureUrl,
    );
  }

  @override
  List<Object?> get props => [
    isSubmitting,
    isProfileUpdated,
    isProfilePictureUpdated,
    authFailureOrSuccessOption,
    userName,
    coverPictureUrl,
  ];
}
