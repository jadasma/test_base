#ifndef DATABASEHANDLER_H
#define DATABASEHANDLER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QVariantList>

class DatabaseHandler : public QObject {
    Q_OBJECT
public:
    explicit DatabaseHandler(QObject *parent = nullptr);

    Q_INVOKABLE QVariantList readUsers();
    Q_INVOKABLE bool insertUser(const QString &id, const QString &name, const QString &age);
    Q_INVOKABLE bool deleteUser(const QString &id);
    Q_INVOKABLE bool updateUser(const QString &id, const QString &name, const QString &age);

private:
    QSqlDatabase db;
};

#endif // DATABASEHANDLER_H



