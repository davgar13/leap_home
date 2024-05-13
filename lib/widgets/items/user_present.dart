
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leap_home/models/users_model.dart';
import '../../pages/profile/users_profile.dart';

class UserPresent extends StatelessWidget{
  final String userId;
  final Color nameColor;
  final Color userTypeColor;
  const UserPresent({
    Key? key, 
    required this.userId,
    required this.nameColor,
    required this.userTypeColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: UserModel().getUserData(userId),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var personalData = snapshot.data!.data() as Map<String, dynamic>;
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UsersProfilePage(userId: userId),
              ),
            ),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 23,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(personalData['image'],
                  )
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${personalData['nombre']} ${personalData['apellido']}',
                      style: TextStyle(
                        color: nameColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      '${personalData['user_type']}',
                      style: TextStyle(
                        color: userTypeColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }
      },
    );
  }
}