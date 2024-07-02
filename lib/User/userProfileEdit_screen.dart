// import 'package:easylibro_app/Login/login_screen.dart';
// import 'package:easylibro_app/Resources/Widgets/alert_box.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class EditProfilePage extends StatefulWidget {
  
//   const EditProfilePage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _EditProfilePageState createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF0D4065),
//           elevation: 1,
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           actions: [
//             Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(
//                     Icons.settings,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     // Navigator.of(context).push(
//                     //   MaterialPageRoute(
//                     //     builder: (BuildContext context) =>  SettingsPage(),
//                     //   ),
//                     // );
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(
//                     Icons.logout_outlined,
//                     color: Colors.white,
//                   ),
//                   onPressed: () async {
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext) => AlertDialog(
//                               title: const Text("Logout!"),
//                               content: const Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text("Are you sure you want to logout?"),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Icon(
//                                     Icons.warning_rounded,
//                                     color: Colors.red,
//                                     size: 60,
//                                   ),
//                                 ],
//                               ),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: const Text("Cancel"),
//                                 ),
//                                 TextButton(
//                                   onPressed: () async {
//                                     final SharedPreferences sharedPreferences =
//                                         await SharedPreferences.getInstance();
//                                     sharedPreferences.clear();
//                                     Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                         builder: (BuildContext) =>
//                                             LoginScreen(),
//                                       ),
//                                     );
//                                     showDialog(
//                                         context: context,
//                                         builder: (BuildContext) => AlertBox(
//                                             content: "You have been logged out!",
//                                             approveText: "OK",
//                                             icon: Icons.check_circle,
//                                             iconColor: Colors.green,
//                                             onApprove: (){}));
//                                   },
//                                   child: const Text("Yes, Logout"),
//                                 ),
//                               ],
//                             ));
//                     // builder: (BuildContext) => AlertBox(
//                     //       content: "Are you sure you want to logout?",
//                     //       approveText: "Yes, Logout",
//                     //       cancelText: "Cancel",
//                     //       onCancel: () {
//                     //         Navigator.of(context).pop();
//                     //       },
//                     //       icon: Icons.warning_rounded,
//                     //       iconColor: Colors.red,
//                     //       onApprove: () async {
//                     //         final SharedPreferences sharedPreferences =
//                     //             await SharedPreferences.getInstance();
//                     //         sharedPreferences.clear();
//                     //         Navigator.of(context).push(
//                     //           MaterialPageRoute(
//                     //             builder: (BuildContext) =>
//                     //                 LoginScreen(),
//                     //           ),
//                     //         );
//                     //       },
//                     //     ));
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//         body: Container(
//           padding:
//               const EdgeInsets.only(left: 25, top: 20, right: 25, bottom: 20),
//           child: ListView(
//             children: [
//               const Text(
//                 "Edit Profile",
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               Center(
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 130,
//                       height: 130,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           width: 4,
//                           color: Theme.of(context).scaffoldBackgroundColor,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             spreadRadius: 2,
//                             blurRadius: 10,
//                             color: Colors.black.withOpacity(0.1),
//                             offset: const Offset(0, 10),
//                           )
//                         ],
//                         shape: BoxShape.circle,
//                         image: const DecorationImage(
//                           fit: BoxFit.cover,
//                           image: NetworkImage(
//                             "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             width: 4,
//                             color: Theme.of(context).scaffoldBackgroundColor,
//                           ),
//                           color: const Color(0xFF0D4065),
//                         ),
//                         child: const Icon(
//                           Icons.edit,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 35,
//               ),
//               buildTextField("First Name", "Nipuni"),
//               buildTextField("Last Name", "Anuradha"),
//               buildDatePicker(context, "Date of Birth", "Select Date"),
//               buildTextField("NIC", "2000787889"),
//               buildTextField("Address", "Matara"),
//               buildTextField("Mobile", "0112324787"),
//               buildTextField("E-mail", "alexd@gmail.com"),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     OutlinedButton(
//                       onPressed: () {},
//                       style: OutlinedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(horizontal: 50),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       child: const Text(
//                         "CANCEL",
//                         style: TextStyle(
//                           fontSize: 14,
//                           letterSpacing: 2.2,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF0D4065),
//                         padding: const EdgeInsets.symmetric(horizontal: 50),
//                         elevation: 2,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       child: const Text(
//                         "SAVE",
//                         style: TextStyle(
//                           fontSize: 14,
//                           letterSpacing: 2.2,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(String labelText, String detailText) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 35.0),
//       child: TextField(
//         decoration: InputDecoration(
//           contentPadding: const EdgeInsets.only(bottom: 3),
//           labelText: labelText,
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           hintText: detailText,
//           hintStyle: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget buildDatePicker(
//     BuildContext context, String labelText, String placeholder) {
//   TextEditingController dateController = TextEditingController();

//   return Padding(
//     padding: const EdgeInsets.only(bottom: 35.0),
//     child: GestureDetector(
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(1900),
//           lastDate: DateTime(2100),
//         );
//         if (pickedDate != null) {
//           dateController.text =
//               "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
//         }
//       },
//       child: AbsorbPointer(
//         child: TextField(
//           controller: dateController,
//           decoration: InputDecoration(
//             contentPadding: const EdgeInsets.only(bottom: 3),
//             labelText: labelText,
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             hintText: placeholder,
//             hintStyle: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }


import 'package:easylibro_app/Login/login_screen.dart';
import 'package:easylibro_app/Resources/Widgets/alert_box.dart';
import 'package:easylibro_app/User/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
 // final UserDetails userDetails;
  const EditProfilePage({super.key, });

  @override
  // ignore: library_private_types_in_public_api
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D4065),
          elevation: 1,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) =>  SettingsPage(),
                    //   ),
                    // );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext) => AlertDialog(
                              title: const Text("Logout!"),
                              content: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Are you sure you want to logout?"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Icon(
                                    Icons.warning_rounded,
                                    color: Colors.red,
                                    size: 60,
                                  ),
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
                                        builder: (BuildContext) =>
                                            LoginScreen(),
                                      ),
                                    );
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext) => AlertBox(
                                            content: "You have been logged out!",
                                            approveText: "OK",
                                            icon: Icons.check_circle,
                                            iconColor: Colors.green,
                                            onApprove: (){}));
                                  },
                                  child: const Text("Yes, Logout"),
                                ),
                              ],
                            ));
                    // builder: (BuildContext) => AlertBox(
                    //       content: "Are you sure you want to logout?",
                    //       approveText: "Yes, Logout",
                    //       cancelText: "Cancel",
                    //       onCancel: () {
                    //         Navigator.of(context).pop();
                    //       },
                    //       icon: Icons.warning_rounded,
                    //       iconColor: Colors.red,
                    //       onApprove: () async {
                    //         final SharedPreferences sharedPreferences =
                    //             await SharedPreferences.getInstance();
                    //         sharedPreferences.clear();
                    //         Navigator.of(context).push(
                    //           MaterialPageRoute(
                    //             builder: (BuildContext) =>
                    //                 LoginScreen(),
                    //           ),
                    //         );
                    //       },
                    //     ));
                  },
                ),
              ],
            ),
          ],
        ),
        body: Container(
          padding:
              const EdgeInsets.only(left: 25, top: 20, right: 25, bottom: 20),
          child: ListView(
            children: [
              const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10),
                          )
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
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
              const SizedBox(
                height: 35,
              ),
              buildTextField("First Name", "widget.userDetails.fName"),
              buildTextField("Last Name", "widget.userDetails.lName"),
              buildDatePicker(context, "Date of Birth", "widget.userDetails.dob"),
              buildTextField("NIC", "widget.userDetails.nic"),
              buildTextField("Address", "widget.userDetails.address"),
              buildTextField("Mobile"," widget.userDetails.phone"),
              buildTextField("E-mail", "widget.userDetails.email"),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
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
                      onPressed: () {},
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String detailText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: detailText,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,            
          ),
        ),
      ),
    );
  }
}

Widget buildDatePicker(
    BuildContext context, String labelText, String placeholder) {
  TextEditingController dateController = TextEditingController();

  return Padding(
    padding: const EdgeInsets.only(bottom: 35.0),
    child: GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          dateController.text =
              "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
        }
      },
      child: AbsorbPointer(
        child: TextField(
          controller: dateController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
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
