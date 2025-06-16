import 'package:json_annotation/json_annotation.dart';
part 'structured_formatting.g.dart';
@JsonSerializable()
class StructuredFormatting {
  @JsonKey(name: 'main_text')
  final String mainText;

  StructuredFormatting({required this.mainText});

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingFromJson(json);

  Map<String, dynamic> toJson() => _$StructuredFormattingToJson(this);
}