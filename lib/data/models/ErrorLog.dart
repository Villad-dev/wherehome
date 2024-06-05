class ErrorLog {
  bool _errorEmptyFields;
  bool _errorPasswords;
  String _errorMessage;

  ErrorLog(
      {required bool errorEmptyFields,
      required bool errorPasswords,
      required String errorMessage})
      : _errorEmptyFields = errorEmptyFields,
        _errorPasswords = errorPasswords,
        _errorMessage = errorMessage;

  bool get errorEmptyFields => _errorEmptyFields;

  set errorEmptyFields(bool value) => _errorEmptyFields = value;

  bool get errorPasswords => _errorPasswords;

  set errorPasswords(bool value) => _errorPasswords = value;

  String get errorMessage => _errorMessage;

  set errorMessage(String value) => _errorMessage = value;
}
