===============================================================================| FAIT! |===============================================================================
° redesign des StudentCards

° en faire du FloatingActionButton que t'as fais en un widget a pars entière avec la signature suivante
    programActionButton(Icon icon, Function func);
        - icon va etre l'icone qui sera afficher dans le floatingactionbutton
        - func va etre la methode qui sera execute lorsque l'utilisateur appuis/clique sur le bouton

° changement des contenus de la screen DetailsStudentScreen selon l'eleve qui a etait appuye dans la screen StudentListScreen avec sécurité anti null
    - c'est à dire -> si les arguments passés retournes un null -> afficher les details de l'objet "Eleve.base()"

° modification du widget permettant d'afficher la moyenne au style que je t'avais parle precedemment

° creation d'un provider pour les students

° placer l'enum CardState dans un fichier dart a pars entiere afin d'en faire des widgets de devoirs/tests des widgets a pars entiere (dans le futur)

° placer le widget "avatar" dans un fichier dart a pars (avatar_widget.dart) afin de pouvoir faire le code de detail_student_screen.dart un chouillat plus propre :)

° placer les cards représentant les exams/devoirs dans un widget a pars entiere afin de pouvoir rendre le code de detail_student_screen.dart plus propre :)

° faire passer les variable du student lorsqu'on va se diriger vers la screen detail_student_screen.dart
=======================================================================================================================================================================

==============================================================================| A FAIRE |==============================================================================
° faire le dialog d'insertion de devoirs/tests (optionnelle)
° Navigation Rail
° Créer une nouvelle screen pour l'ajout des Student
° Implementer supression délève
° Login screen
° Prendre ALAD1
=======================================================================================================================================================================