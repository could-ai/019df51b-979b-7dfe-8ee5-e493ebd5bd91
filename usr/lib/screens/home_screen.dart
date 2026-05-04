import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../widgets/trending_sidebar.dart';
import '../widgets/chat_area.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;
    
    return Scaffold(
      appBar: isDesktop ? null : AppBar(
        title: const Text('Mali AI'),
        actions: [
          Consumer<ChatProvider>(
            builder: (context, provider, child) {
              if (provider.isCreatorMode) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Chip(
                      label: Text('Creator Mode', style: TextStyle(fontSize: 12)),
                      backgroundColor: Colors.indigo,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      drawer: isDesktop ? const Drawer(
        child: TrendingSidebar(),
      ) : Drawer(
        child: const TrendingSidebar(),
      ),
      body: Row(
        children: [
          if (isDesktop)
            const SizedBox(
              width: 300,
              child: TrendingSidebar(),
            ),
          const Expanded(
            child: ChatArea(),
          ),
        ],
      ),
    );
  }
}
