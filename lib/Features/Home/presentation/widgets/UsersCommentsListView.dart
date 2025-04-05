
import 'package:e__commerce/Features/Home/presentation/widgets/UserComment.dart';
import 'package:flutter/material.dart';

class UsersCommentsListView extends StatelessWidget {
  const UsersCommentsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (context,index)=>UserComment() , separatorBuilder: (context,index)=>const Divider(), itemCount: 8, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),);
  }
}