import 'package:flutter/material.dart';

class OptionDialog {
  final BuildContext _context;
  final Function(String) _onSubmit;

  OptionDialog(this._context, this._onSubmit);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showOptionDialog() {
    showDialog(
      context: _context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: Form(
            key: _formKey,
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Введіть ім'я",
              ),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'Поле не може бути пустим';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            new TextButton(
                child: const Text('Назад'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new TextButton(
                child: const Text('Ок'),
                onPressed: () {
                  // _onSubmit();
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // Process data.
                    Navigator.pop(context);
                  }
                })
          ],
        );
      },
    );
  }
}
