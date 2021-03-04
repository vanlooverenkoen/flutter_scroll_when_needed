import 'package:flutter/material.dart';
import 'package:scroll_when_needed/scroll_when_needed.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollPhysics _physics = AlwaysScrollableScrollPhysics();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll when needed'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey,
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    color: _physics is AlwaysScrollableScrollPhysics ? Colors.black : Colors.blue,
                    child: Text(
                      'ALWAYS',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    onPressed: () {
                      setState(() => _physics = AlwaysScrollableScrollPhysics());
                    },
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    color: _physics is ClampingScrollPhysics ? Colors.black : Colors.blue,
                    child: Text(
                      'CLAMPING',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    onPressed: () {
                      setState(() => _physics = ClampingScrollPhysics());
                    },
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    color: _physics is NeverScrollableScrollPhysics ? Colors.black : Colors.blue,
                    child: Text(
                      'NEVER',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    onPressed: () {
                      setState(() => _physics = NeverScrollableScrollPhysics());
                    },
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    color: _physics is ScrollWhenNeededPhysics ? Colors.black : Colors.blue,
                    child: Text(
                      'ONLY WHEN NEEDED',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    onPressed: () {
                      setState(() {
                        _physics = ScrollWhenNeededPhysics(targetPlatform: Theme.of(context).platform);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollWhenNeededBehavior(),
              child: ListView(
                physics: _physics,
                children: [
                  Container(
                    height: 100,
                    color: Colors.amber,
                  ),
                  TextField(),
                  Container(
                    height: 300,
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
