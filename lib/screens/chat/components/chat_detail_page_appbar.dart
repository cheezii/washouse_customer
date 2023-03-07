import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';

class ChatDetailPageAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const ChatDetailPageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 2),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile/2.jpg'),
                maxRadius: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Trần Tân Long',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Online',
                      style: TextStyle(
                        color: onlineColor,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
              Icon(Icons.more_vert, color: Colors.grey.shade500),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
