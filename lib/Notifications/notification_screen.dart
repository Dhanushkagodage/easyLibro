import 'package:easylibro_app/Notifications/notification.dart';
import 'package:easylibro_app/Notifications/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum Action { share, delete, archive }

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isloading = false;
  List<NotificationDetails> allNotifications = []; // Declare the variable here

  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    setState(() {
      isloading = true;
    });
    try {
      final notifications = await notificationService.fetchNotifications();
      allNotifications = notifications;
    } catch (e) {
      //print('Error fetching notifications: $e');
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FD),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final notification = allNotifications[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Slidable(
                      key: Key("notification.id"),
                      startActionPane: ActionPane(
                        motion: const StretchMotion(),
                        dismissible: DismissiblePane(
                          onDismissed: () => _onDismissed(index, Action.share),
                        ),
                        children: const [],
                      ),
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        dismissible: DismissiblePane(
                          onDismissed: () => _onDismissed(index, Action.delete),
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
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: buildNotificationListTile(notification),
                      ),
                    ),
                  );
                },
                childCount: allNotifications.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNotificationListTile(NotificationDetails notification) => Builder(
        builder: (context) => ListTile(
          contentPadding: EdgeInsets.all(16.sp),
          title: Text(
            notification.subject,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(notification.description,style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            )),
          leading: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(25.sp),
            ),
            child: Icon(Icons.notifications_active,
                color: Color.fromARGB(255, 3, 16, 27), size: 40.sp),
          ),
          onTap: () {
            final slidable = Slidable.of(context)!;
            final isClosed =
                slidable.actionPaneType.value == ActionPaneType.none;
            if (isClosed) {
              slidable.openCurrentActionPane();
            } else {
              slidable.close();
            }
          },
        ),
      );

  void _onDismissed(int index, Action action) {
    setState(() => allNotifications.removeAt(index));

    // Handle actions like delete
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
}
