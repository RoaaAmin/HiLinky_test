
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool status_general_notif = false;
  bool status_sound = false;
  bool status_vibrate = false;
  bool statusA = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        leading: const Icon(Icons.arrow_back_ios),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Common",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("General Notification"),
//switch
                FlutterSwitch(
                  //  activeText: "female",
                  activeColor: const Color.fromARGB(255, 250, 147, 2),
                  //   activeIcon: const Icon(Icons.woman),
                  //  inactiveText: "male",
                  inactiveColor: Colors.grey,
                  //  inactiveIcon: const Icon(Icons.man),
                  width: 70.0,
                  height: 30.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  value: status_general_notif,
                  borderRadius: 30.0,
                  // padding: 5.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      status_general_notif = val;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Sound"),
//switch
                FlutterSwitch(
                  //  activeText: "female",
                  activeColor: const Color.fromARGB(255, 250, 147, 2),
                  //   activeIcon: const Icon(Icons.woman),
                  //  inactiveText: "male",
                  inactiveColor: Colors.grey,
                  //  inactiveIcon: const Icon(Icons.man),
                  width: 70.0,
                  height: 30.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  value: status_sound,
                  borderRadius: 30.0,
                  // padding: 5.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      status_sound = val;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Vibrate"),
//switch
                FlutterSwitch(
                  //  activeText: "female",
                  activeColor: const Color.fromARGB(255, 250, 147, 2),
                  //   activeIcon: const Icon(Icons.woman),
                  //  inactiveText: "male",
                  inactiveColor: Colors.grey,
                  //  inactiveIcon: const Icon(Icons.man),
                  width: 70.0,
                  height: 30.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  value: status_vibrate,
                  borderRadius: 30.0,
                  // padding: 5.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      status_vibrate = val;
                    });
                  },
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              color: Colors.orange,
            ),
            const Text(
              "System & Services Update",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Vibrate"),
//switch
                FlutterSwitch(
                  //  activeText: "female",
                  activeColor: const Color.fromARGB(255, 250, 147, 2),
                  //   activeIcon: const Icon(Icons.woman),
                  //  inactiveText: "male",
                  inactiveColor: Colors.grey,
                  //  inactiveIcon: const Icon(Icons.man),
                  width: 70.0,
                  height: 30.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  value: statusA,
                  borderRadius: 30.0,
                  // padding: 5.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      statusA = val;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Vibrate"),
//switch
                FlutterSwitch(
                  //  activeText: "female",
                  activeColor: const Color.fromARGB(255, 250, 147, 2),
                  //   activeIcon: const Icon(Icons.woman),
                  //  inactiveText: "male",
                  inactiveColor: Colors.grey,
                  //  inactiveIcon: const Icon(Icons.man),
                  width: 70.0,
                  height: 30.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  value: statusA,
                  borderRadius: 30.0,
                  // padding: 5.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      statusA = val;
                    });
                  },
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              color: Colors.orange,
            ),
            const Text(
              "Others",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Vibrate"),
//switch
                FlutterSwitch(
                  //  activeText: "female",
                  activeColor: const Color.fromARGB(255, 250, 147, 2),
                  //   activeIcon: const Icon(Icons.woman),
                  //  inactiveText: "male",
                  inactiveColor: Colors.grey,
                  //  inactiveIcon: const Icon(Icons.man),
                  width: 70.0,
                  height: 30.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  value: statusA,
                  borderRadius: 30.0,
                  // padding: 5.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      statusA = val;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Vibrate"),
//switch
                FlutterSwitch(
                  //  activeText: "female",
                  activeColor: const Color.fromARGB(255, 250, 147, 2),
                  //   activeIcon: const Icon(Icons.woman),
                  //  inactiveText: "male",
                  inactiveColor: Colors.grey,
                  //  inactiveIcon: const Icon(Icons.man),
                  width: 70.0,
                  height: 30.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  value: statusA,
                  borderRadius: 30.0,
                  // padding: 5.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      statusA = val;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
