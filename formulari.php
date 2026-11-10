<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test formularis</title>
</head>

<body>
    <form method="post" action="check_form.php">
        Name: <input type="text" name="name" placeholder="Type your name here">
        <br /><br />
        Apellido: <input type="text" name="apellido" placeholder="Type your surname here">
        <br /><br />
        E-mail: <input type="email" name="email" placeholder="example@test.com">
        <br /><br />
        Password: <input type="password" name="password" placeholder="This is secret">
        <br /><br />
        Gender:
        <input type="radio" name="gender" value="dona" checked>Female
        <input type="radio" name="gender" value="home">Male
        <br /><br />
        <input type="checkbox" name="vehicle1" value="Bike"> I have a bike<br />
        <input type="checkbox" name="vehicle2" value="Car"> I have a car
        <br /><br />
        <input type="submit" name="submitButton" value="Submit">
    </form>
</body>

</html>