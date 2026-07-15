import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}
