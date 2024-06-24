// import 'package:easylibro_app/widgets/layout_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:easylibro_app/widgets/wave_clipper.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Opacity(
//               opacity: 0.5,
//               child: ClipPath(
//                 clipper: WaveClipper(),
//                 child: Container(
//                   color: const Color(0xFF0D4065),
//                   height: 250,
//                 ),
//               ),
//             ),
//             ClipPath(
//               clipper: WaveClipper(),
//               child: Container(
//                 color: const Color(0xFF0D4065),
//                 height: 242,
//                 child: Center(
//                     child: Image.asset(
//                   "assets/librarylogoRW.png",
//                   scale: 20,
//                 )),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 210, left: 28, right: 28),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text("Sign in",
//                       style: TextStyle(
//                           fontSize: 38,
//                           color: Color(0xFF080C27),
//                           fontFamily: "Inter",
//                           fontWeight: FontWeight.w600)),
//                   const Text("Welcome!",
//                       style: TextStyle(
//                           fontSize: 25,
//                           color: Color(0xFF080C27),
//                           fontFamily: "Inter",
//                           fontWeight: FontWeight.w500)),
//                   const SizedBox(height: 35),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const TextField(
//                         decoration: InputDecoration(
//                             suffixIcon: Icon(
//                               Icons.check,
//                               color: Colors.grey,
//                             ),
//                             label: Text(
//                               'UserName',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontFamily: "Inter",
//                                 color: Color(0xFF080C27),
//                               ),
//                             )),
//                       ),
//                       const TextField(
//                         decoration: InputDecoration(
//                             suffixIcon: Icon(
//                               Icons.visibility_off,
//                               color: Colors.grey,
//                             ),
//                             label: Text(
//                               'Password',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontFamily: "Inter",
//                                 color: Color(0xFF080C27),
//                               ),
//                             )),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           'Forgot Password?',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 15,
//                             color: Color(0xFF0D4065),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const LayoutScreen(currentIndex: 2,)),
//                           );
//                         },
//                         child: Container(
//                           height: 55,
//                           width: 300,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(30),
//                               color: const Color(0xFF0D4065)),
//                           child: const Center(
//                             child: Text(
//                               'SIGN IN',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                   color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Don't have account?",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey),
//                           ),
//                           Text(
//                             "Sign up",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15,
//                                 color: Colors.black),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:easylibro_app/Login/auth_request.dart';
// import 'package:easylibro_app/Login/auth_service.dart';
// import 'package:easylibro_app/Resources/Widgets/alert_box.dart';
// import 'package:easylibro_app/widgets/wave_clipper.dart';
// import 'package:flutter/material.dart';
// import 'package:easylibro_app/widgets/layout_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _userNameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final AuthService _authService = AuthService();

//   Future<void> _login() async {
//     final request = AuthRequest(
//       userName: _userNameController.text,
//       password: _passwordController.text,
//     );

