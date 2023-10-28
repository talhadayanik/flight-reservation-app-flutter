<?php

$servername = "localhost";
$username = "root";
$passwordDB = "";
$dbname = "flight_reservation";
$users_table = "users";
$flights_table = "flights";
$pnr_table = "pnr";

//$action = $_POST['action'];
$action = isset($_POST["action"]) ? $_POST["action"] : "";

$conn = new mysqli($servername, $username, $passwordDB, $dbname);

if($conn->connect_error){
    die("Connection failed: " . $conn->connect_error);
    return;
}

if("CREATE_TABLE" == $action){
    $sql = "CREATE TABLE IF NOT EXISTS $users_table (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        email VARCHAR(30) NOT NULL,
        password VARCHAR(30) NOT NULL,
        first_name VARCHAR(30) NOT NULL,
        last_name VARCHAR(30) NOT NULL,
        level VARCHAR(7) NOT NULL
        )";

    if($conn->query($sql) === TRUE){
        echo "success";
    }else{
        echo "error";
    }
    $conn->close();
    return;
}

if("GET_ALL_USERS" == $action){
    $db_data = array();
    //$sql = "SELECT id, email, first_name, last_name, level from $users_table ORDER BY id";
    $sql = "CALL kullanicilariAl()";
    $result = $conn->query($sql);
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
            $db_data[] = $row;
        }
        echo json_encode($db_data);
    }else{
        echo "error";
    }
    $conn->close();
    return;
}


//ADD USER
if("ADD_USER" == $action){

    $email = $_POST['email'];
    $password = $_POST['password'];
    $sql = "SELECT email FROM users WHERE email = '".$email."'";
    $result = $conn->query($sql);
    if($result->num_rows > 0){
        echo "bu email zaten kayitli";
        $conn->close();
        return;
    }else{
        $email = $_POST["email"];
        $password = $_POST["password"];
        $first_name = $_POST["first_name"];
        $last_name = $_POST["last_name"];
        $level = $_POST["level"];
        $sql = "INSERT INTO $users_table (email, password, first_name, last_name, level)
            VALUES ('$email', '$password', '$first_name', '$last_name', '$level')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }
}

//UPDATE USER
if("UPDATE_USER" == $action){
    $user_id = $_POST["user_id"];
    $email = $_POST["email"];
    $password = $_POST["password"];
    $first_name = $_POST["first_name"];
    $last_name = $_POST["last_name"];
    $level = $_POST["level"];
    $sql = "UPDATE $users_table SET email = '".$email."', password = '".$password."',
    first_name = '".$first_name."', last_name = '".$last_name."', level = '".$level."'
    WHERE id = '".$user_id."'";
    if($conn->query($sql) === TRUE){
        echo "success";
    }else{
        echo "error";
    }
    $conn->close();
    return;
}

//DELETE USER
if('DELETE_USER' == $action){
    $user_id = $_POST['user_id'];
    $sql = "DELETE FROM $users_table WHERE id = '$user_id'";
    if($conn->query($sql) === TRUE){
        echo "success";
    }else{
        echo "error";
    }
    $conn->close();
    return;
}

if("ADD_FLIGHT" == $action){

    $from_location = $_POST['from_location'];
    $to_location = $_POST['to_location'];
    $flight_date = $_POST['flight_date'];
    $departure_time = $_POST['departure_time'];
    $arrival_time = $_POST['arrival_time'];
    $eco_price = $_POST['eco_price'];
    $business_price = $_POST['business_price'];
    $first_price = $_POST['first_price'];
    $eco_count = $_POST['eco_count'];
    $business_count = $_POST['business_count'];
    $first_count = $_POST['first_count'];

    $sql = "INSERT INTO $flights_table (from_location, to_location, flight_date, 
        departure_time, arrival_time, eco_price, business_price, first_price, eco_count, 
        business_count, first_count) VALUES ('$from_location', '$to_location', '$flight_date',
        '$departure_time', '$arrival_time', '$eco_price', '$business_price', '$first_price',
        '$eco_count', '$business_count', '$first_count')";
    $result = $conn->query($sql);
    echo "success";
    $conn->close();
    return;
}

