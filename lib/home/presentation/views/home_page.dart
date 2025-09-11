import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa_iq/home/presentation/views/all_sites_page.dart';
import 'package:nexa_iq/home/presentation/views/my_views_page.dart';
import 'package:nexa_iq/home/presentation/views/preset_view_page.dart';

final homeTabIndexProvider = StateProvider<int>((ref) => 0);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<Widget?> _pages = [null, null, null]; // cache pages lazily

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: ref.read(homeTabIndexProvider),
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      ref.read(homeTabIndexProvider.notifier).state = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(homeTabIndexProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Column(
        children: [
          Material(
            color: const Color(0xFF1f2f34),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: const [
                Tab(text: "All Sites"),
                Tab(text: "Preset Views"),
                Tab(text: "My Views"),
              ],
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: currentIndex,
              children: List.generate(_pages.length, (index) {
                // lazy load & cache
                _pages[index] ??= _buildPage(index);
                return _pages[index]!;
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const AllSitesPage();
      case 1:
        return const PresetViewsPage();
      case 2:
        return const MyViewsPage();
      default:
        return const SizedBox();
    }
  }
}
