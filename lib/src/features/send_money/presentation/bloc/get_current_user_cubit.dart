import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_send_app/src/core/entities/user.dart';
import 'package:money_send_app/src/features/send_money/domain/usecases/get_current_user_use_case.dart';

class GetCurrentUserCubit extends Cubit<User?> {
  GetCurrentUserCubit(this._useCase) : super(null);

  final GetCurrentUserUseCase _useCase;

  void getCurrentUser() async {
    try {
      final response = await _useCase();
      emit(response);
    } catch (e) {
      emit(null);
    }
  }
}
