import QtQuick.Controls.Material 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    visible: true
    width: 400
    height: 450
    title: "QT Quick App with MySQL"
    Material.theme: Material.Light
    Material.primary: "#D81B60"   // Pink primary color
    Material.accent: "#9C27B0"    // Purple accent color
    color: "#F3E5F5"              // Light pink background for the window

    // Define the user model for the ListView
    ListModel {
        id: userModel
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 8
        Layout.alignment: Qt.AlignTop

        // Title Section
        RowLayout {
            spacing: 8
            Layout.fillWidth: true

            Button {
                Layout.fillWidth: true
                background: Rectangle {
                    color: "#E91E63"  // Pink shade for the button background
                    radius: 20
                }
                font.pixelSize: 16
                contentItem: Text {
                    text: qsTr("Data Recuperation")
                    color: "#FFFFFF" // White text color
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }

        // Buttons Section (placed on the same row)
        RowLayout {
            spacing: 150  // Spacing between the buttons
            Layout.fillWidth: true

            // Read Button
            Button {
                background: Rectangle {
                    color: "transparent"  // Transparent background
                }
                contentItem: Image {
                    source: "qrc:/read_icon.png"  // Replace with the actual path to the image
                    width: 16  // Set image width to 16 pixels
                    height: 16 // Set image height to 16 pixels
                    fillMode: Image.PreserveAspectFit
                }
                onClicked: {
                    readUsers()
                    nameInput.clear()
                    idInput.clear()
                    ageInput.clear()
                }
            }

            // Insert Button
            Button {
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/insert_icon.png"  // Replace with the actual path to the image
                    width: 16  // Set image width to 16 pixels
                    height: 16 // Set image height to 16 pixels
                    fillMode: Image.PreserveAspectFit
                }
                onClicked: {
                    insertUser(idInput.text, nameInput.text, ageInput.text)
                    nameInput.clear()
                    idInput.clear()
                    ageInput.clear()
                }
            }

            // Update Button
            Button {
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/update_icon.png"  // Replace with the actual path to the image
                    width: 16  // Set image width to 16 pixels
                    height: 16 // Set image height to 16 pixels
                    fillMode: Image.PreserveAspectFit
                }
                onClicked: {
                    updateUser(idInput.text, nameInput.text, ageInput.text)
                    nameInput.clear()
                    idInput.clear()
                    ageInput.clear()
                }
            }

            // Delete Button
            Button {
                background: Rectangle {
                    color: "transparent"
                }
                contentItem: Image {
                    source: "qrc:/delete_icon.png"  // Replace with the actual path to the image
                    width: 16  // Set image width to 16 pixels
                    height: 16 // Set image height to 16 pixels
                    fillMode: Image.PreserveAspectFit
                }
                onClicked: {
                    deleteUser(idInput.text)
                    nameInput.clear()
                    idInput.clear()
                    ageInput.clear()
                }
            }

        }

        // Input Fields Section
        RowLayout {
            spacing: 8
            Layout.fillWidth: true

            TextField {
                id: idInput
                placeholderText: "Enter ID"
                Layout.fillWidth: true
                background: Rectangle {
                    color: "#F8BBD0" // Light pink for TextField background
                    radius: 4
                }
                font.pixelSize: 16
                color: "#D81B60" // Dark pink text color
            }

            TextField {
                id: nameInput
                placeholderText: "Enter name"
                Layout.fillWidth: true
                background: Rectangle {
                    color: "#F8BBD0" // Light pink for TextField background
                    radius: 4
                }
                font.pixelSize: 16
                color: "#D81B60" // Dark pink text color
            }

            TextField {
                id: ageInput
                placeholderText: "Enter Age"
                Layout.fillWidth: true
                background: Rectangle {
                    color: "#F8BBD0" // Light pink for TextField background
                    radius: 4
                }
                font.pixelSize: 16
                color: "#D81B60" // Dark pink text color
            }
        }

        ScrollView {
            Layout.fillWidth: true
            Layout.preferredHeight: 250
            Layout.alignment: Qt.AlignTop

            ListView {
                id: userList
                width: parent.width
                model: userModel
                delegate: Item {
                    width: userList.width
                    height: 30
                    Column {
                        spacing: 0
                        Text {
                            text: model.id + " (Name: " + model.name + ", Age: " + model.age + ")"
                            color: "#121212" // White text for readability
                            font.pixelSize: 18
                        }
                    }
                }
            }
        }
    }

    // Function to read the users from the database
    function readUsers() {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "http://dengtech.systems/data/mysqltest/apiget.php?action=read", true);
        xhr.onload = function() {
            if (xhr.status === 200) {
                userModel.clear();  // Clear the model before populating it
                var jsonResponse = JSON.parse(xhr.responseText);
                for (var i = 0; i < jsonResponse.length; i++) {
                    userModel.append({ id: jsonResponse[i].id, name: jsonResponse[i].name, age: jsonResponse[i].age });
                }
            } else {
                console.error("Error reading users");
            }
        };
        xhr.send();
    }

    // Function to insert a new user with a GET request
    function insertUser(id, name, age) {
        var xhr = new XMLHttpRequest();
        // Add the parameters to the URL as query strings
        var url = "http://dengtech.systems/data/mysqltest/apiget.php?action=insert&id=" + encodeURIComponent(id) +
                  "&name=" + encodeURIComponent(name) +
                  "&age=" + encodeURIComponent(age);

        xhr.open("GET", url, true); // GET request with data in the URL
        xhr.onload = function() {
            if (xhr.status === 200) {
                console.log("User inserted successfully");
                readUsers();  // Refresh the user list after insertion
            } else {
                console.error("Error inserting user");
            }
        };
        xhr.send(); // Send the request without a body
    }

    // Function to delete a user by ID with a GET request
    function deleteUser(id) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET","http://dengtech.systems/data/mysqltest/apiget.php?action=delete&id=" + id, true);
        xhr.onload = function() {
            if (xhr.status === 200) {
                console.log("User deleted successfully");
                readUsers();  // Refresh the user list after deletion
            } else {
                console.error("Error deleting user");
            }
        };
        xhr.send();
    }

    // Function to update the user's information with a GET request
    function updateUser(id, name, age) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET","http://dengtech.systems/data/mysqltest/apiget.php?action=update&id=" + id + "&name=" + encodeURIComponent(name) + "&age=" + encodeURIComponent(age), true);
        xhr.onload = function() {
            if (xhr.status === 200) {
                console.log("User updated successfully");
                readUsers();  // Refresh the user list after update
            } else {
                console.error("Error updating user");
            }
        };
        xhr.send();
    }
}
