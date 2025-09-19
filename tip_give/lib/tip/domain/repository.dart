import '../data/model/tip_response.dart';

abstract class TipRepository {
  Future<TipResponse> initializeTip({
    required String employeeId,
    required String amount,
  });
}
