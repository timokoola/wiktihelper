import 'package:flutter/material.dart';
import 'package:wiktihelper/shared/models/wiktionary_result.dart';
import 'package:wiktihelper/shared/services/wiktionary_service.dart';

class SearchBox extends StatefulWidget {
  final Function(WiktionaryResult) onResult;

  const SearchBox({
    Key? key,
    required this.onResult,
  }) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final _searchController = TextEditingController();
  final _wiktionaryService = WiktionaryService();
  bool _isLoading = false;

  Future<void> _searchWord(String word) async {
    if (word.isEmpty) return;

    setState(() => _isLoading = true);
    
    try {
      final result = await _wiktionaryService.searchWord(word);
      widget.onResult(WiktionaryResult.fromJson(result));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search for a word...',
          prefixIcon: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        onSubmitted: _searchWord,
        onChanged: (value) {
          if (value.isEmpty) {
            widget.onResult(WiktionaryResult(
              title: '',
              extract: '',
              source: '',
            ));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 