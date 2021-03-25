import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_light/entity/LightSetting.dart';
import 'package:smart_light/entity/Option.dart';

class OptionsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  List<Option> _options = [
    Option('Sunny', LightSetting(Colors.lightBlue, 50, 50)),
    Option('Windy', LightSetting(Colors.redAccent, 50, 50)),
    Option('Work', LightSetting(Colors.greenAccent, 50, 50)),
    Option('Relax', LightSetting(Colors.amber, 50, 50)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Режими'),
      ),
      body: GridView.builder(
        itemCount: _options.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        padding: EdgeInsets.all(5),
        itemBuilder: (BuildContext context, int index) {
          return ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  _options[index].lightSetting.color),
            ),
            onPressed: () {},
            child: Center(
              child: new GridTile(
                child: new Text(_options[index]
                    .name),
              ),
            ),
          );
        },
      ),
    );
  }
}
