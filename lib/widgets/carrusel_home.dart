import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselHome extends StatelessWidget {
  final List<String> imgList = [
    'assets/carrusel/Adop_image1.jpg',
    'assets/carrusel/Adop_image2.jpg',
    'assets/carrusel/Adop_image3.jpg',
  ];

  final Map<String, String> imgMap = {
    'assets/carrusel/Adop_image1.jpg' : 'Dale a una mascota una segunda oportunidad de ser feliz',
    'assets/carrusel/Adop_image2.jpg' : 'Pequeñas patas, grandes corazones',
    'assets/carrusel/Adop_image3.jpg' : '"Un amigo fiel espera: adopta, no compres',
   };

  CarouselHome({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true, 
        enlargeCenterPage: true, 
        viewportFraction: 0.9, 
        aspectRatio: 2.0, 
      ),
      items: imgList.map((item) {
        return Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: Stack(
              children: <Widget>[
                Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    color: Colors.black.withOpacity(0.4),
                    child: Text(
                      imgMap[item]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}