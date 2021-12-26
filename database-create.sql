DROP DATABASE IF EXISTS test;
CREATE DATABASE test;

CREATE TABLE test.items (
  id int(11) NOT NULL,
  description varchar(255) DEFAULT NULL,
  uds int(11) DEFAULT NULL,
  PRIMARY KEY (id)
);
    
   
CREATE TABLE test.items_updates (
  id varchar(100) NOT NULL,
  action varchar(100) DEFAULT NULL,
  data_before text DEFAULT NULL,
  data_after text DEFAULT NULL,
  timestamp timestamp NOT NULL DEFAULT current_timestamp(),
  processed binary(1) DEFAULT NULL,
  processed_timestamp timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id)
);


DROP TRIGGER IF EXISTS test.item_created;
CREATE TRIGGER test.item_created
AFTER INSERT ON test.items
FOR EACH ROW 
INSERT INTO test.items_updates VALUES ( UUID(), "INSERT", NULL, JSON_OBJECT('id', NEW.id, 'description', NEW.description, 'uds', NEW.uds), NOW(),0, NULL);


DROP TRIGGER IF EXISTS test.item_updated;
CREATE TRIGGER test.item_updated
AFTER UPDATE ON test.items
FOR EACH ROW 
INSERT INTO test.items_updates VALUES ( UUID(), "UPDATE", JSON_OBJECT('id', OLD.id, 'description', OLD.description, 'uds', OLD.uds), JSON_OBJECT('id', NEW.id, 'description', NEW.description, 'uds', NEW.uds), NOW(),0,NULL);

DROP TRIGGER IF EXISTS test.item_deleted;
CREATE TRIGGER test.item_deleted
BEFORE DELETE ON test.items
FOR EACH ROW 
INSERT INTO test.items_updates VALUES ( UUID(), "DELETE", JSON_OBJECT('id', OLD.id, 'description', OLD.description, 'uds', OLD.uds), NULL, NOW(),0, NULL);



INSERT INTO test.items VALUES (10,'PRIMER ARTICULO',100);
INSERT INTO test.items VALUES (20,'SEGUNDO ARTICULO',100);
INSERT INTO test.items VALUES (30,'TERCER ARTICULO',100);
INSERT INTO test.items VALUES (40,'CUARTO ARTICULO',100);
INSERT INTO test.items VALUES (50,'QUINTO ARTICULO',100);
INSERT INTO test.items VALUES (60,'SEXTO ARTICULO',100);
INSERT INTO test.items VALUES (70,'SEPTIMO ARTICULO',100);
INSERT INTO test.items VALUES (80,'OCTAVO ARTICULO',100);
INSERT INTO test.items VALUES (90,'NOVENO ARTICULO',100);

UPDATE test.items SET UDS = UDS + 1; 

DELETE FROM test.items WHERE id BETWEEN 30 AND 50;