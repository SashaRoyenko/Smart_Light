import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_light/pages/parts/dialogs/add_device_dialog.dart';

import '../entity/Device.dart';
import '../service/shared_preferences_service.dart';

class DevicesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  SharedPreferencesService _sharedPreferencesService;
  List<Device> devices = [];

  @override
  void initState() {
    super.initState();
    _sharedPreferencesService = SharedPreferencesService.getInstance();
    // var devs = [
    //   Device("id", "description", false),
    //   Device("id2", "description2", true)
    // ];
    // _sharedPreferencesService.putObject(
    //     "devices", devs.map((e) => e.toJson()).toList());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
        title: Text("Пристрої"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: <Color>[
              Colors.white,
              Color(0xe413c0b1),
              Color(0xec02653c),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: getDevices(),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              // Text(
              //   "Якщо ви не бачите необхідного пристрою, "
              //   "то спочатку приєднайтеся за допомогою налаштувань",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Colors.blue,
              //     fontSize: 14,
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 15.0, bottom: 30.0),
        child: FloatingActionButton(
          backgroundColor: Color(0x4424FF39),
          child: Icon(
            Icons.add,
            size: 50,
          ),
          onPressed: () {
            AddDeviceDialog(context, (deviceId, deviceDesc) {
              setState(() {
                devices.add(Device(deviceId, deviceDesc, false));
                _sharedPreferencesService.putObject(
                    "devices", devices.map((e) => e.toJson()).toList());
              });
            }).showOptionDialog();
          },
        ),
      ),
    );
  }

  List<Widget> getDevices() {
    List<dynamic> tempList =
        _sharedPreferencesService.getObjects("devices");
    if(tempList == null) {
      return [];
    }
    devices = tempList.map((e) => Device.fromJson(e)).toList();
    return devices
        .map((e) => Dismissible(
              key: Key(e.id),
              onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  devices.remove(e);
                  _sharedPreferencesService.putObject(
                      "devices", devices.map((e) => e.toJson()).toList());
                });
              },
              child: GestureDetector(
                onTap: () => {
                  setState(() {
                    devices.forEach((element) {
                      element.isSelected = false;
                    });
                    e.isSelected = true;
                    _sharedPreferencesService.putObject(
                        "devices", devices.map((e) => e.toJson()).toList());
                    _sharedPreferencesService.putObject("active_device", e);
                  })
                },
                child: Card(
                  color: e.isSelected ? Colors.green : Colors.white,
                  child: ListTile(
                    title: Text(
                      e.description,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(e.id,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        )),
                  ),
                ),
              ),
            ))
        .toList();
  }
}
