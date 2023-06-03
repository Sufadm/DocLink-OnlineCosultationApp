import 'package:flutter/material.dart';

import '../widgets/box_widget.dart';

class ViewAllCategoriesPage extends StatelessWidget {
  const ViewAllCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change your color here
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'All Categories',
          style: TextStyle(
            color: Colors.black, // Change the text color here
            fontSize: 20, // Adjust the font size if needed
            fontWeight: FontWeight.bold, // Adjust the font weight if needed
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: const [
            ViewAllCategorieWidget(
              categoriename: 'Categorie 1',
            ),
            ViewAllCategorieWidget(
              categoriename: 'Categorie 2',
            ),
            ViewAllCategorieWidget(
              categoriename: 'Categorie 3',
            ),
            ViewAllCategorieWidget(
              categoriename: 'Categorie 4',
            ),
            ViewAllCategorieWidget(
              categoriename: 'Categorie 5',
            ),
          ],
        ),
      ),
    );
  }
}
