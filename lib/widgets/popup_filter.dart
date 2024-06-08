import 'package:flutter/material.dart';

class PopupFilter extends StatefulWidget {
  @override
  _PopupFilterState createState() => _PopupFilterState();
}

class _PopupFilterState extends State<PopupFilter> {
  List<String> filters = ["Books", "Novels", "Newspapers", "Ebooks"];
  List<bool> selectedFilters = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Resources"),
        backgroundColor: const Color(0xFF0D4065),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(filters[index]),
                    value: selectedFilters[index],
                    onChanged: (bool? value) {
                      setState(() {
                        selectedFilters[index] = value!;
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle filter logic here
                Navigator.pop(context, selectedFilters);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: const Color(0xFF0D4065),
              ),
              child: Text("Apply Filters"),
            ),
          ],
        ),
      ),
    );
  }
}
