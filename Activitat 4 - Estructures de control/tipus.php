<?php
$x = 10;
$y = "10";
$z = $x * 2;
$a = "23 anys";
$b = $x + 11;
$c = 1.234;
$d = 1.2e3;
$e = 7E-10;
$f = NULL;

$variables = [
    "x" => $x,
    "y" => $y,
    "z" => $z,
    "a" => $a,
    "b" => $b,
    "c" => $c,
    "d" => $d,
    "e" => $e,
    "f" => $f
];
foreach ($variables as $nom => $valor) {
   $tipus = gettype($valor);

   if($tipus == "integer" || $tipus == "double") {
       echo "$nom: Número<br>";
   } elseif($tipus == "string") {
       echo "$nom: String<br>";
   } elseif($tipus == "NULL") {
    echo "$nom: NULL<br>";
   } else {
       echo "$nom: tipus<br>";

   }
}

?>