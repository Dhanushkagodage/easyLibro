import 'package:flutter/material.dart';

class DetailContainer extends StatefulWidget {
  final String label;
  final String value;
  final IconData icon;

  const DetailContainer({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  State<DetailContainer> createState() => _DetailContainerState();
}

class _DetailContainerState extends State<DetailContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 70,
      decoration: BoxDecoration(
          color: Color(0xFFB5D2FF), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xFFF7F8FD),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      color: Color.fromARGB(255, 131, 179, 252), width: 2)),
              child: Icon(widget.icon,color: Color(0xFF080C27),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( widget.label,
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0D4065))),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text( widget.value,
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF080C27))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
