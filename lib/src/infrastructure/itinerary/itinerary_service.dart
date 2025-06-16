import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:travel_hero/src/domain/itinerary/itinerary_request_body.dart';
import 'package:travel_hero/src/domain/itinerary/openai_response.dart';
import 'package:widgets_book/widgets_book.dart';

part 'itinerary_service.g.dart';

@RestApi(
  baseUrl: ApiConstant.openAiCompletionsUrl,
)
abstract class ItineraryService {
  factory ItineraryService(
    Dio dioBuilder, {
    String baseUrl,
  }) = _ItineraryService;

  @POST('/completions')
  Future<OpenAIResponse> getItineraryFromAi({
    @Header('Authorization') required String authorization,
    @Body()
    required ItineraryRequestBody itineraryRequestBody,
  });
}
