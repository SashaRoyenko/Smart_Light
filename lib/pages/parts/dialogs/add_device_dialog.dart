import 'package:flutter/material.dart';

class AddDeviceDialog {
  final BuildContext _context;
  final Function(String, String) _onSubmit;

  AddDeviceDialog(this._context, this._onSubmit);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _deviceName ="";
  String _description ="";

  void showOptionDialog() {
    showDialog(
      context: _context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: Container(
            height: 100,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Введіть id пристрою",
                    ),
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return 'Поле не може бути пустим';
                      }
                      _deviceName = value;
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Введіть опис пристрою",
                    ),
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return 'Поле не може бути пустим';
                      }
                      _description = value;
                      return null;
                    },
                  ),
                ],
              ),
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
                    _onSubmit(_deviceName, _description);
                    Navigator.pop(context);
                  }
                })
          ],
        );
      },
    );
  }
}
