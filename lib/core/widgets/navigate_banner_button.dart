import 'package:flutter/material.dart';

class CustomNavigationBanner extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isArrowLeft;

  const CustomNavigationBanner({
    super.key,
    required this.text,
    required this.onTap,
    this.isArrowLeft = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF3B97ED),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isArrowLeft) ...[
              const Icon(Icons.arrow_back_ios, color: Colors.white, size: 14),
              const SizedBox(width: 8),
            ],

            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),

            if (!isArrowLeft) ...[
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
            ],
          ],
        ),
      ),
    );
  }
}