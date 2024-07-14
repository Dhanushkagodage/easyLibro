import 'package:easylibro_app/User/setting_page.dart';
import 'package:easylibro_app/widgets/loading_indictor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easylibro_app/Login/login_screen.dart';
import 'package:easylibro_app/widgets/alert_box.dart';
import 'package:easylibro_app/User/user_service.dart';
import 'package:easylibro_app/User/userdetails.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _dobController = TextEditingController();
  UserService userService = UserService();
  UserDetails? userDetails;

  @override
  void initState() {
    super.initState();
    _dobController.text = "01/01/2000";
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      UserDetails user = await userService.fetchUserDetails();
      setState(() {
        userDetails = user;
        // Update text fields if needed
        _dobController.text = user.dob ?? "01/01/2000"; // Example update
      });
    } catch (e) {
      // Handle error fetching user details
      print('Error fetching user details: $e');
    }
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
                            builder: (BuildContext context) => SettingsPage(),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout_outlined,
                          color: Colors.white),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Logout!"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Are you sure you want to logout?"),
                                SizedBox(height: 10.h),
                                Icon(Icons.warning_rounded,
                                    color: Colors.red, size: 60.sp),
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
                                  final SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  sharedPreferences.clear();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const LoginScreen()),
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
            body: userDetails == null
                ? Center(child: MyLoadingIndicator())
                : Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F8FD),
                    ),
                    child: ListView(children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 30.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 20.h, bottom: 20.h),
                                child: Text(
                                  'Edit Profile:',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'Inter',
                                    color: Color(0xFF080C27),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 120.sp,
                                      height: 120.sp,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2.sp,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 5.sp,
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              NetworkImage(userDetails!.image),
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
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
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
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 35.h),
                      Padding(
                          padding: EdgeInsets.only(left: 30.w, right: 30.w),
                          child: Container(
                              child: Column(children: [
                            _buildTextField(
                                "First Name", userDetails!.fName, Icons.person),
                            _buildTextField(
                                "Last Name", userDetails!.lName, Icons.person),
                            _buildTextField(
                                "Gender", userDetails!.gender, Icons.person),
                            _buildTextField(
                                "Date of Birth", userDetails!.dob, Icons.person,
                                isDobField: true),
                            _buildTextField(
                                "Address", userDetails!.address, Icons.home),
                            _buildTextField(
                                "Mobile", userDetails!.phone, Icons.call),
                          ]))),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.h, bottom: 20.h, left: 20.w, right: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 170.sp,
                              height: 50.sp,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 205, 205, 205),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text("Cancel",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                            Container(
                              width: 170.sp,
                              height: 50.sp,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0D4065),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text("Save",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]))));
  }

  Widget _buildTextField(String labelText, String detailText, IconData iconData,
      {bool isDobField = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 35.h),
      child: TextField(
        controller: isDobField ? _dobController : null,
        readOnly: isDobField,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3.h),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: detailText,
          hintStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          prefixIcon: Container(
            width: 26.sp,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 30.sp,
                  height: 30.sp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
                Center(
                  child: Icon(
                    iconData,
                    size: 20.sp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          suffixIcon: isDobField
              ? IconButton(
                  icon: Icon(Icons.calendar_today, color: Colors.black),
                  onPressed: () async {
                    DateTime? pickedDate = await showDialog<DateTime>(
                      context: context,
                      builder: (BuildContext context) {
                        return DatePickerDialog(
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                      },
                    );

                    if (pickedDate != null) {
                      setState(() {
                        _dobController.text =
                            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                      });
                    }
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: const Color(0xFF0D4065), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 174, 173, 173), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // Widget _datePicker() {
  //   return DatePicker(
  //     centerLeadingDate: true,
  //     minDate: DateTime(2020),
  //     maxDate: DateTime(2024),
  //     initialDate: DateTime(2023, 1),
  //   );
  // }
}
