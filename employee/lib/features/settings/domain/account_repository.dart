import 'package:tip_employee/features/settings/data/model/account_model.dart';



abstract class AccountRepository {
  Future<Account> getMyAccount();
  Future<Account> updateAccount({
    required String accountNumber,
    required String accountName,
  });
}
