import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
     List<Item> _data = generateItems();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D4065),
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "Settings",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                    color: const Color(0xFF0D4065)
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),

            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _data[index].isExpanded = !isExpanded;
                });
              },
              children: _data.map<ExpansionPanel>((Item item) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(item.headerValue),
                    );
                  },
                  body: ListTile(
                    title: Text(item.expandedValue),
                    subtitle: item.headerValue == "Privacy and security"
                        ? Row(
                      children: [
                        Icon(Icons.volume_up_outlined,
                            color: const Color(0xFF0D4065)),
                        SizedBox(width: 8),
                        Text('Additional Settings')
                      ],
                    )
                        : null,
                  ),
                  isExpanded: item.isExpanded,
                );
              }).toList(),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                    color: const Color(0xFF0D4065)
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildNotificationOptionRow("New for you", true),
            buildNotificationOptionRow("Account activity", true),
            buildNotificationOptionRow("Opportunity", false),
            SizedBox(
              height: 50,
            ),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
                child: Text("SIGN OUT",
                    style: TextStyle(
                        fontSize: 16, letterSpacing: 2.2, color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            value: isActive,
            onChanged: (bool val) {},
            activeColor: Colors.blue, // Set the active color to blue
          ),
        ),
      ],
    );
  }
}



    class Item {
    Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
    });

    String expandedValue;
    String headerValue;
    bool isExpanded;
    }

    List<Item> generateItems() {
    return [
    Item(
    headerValue: 'Change password',
    expandedValue: 'change your password here',
    ),
    Item(
    headerValue: 'Content settings',
    expandedValue: 'Details about content settings',
    ),
    Item(
    headerValue: 'Email settings',
    expandedValue: 'Details about email settings',
    ),
    Item(
    headerValue: 'Language',
    expandedValue: 'Details about language settings',
    ),
    Item(
    headerValue: 'Privacy and security',
    expandedValue: 'Details about privacy and security settings',
    ),
    ];

  }
