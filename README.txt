/* Dodanie skryptu */
config.xml -> <import src="draws3d-scripts-main/scripts.xml" />

/* Info */
+ Autor: heisenberg
+ Wymagane do dzialania: MySQL module
+ Domyslne haslo: "draws123"  (mozna zmienic w draws-server-init)

/* MySQL EXAMPLE */
CREATE TABLE draws3d (
id INT(13) UNSIGNED PRIMARY KEY,
text VARCHAR(255) NOT NULL,
x float(20) NOT NULL,
y float(20) NOT NULL,
z float(20) NOT NULL,
r INT(3) NOT NULL,
g INT(3) NOT NULL,
b INT(3) NOT NULL,
h INT(13) NOT NULL,
visible INT(13) NOT NULL
);

/* Funkcje */ - Domyślnie w draws-server-init

   enabledDraws3dSystem(bool);  - włącz/wyłącz system drawow
   enabledPermission(bool);  - Używanie komend do drawów3d dla wszystkich/dla osób z uprawnieniem

/* Komendy */
draw.add - Dodanie nowego drawa
draw.text - Zmiana tekstu drawa
draw.rem - Usuniecie drawa
draw.pos - Zmiana pozycji drawa (Aktualna pozycja gracza)
draw.color - Zmiana RGB drawa
draw.range - Zmiana zasiegu widzenia drawa
draw.height - Zmiana polozenia wysokosci drawa
draw.show - Globalne odkrycie drawow 3d
draw.hide - Globalne ukrycie drawow 3d
draw.login - Logowanie do uprawnien edytowania drawow 3d
draw.help - Lista komend
draw - Lista komend
