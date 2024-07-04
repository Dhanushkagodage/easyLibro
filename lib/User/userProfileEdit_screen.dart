// ignore_for_file: file_names

import 'package:easylibro_app/User/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easylibro_app/Login/login_screen.dart';
import 'package:easylibro_app/Resources/Widgets/alert_box.dart';
import 'package:easylibro_app/User/user_service.dart';
import 'package:easylibro_app/User/userdetails.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late Future<UserDetails> futureUserDetails;

  @override
  void initState() {
    super.initState();
    futureUserDetails = UserService().fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D4065),
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>  SettingsPage(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.logout_outlined, color: Colors.white),
                  onPressed: () async {

                    
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Logout!"),
                        content:  Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Are you sure you want to logout?"),
                            SizedBox(height: 10.h),
                            Icon(Icons.warning_rounded, color: Colors.red, size: 60.sp),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              sharedPreferences.clear();
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()),
                              );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertBox(
                                  content: "You have been logged out!",
                                  approveText: "OK",
                                  icon: Icons.check_circle,
                                  iconColor: Colors.green,
                                  onApprove: () {},
                                ),
                              );
                            },
                            child: const Text("Yes, Logout"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        body: FutureBuilder<UserDetails>(
          future: futureUserDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              UserDetails userDetails = snapshot.data!;
              return Container(
                padding:  EdgeInsets.all(25.sp),
                child: ListView(
                  children: [
                     Text(
                      "Edit Profile",
                      style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w400),
                    ),
                     SizedBox(height: 15.h),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130.w,
                            height: 130.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 4.w,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 10),
                                ),
                              ],
                              shape: BoxShape.circle,
                              image:  DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  userDetails.image
                                 
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: const Color(0xFF0D4065),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                     SizedBox(height: 35.h),
                    buildTextField("First Name", userDetails.fName),
                    buildTextField("Last Name", userDetails.lName),
                    buildTextField("Gender", userDetails.gender),
                    buildDatePicker(context, "Date of Birth", userDetails.dob),
                    buildTextField("Address", userDetails.address),
                    buildTextField("Mobile", userDetails.phone),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              padding:  EdgeInsets.symmetric(horizontal: 50.w),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              "CANCEL",
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertBox(
                                  content: "Profile updated successfully!",
                                  approveText: "OK",
                                  icon: Icons.check_circle,
                                  iconColor: Colors.green,
                                  onApprove: () {},
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D4065),
                              padding: const EdgeInsets.symmetric(horizontal: 50),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              "SAVE",
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No user data found'));
            }
          },
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String detailText) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 35.0.h),
      child: TextField(
        decoration: InputDecoration(
          contentPadding:  EdgeInsets.only(bottom: 3.h),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: detailText,
          hintStyle:  TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildDatePicker(BuildContext context, String labelText, String placeholder) {
    
    TextEditingController dateController = TextEditingController(text: placeholder);

    return Padding(
      padding:  EdgeInsets.only(bottom: 35.0.h),
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.tryParse(placeholder) ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            dateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
          }
        },
        child: AbsorbPointer(
          child: TextField(
            controller: dateController,
            decoration: InputDecoration(
              contentPadding:  EdgeInsets.only(bottom: 3.h),
              labelText: labelText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeholder,
              hintStyle:  TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
