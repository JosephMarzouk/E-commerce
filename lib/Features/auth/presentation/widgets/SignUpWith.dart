import 'package:flutter/material.dart';

class SignUpWith extends StatelessWidget {
  const SignUpWith({super.key, required this.image, required this.text});
final String image;
final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 300,
        decoration: BoxDecoration(
          color: const Color(0xffE4E4E4),
          borderRadius: BorderRadius.circular(50)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 1,),
            Expanded(child:Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white ),
              child: Image.asset(image,),) ),
            const SizedBox(
              width: 32,
            ),
             
              
                   Text(text,
                      style: const TextStyle(
                          color: Color(0xff2c4370),
                          fontWeight: FontWeight.w600,fontSize: 16)),
                          
                Spacer(flex: 3,)
          ],
          
        ),
      );
    
  }
}