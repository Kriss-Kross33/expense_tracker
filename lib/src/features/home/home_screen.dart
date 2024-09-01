import 'package:expense_track/src/core/core.dart';
import 'package:expense_track/src/features/home/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final screens = <Widget>[
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TabIndicators(
                    activeColor: ColorConsts.primaryColor,
                    inactiveColor: ColorConsts.white,
                    numTabs: screens.length,
                    height: 5,
                    padding: 0,
                    currentIndex: state.index,
                  ),
                  BottomNavigationBar(
                    backgroundColor: ColorConsts.primaryColor,
                    selectedItemColor: ColorConsts.white,
                    unselectedItemColor: ColorConsts.grey,
                    onTap: (index) =>
                        context.read<NavBarCubit>().onTabSelected(index),
                    type: BottomNavigationBarType.fixed,
                    currentIndex: state.index,
                    unselectedLabelStyle: const TextStyle(
                      color: ColorConsts.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    selectedLabelStyle: const TextStyle(
                      color: ColorConsts.white,
                      fontWeight: FontWeight.w500,
                    ),
                    items: [
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          AssetConsts.home,
                          height: 26,
                          width: 40,
                        ),
                        activeIcon: Image.asset(
                          AssetConsts.home,
                          height: 26,
                          width: 40,
                          color: Colors.white,
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          AssetConsts.history,
                          height: 26,
                          width: 40,
                        ),
                        activeIcon: Image.asset(
                          AssetConsts.history,
                          height: 26,
                          width: 40,
                          color: Colors.white,
                        ),
                        label: 'Learn',
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          AssetConsts.profile,
                          height: 26,
                          width: 40,
                        ),
                        activeIcon: Image.asset(
                          AssetConsts.profile,
                          height: 26,
                          width: 40,
                          color: Colors.white,
                        ),
                        label: 'Profile',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: IndexedStack(
              index: state.index,
              children: screens,
            ),
          );
        },
      ),
    );
  }
}

class TabIndicators extends StatelessWidget {
  const TabIndicators({
    required int numTabs,
    required int currentIndex,
    required Color activeColor,
    required double padding,
    required double height,
    Color inactiveColor = const Color(0x00FFFFFF),
    super.key,
  })  : _numTabs = numTabs,
        _currentIndex = currentIndex,
        _activeColor = activeColor,
        _inactiveColor = inactiveColor,
        _padding = padding,
        _height = height;

  final int _numTabs;
  final int _currentIndex;
  final Color _activeColor;
  final Color _inactiveColor;
  final double _padding;
  final double _height;

  @override
  Widget build(BuildContext context) {
    final elements = <Widget>[];

    for (var i = 0; i < _numTabs; ++i) {
      elements.add(
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: _padding),
            child: Container(
                color: i == _currentIndex ? _activeColor : _inactiveColor),
          ),
        ),
      );
    }

    return SizedBox(
      height: _height,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: elements,
      ),
    );
  }
}
