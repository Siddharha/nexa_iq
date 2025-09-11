import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa_iq/events/presentation/views/event_page.dart';
import 'package:nexa_iq/home/presentation/views/home_page.dart';
final landingPageIndexProvider = StateProvider<int>((ref) => 0);

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: ref.read(landingPageIndexProvider));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(landingPageIndexProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1f2f34),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          ref.read(landingPageIndexProvider.notifier).state = index;
        },
        children: const [
          HomePage(), // Lazy loaded only when swiped
          EventPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          _pageController.jumpToPage (index);
          ref.read(landingPageIndexProvider.notifier).state = index;
        },
        backgroundColor: const Color(0xFF1f2f34),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Event"),
        ],
      ),
    );
  }
}

