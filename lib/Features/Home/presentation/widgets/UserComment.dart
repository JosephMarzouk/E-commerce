import 'package:flutter/material.dart';

class UserComment extends StatelessWidget {
  const UserComment({super.key, required this.username, required this.comment,  this.replay=''});

final String username , comment,replay;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(username,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
          Text(comment,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        if (replay != "")
          Column(
            children: [
              const Text(
                "Replay :-",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                replay,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
     
      ],
      ),
    );
    
  }
}