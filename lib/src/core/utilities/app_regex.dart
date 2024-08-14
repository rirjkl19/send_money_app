final class AppRegex {
  const AppRegex._();

  /// Regular expression for amount input. It allows only numbers and a maximum of 2 decimal places.
  static final RegExp amountInput = RegExp(r'^\d+\.?\d{0,2}');
}
