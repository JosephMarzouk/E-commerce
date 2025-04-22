import 'package:e__commerce/Features/Home/presentation/widgets/UserComment.dart';
import 'package:e__commerce/core/CustomCircleProgIndicator.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UsersCommentsListView extends StatelessWidget {
  const UsersCommentsListView({
    super.key,
    required this.productID,
  });
  final String productID ;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client
          .from('comments_table')
          .stream(primaryKey: ['id'])
          .eq('for_product', productID)
          .order('created_at', ascending: false)
          .execute(),
      builder: (context, snapshot) {
        List<Map<String, dynamic>>? comments = snapshot.data;
       if(snapshot.connectionState == ConnectionState.waiting)
       {
        return const Center(
          child: CustomCircleProgIndicator(),
        );
       }
       else if (!snapshot.hasData)
       {
        return const Center(
          child: Text('No comments yet'),
        );
       }
       else if (snapshot.hasData)

       {
return ListView.builder(
  physics: const NeverScrollableScrollPhysics(),
  shrinkWrap: true,
          itemCount: comments?.length??0 ,
          itemBuilder: (context, index) {
            return UserComment(
              username: comments?[index]['user_name'],
              comment: comments?[index]['comment'],
              replay: comments?[index]['replay']??"",
            );
          },
        );
       }
       else {
        return const Center(
          child: Text('something went wrong , try again later'),
        );
       }
      },
    );
  }
}
