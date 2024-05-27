import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      // layar render ulang ketika tab berubah
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Berikutnya'),
      ),
      body: Column(
        children: [
          Center(
            child: Text('Selamat datang di halaman berikutnya!'),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                Container(
                    color: Colors.red,
                    height: 200,
                    child: Center(child: Text('Ini adalah halaman berikutnya'))
                ),
                Container(
                    color: Colors.green,
                    height: 200,
                    child: Center(child: Text('Ini adalah halaman berikutnya'))
                ),
                Container(
                    color: Colors.blue,
                    height: 200,
                    child: Center(child: Text('Ini adalah halaman berikutnya'))
                ),
                SizedBox(
                  height: 100,
                  child: TabBar(
                      controller: _tabController,
                      tabs: const <Widget>[
                        Tab(text: 'Tab 1'),
                        Tab(text: 'Tab 2'),
                        Tab(text: 'Tab 3'),
                      ]),
                ),
                 _tabItem(children: [
                   Container(height: 320, color: Colors.grey, child: Center(child: Text('Value of Tab 1'))),
                   Container(height: 220, color: Colors.blueGrey, child: Center(child: Text('Value of Tab 2'))),
                   Container(height: 520, color: Colors.black45, child: Center(child: Text('Value of Tab 3'))),
                 ])

              ],
            ),
          ),
          // custom button with feedback animation
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('This is a custom button with feedback animation'),
                    ),
                  );
                },
                child: const Text('Custom Button'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabItem({required List<Widget> children}) {
    return children[_tabController.index];
  }
}