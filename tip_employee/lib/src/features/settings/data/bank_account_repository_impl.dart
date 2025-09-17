// lib/src/data/repositories/bank_account_repository_impl.dart
import 'package:tip_employee/src/core/service/account_service.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_account_request.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_account_response.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_model.dart';
import 'package:tip_employee/src/features/settings/domain/bank_account_repository.dart';


class BankAccountRepositoryImpl implements BankAccountRepository {
  final AccountService accountService;

  BankAccountRepositoryImpl({required this.accountService});

  @override
  Future<BankAccountResponse> getBankAccount() async {
    return await accountService.getBankAccount();
  }

  @override
  Future<BankAccountResponse> updateBankAccount(BankAccountRequest request) async {
    return await accountService.updateBankAccount(request);
  }
  @override
  Future<List<Bank>> getBanks() async {
    return await accountService.getBanks();
  }
}
