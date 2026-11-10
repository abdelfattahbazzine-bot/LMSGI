<?php
$nom = "Joan";
$curs = "ASIX1";

switch ($curs) {
    case "ASIX1":
        echo "$nom, alumne d'administració de sistemes informàtics i xarxes de primer";
        break;

    case "ASIX2":
        echo "$nom, alumne d'administració de sistemes informàtics i xarxes de segon";
        break;

    case "DAW1":
        echo "$nom, alumne de desenvolupament d'aplicacions web de primer";
        break;

    case "DAW2":
        echo "$nom, alumne de desenvolupament d'aplicacions web de segon";
        break;

    case "DAM1":
        echo "$nom, alumne de desenvolupament d'aplicacions multiplataforma de primer";
        break;

    case "DAM2":
        echo "$nom, alumne de desenvolupament d'aplicacions multiplataforma de segon";
        break;

    default:
        echo "$nom no és alumne de cicle superior d'informàtica";
        break;
}
?>