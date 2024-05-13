import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leap_home/widgets/btn/button_sec.dart';

import '../../pages/others/pet_info_page.dart';
import '../../utils/colors.dart';
import '../items/user_present.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Pet_Person').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar los datos'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No hay Mascotas disponibles'));
        }
        var posts = snapshot.data!.docs;

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            var post = posts[index].data() as Map<String, dynamic>;
            return GestureDetector(
              
              onTap: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CatDetailScreen(catData: post),
                  ),
                );*/
              },
              child: Card(
                margin: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                elevation: 8,
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserPresent(
                        userId: post['idPerson'],
                        nameColor: Colores.negro,
                        userTypeColor: Color.fromARGB(255, 56, 52, 52),
                      ),
                      const SizedBox(height: 10),

                      if (post['imageUrl'] != null &&
                          post['imageUrl'].isNotEmpty)
                        ClipRRect(
                          borderRadius:
                              BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(25.0),
                                bottomLeft: Radius.circular(25.0),
                                bottomRight: Radius.circular(5.0)
                              ),
                          child: Image. network(
                            post['imageUrl'],
                            width: double.infinity,
                            height: 300.0,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (BuildContext context, Object exception,
                                StackTrace? stackTrace) {
                              return const Icon(
                                  Icons.error); // Or any placeholder you'd like
                            },
                          ),
                        ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          'Datos de la Mascota',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic
                          ),
                        ),
                      ),
                      //const SizedBox(height: 5),
                      Divider(
                        color: const Color.fromARGB(255, 39, 39, 39).withOpacity(0.5),
                        thickness: 1,
                        indent: 15,
                        endIndent: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nombre: ',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic
                            ),
                          ),
                          Text(
                            post['name'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Tipo: ',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic
                            ),
                          ),
                          Text(
                            post['type'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ButtonSec(
                            textValue: 'Ver Detalles', 
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PetInfoPage( 
                                    petInfoID: posts[index].id,
                                    ownerId: post['idPerson'],
                                  ),
                                ),
                              );
                            }, 
                            newColor: Colores.jet, 
                            fontColor: Colores.white, 
                            height: 25,
                            fontSize: 15,
                            borderTopLeftRadius: 5,
                            borderTopRightRadius: 25,
                            borderBottomLeftRadius: 25,
                            borderBottomRightRadius: 5,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ),
            );
          },
        );
      },
    );
  }
}
