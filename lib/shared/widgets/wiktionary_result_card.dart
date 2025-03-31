import 'package:flutter/material.dart';
import 'package:wiktihelper/shared/models/wiktionary_result.dart';
import 'package:wiktihelper/shared/services/share_service.dart';

class WiktionaryResultCard extends StatelessWidget {
  final WiktionaryResult result;

  const WiktionaryResultCard({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (result.title.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    result.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    result.source.toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.ios_share),
                  onPressed: () => ShareService.shareWiktionaryResult(result),
                  tooltip: 'Share Wiktionary link',
                ),
              ],
            ),
          ),
          if (result.hasError)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                result.error!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _formatDefinition(result.extract).map((section) {
                  if (section.startsWith('==')) {
                    // This is a section header
                    return Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        section.replaceAll('==', '').trim(),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    );
                  } else if (section.startsWith('*')) {
                    // This is a bullet point
                    return Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• '),
                          Expanded(
                            child: Text(
                              section.substring(1).trim(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Regular text
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        section.trim(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  List<String> _formatDefinition(String extract) {
    // Split by newlines and filter out empty lines
    return extract
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .toList();
  }
} 