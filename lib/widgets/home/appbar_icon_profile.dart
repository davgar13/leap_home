
import 'package:flutter/material.dart';

import '../../models/users_model.dart';

class AppBarIconProfile extends StatelessWidget{
 const AppBarIconProfile({super.key});

  @override
  Widget build(BuildContext context) {
      return FutureBuilder<String>(
      future: UserModel().getCurrentUserImage(), 
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); 
        } else if (snapshot.hasError) {
          return const Icon(Icons.error); 
        } else {
          return IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 17,
              backgroundImage: NetworkImage(snapshot.data!),
            ),
            onPressed: () {
              /*Navigator.push(context, 
                MaterialPageRoute(builder: (context) => ProfileView(
                  userId: FirebaseAuth.instance.currentUser!.uid,
                ))
              );*/
            },
          );
        }
      },
    );
  }
}