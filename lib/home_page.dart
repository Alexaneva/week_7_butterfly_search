import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> butterfly = [
    {"id": 1, "name": "name1", "desc": "desc1"},
    {"id": 2, "name": "name2", "desc": "desc2"},
    {"id": 3, "name": "name3", "desc": "desc3"},
    {"id": 4, "name": "name4", "desc": "desc4"},
  ];
  List<Map<String, dynamic>> foundButterfly = [];

  @override
  void initState() {
    //  в начале все бабочки видны
    foundButterfly = butterfly;
  }

  // Эта функция вызывается каждый раз, когда изменяется текстовое поле
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = butterfly;
    } else {
      results = butterfly
          .where((butterfly) => butterfly["name"]
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
      // мы используем метод toLowerCase(), чтобы сделать его нечувствительным к регистру
    }
    // обновляем UI
    setState(() {
      foundButterfly = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                labelText: "Search",
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: foundButterfly.isNotEmpty
                  ? ListView.builder(
                itemCount: butterfly.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(foundButterfly[index]["id"]),
                  color: Colors.teal,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Text(foundButterfly[index]["name"]),
                    subtitle:
                    Text(foundButterfly[index]["desc"].toString()),
                  ),
                ),
              )
                  : const Text(
                'No result found',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
