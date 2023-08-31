° redesign des StudentCards
° en faire du FloatingActionButton que t'as fais en un widget a pars entière avec la signature suivante
    programActionButton(Icon icon, Function func);
        - icon va etre l'icone qui sera afficher dans le floatingactionbutton
        - func va etre la methode qui sera execute lorsque l'utilisateur appuis/clique sur le bouton
° changement des contenus de la screen DetailsStudentScreen selon l'eleve qui a etait appuye dans la screen StudentListScreen avec sécurité anti null
    - c'est à dire -> si les arguments passés retournes un null -> afficher les details de l'objet "Eleve.base()"
° modification du widget permettant d'afficher la moyenne au style que je t'avais parle precedemment
° creation d'un provider pour les students