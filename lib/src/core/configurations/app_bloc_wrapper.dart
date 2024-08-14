import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_send_app/src/features/dashboard/data/data_sources/wallet_data_source.dart';
import 'package:money_send_app/src/features/dashboard/data/repositories/i_wallet_repository.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/wallet_repository.dart';

class AppBlocWrapper extends StatefulWidget {
  const AppBlocWrapper({super.key, required this.child});

  final Widget child;

  @override
  State<AppBlocWrapper> createState() => _AppBlocWrapperState();
}

class _AppBlocWrapperState extends State<AppBlocWrapper> {
  final WalletDataSource walletDataSource = WalletDataSource();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<WalletRepository>(
          create: (context) => IWalletRepository(remoteDataSource: walletDataSource),
        ),
      ],
      child: Container(),
    );
  }
}
