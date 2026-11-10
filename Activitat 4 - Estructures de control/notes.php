<?php
$nota = rand(0, 10);

 echo "Nota: " . $nota . "";


if ($nota<5) {
    echo "Suspés";
}elseif ($nota== 5) {
    echo "Aprovat";
}elseif ($nota== 6) {
    echo "Bé";
}elseif ($nota== 7 || $nota== 8) {
    echo "Notable";
} else {
    echo "Excel·lent";
    
}