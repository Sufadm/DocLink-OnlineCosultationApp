import 'package:doc_link/presentation/screens/homescreen.dart/doctors/doctors_details.dart';
import 'package:doc_link/services/firestore_service.dart';
import 'package:doc_link/shared/const/const.dart';
import 'package:flutter/material.dart';

import '../../../model/profile_model.dart';

class CustomSearchDelegate extends SearchDelegate {
  late List<ProfileModel> doctors = [];
  List<ProfileModel> searchResults = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          searchResults = [];
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (searchResults.isEmpty) {
      return Center(
        child: Text('No results found for "$query"'),
      );
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final doctor = searchResults[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(doctor.imageUrl),
          ),
          title: Text(doctor.name),
          subtitle: Text(doctor.category),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorsDetails(profile: doctor),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<ProfileModel>>(
      stream: FirestoreService().getDoctorsProfilesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {}

        if (snapshot.hasError) {
          return const Text('Error fetching doctors');
        }

        doctors = snapshot.data ?? [];
        searchResults = doctors
            .where((doctor) =>
                doctor.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        if (searchResults.isEmpty) {
          return Center(
            child: Text(
              'No results found',
              style: kTextStyleMediumBlack,
            ),
          );
        }

        return ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final doctor = searchResults[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(doctor.imageUrl),
              ),
              title: Text(doctor.name),
              subtitle: Text(doctor.category),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorsDetails(profile: doctor),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
