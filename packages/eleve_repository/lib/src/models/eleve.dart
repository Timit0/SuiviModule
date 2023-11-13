import 'package:equatable/equatable.dart';

import 'package:eleve_repository/src/entities/entities.dart';

class Eleve extends Equatable {
  
  String id;
  String name;
  String firstname;
  String photoFilename;

  Eleve(
      {required this.id,
      required this.name,
      required this.firstname,
      required this.photoFilename});

  Eleve copyWith(
          {String? id,
          String? name,
          String? firstname,
          String? photoFilename}) =>
      Eleve(
          id: id ?? this.id,
          name: name ?? this.name,
          firstname: firstname ?? this.firstname,
          photoFilename: photoFilename ?? this.photoFilename);

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'name': name,
  //       'nickname': firstname,
  //       'photoFilename': photoFilename
  //     };

  // factory Eleve.fromJson(Map<String, dynamic> json) => Eleve(
  //     id: json['id'],
  //     name: json['name'],
  //     firstname: json['nickname'],
  //     photoFilename: json['photoFilename'] ?? "");

    EleveEntity toEntity() => EleveEntity(
      id :id,
      name: name,
      firstname: firstname,
      photoFilename: photoFilename
    );

    static Eleve fromEntity(EleveEntity entity) => Eleve(
      id: entity.id,
      name: entity.name,
      firstname: entity.firstname,
      photoFilename: entity.photoFilename
    );

  factory Eleve.base() { 
    return Eleve(
      id: 'cp-99abc',
      name: 'abcd',
      firstname: 'efgh',
      photoFilename: 'assets/img/placeholderImage.png');
    }

  bool get isBase => this == Eleve.base();
  bool get isError => this == Eleve.error();
  bool get isOk => this != Eleve.base() && this != Eleve.error();

  factory Eleve.error() => Eleve(
      id: 'ERROR',
      name: 'ERROR',
      firstname: 'ERROR',
      photoFilename: 'assets/img/errorImage.png');

  @override
  String toString() {
    return "id:\t$id\nname.\t$name\nfirstname:\t$firstname\nphotoFilename:\t$photoFilename";
  }

  @override
  List<Object?> get props => [id, name, firstname, photoFilename];
}
