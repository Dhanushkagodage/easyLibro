// import 'package:easylibro_app/screens/User.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// enum Action { share, delete, archive }

// class NotificationScreen extends StatelessWidget {
//   List<User> users = AllUsers;
//   NotificationScreen({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F8FD),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Container(
//               height: 50,
//               child: Text(
//                 'Notifications',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               controller: ScrollController(),
//               child: Column(
//                 children: [
//                   SlidableAutoCloseBehavior(
//                     closeWhenOpened: true,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: ListView.builder(
//                         itemCount: users.length,
//                         itemBuilder: (context, index) {
//                           final user = users[index];
                          
//                           return Padding(
//                             padding: const EdgeInsets.only(top:5),
//                             child: Slidable(
//                               key: Key(user.name),
//                               startActionPane: ActionPane(
//                                 motion: const StretchMotion(),
//                                 dismissible: DismissiblePane(
//                                   onDismissed: () => _onDismissed(index, Action.share),
//                                 ),
//                                 children: [],
//                               ),
//                               endActionPane: ActionPane(
//                                 motion: const BehindMotion(),
//                                 dismissible: DismissiblePane(
//                                   onDismissed: () => _onDismissed(index, Action.delete),
//                                 ),
//                                 children: [
//                                   SlidableAction(
//                                     backgroundColor: Colors.red,
//                                     icon: Icons.delete,
//                                     label: 'Delete',
//                                     onPressed: (context) => _onDismissed(index, Action.delete),
//                                   ),
//                                 ],
//                               ),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border: Border.all(color: Colors.grey, width: 1.0),
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                                 child: buildUserListTile(user),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildUserListTile(User user) => Builder(
//     builder: (context) => ListTile(
//       contentPadding: const EdgeInsets.all(16),
//       title: Text(user.name),
//       subtitle: Text(user.email),
//       leading: CircleAvatar(
//         radius: 30,
//         backgroundImage: NetworkImage(user.image),
//       ),
//       onTap: () {
//         final slidable = Slidable.of(context)!;
//         final isClosed = slidable.actionPaneType.value == ActionPaneType.none;
//         if (isClosed) {
//           slidable.openCurrentActionPane();
//         } else {
//           slidable.close();
//         }
//       },
//     ),
//   );

//   void _onDismissed(int index, Action action) {
//     final user = users[index];
//     //setState(() => users.removeAt(index));

//     //   switch (action) {
//     //     case Action.delete:
//     //       _showSnackBar ( context , '${user.name} is deleted', Colors.red);
//     //       break;
//     //   }
//   }

//   void _showSnakBar(BuildContext context, String message, Color color) {
//     final snackBar = SnackBar(
//       content: Text(message),
//       backgroundColor: color,
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }


import 'package:easylibro_app/Notifications/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum Action { share, delete, archive }

class NotificationScreen extends StatelessWidget {
  List<User> users = AllUsers;
  NotificationScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FD),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top:20, left: 20, right: 20,),
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
            padding: const EdgeInsets.only(top:10, left: 20, right: 20, bottom: 20,),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final user = users[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Slidable(
                      key: Key(user.name),
                      startActionPane: ActionPane(
                        motion: const StretchMotion(),
                        dismissible: DismissiblePane(
                          onDismissed: () => _onDismissed(index, Action.share),
                        ),
                        children: [],
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
                            onPressed: (context) => _onDismissed(index, Action.delete),
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: buildUserListTile(user),
                      ),
                    ),
                  );
                },
                childCount: users.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserListTile(User user) => Builder(
        builder: (context) => ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(user.name),
          subtitle: Text(user.email),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(user.image),
          ),
          onTap: () {
            final slidable = Slidable.of(context)!;
            final isClosed = slidable.actionPaneType.value == ActionPaneType.none;
            if (isClosed) {
              slidable.openCurrentActionPane();
            } else {
              slidable.close();
            }
          },
        ),
      );

  void _onDismissed(int index, Action action) {
    final user = users[index];
    //setState(() => users.removeAt(index));

    //   switch (action) {
    //     case Action.delete:
    //       _showSnackBar ( context , '${user.name} is deleted', Colors.red);
    //       break;
    //   }
  }

  void _showSnakBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
