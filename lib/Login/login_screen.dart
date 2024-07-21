import 'package:easylibro_app/Notifications/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:easylibro_app/Login/auth_request.dart';
import 'package:easylibro_app/Login/auth_service.dart';
import 'package:easylibro_app/widgets/wave_clipper.dart';
import 'package:easylibro_app/widgets/layout_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/link.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final NotificationService notificationService = NotificationService();
  String? firebasetoken;

  final String url = 'https://easylibro.online/LogIN/ForgetPassword';

  bool _isLoading = false;

  bool _isObscured = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final userName = _userNameController.text;
    final password = _passwordController.text;

    if (userName.isEmpty || password.isEmpty) {
      _showErrorSnackbar("Please Enter Both Username and Password");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final request = AuthRequest(
      userName: userName,
      password: password,
    );

    try {
      final response = await _authService.login(request);
      await _authService.saveUserData(userName, response.accessToken);

      if (response.message == 'success') {
        try {
          final firebaseToken = await FirebaseMessaging.instance.getToken();
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          await localStorage.setString('firebaseToken', firebaseToken!);
          final firebasetoken = localStorage.getString('firebaseToken');
          print('firebaseToken1:$firebasetoken');
          print('firebaseToken2:$firebaseToken');
          await notificationService.setToken(firebaseToken, userName);

          print('firebaseToken2:$firebaseToken');
        } catch (e) {
          print("Error in getting firebase token");
        }

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LayoutScreen(
                    currentIndex: 2,
                  )),
        );
        _showSuccessSnackbar('Login Successfully!');
        final SharedPreferences localStorage =
            await SharedPreferences.getInstance();
        localStorage.setString('userName', userName);
      } else {
        _showErrorSnackbar('Invalid username or password');
      }
    } catch (e) {
      _showErrorSnackbar('Login failed!');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                 color: Colors.blue,
                  height: 290.h,
                ),
              ),
            ),
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: const Color(0xFF0D4065),
                height: 282.h,
                child: Center(
                    child: Image.asset(
                  "assets/logo.png",
                  scale: 14.sp,
                )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 260.h, left: 28.w, right: 28.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sign in",
                        style: TextStyle(
                            fontSize: 38.sp,
                            color: Color(0xFF080C27),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600)),
                    Text("Welcome!",
                        style: TextStyle(
                            fontSize: 25.sp,
                            color: Color(0xFF080C27),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 35.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _userNameController,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.check,
                                color: Colors.grey,
                              ),
                              label: Text(
                                'UserName',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Inter",
                                  color: Color(0xFF080C27),
                                ),
                              )),
                        ),
                        TextField(
                          controller: _passwordController,
                          obscureText: _isObscured,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                              label: Text(
                                'Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Inter",
                                  color: Color(0xFF080C27),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Link(
                            uri: Uri.parse(url),
                            target: LinkTarget.blank,
                            builder: (context, followLink) {
                              return GestureDetector(
                                onTap: followLink,
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.sp,
                                    color: Color(0xFF0D4065),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        GestureDetector(
                          onTap: _login,
                          child: Container(
                            height: 55.h,
                            width: 300.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.sp),
                                color: const Color(0xFF0D4065)),
                            child: Center(
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    )
                                  : Text(
                                      'SIGN IN',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp,
                                          color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
