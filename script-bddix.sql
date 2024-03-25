--1. Liste des potions : Numéro, libellé, formule et constituant principal. (5 lignes)
select * from potion;

--2. Liste des noms des trophées rapportant 3 points. (2 lignes)
select * from trophee where num_resserre = 3;

--3. Liste des villages (noms) contenant plus de 35 huttes. (4 lignes)
select * from village where nb_huttes > 35;

--4. Liste des trophées (numéros) pris en mai / juin 52. (4 lignes)
select * from trophee where date_prise between '2052-05-05' and '2052-06-06';

--5. Noms des habitants commençant par 'a' et contenant la lettre 'r'. (3 lignes)
select * from habitant where nom LIKE 'A%' and nom LIKE '%r%' ;

--6. Numéros des habitants ayant bu les potions numéros 1, 3 ou 4. (8 lignes)
select distinct num_hab from absorber where num_potion = 1 or num_potion = 3 or num_potion = 4;

--7. Liste des trophées : numéro, date de prise, nom de la catégorie et nom du preneur. (10lignes)
select num_trophee, date_prise, nom_categ, nom from trophee
inner join categorie on trophee.code_cat = categorie.code_cat 
inner join habitant on trophee.num_preneur = habitant.num_hab;

--8. Nom des habitants qui habitent à Aquilona. (7 lignes)
select habitant.nom from habitant
inner join village on habitant.num_village = village.num_village 
where village.nom_village = 'Aquilona';

--9. Nom des habitants ayant pris des trophées de catégorie Bouclier de Légat. (2 lignes)
select distinct habitant.nom from habitant
inner join trophee on habitant.num_hab = trophee.num_trophee 
inner join categorie on trophee.code_cat = categorie.code_cat 
where categorie.nom_categ = 'Bouclier de Légat';

--10. Liste des potions (libellés) fabriquées par Panoramix : libellé, formule et constituantprincipal. (3 lignes)
select potion.lib_potion , potion.formule , potion.num_potion from potion
inner join fabriquer on potion.num_potion = fabriquer.num_potion 
inner join habitant on fabriquer.num_hab = habitant.num_hab 
where habitant.nom = 'Panoramix';

--11. Liste des potions (libellés) absorbées par Homéopatix. (2 lignes)
select distinct potion.lib_potion from potion
inner join absorber on potion.num_potion = absorber.num_potion 
inner join habitant on absorber.num_hab = habitant.num_hab 
where habitant.nom = 'Homéopatix';

--12. Liste des habitants (noms) ayant absorbé une potion fabriquée par l'habitant numéro 3. (4 lignes)
select distinct habitant.nom from habitant 
inner join absorber on habitant.num_hab = absorber.num_hab
inner join fabriquer on absorber.num_potion = fabriquer.num_potion 
where fabriquer.num_hab = 3; 

--13. Liste des habitants (noms) ayant absorbé une potion fabriquée par Amnésix. (7 lignes)
select distinct habitant.nom from habitant
inner join absorber on habitant.num_hab = absorber.num_hab 
inner join fabriquer on absorber.num_potion = fabriquer.num_potion
inner join habitant as fab_habitant on fabriquer.num_hab  = fab_habitant.num_hab
where fab_habitant.nom = 'Amnésix';

--14. Nom des habitants dont la qualité n'est pas renseignée. (2 lignes)
select nom from habitant
left join qualite on habitant.num_qualite = qualite.num_qualite
where qualite.num_qualite is null;

--15. Nom des habitants ayant consommé la Potion magique n°1 (c'est le libellé de lapotion) en février 52. (3 lignes)
select distinct nom from habitant
inner join absorber on habitant.num_hab = absorber.num_hab 
inner join potion on absorber.num_potion = potion.num_potion 
where potion.lib_potion = 'Potion magique n°1'
and extract(month from absorber.date_a) = 02
and extract(year from absorber.date_a) = 2052;

--16. Nom et âge des habitants par ordre alphabétique. (22 lignes)
select nom, age from habitant
order by nom asc;
--17. Liste des resserres classées de la plus grande à la plus petite : nom de resserre et nom du village. (3 lignes)
select nom_resserre, village.nom_village from resserre
inner join village on resserre.num_village = village.num_village 
order by resserre.superficie desc;

--18. Nombre d'habitants du village numéro 5. (4)
select count(*) as num_hab from habitant
where num_village = 5;

--19. Nombre de points gagnés par Goudurix. (5)
select sum(categorie.nb_points) as total_points from trophee
inner join categorie on trophee.code_cat = categorie.code_cat 
inner join habitant on trophee.num_preneur = habitant.num_hab
where habitant.nom = 'Goudurix';

--20. Date de première prise de trophée. (03/04/52)
select min(date_prise)as date_premiere_prise from trophee;

--21. Nombre de louches de Potion magique n°2 (c'est le libellé de la potion) absorbées. (19)
select sum(quantite)as total_louches_absorbees from absorber
inner join potion on absorber.num_potion = potion.num_potion 
where potion.lib_potion = 'Potion magique n°2';

--22. Superficie la plus grande. (895)
select max(superficie) from resserre;

--23. Nombre d'habitants par village (nom du village, nombre). (7 lignes)
select village.nom_village, count(habitant.num_hab)from village
left join habitant on village.num_village = habitant.num_village 
group by village.num_village ;

--24. Nombre de trophées par habitant (6 lignes)
select nom, count(trophee.num_trophee) from habitant
inner join trophee on habitant.num_hab = trophee.num_preneur 
group by habitant.nom;

--25. Moyenne d'âge des habitants par province (nom de province, calcul). (3 lignes)
select province.nom_province, avg(habitant.age) from habitant
inner join village on habitant.num_village = village.num_village
inner join Province on village.num_province = province.num_province
group by province.nom_province;

--26. Nombre de potions différentes absorbées par chaque habitant (nom et nombre). (9lignes)
select nom, count(distinct absorber.num_potion) from habitant
inner join absorber on habitant.num_hab = absorber.num_hab 
group by habitant.nom;

--27. Nom des habitants ayant bu plus de 2 louches de potion zen. (1 ligne)
select nom from habitant
inner join absorber on habitant.num_hab = absorber.num_hab 
inner join potion on absorber.num_potion = potion.num_potion 
where lib_potion = 'Potion Zen'
group by nom having sum(absorber.quantite) > 2; 

--28. Noms des villages dans lesquels on trouve une resserre (3 lignes)
select distinct nom_village from village
inner join resserre on village.num_village = resserre.num_village;

--29. Nom du village contenant le plus grand nombre de huttes. (Gergovie)
SELECT nom_village FROM village
ORDER BY  village.nb_huttes DESC
LIMIT 1;

--30. Noms des habitants ayant pris plus de trophées qu'Obélix (3 lignes).
select nom from habitant
inner join trophee on habitant.num_hab = trophee.num_preneur 
where trophee.num_preneur <> (select num_hab from habitant where nom = 'Obélix')
group by habitant.num_hab 
having count(trophee.num_trophee) >
(select count (trophee.num_trophee) from trophee
inner join habitant on trophee.num_preneur = habitant.num_hab 
where habitant.nom = 'Obélix');
