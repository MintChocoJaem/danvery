import 'package:danvery/screens/main/search/search_screen.dart';
import 'package:danvery/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/orb/components/components.dart';

final currentPageIndexProvider = StateProvider<int>((ref) => 0);

class MainScreen extends ConsumerWidget{
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: IndexedStack(
        index: ref.watch(currentPageIndexProvider),
        children: const [
          HomeScreen(),
          SearchScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: OrbBottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "검색"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "내 정보"),
        ],
        onIndexChanged: (value) {
          ref.read(currentPageIndexProvider.notifier).state = value;
        },
      ),
    );
  }
}
