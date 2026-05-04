import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';

class TrendingSidebar extends StatelessWidget {
  const TrendingSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Trending Topics',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      context.read<ChatProvider>().refreshTrending();
                    },
                    tooltip: 'Refresh Topics',
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: provider.trendingTopics.length,
                    itemBuilder: (context, index) {
                      final topic = provider.trendingTopics[index];
                      return ListTile(
                        leading: const Icon(Icons.trending_up, color: Colors.blueAccent),
                        title: Text(
                          topic['title']!,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          topic['timestamp']!,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                        onTap: () {
                          // Tap action for trending topic could insert text
                        },
                      );
                    },
                  );
                },
              ),
            ),
            // Creator Mode Badge
            Consumer<ChatProvider>(
              builder: (context, provider, child) {
                if (provider.isCreatorMode) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    width: double.infinity,
                    color: Colors.indigo.withOpacity(0.3),
                    child: const Column(
                      children: [
                        Icon(Icons.verified_user, color: Colors.indigoAccent),
                        SizedBox(height: 8),
                        Text(
                          'Welcome back, Malakai',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.indigoAccent,
                          ),
                        ),
                        Text(
                          '(Creator Mode Active)',
                          style: TextStyle(fontSize: 12, color: Colors.indigoAccent),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
