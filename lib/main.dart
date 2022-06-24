import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'mainscreen.dart';
import 'notification_service.dart';
import 'package:http/http.dart' as http;
import 'package:typed_data/src/typed_buffer.dart';
import './Product.dart';
import './albums.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

final builder2 = MqttClientPayloadBuilder();

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/config.json');
}

final client = MqttServerClient('192.168.1.110', '');
var _httpResObj = [];
void main() async {
  // _httpResObj = await _getStoreProducts();
  try {
var    temprt =0;
    WidgetsFlutterBinding.ensureInitialized();
    NotificationService().initNotification();
    generateRandomValues() {
      int random(min, max) {
        return min + Random().nextInt(max - min);
      }

      Timer.periodic(new Duration(seconds: 5), (timer) {
        temprt= generateRandomValues();
      });
    }

    runApp(App());

    client.setProtocolV311();
    client.logging(on: false);
    client.keepAlivePeriod = 0;
    client.autoReconnect = true;
    client.port = 1883;
    await client.connect();
  } on Exception catch (e) {
    print('EXAMPLE::client exception - $e');
    client.disconnect();
  }

  // builder2.addString('Hello from mqtt_client topic 2');
  //
  // client.publishMessage("shalaby/msg",MqttQos.atLeastOnce,builder2.payload!);
  print("client connected:${client.instantiationCorrect}");
  // runApp(app());
}

// Products


// StoreProducts : http
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  publishToQueue(String text) async {
    try {
      print("status $client.instantiationCorrect");
      if (!client.instantiationCorrect) {
        client.doAutoReconnect();
      }
      builder2.addString(text);
      client.publishMessage(
          "/light_switch/led1", MqttQos.exactlyOnce, builder2.payload!);
      builder2.clear();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("SABA Smart Home"),
          backgroundColor: Color.fromRGBO(40, 82, 149, 1),
        ),
        body: Card(
          shadowColor: Colors.grey,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              BedRoomLightSwitch1(),
              BedRoom2LightSwitch(),
              DoorLock(),
              GarageDoorLock(),
              TempretureSensor(),
              KettleMonitor()
            ],
          ),
        ),

        // child: ListView.builder(
        //   itemCount: _httpResObj.length ,
        //   itemBuilder: (BuildContext context, int position) {
        //     return Product(name: "${_httpResObj[position]['title']}", desc: "${_httpResObj[position]['category']}", price: double.parse("${_httpResObj[position]['price']}"), image: "${_httpResObj[position]['image']}");
        //   },
        // ),
      ),
    );
  }
}

class DoorLock extends StatefulWidget {
  const DoorLock({Key? key}) : super(key: key);

  @override
  State<DoorLock> createState() => _DoorLockState();
}

class _DoorLockState extends State<DoorLock> {
  var door_lock = "locked";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            Text("Front Door ${door_lock}"),
            IconButton(
              icon: Icon(Icons.lock),
              onPressed: () {
                setState(() {
                  door_lock = "locked";
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.lock_open),
              onPressed: () {
                setState(() {
                  door_lock = "unlocked";
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GarageDoorLock extends StatefulWidget {
  const GarageDoorLock({Key? key}) : super(key: key);

  @override
  State<GarageDoorLock> createState() => _GarageDoorLockState();
}

class _GarageDoorLockState extends State<GarageDoorLock> {
  var door_lock = "locked";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            Text("Garage Door ${door_lock}"),
            IconButton(
              icon: Icon(Icons.lock),
              onPressed: () {
                setState(() {
                  door_lock = "locked";
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.lock_open),
              onPressed: () {
                setState(() {
                  door_lock = "unlocked";
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BedRoomLightSwitch1 extends StatefulWidget {
  const BedRoomLightSwitch1({Key? key}) : super(key: key);

  @override
  State<BedRoomLightSwitch1> createState() => _BedRoomLightSwitch1State();
}

class _BedRoomLightSwitch1State extends State<BedRoomLightSwitch1> {
  publishToQueue(String text) async {
    try {
      print("status $client.instantiationCorrect");
      if (!client.instantiationCorrect) {
        client.doAutoReconnect();
      }
      builder2.addString(text);
      client.publishMessage(
          "/light_switch/led1", MqttQos.exactlyOnce, builder2.payload!);
      builder2.clear();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "Bed Room 1 Light Switch",
            style: TextStyle(fontSize: 20),
          ),
          Text('use the below switches to switch on,off or blink the light..',
              style: TextStyle(fontSize: 12)),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.lightbulb),
                onPressed: () {
                  publishToQueue("on");
                },
              ),
              IconButton(
                icon: Icon(Icons.lightbulb_outline),
                onPressed: () {
                  publishToQueue("off");
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class BedRoom2LightSwitch extends StatefulWidget {
  const BedRoom2LightSwitch({Key? key}) : super(key: key);

  @override
  State<BedRoom2LightSwitch> createState() => _BedRoom2LightSwitchState();
}

class _BedRoom2LightSwitchState extends State<BedRoom2LightSwitch> {
  publishToQueue(String text) async {
    try {
      print("status $client.instantiationCorrect");
      if (!client.instantiationCorrect) {
        client.doAutoReconnect();
      }
      builder2.addString(text);
      client.publishMessage(
          "/light_switch/led1", MqttQos.exactlyOnce, builder2.payload!);
      builder2.clear();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "Bed Room 2 Light Switch",
            style: TextStyle(fontSize: 20),
          ),
          Text('use the below switches to switch on,off or blink the light..',
              style: TextStyle(fontSize: 12)),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.lightbulb),
                onPressed: () {
                  publishToQueue("on");
                },
              ),
              IconButton(
                icon: Icon(Icons.lightbulb_outline),
                onPressed: () {
                  publishToQueue("off");
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TempretureSensor extends StatefulWidget {
  const TempretureSensor({Key? key}) : super(key: key);

  @override
  State<TempretureSensor> createState() => _TempretureSensorState();
}

class _TempretureSensorState extends State<TempretureSensor> {
  var temp= 25;
  generateRandomValues() {
    int random(min, max) {
      return min + Random().nextInt(max - min);
    }

    Timer.periodic(new Duration(seconds: 5), (timer) {
      generateRandomValues();
    });

    setState((){
      temp= random(25, 37);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "Temperature",
            style: TextStyle(fontSize: 20),
          ),
          // ElevatedButton(onPressed:() {generateRandomValues();}, child: Text("check")),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [Text(temp >= 35 ? "${temp.toString()} too hot " : temp.toString())],
          ),
        ],
      ),
    );
  }
}


class KettleMonitor extends StatefulWidget {
  const KettleMonitor({Key? key}) : super(key: key);

  @override
  State<KettleMonitor> createState() => _KettleMonitorState();
}

class _KettleMonitorState extends State<KettleMonitor> {
  var temp= 25;
  generateRandomValues() {
    int random(min, max) {
      return min + Random().nextInt(max - min);
    }

    Timer.periodic(new Duration(seconds: 5), (timer) {
      generateRandomValues();
    });

    setState((){
      temp= random(80, 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "Boiler Monitoring sensor",
            style: TextStyle(fontSize: 20),
          ),
          IconButton(onPressed: (){generateRandomValues();}, icon:  Icon(Icons.remove_red_eye),),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [Text(temp >= 90 ? "${temp.toString()} Warning: the sensor will turn of the device " : temp.toString())],
          ),
        ],
      ),
    );
  }
}
