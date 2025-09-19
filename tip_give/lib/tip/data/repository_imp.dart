import '../core/service/tip_service.dart';
import '../domain/repository.dart';
import 'model/tip_response.dart';

class TipRepositoryImpl implements TipRepository {
  final TipService tipService;

  TipRepositoryImpl({required this.tipService});

  @override
  Future<TipResponse> initializeTip({
    required String employeeId,
    required String amount,
  }) async {
    return await tipService.initializeTip(
      employeeId: employeeId,
      amount: amount,
    );
  }
}
