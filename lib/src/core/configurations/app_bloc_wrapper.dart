import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_send_app/src/features/dashboard/data/data_sources/wallet_data_source.dart';
import 'package:money_send_app/src/features/dashboard/data/repositories/i_wallet_repository.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/wallet_repository.dart';
import 'package:money_send_app/src/features/dashboard/domain/usecases/get_wallet_use_case.dart';
import 'package:money_send_app/src/features/dashboard/presentation/bloc/wallet_bloc.dart';

class AppBlocWrapper extends StatefulWidget {
  const AppBlocWrapper({super.key, required this.child});

  final Widget child;

  @override
  State<AppBlocWrapper> createState() => _AppBlocWrapperState();
}

class _AppBlocWrapperState extends State<AppBlocWrapper> {
  late final _walletDataSource = WalletDataSource();

  late final _walletRepository = IWalletRepository(remoteDataSource: _walletDataSource);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<WalletRepository>(create: (context) => _walletRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => WalletCubit(
              getWalletUseCase: GetWalletUseCase(walletRepository: _walletRepository),
            ),
          ),
        ],
        child: widget.child,
      ),
    );
  }
}
