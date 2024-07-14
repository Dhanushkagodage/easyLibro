// import 'package:easylibro_app/Notifications/notification.dart';
// import 'package:easylibro_app/Notifications/notification_service.dart';
// import 'package:easylibro_app/widgets/loading_indictor.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// enum Action { share, delete, archive }

// class NotificationScreen extends StatefulWidget {
//   final VoidCallback fetchunreadcount;
//   const NotificationScreen({super.key, required this.fetchunreadcount});

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   bool isLoading = true;
//   List<NotificationDetails> allNotifications = [];
//   List<NotificationDetails> readNotifications = [];
//   List<NotificationDetails> unreadNotifications = [];
//   int selectedTabIndex = 1;

//   NotificationService notificationService = NotificationService();

//   @override
//   void initState() {
//     super.initState();
//     fetchNotifications();
//     widget.fetchunreadcount();
//   }

//   Future<void> fetchNotifications() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       final notifications = await notificationService.fetchNotifications();
//       notifications.sort((a, b) => b.ago.compareTo(a.ago));
//       allNotifications = notifications;
//       readNotifications = notifications
//           .where((notification) => notification.status == 'read')
//           .toList();
//       unreadNotifications = notifications
//           .where((notification) => notification.status == 'unread')
//           .toList();

//     } catch (e) {
//       print('Error fetching notifications: $e');
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   List<NotificationDetails> getCurrentNotifications() {
//     return selectedTabIndex == 0 ? readNotifications : unreadNotifications;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F8FD),
//       body: Padding(
//         padding: EdgeInsets.only(top: 20.sp, right: 20.sp, left: 20.sp),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(bottom: 10.sp),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'My Notifications:',
//                     style: TextStyle(
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Container(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _notifyCategory(0, 'Read'),
//                         _notifyCategory(1, 'Unread'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             isLoading
//                 ? Expanded(
//                     child: Center(child: MyLoadingIndicator()),
//                   )
//                 : Expanded(
//                     child: CustomScrollView(
//                       slivers: [
//                         SliverList(
//                           delegate: SliverChildBuilderDelegate(
//                             (context, index) {
//                               final notification =
//                                   getCurrentNotifications()[index];
//                               return Padding(
//                                 padding: EdgeInsets.only(top: 5.sp),
//                                 child: Slidable(
//                                   key: Key(notification.id.toString()),
//                                   startActionPane: ActionPane(
//                                     motion: const StretchMotion(),
//                                     dismissible: DismissiblePane(
//                                       onDismissed: () =>
//                                           _onDismissed(index, Action.share),
//                                     ),
//                                     children: const [],
//                                   ),
//                                   endActionPane: ActionPane(
//                                     motion: const BehindMotion(),
//                                     dismissible: DismissiblePane(
//                                       onDismissed: () =>
//                                           _onDismissed(index, Action.delete),
//                                     ),
//                                     children: [
//                                       SlidableAction(
//                                         backgroundColor: Colors.red,
//                                         icon: Icons.delete,
//                                         label: 'Delete',
//                                         onPressed: (context) =>
//                                             _onDismissed(index, Action.delete),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(
//                                           color: Colors.grey, width: 1.sp),
//                                       borderRadius: BorderRadius.circular(8.sp),
//                                     ),
//                                     child: buildNotificationListTile(
//                                         notification, index),
//                                   ),
//                                 ),
//                               );
//                             },
//                             childCount: getCurrentNotifications().length,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildNotificationListTile(
//       NotificationDetails notification, int index) {
//     return Builder(
//       builder: (context) => ListTile(
//         contentPadding: EdgeInsets.all(16.sp),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Flexible(
//               fit: FlexFit.tight,
//               child: Text(
//                 notification.subject,
//                 style: TextStyle(
//                   fontSize: 15.sp,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             if (notification.status == 'unread')
//               IconButton(
//                 onPressed: () async {
//                   setState(() {
//                     unreadNotifications.removeAt(index);
//                     readNotifications.add(notification);
//                   });
//                   try {
//                     await notificationService.markAsRead(notification.id);
//                     widget.fetchunreadcount();
//                   } catch (e) {
//                     print(e);
//                     _showSnackBar(
//                         context, 'Failed to mark as read, $e', Colors.red);
//                     setState(() {
//                       readNotifications.remove(notification);
//                       unreadNotifications.insert(index, notification);
//                     });
//                   }
//                 },
//                 icon: Icon(
//                   Icons.remove_red_eye_outlined,
//                   color: Colors.blue,
//                   size: 25.sp,
//                 ),
//               ),
//           ],
//         ),
//         subtitle: Column(
//           children: [
//             Text(
//               notification.description,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             SizedBox(height: 5.sp),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text(
//                   notification.ago == 0
//                       ? 'Today'
//                       : '${notification.ago} days ago',
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         leading: Container(
//           width: 40.sp,
//           height: 40.sp,
//           decoration: BoxDecoration(
//             color: Colors.blue,
//             borderRadius: BorderRadius.circular(20.sp),
//           ),
//           child: Icon(
//             Icons.notifications_active,
//             color: Color.fromARGB(255, 3, 16, 27),
//             size: 25.sp,
//           ),
//         ),
//       ),
//     );
//   }

//   void _onDismissed(int index, Action action) {
//     setState(() {
//       final currentNotifications = getCurrentNotifications();
//       currentNotifications.removeAt(index);

//       allNotifications = [...readNotifications, ...unreadNotifications];
//     });

//     if (action == Action.delete) {
//       _showSnackBar(context, 'Notification deleted', Colors.red);
//     }
//   }

//   void _showSnackBar(BuildContext context, String message, Color color) {
//     final snackBar = SnackBar(
//       content: Text(message),
//       backgroundColor: color,
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   Widget _notifyCategory(int index, String category) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedTabIndex = index;
//         });
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: selectedTabIndex == index ? Colors.blue : Colors.white,
//           border: Border.all(color: Colors.blue, width: 1.sp),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
//           child: Text(
//             category,
//             style: TextStyle(
//               fontSize: 16.sp,
//               color: selectedTabIndex == index ? Colors.white : Colors.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:easylibro_app/Notifications/notification.dart';
import 'package:easylibro_app/Notifications/notification_service.dart';
import 'package:easylibro_app/widgets/loading_indictor.dart';

enum Action { share, delete, archive }

class NotificationScreen extends StatefulWidget {
  final VoidCallback fetchunreadcount;
  const NotificationScreen({super.key, required this.fetchunreadcount});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isLoading = true;
  List<NotificationDetails> allNotifications = [];
  List<NotificationDetails> readNotifications = [];
  List<NotificationDetails> unreadNotifications = [];
  int selectedTabIndex = 1;

  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    fetchNotifications();
    widget.fetchunreadcount();
  }

  Future<void> fetchNotifications() async {
    setState(() {
      isLoading = true;
    });
    try {
      final notifications = await notificationService.fetchNotifications();

      // Sort all notifications by 'ago' descending
      //notifications.sort((a, b) => b.ago.compareTo(a.ago));
      notifications.sort((a, b) => a.ago.compareTo(b.ago));

      // Separate into read and unread notifications
      readNotifications = notifications
          .where((notification) => notification.status == 'read')
          .toList();
      unreadNotifications = notifications
          .where((notification) => notification.status == 'unread')
          .toList();
    } catch (e) {
      print('Error fetching notifications: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<NotificationDetails> getCurrentNotifications() {
    return selectedTabIndex == 0 ? readNotifications : unreadNotifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FD),
      body: Padding(
        padding: EdgeInsets.only(top: 20.sp, right: 20.sp, left: 20.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Notifications:',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                      color: Color(0xFF080C27),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _notifyCategory(0, 'Read'),
                        _notifyCategory(1, 'Unread'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? Expanded(
                    child: Center(child: MyLoadingIndicator()),
                  )
                : Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final notification =
                                  getCurrentNotifications()[index];
                              return Padding(
                                padding: EdgeInsets.only(top: 5.sp),
                                child: Slidable(
                                  key: Key(notification.id.toString()),
                                  startActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    dismissible: DismissiblePane(
                                      onDismissed: () =>
                                          _onDismissed(index, Action.share),
                                    ),
                                    children: const [],
                                  ),
                                  endActionPane: ActionPane(
                                    motion: const BehindMotion(),
                                    dismissible: DismissiblePane(
                                      onDismissed: () =>
                                          _onDismissed(index, Action.delete),
                                    ),
                                    children: [
                                      SlidableAction(
                                        backgroundColor: Colors.red,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                        onPressed: (context) =>
                                            _onDismissed(index, Action.delete),
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 1.sp),
                                      borderRadius: BorderRadius.circular(8.sp),
                                    ),
                                    child: buildNotificationListTile(
                                        notification, index),
                                  ),
                                ),
                              );
                            },
                            childCount: getCurrentNotifications().length,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildNotificationListTile(
      NotificationDetails notification, int index) {
    return Builder(
      builder: (context) => ListTile(
        contentPadding: EdgeInsets.all(16.sp),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Text(
                notification.subject,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (notification.status == 'unread')
              IconButton(
                onPressed: () async {
                  setState(() {
                    unreadNotifications.removeAt(index);
                    readNotifications.add(notification);
                  });
                  try {
                    await notificationService.markAsRead(notification.id);
                    widget.fetchunreadcount();
                  } catch (e) {
                    print(e);
                    _showSnackBar(
                        context, 'Failed to mark as read, $e', Colors.red);
                    setState(() {
                      readNotifications.remove(notification);
                      unreadNotifications.insert(index, notification);
                    });
                  }
                },
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.blue,
                  size: 25.sp,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.description,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 5.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  notification.ago == 0
                      ? 'Today'
                      : '${notification.ago} days ago',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
        leading: Container(
          width: 40.sp,
          height: 40.sp,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: Icon(
            Icons.notifications_active,
            color: Color.fromARGB(255, 3, 16, 27),
            size: 25.sp,
          ),
        ),
      ),
    );
  }

  void _onDismissed(int index, Action action) {
    setState(() {
      final currentNotifications = getCurrentNotifications();
      currentNotifications.removeAt(index);

      allNotifications = [...readNotifications, ...unreadNotifications];
    });

    if (action == Action.delete) {
      _showSnackBar(context, 'Notification deleted', Colors.red);
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _notifyCategory(int index, String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedTabIndex == index ? Colors.blue : Colors.white,
          border: Border.all(color: Colors.blue, width: 1.sp),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
          child: Text(
            category,
            style: TextStyle(
              fontSize: 16.sp,
              color: selectedTabIndex == index ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
