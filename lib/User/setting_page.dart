import 'package:easylibro_app/User/user_service.dart';
import 'package:easylibro_app/widgets/loading_indictor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
// ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  UserService userService = UserService();
  bool _isObscured = true;
  bool isloading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            SizedBox(width: 10.w),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                message,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.white,
            ),
            SizedBox(width: 10.w),
            Text(
              message,
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _changePassword() async {
    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      _showErrorSnackbar("Please fill all fields.");
      return;
    }

    if (newPassword != confirmPassword) {
      _showErrorSnackbar("New Passwords do not match.");
      return;
    }
    try {
      setState(() {
        isloading = true;
      });
      final success =
          await userService.changePassword(oldPassword, newPassword);
      _oldPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      setState(() {
        isloading = false;
      });
      if (success) {
        _showSuccessSnackbar("Password changed successfully.");
      } else {
        _showErrorSnackbar("Failed to change password.");
      }
    } catch (e) {
      setState(() {
        isloading = false;
      });
      _showErrorSnackbar("Failed to change password.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [Scaffold(
          backgroundColor: const Color(0xFFF7F8FD),
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
            padding: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: ListView(children: [
              Text(
                "Change Password:",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Inter',
                  color: Color(0xFF080C27),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.h, left: 10.w, right: 10.w),
                child: Center(
                  child: Container(
                    child: Column(
                      children: [
                        _buildTextField("Enter your current password",
                            _oldPasswordController, Icons.lock_outline),
                        _buildTextField("Enter your new password",
                            _newPasswordController, Icons.lock_outline),
                        _buildTextField("Confirm your new password",
                            _confirmPasswordController, Icons.lock_outline),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
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
                                child: Text("Reset",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _changePassword();
                              },
                              child: Container(
                                width: 170.sp,
                                height: 50.sp,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0D4065),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text("Confirm",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
        if (isloading)
        Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: MyLoadingIndicator(),
          ),
        ),
      ]),
    );
  }

  Widget _buildTextField(
      String labelText, TextEditingController controller, IconData iconData) {
    return Padding(
      padding: EdgeInsets.only(bottom: 35.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          TextField(
            controller: controller,
            obscureText: _isObscured,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 3.h),
              floatingLabelBehavior: FloatingLabelBehavior.always,
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
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black,
                ),
                onPressed: _togglePasswordVisibility,
              ),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xFF0D4065), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: const Color.fromARGB(255, 174, 173, 173), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
