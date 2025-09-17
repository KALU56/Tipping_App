import 'package:tip_employee/core/service/account_service.dart';
import 'package:tip_employee/features/settings/data/model/account_model.dart';
import 'package:tip_employee/features/settings/domain/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountService accountService;

  AccountRepositoryImpl({required this.accountService});

  @override
  Future<Account> getMyAccount() async {
    try {
      final data = await accountService.getMyAccount();
      return Account.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Account> updateAccount({
    required String accountNumber,
    required String accountName,
  }) async {
    try {
      final data = await accountService.updateAccount(
        accountNumber: accountNumber,
        accountName: accountName,
      );
      return Account.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
