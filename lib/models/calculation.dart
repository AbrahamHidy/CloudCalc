import 'package:function_tree/function_tree.dart';

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

  void setResult(String result) {
    _result = result;
  }

  void setExpression(String expression) {
    _expression = expression;
  }

  void appendToExpresstion(String toAppend) {
    _expression += toAppend;
  }

  void backspace() {
    if (_expression.length > 1) {
      _expression = _expression.substring(0, _expression.length - 1);
    } else if (_expression.length == 1) {
      _expression = "";
    }
  }

  bool solve() {
    try {
      if (_expression.isNotEmpty) {
        String result = _expression.interpret().toString();
        if (result.substring(result.length - 2) == ".0") {
          result = result.substring(0, result.length - 2);
        }
        _result = result;
      } else {
        _result = "";
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
