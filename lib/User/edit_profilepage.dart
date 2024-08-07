import 'dart:io';
import 'package:easylibro_app/Login/login_screen.dart';
import 'package:easylibro_app/Notifications/notification_service.dart';
import 'package:easylibro_app/User/setting_page.dart';
import 'package:easylibro_app/User/user_service.dart';
import 'package:easylibro_app/User/userdetails.dart';
import 'package:easylibro_app/screens/error_screen.dart';
import 'package:easylibro_app/widgets/alert_box.dart';
import 'package:easylibro_app/widgets/loading_indictor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  UserService userService = UserService();
  UserDetails? userDetails;
  File? _imageFile;
  bool hasError = false;
  final _picker = ImagePicker();
  String imageURL = '';
  NotificationService notificationService = NotificationService();
  String userName = '';
  String firebaseToken = '';
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Color _savecontainerColor = const Color(0xFF0D4065);

  void _savebutton() {
    setState(() {
      _savecontainerColor = Color.fromARGB(160, 13, 64, 101);
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _savecontainerColor = const Color(0xFF0D4065);
      });
    });
  }

  Color _resetcontainerColor = Color.fromARGB(255, 205, 205, 205);

  void _resetbutton() {
    setState(() {
      _resetcontainerColor = Color.fromARGB(160, 205, 205, 205);
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _resetcontainerColor = Color.fromARGB(255, 205, 205, 205);
      });
    });
  }

  Future<void> fetchUserDetails() async {
    try {
      UserDetails user = await userService.fetchUserDetails();
      setState(() {
        userDetails = user;
        _dobController.text = user.dob;
        _fNameController.text = user.fName;
        _lNameController.text = user.lName;
        _genderController.text = user.gender;
        _addressController.text = user.address;
        _phoneController.text = user.phone;
      });
    } catch (e) {
      setState(() {
        hasError = true;
      });
      _showErrorSnackbar("Error fetching user details");
    }
  }

  Future<void> editUserDetails() async {
    try {
      setState(() {
        isloading = true;
      });
      bool success = await userService.editUserDetails(
        _fNameController.text,
        _lNameController.text,
        _dobController.text,
        _addressController.text,
        _phoneController.text,
        _genderController.text,
      );
      if (success) {
        fetchUserDetails();
        setState(() {
          isloading = false;
        });
        _showSuccessSnackbar("User details updated successfully");
      } else {
        setState(() {
          isloading = false;
        });
        _showErrorSnackbar("Failed to update user details");
      }
    } catch (e) {
      _showErrorSnackbar("Error updating user details");
    }
  }

  Future<void> selectImage() async {
    final image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
      await uploadImageToCloudinary(_imageFile!);
    }
  }

  Future<void> uploadImageToCloudinary(File image) async {
    final cloudinary = CloudinaryPublic('dxkaiqscs', 'myCloud', cache: false);
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image),
      );
      setState(() {
        imageURL = response.secureUrl;
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> editUserImage() async {
    try {
      //print('Image URL: $imageURL');
      bool result = await userService.editUserImage(imageURL);
      //print('Image upload result: $result');
      if (result) {
        fetchUserDetails();
      } else {
        _showErrorSnackbar("Image upload failed");
      }
    } catch (e) {
      // _showErrorSnackbar("Error uploading image");
    }
  }

  void resetFields() {
    setState(() {
      if (userDetails != null) {
        _dobController.text = userDetails!.dob;
        _fNameController.text = userDetails!.fName;
        _lNameController.text = userDetails!.lName;
        _genderController.text = userDetails!.gender;
        _addressController.text = userDetails!.address;
        _phoneController.text = userDetails!.phone;
        _imageFile = null;
      }
      _showSuccessSnackbar("Fields are reset");
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

  Future<void> _handleRefresh() async {
    await fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      Scaffold(
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
                    icon:
                        const Icon(Icons.logout_outlined, color: Colors.white),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertBox(
                                title: "Logout!",
                                content: "Are you sure you want to logout?",
                                approveText: "Yes, Logout",
                                cancelText: "Cancel",
                                icon: Icons.warning_rounded,
                                iconColor: Colors.red,
                                onApprove: () async {
                                  final SharedPreferences localStorage =
                                      await SharedPreferences.getInstance();
                                  final firebaseToken =
                                      localStorage.getString('firebaseToken');
                                  final userName =
                                      localStorage.getString('userName');
                                  localStorage.clear();
                                  await notificationService.removeToken(
                                      firebaseToken!, userName!);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const LoginScreen()),
                                  );
                                  _showSuccessSnackbar(
                                      "Logged out successfully");
                                },
                                onCancel: () {
                                  Navigator.of(context).pop();
                                });
                          });
                    },
                  ),
                ],
              ),
            ],
          ),
          body: userDetails == null
              ? Center(child: MyLoadingIndicator())
              : hasError
                  ? Expanded(
                      child: ErrorScreen(),
                    )
                  : RefreshIndicator(
                      onRefresh: _handleRefresh,
                      color: Color(0xFF080C27),
                      backgroundColor: Colors.white,
                      child: Container(
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
                                      padding: EdgeInsets.only(
                                          top: 20.h, bottom: 20.h),
                                      child: Text(
                                        'Edit Profile:',
                                        style: TextStyle(
                                          fontSize: 15.sp,
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
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  offset: const Offset(0, 5),
                                                ),
                                              ],
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: _imageFile != null
                                                    ? FileImage(_imageFile!)
                                                    : NetworkImage(
                                                        userDetails!.image),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: selectImage,
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
                                                  color:
                                                      const Color(0xFF0D4065),
                                                ),
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                ),
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
                                padding:
                                    EdgeInsets.only(left: 30.w, right: 30.w),
                                child: Container(
                                    child: Column(children: [
                                  _buildTextField(
                                      "First Name",
                                      _fNameController,
                                      userDetails!.fName,
                                      Icons.person),
                                  _buildTextField("Last Name", _lNameController,
                                      userDetails!.lName, Icons.person),
                                  _buildTextField("Gender", _genderController,
                                      userDetails!.gender, Icons.person),
                                  _buildTextField(
                                      "Date of Birth",
                                      _dobController,
                                      userDetails!.dob,
                                      Icons.person,
                                      isDobField: true),
                                  _buildTextField("Address", _addressController,
                                      userDetails!.address, Icons.home),
                                  _buildTextField("Mobile", _phoneController,
                                      userDetails!.phone, Icons.call),
                                ]))),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10.h,
                                  bottom: 20.h,
                                  left: 20.w,
                                  right: 20.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _resetbutton();
                                      resetFields();
                                    },
                                    child: Container(
                                      width: 170.sp,
                                      height: 50.sp,
                                      decoration: BoxDecoration(
                                        color: _resetcontainerColor,
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
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _savebutton();
                                      editUserDetails();
                                      editUserImage();
                                    },
                                    child: Container(
                                      width: 170.sp,
                                      height: 50.sp,
                                      decoration: BoxDecoration(
                                        color: _savecontainerColor,
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
                                  ),
                                ],
                              ),
                            ),
                          ])),
                    )),
      if (isloading)
        Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: MyLoadingIndicator(),
          ),
        ),
    ]));
  }

  Widget _buildTextField(
    String labelText,
    TextEditingController controller,
    String detailText,
    IconData iconData, {
    bool isDobField = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 35.h),
      child: TextField(
        controller: controller,
        readOnly: isDobField,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3.h),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: detailText,
          hintStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
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
                  icon:
                      Icon(Icons.calendar_today_outlined, color: Colors.black),
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
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
}
