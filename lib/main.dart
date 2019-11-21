import 'package:flutter/material.dart';
import 'package:flutter_github/page/DynamicPage.dart';
import 'package:flutter_github/page/MyPage.dart';
import 'package:flutter_github/page/TrendPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  TabController _tabController;

  _renderTab(icon, text) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 16.0,
          ),
          Text(text)
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    List<Widget> tabs = [
      _renderTab(Icons.android, "首页"),
      _renderTab(Icons.apps, "发现"),
      _renderTab(Icons.business, "我的")
    ];
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
          ),
          body: TabBarView(
            children: [DynamicPage(), TrendPage(), MyPage()],
            controller: _tabController,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
          bottomNavigationBar: Material(
            color: Colors.cyan,
            child: TabBar(
              tabs: tabs,
              controller: _tabController,
            ),
          ),
        ),
        onWillPop: () => _exitAppDialog(context));
  }

  Future<bool> _exitAppDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("确定退出应用吗？"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("取消")),
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("确定"))
              ],
            ));
  }
}
