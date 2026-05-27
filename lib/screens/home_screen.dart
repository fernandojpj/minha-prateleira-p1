import 'package:flutter/material.dart';
import 'package:minha_prateleira/models/book.dart';
import 'package:minha_prateleira/screens/book_form_screen.dart';
import 'package:minha_prateleira/widegets/book_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showFab = true; 

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _showFab = _tabController.index == 0;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minha Prateleira',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller:
              _tabController,
          labelColor: Colors.brown,
          indicatorColor: Colors.brown,
          tabs: const [
            Tab(text: "MINHA PRATELEIRA"),
            Tab(text: "PRATELEIRA DOS AMIGOS"),
          ],
        ),
      ),
      body: TabBarView(
        controller:
            _tabController, 
        children: [
          ValueListenableBuilder<List<Book>>(
            valueListenable: myBooksNotifier,
            builder: (context, currentBooks, child) {
              return BookGrid(books: currentBooks);
            },
          ),

          ValueListenableBuilder<List<Book>>(
            valueListenable: friendsBooksNotifier,
            builder: (context, currentFriendsBooks, child) {
              return BookGrid(books: currentFriendsBooks, isFriendView: true);
            },
          ),
        ],
      ),
      floatingActionButton: _showFab
          ? FloatingActionButton(
              backgroundColor: Colors.brown[300],
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookFormScreen(),
                  ),
                );
              },
            )
          : null, 
    );
  }
}
