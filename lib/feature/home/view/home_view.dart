import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/app_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskproject/feature/login/state/auth_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin{
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: AppTab.listTabView.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers : [
        BlocProvider(create: (_) => AuthenticationCubit())
      ],
      child: DefaultTabController(
        length: AppTab.listTabView.length,
        child: Stack(
          children: [
            Scaffold(
              // appBar: AppBar(
              //   title:  const Text(AppString.appName),
              // ),
              bottomNavigationBar: TabBar(
                labelColor: Colors.pink,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.pink,
                tabs: AppTab.getHomeScreenTabs(_tabController.index),
                controller: _tabController,
                onTap: (index) {
                  setState(() {});
                },
              ),
              body: TabBarView(
                controller: _tabController,
                children: AppTab.listTabView
                    .map((tabView) => _TabNavigator(child: tabView))
                    .toList(),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 40,
              child: _buttonAdd
            ),
          ],
        ),
      ),
    );
  }

  final Widget _buttonAdd = Center(
    child: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: Icon(Icons.add,color: Colors.white,size: 40,)
      ),
    ),
  );

}

class _TabNavigator extends StatelessWidget {
  final Widget child;
  const _TabNavigator({required this.child});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => child);
      },
    );
  }
}
