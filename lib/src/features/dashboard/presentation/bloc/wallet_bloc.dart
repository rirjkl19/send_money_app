import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_send_app/src/core/configurations/app_error.dart';
import 'package:money_send_app/src/features/dashboard/domain/entities/wallet.dart';
import 'package:money_send_app/src/features/dashboard/domain/usecases/get_wallet_use_case.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit({required this.getWalletUseCase}) : super(WalletInitial());

  final GetWalletUseCase getWalletUseCase;

  void getWallet() async {
    try {
      emit(WalletLoading());
      final result = await getWalletUseCase();
      emit(WalletLoaded(wallet: result));
    } on AppError {
      emit(WalletError('An error occurred while fetching wallet balance'));
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }
}

sealed class WalletState {
  const WalletState({this.wallet});

  final Wallet? wallet;
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  WalletLoaded({super.wallet});
}

class WalletError extends WalletState {
  final String message;
  WalletError(this.message);
}
