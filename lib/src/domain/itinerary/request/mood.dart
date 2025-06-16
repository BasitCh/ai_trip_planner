import 'package:json_annotation/json_annotation.dart';

part 'mood.g.dart';

@JsonSerializable(explicitToJson: true)
class Mood {
  final String name;
  bool isSelected;

  Mood({
    required this.name,
    this.isSelected = false,
  });

  factory Mood.fromJson(Map<String, dynamic> json) => _$MoodFromJson(json);

  Map<String, dynamic> toJson() => _$MoodToJson(this);

  /// ✅ `copyWith` method for immutability
  Mood copyWith({
    String? name,
    bool? isSelected,
  }) {
    return Mood(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}