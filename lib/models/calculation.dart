class Calculation {
  String _result;
  String _expression;
  DateTime timeCreated = DateTime.now();

  Calculation(this._result, this._expression);

  String getResult() {
    return _result;
  }

  String getExpression() {
    return _expression;
  }
}
