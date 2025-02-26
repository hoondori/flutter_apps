import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  TabsPage({super.key, required this.observer});
  final FirebaseAnalyticsObserver observer;

  @override
  State<TabsPage> createState() => _TabsPageState(observer);
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin, RouteAware {
  _TabsPageState(this._observer);

  final FirebaseAnalyticsObserver _observer;
  TabController? _controller;
  int _selectedIndex = 0;

  final List<Tab> tabs = <Tab>[
    const Tab(text: '1번',  icon: Icon(Icons.looks_one),),
    const Tab(text: '2번',  icon: Icon(Icons.looks_two),),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: _selectedIndex
    );
  }

  // 현재 선택된 tab의 정보를 analytics에 보낸다
  void _sendCurrentTab() {
    _observer.analytics.logScreenView(screenName: 'tab/$_selectedIndex');
  }

  @override
  void didChangeDependencies() {
    // observer subscribe
    super.didChangeDependencies();
    _observer.subscribe(this, ModalRoute.of(context) as dynamic);
  }

  @override
  void dispose() {
    _observer.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(bottom: TabBar(tabs: tabs, controller: _controller,),),
      body: TabBarView(
        controller: _controller,
        children: tabs.map((Tab tab) {
          return Center(child: Text(tab.text!));
        }).toList(),
      ),
    );
  }
}
