
import 'package:flutter/material.dart';

import '../../models/users_model.dart';

class AppBarIconProfile extends StatelessWidget{
  final Function()? onPressed;
  const AppBarIconProfile({
    super.key,
    this.onPressed
    });

  @override
  Widget build(BuildContext context) {
      return FutureBuilder<String>(
      future: UserModel().getCurrentUserImage(), 
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 2.0, 
            ) 
          );
        } else if (snapshot.hasError) {
          return const Icon(Icons.error); 
        } else {
          return IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 17,
              backgroundImage: NetworkImage(snapshot.data!),
            ),
            onPressed: onPressed,
          );
        }
      },
    );
  }
}