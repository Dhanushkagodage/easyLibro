import 'package:easylibro_app/widgets/resource.dart';
import 'package:flutter/material.dart';


class ResourceCard extends StatefulWidget {
  final Resource resource;

  const ResourceCard({super.key, required this.resource});

  @override
  State<ResourceCard> createState() => _ResourceCardState();
}

class _ResourceCardState extends State<ResourceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:60,
      child: Text(widget.resource.title),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 132, 15, 15),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 64, 64, 64)
                .withOpacity(0.1), // Shadow color
            spreadRadius: 4, // Spread radius
            blurRadius: 4, // Blur radius
            offset: const Offset(2, 2), // Changes position of shadow
          ),
        ],
      ),
    );
  }
}