//     try {
//       final response = await _authService.login(request);
//       if (response.message == 'success') {
//         Navigator.push(
//           // ignore: use_build_context_synchronously
//           context,
//           MaterialPageRoute(
//               builder: (context) => const LayoutScreen(currentIndex: 2)),
//         );
//         showDialog(
//             context: context,
//             builder: (BuildContext context) => AlertBox(
//                 content: "Login Successfully!",
//                 icon: Icons.check,
//                 approveText: "ok",
//                 iconColor: Colors.green,
//                 onApprove: () {}));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Login failed: ${response.message}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//       print("$e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Opacity(
//               opacity: 0.5,
//               child: ClipPath(
//                 clipper: WaveClipper(),
//                 child: Container(
//                   color: const Color(0xFF0D4065),
//                   height: 250,
//                 ),
//               ),
//             ),
//             ClipPath(
//               clipper: WaveClipper(),
//               child: Container(
//                 color: const Color(0xFF0D4065),
//                 height: 242,
//                 child: Center(
//                     child: Image.asset(
//                   "assets/librarylogoRW.png",
//                   scale: 20,
//                 )),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 210, left: 28, right: 28),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text("Sign in",
//                         style: TextStyle(
//                             fontSize: 38,
//                             color: Color(0xFF080C27),
//                             fontFamily: "Inter",
//                             fontWeight: FontWeight.w600)),
//                     const Text("Welcome!",
//                         style: TextStyle(
//                             fontSize: 25,
//                             color: Color(0xFF080C27),
//                             fontFamily: "Inter",
//                             fontWeight: FontWeight.w500)),
//                     const SizedBox(height: 35),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         TextField(
//                           controller: _userNameController,
//                           decoration: const InputDecoration(
//                               suffixIcon: Icon(
//                                 Icons.check,
//                                 color: Colors.grey,
//                               ),
//                               label: Text(
//                                 'UserName',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   fontFamily: "Inter",
//                                   color: Color(0xFF080C27),
//                                 ),
//                               )),
//                         ),
//                         TextField(
//                           controller: _passwordController,
//                           obscureText: true,
//                           decoration: const InputDecoration(
//                               suffixIcon: Icon(
//                                 Icons.visibility_off,
//                                 color: Colors.grey,
//                               ),
//                               label: Text(
//                                 'Password',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   fontFamily: "Inter",
//                                   color: Color(0xFF080C27),
//                                 ),
//                               )),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         const Align(
//                           alignment: Alignment.centerRight,
//                           child: Text(
//                             'Forgot Password?',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 15,
//                               color: Color(0xFF0D4065),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 40,
//                         ),
//                         GestureDetector(
//                           onTap: _login,
//                           child: Container(
//                             height: 55,
//                             width: 300,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(30),
//                                 color: const Color(0xFF0D4065)),
//                             child: const Center(
//                               child: Text(
//                                 'SIGN IN',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20,
//                                     color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Don't have account?",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.grey),
//                             ),
//                             Text(
//                               "Sign up",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15,
//                                   color: Colors.black),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:easylibro_app/Login/auth_request.dart';
import 'package:easylibro_app/Login/auth_service.dart';
import 'package:easylibro_app/Resources/Widgets/alert_box.dart';
import 'package:easylibro_app/widgets/wave_clipper.dart';
import 'package:easylibro_app/widgets/layout_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
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
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertBox(
          content: 'Please enter both username and password',
          icon: Icons.error,
          approveText: "ok",
          iconColor: Colors.red,
          onApprove: () {},
        ),
      );
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
      if (response.message == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const LayoutScreen(currentIndex: 2)),
        );
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertBox(
            content: "Login Successfully!",
            icon: Icons.check_circle,
            approveText: "ok",
            iconColor: Colors.green,
            onApprove: () {},
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertBox(
            content: "Login Failed!",
            icon: Icons.error,
            approveText: "ok",
            iconColor: Colors.red,
            onApprove: () {},
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertBox(
          title: "Login Failed!",
          content: "Please check your username and password.",
          icon: Icons.error,
          approveText: "ok",
          iconColor: Colors.red,
          onApprove: () {},
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
                  color: const Color(0xFF0D4065),
                  height: 250,
                ),
              ),
            ),
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: const Color(0xFF0D4065),
                height: 242,
                child: Center(
                    child: Image.asset(
                  "assets/librarylogoRW.png",
                  scale: 20,
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 210, left: 28, right: 28),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Sign in",
                        style: TextStyle(
                            fontSize: 38,
                            color: Color(0xFF080C27),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600)),
                    const Text("Welcome!",
                        style: TextStyle(
                            fontSize: 25,
                            color: Color(0xFF080C27),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 35),
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Color(0xFF0D4065),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: _login,
                          child: Container(
                            height: 55,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xFF0D4065)),
                            child: Center(
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    )
                                  : const Text(
                                      'SIGN IN',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            Text(
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                          ],
                        )
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
