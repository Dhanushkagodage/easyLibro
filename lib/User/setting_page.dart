import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  String _currentPassword = '';
  String _newPassword = '';
  // ignore: unused_field
  String _confirmPassword = '';
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
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

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                    width: 8.w,
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
              SizedBox(height:20.0),
              ExpansionTile(
                title: Text(
                  "Change Password",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                     color: Colors.grey,
                  ),
                ),
                children: <Widget>[

                  ListTile(
                    title: Text('Current Password'), // Correct usage of title
                    subtitle: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter your current password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true, // For password input
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _currentPassword = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text('New Password'),
                    subtitle: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter your new password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newPassword = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text('Confirm New Password'),
                    subtitle: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Confirm your new password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your new password';
                        }
                        if (value != _newPassword) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _confirmPassword = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Process the password, e.g., send it to the server or authenticate locally
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Password: $_currentPassword')),
                        );
                      }
                    },

                    child: Text('Confirm'),
                  ),
                ],
              ),


              SizedBox(
                height: 40.h,
              ),
              Row(
                children: [
                  Icon(
                      Icons.notifications,
                      color: const Color(0xFF0D4065)
                  ),
                  SizedBox(
                    width: 8.w,
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
              buildNotificationOptionRow("Extend dates", false),
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
                          fontSize: 16, letterSpacing: 2.2, color: Colors.black )),
                ),
              )
                ],
              ),



        ),
        ]
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