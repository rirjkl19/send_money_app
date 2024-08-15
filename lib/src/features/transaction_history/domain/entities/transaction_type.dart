enum TransactionType {
  deposit,
  withdraw;

  String get label {
    switch (this) {
      case TransactionType.deposit:
        return 'Deposit';
      case TransactionType.withdraw:
        return 'Withdraw';
      default:
        return '';
    }
  }

  String get transactionLabel {
    switch (this) {
      case TransactionType.deposit:
        return 'Cash in transaction from ';
      case TransactionType.withdraw:
        return 'Sent money to ';
    }
  }
}
