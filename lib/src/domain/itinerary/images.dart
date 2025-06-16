import 'package:widgets_book/widgets_book.dart';
part 'images.g.dart';

@JsonSerializable()
class Images {
  final String? networkUrl; // Network URL
  final String? filePath; // Local file path

  Images({this.networkUrl, this.filePath})
      : assert(networkUrl != null || filePath != null, "Either networkUrl or filePath must be provided");

  bool get isNetwork => networkUrl != null;
  bool get isFile => filePath != null;

  // Convert ImageSource to JSON
  Map<String, dynamic> toJson()  => _$ImagesToJson(this);

  // Create ImageSource from JSON
  factory Images.fromJson(Map<String, dynamic> json) =>  _$ImagesFromJson(json);
}
