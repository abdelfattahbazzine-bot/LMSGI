
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

function resoldreTipus($variable) {

    $tipus = gettype($variable);

    if ($tipus == "integer" || $tipus == "double") {
        return "número";
    } else {
        return $tipus;
    }
}

echo resoldreTipus($x) . "<br>";
echo resoldreTipus($y) . "<br>";
echo resoldreTipus($z) . "<br>";
echo resoldreTipus($a) . "<br>";
echo resoldreTipus($b) . "<br>";
echo resoldreTipus($c) . "<br>";
echo resoldreTipus($d) . "<br>";
echo resoldreTipus($e) . "<br>";
echo resoldreTipus($f) . "<br>";

?>
