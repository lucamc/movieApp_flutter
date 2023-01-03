

import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Movies',
        style:  TextStyle(
          fontSize: 28,
          fontFamily: 'Lato'),
          ),
        toolbarHeight: 64,
        elevation: 0,
        actions: [    //Icon Search
          IconButton(
            padding: const EdgeInsets.only(
              right: 14.0
            ),
            
            iconSize: 28,
            
            onPressed:() {}, 
            icon: const Icon(Icons.search_outlined)
            )
          ],

      ),



      body: SingleChildScrollView( //Permite hacer Scroll
        child:  Column(    //Listado Horizontal de Movies
         children: [
          
          //Tarjetas Principales
          CardSwiper(),

          //Slider Peliculas
          MovieSilder()
         
         ],
        ),
      )
    );
  }
}