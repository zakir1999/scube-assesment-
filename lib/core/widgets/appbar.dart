import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final VoidCallback? onNotificationPressed;


  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFEAF0F6),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF2D3339), size: 26), // AppColors.textDark
        onPressed: onBackPressed ?? () => context.pop(),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF2D3339),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              onPressed: onNotificationPressed ?? () {},
              icon: const Icon(Icons.notifications_active_outlined, color: Colors.grey, size: 28),
            ),
            const Positioned(
              right: 12,
              top: 12,
              child: Icon(Icons.circle, color: Colors.red, size: 10),
            )
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}