if("GET_ALL_FLIGHTS" == $action){
    $db_data = array();
    $sql = "SELECT id, from_location, to_location, flight_date, departure_time,
    arrival_time, eco_price, business_price, first_price, eco_count, business_count,
    first_count from $flights_table ORDER BY id";
    $result = $conn->query($sql);
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
            $db_data[] = $row;
        }
        echo json_encode($db_data);
    }else{
        echo "error";
    }
    $conn->close();
    return;
}

if("UPDATE_FLIGHT" == $action){
    $flight_id = $_POST["flight_id"];
    $from_location = $_POST["from_location"];
    $to_location = $_POST["to_location"];
    $flight_date = $_POST["flight_date"];
    $departure_time = $_POST["departure_time"];
    $arrival_time = $_POST["arrival_time"];
    $eco_price = $_POST["eco_price"];
    $business_price = $_POST["business_price"];
    $first_price = $_POST["first_price"];
    $eco_count = $_POST["eco_count"];
    $business_count = $_POST["business_count"];
    $first_count = $_POST["first_count"];

    $sql = "UPDATE $flights_table SET from_location = '$from_location', to_location = '$to_location',
    flight_date = '$flight_date', departure_time = '$departure_time', arrival_time = '$arrival_time',
    eco_price = '$eco_price', business_price = '$business_price', first_price = '$first_price',
    eco_count = '$eco_count', business_count = '$business_count', first_count = '$first_count'
    WHERE id = '$flight_id'";
    if($conn->query($sql) === TRUE){
        echo "success";
    }else{
        echo "error";
    }
    $conn->close();
    return;
}

if("GET_A_FLIGHT" == $action){
    $db_data = array();
    $flight_id = $_POST["flight_id"];
    $sql = "SELECT id, from_location, to_location, flight_date, departure_time,
    arrival_time, eco_price, business_price, first_price, eco_count, business_count,
    first_count from $flights_table WHERE id = '$flight_id'";
    $result = $conn->query($sql);
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
            $db_data[] = $row;
        }
        echo json_encode($db_data);
    }else{
        echo "error";
    }
    $conn->close();
    return;
}

if("GET_DESIRED_FLIGHTS" == $action){
    $db_data = array();
    $from_location = $_POST["from_location"];
    $to_location = $_POST["to_location"];
    $flight_date = $_POST["flight_date"];
    $sql = "SELECT id, from_location, to_location, flight_date, departure_time,
    arrival_time, eco_price, business_price, first_price, eco_count, business_count,
    first_count from $flights_table WHERE from_location = '$from_location' and to_location = '$to_location' 
    and flight_date = '$flight_date' ORDER BY id";
    $result = $conn->query($sql);
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
            $db_data[] = $row;
        }
        echo json_encode($db_data);
    }else{
        echo "error";
    }
    $conn->close();
    return;
}

if("ADD_PNR" == $action){

    $user_id = $_POST['user_id'];
    $flight_id = $_POST['flight_id'];
    $seat_no = $_POST['seat_no'];

    $sql = "INSERT INTO $pnr_table (user_id, flight_id, seat_no)
     VALUES ('$user_id', '$flight_id', '$seat_no')";
    $result = $conn->query($sql);
    echo "success";
    $conn->close();
    return;
}

if("GET_PNRS" == $action){
    $db_data = array();
    $user_id = $_POST["user_id"];
    $sql = "SELECT id, user_id, flight_id, seat_no
     from $pnr_table WHERE user_id = '$user_id'";
    $result = $conn->query($sql);
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
            $db_data[] = $row;
        }
        echo json_encode($db_data);
    }else{
        echo "error";
    }
    $conn->close();
    return;
}

if('DELETE_PNR' == $action){
    $pnr_id = $_POST['pnr_id'];
    $sql = "DELETE FROM $pnr_table WHERE id = '$pnr_id'";
    if($conn->query($sql) === TRUE){
        echo "success";
    }else{
        echo "error";
    }
    $conn->close();
    return;
}

if('DELETE_FLIGHT' == $action){
    $flight_id = $_POST['flight_id'];
    $sql = "DELETE FROM $flights_table WHERE id = '$flight_id'";
    if($conn->query($sql) === TRUE){
        echo "success";
    }else{
        echo "error";
    }
    $conn->close();
    return;
}

?>