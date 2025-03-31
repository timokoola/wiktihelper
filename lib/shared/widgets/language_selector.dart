import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final String selectedLanguage;
  final Function(String) onLanguageChanged;

  const LanguageSelector({
    Key? key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLanguageOption(
            context,
            'en',
            'EN',
            Icons.language,
          ),
          _buildLanguageOption(
            context,
            'fi',
            'FI',
            Icons.language,
          ),
          _buildLanguageOption(
            context,
            'es',
            'ES',
            Icons.language,
          ),
          _buildLanguageOption(
            context,
            'sv',
            'SV',
            Icons.language,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) {
    final isSelected = selectedLanguage == value;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onLanguageChanged(value),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 14,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 