-- Als Gast möchte ich alle Artikel angezeigt bekommen.
SELECT i.name,
  i.description,
  i.price,
  i.stock,
  i.manufacturer
FROM items i;

-- felix
-- Als Gast möchte ich nach einem bestimmten Artikel suchen.
SELECT i.name,
  i.description,
  i.price,
  i.stock,
  i.manufacturer
FROM items i
WHERE i.name LIKE "%lampe%";

-- Als Gast möchte ich mich einloggen, um eine Bestellung zu tätigen.
SELECT u.username,
  u.passwordsalt
FROM users u
WHERE u.username = ?;

-- Als Mitglied möchte ich meine Email-Adrese bearbeiten, weil sie sich aktualisiert hat.
UPDATE users u
SET u.email = ?
WHERE u.userid = ?;

-- Als Mitglied möchte ich meinen Usernamen bearbeiten, weil dieser sich geändert hat.
UPDATE users u
SET u.username = ?
WHERE u.userid = ?;

-- Als Mitglied möchte ich mein Passwort ändern, um die Sicherheit zu gewährleisten.
UPDATE users u
SET u.passwordHash = ?
WHERE u.userid = ?;

-- Als Mitglied möchte ich meinen Vor- und Nachnamen bearbeiten, da er sich geändert hat.
UPDATE users u
SET u.firstname = ?,
  u.lastname = ?
WHERE u.userid = ?;

-- Als Mitglied möchte ich meine Telefonnummer/Alt bearbeiten, weil sie sich aktualisiert haben.
UPDATE users u
SET u.phone = ?,
  u.phoneAlt = ?
WHERE u.userid = ?;

-- Als Mitglied möchte ich mein Geschlecht bearbeiten.
UPDATE users u
SET u.gender = ?
WHERE u.userid = ?;

-- Als Mitglied möchte ich meinen Geburtstag bearbeiten.
UPDATE users u
SET u.birthday = ?
WHERE u.userid = ?;

-- Als Mitglied möchte ich meine Adresse bearbeiten, weil sie sich geändert hat.
UPDATE addresses a
  JOIN addressTypes adt ON adt.addressID = a.addressID
  JOIN users u ON u.userid = adt.userID
SET a.country = ?,
  a.city = ?,
  a.zipcode = ?,
  a.street = ?
WHERE u.userid = ?;

-- Als Mitglied möchte ich eine weitere Adresse hinzufügen, um eine weiter Zustellungsadresse zur Auswahl zu haben
START TRANSACTION;

INSERT INTO addresses(country, city, zipcode, street)
VALUES ("DE", "Schlumpfhausen", "43534", "Straße 1");

INSERT INTO addressTypes (
    userID,
    addressID,
    isBillingAddress,
    isDeliveryAddress
  )
VALUES (0, LAST_INSERT_ID(), 1, 1);

COMMIT;

-- Als Mitglied möchte ich einen Artikel bestellen, den ich mir ausgesucht habe.

-- Als Mitglied möchte ich einen Artikel in den Warenkorb legen, um ihn zu kaufen.

-- Als Mitarbeiter möchte ich einen Artikel hinzufügen.
INSERT INTO items(
    name,
    dealerID,
    description,
    price,
    stock,
    manufacturer,
    dateAdded
  )
VALUES (
    "Fußball 2",
    1,
    "ein weiterer ball",
    59.99,
    10,
    "Adidas",
    now()
  );

-- Als Mitarbeiter möchte ich einen Dealer hinzufügen.
INSERT INTO dealers(addressID, description)
VALUES (?, ?);

-- Als Mitarbeiter möchte ich einen Artikel löschen (15)
DELETE FROM items
WHERE items.itemID = ?;

-- Als Admin möchte ich eine neue Berechtigung anlegen.
INSERT INTO permissions(name, description)
VALUES (?, ?);

-- Als Admin möchte ich eine Berechtigung löschen.
DELETE FROM permissions
WHERE permissions.name = ?;

