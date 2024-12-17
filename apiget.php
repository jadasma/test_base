<?php
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Content-Security-Policy: default-src 'self'; script-src 'self';");

error_reporting(E_ALL);
ini_set('display_errors', 1);

$mysqli = new mysqli("dengtech.systems", "admin_mounir", "123456mounir", "admin_test");

if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}
$action = filter_input(INPUT_GET, 'action', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
$name = filter_input(INPUT_GET, 'name', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
$id = filter_input(INPUT_GET, 'id', FILTER_SANITIZE_NUMBER_INT);
     
switch ($action) {
    case 'read':
        $result = $mysqli->query("SELECT * FROM users");
        $users = array();
        while ($row = $result->fetch_assoc()) {
            $users[] = $row;
        }
        echo json_encode($users);
        break;

    case 'insert':
        $name = $_GET['name'];
        $stmt = $mysqli->prepare("INSERT INTO users (name) VALUES (?)");
        $stmt->bind_param("s", $name);
        $stmt->execute();
        break;

    case 'update':
        $id = $_GET['id'];
        $name = $_GET['name'];
        $stmt = $mysqli->prepare("UPDATE users SET name=? WHERE id=?");
        $stmt->bind_param("si", $name, $id);
       if ($stmt->execute()) {
        echo json_encode(array("message" => "User updated successfully"));
    } else {
        echo json_encode(array("message" => "Error updating user", "error" => $stmt->error));
    }
        break;

    case 'delete':
        $id = $_GET['id'];
        $stmt = $mysqli->prepare("DELETE FROM users WHERE id=?");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        break;

    default:
        echo json_encode(array("message" => "Invalid Request"));
}



$mysqli->close();
?>
