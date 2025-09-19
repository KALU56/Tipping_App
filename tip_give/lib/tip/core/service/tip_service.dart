
import 'package:tip_give/tip/core/service/http_service/http_service.dart';
import 'package:tip_give/tip/core/service/http_service/http_service_response_model.dart';

import '../../data/model/tip_response.dart';


class TipService {
  final HttpService httpService;

  TipService({required this.httpService});

  Future<TipResponse> initializeTip({
    required String employeeId,
    required String amount,
  }) async {
    final endpoint = '/api/tip/$employeeId/?amount=$amount';
    final HttpServiceResponseModel response = await httpService.get(endpoint);

    if (response.staticCode == 200) {
      return TipResponse.fromJson(response.data);
    } else {
      throw Exception(
          'Failed to initialize tip: ${response.data['error'] ?? 'Unknown error'}');
    }
  }
}
