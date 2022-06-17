-- Als Gast möchte ich alle Artikel Items angezeigt bekommen 
select i.name,
  i.description,
  i.price,
  i.stock,
  i.manufacturer
from items i;

-- Als Gast möchte ich nach einem bestimmten Artikel suchen
SELECT i.name,
  i.description,
  i.price,
  i.stock,
  i.manufacturer
from items i
where i.name like "%?%";

-- Als Gast möchte ich mich einloggen, um eine Bestellung zu tätigen.
select u.username,
  u.passwordsalt
from users u
where u.username = ?;

-- Als Mitglied möchte ich meine Email-Adrese bearbeiten, weil sie aktualisiert hat.
update users u
set u.email = ?
where u.userid = ?;

-- Als Mitglied möchte ich mein usernamen bearbeiten, weil dieser sich geändert hat.
update users u
set u.username = ?
where u.userid = ?;

-- Als Mitglied möchte ich mein passwort ändern, um die Sicherheit zu gewährleisten.
update users u
set u.passwordHash = ?
where u.userid = ?;

-- Als Mitglied möchte ich meinen Vor- und Nachnamen bearbeiten, da er sich geändert hat.
update users u
set u.firstname = ?,
  u.lastname = ?
where u.userid = ?;

-- Als Mitglied möchte ich meine Telefonnummer/Alt bearbeiten, weil sie aktualisiert haben.
update users u
set u.phone = ?,
  u.phoneAlt = ?
where u.userid = ?;

-- Als Mitglied möchte ich mein Geschlecht bearbeiten.
update users u
set u.gender = ?
where u.userid = ?;

-- Als Mitglied möchte ich meinen Geburtstag bearbeiten.
update users u
set u.birthday = ?
where u.userid = ?;

-- Als Mitglied möchte ich meine Adresse bearbeiten, weil sie sich geändert hat.
update addresses a
  join addressTypes adt on adt.addressID = a.addressID
  join users u on u.userid = adt.userID
set a.country = ?,
  a.city = ?,
  a.zipcode = ?,
  a.street = ?
where u.userid = ?;

-- Als Mitglied möchte ich eine weitere Adresse hinzufügen, um eine weiter Zustellungsadresse zur Auswahl zu haben
BEGIN transaction
insert into addresses(country, city, zipcode, street)
  join addressTypes adt on adt.addressID = a.addressID
  join users u on u.userid = adt.userID
values ("DE", "Schlumpfhausen", "43534", "Straße 1");
-- TODO max in variable speichern
insert into addressesTypes (
    userID,
    addressID,
    isBillingAddress,
    isDeliveryAddress
  )
  join addresseson adt.addressID = a.addressID
  join users u on u.userid = adt.userID
values (0, , 1, 1);
commit;

-- Als Mitglied möchte ich einen Artikel bestellen, den ich mir ausgesucht habe

-- Als Mitglied möchte ich einen Artikel in den Warenkorb legen, um ihn zu kaufen

-- Als Mitarbeiter möchte ich einen Artikel hinzufügen  
insert into items(
    name,
    dealerID,
    description,
    price,
    stock,
    manufacturer,
    dateAdded
  )
values (
    "Fußball 2",
    1,
    "ein weiterer ball",
    59.99,
    10,
    "Adidas",
    now()
  );

-- Als Mitarbeiter möchte ich einen Dealer hinzufügen
insert into dealers(addressID, name)
values (?, ?);

-- Als Mitarbeiter möchte ich einen Artikel löschen (15)
delete from items
where items.itemID = ?;

-- Als Admin möchte ich eine neue Berechtigung anlegen
insert into permissions(name, description)
values (?, ?);

-- Als Admin möchte ich eine Berechtigung löschen
delete from permissions
where permissions.name = ?;

--Hi =)
