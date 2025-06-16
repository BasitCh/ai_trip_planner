import 'package:travel_hero/src/domain/itinerary/ai_request_message.dart';
import 'package:widgets_book/widgets_book.dart';

part 'itinerary_request_body.g.dart';

@JsonSerializable(explicitToJson: true)
class ItineraryRequestBody {
  final String model;
  final List<AiRequestMessage> messages;
  @JsonKey(name: 'max_tokens')
  final int maxTokens;

  ItineraryRequestBody({
    required this.model,
    required this.messages,
    this.maxTokens = 2000,
  });

  factory ItineraryRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ItineraryRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ItineraryRequestBodyToJson(this);
}
