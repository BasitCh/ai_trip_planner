import 'package:travel_hero/src/domain/itinerary/travel_itinerary.dart';
import 'package:widgets_book/widgets_book.dart';

part 'itinerary_response.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class ItineraryResponse {
  @JsonKey(name: "valid")
  final bool? valid;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "travel_itinerary")
  final TravelItinerary? travelItinerary;

  ItineraryResponse({
    this.valid,
    this.message,
    this.travelItinerary,
  });

  factory ItineraryResponse.fromJson(Map<String, dynamic> json) =>
      _$ItineraryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItineraryResponseToJson(this);
}
