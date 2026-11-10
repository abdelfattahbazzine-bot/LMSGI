
<?php

$operand1 = 10;
$operand2 = 5;
$operacio = "divisio";

function calcular($operand1, $operand2, $operacio) {

    if ($operacio == "suma") {
        return $operand1 + $operand2;
    }
    elseif ($operacio == "resta") {
        return $operand1 - $operand2;
    }
    elseif ($operacio == "multiplicacio") {
        return $operand1 * $operand2;
    }
    elseif ($operacio == "divisio") {

        if ($operand2 == 0) {
            return "No es pot dividir entre zero";
        }
        else {
            return $operand1 / $operand2;
        }
    }
    else {
        return "Operacio no valida";
    }
}

echo calcular($operand1, $operand2, $operacio);

?>
