#include "DatabaseHandler.h"
#include <QSqlError>
#include <QDebug>

DatabaseHandler::DatabaseHandler(QObject *parent) : QObject(parent) {
    // Configurer la connexion à MySQL
    db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("dengtech.systems");
    db.setDatabaseName("admin_test"); // Remplacez par le nom de votre base de données
    db.setUserName("admin_mounir");         // Remplacez par votre nom d'utilisateur MySQL
    db.setPassword("123456mounir");         // Remplacez par votre mot de passe MySQL

    if (!db.open()) {
        qWarning() << "Failed to connect to database:" << db.lastError().text();
    } else {
        qDebug() << "Database connection established.";
    }
}

QVariantList DatabaseHandler::readUsers() {
    QSqlQuery query("SELECT * FROM users");
    QVariantList users;

    while (query.next()) {
        QVariantMap user;
        user["id"] = query.value("id").toString();
        user["name"] = query.value("name").toString();
        user["age"] = query.value("age").toString();
        users.append(user);
    }
    return users;
}

bool DatabaseHandler::insertUser(const QString &id, const QString &name, const QString &age) {
    QSqlQuery query;
    query.prepare("INSERT INTO users (id, name, age) VALUES (:id, :name, :age)");
    query.bindValue(":id", id);
    query.bindValue(":name", name);
    query.bindValue(":age", age);

    if (!query.exec()) {
        qWarning() << "Insert failed:" << query.lastError().text();
        return false;
    }
    return true;
}

bool DatabaseHandler::deleteUser(const QString &id) {
    QSqlQuery query;
    query.prepare("DELETE FROM users WHERE id = :id");
    query.bindValue(":id", id);

    if (!query.exec()) {
        qWarning() << "Delete failed:" << query.lastError().text();
        return false;
    }
    return true;
}

bool DatabaseHandler::updateUser(const QString &id, const QString &name, const QString &age) {
    QSqlQuery query;
    query.prepare("UPDATE users SET name = :name, age = :age WHERE id = :id");
    query.bindValue(":id", id);
    query.bindValue(":name", name);
    query.bindValue(":age", age);

    if (!query.exec()) {
        qWarning() << "Update failed:" << query.lastError().text();
        return false;
    }
    return true;
}



