import 'package:flutter/material.dart';
import 'package:wiktihelper/shared/models/wiktionary_result.dart';
import 'package:wiktihelper/shared/services/wiktionary_service.dart';

class SearchBox extends StatelessWidget {
  final Function(String) onSearch;
  final bool isLoading;

  const SearchBox({
    Key? key,
    required this.onSearch,
    required this.isLoading,
  }) : super(key: key);

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
        autocorrect: false,
        enableSuggestions: false,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          hintText: 'Search for a word...',
          prefixIcon: isLoading
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
        onSubmitted: onSearch,
      ),
    );
  }
} 