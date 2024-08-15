import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_send_app/src/features/dashboard/data/data_sources/mock_user_data_source.dart';
import 'package:money_send_app/src/features/dashboard/data/data_sources/remote_user_data_source.dart';
import 'package:money_send_app/src/features/dashboard/data/data_sources/remote_wallet_data_source.dart';
import 'package:money_send_app/src/features/dashboard/data/repositories/i_user_repository.dart';
import 'package:money_send_app/src/features/dashboard/data/repositories/i_wallet_repository.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/wallet_repository.dart';
import 'package:money_send_app/src/features/dashboard/domain/usecases/get_wallet_use_case.dart';
import 'package:money_send_app/src/features/dashboard/presentation/bloc/wallet_cubit.dart';
import 'package:money_send_app/src/features/transaction_history/data/data_sources/transaction_data_source.dart';
import 'package:money_send_app/src/features/transaction_history/data/repositories/i_transaction_repository.dart';
import 'package:money_send_app/src/features/transaction_history/domain/repositories/transaction_repository.dart';
import 'package:money_send_app/src/features/transaction_history/domain/usecases/get_transactions_use_case.dart';
import 'package:money_send_app/src/features/transaction_history/presentation/bloc/transaction_list_bloc.dart';

class AppBlocWrapper extends StatefulWidget {
  const AppBlocWrapper({super.key, required this.child});

  final Widget child;

  @override
  State<AppBlocWrapper> createState() => _AppBlocWrapperState();
}

class _AppBlocWrapperState extends State<AppBlocWrapper> {
  late final _mockUserDataSource = MockUserDataSource();
  late final _userDataSource = RemoteUserDataSource();
  late final _walletDataSource = RemoteWalletDataSource();
  late final _transactionDataSource = TransactionDataSource();

  late final _userRepository = IUserRepository(
    mockUserDataSource: _mockUserDataSource,
    remoteUserDataSource: _userDataSource,
  );
  late final _walletRepository = IWalletRepository(walletDataSource: _walletDataSource);
  late final _transactionRepository = ITransactionRepository(
    transactionDataSource: _transactionDataSource,
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<WalletRepository>(create: (context) => _walletRepository),
        RepositoryProvider<TransactionRepository>(create: (context) => _transactionRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => WalletCubit(
              getWalletUseCase: GetWalletUseCase(
                userRepository: _userRepository,
                walletRepository: _walletRepository,
              ),
            ),
          ),
          BlocProvider(
            create: (_) => TransactionListCubit(
              getTransactionsUseCase: GetTransactionsUseCase(_transactionRepository),
            ),
          ),
        ],
        child: widget.child,
      ),
    );
  }
}
