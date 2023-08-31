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

° resolution du probleme du "Error: Expected a value of type 'Map<String, dynamic>' but got one of type 'Null' lors de l'ajout d'un nouvel eleve. C'est a dire
    - faire pas mal de modif pour la methode addEleve dans FirebaseDBService car celui - ci n'ajoutais que le nouvel élève dans la reference mais pas dans les modules