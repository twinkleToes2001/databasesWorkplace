CREATE TABLE t_messure (
    id_messure INT NOT NULL, 
    names VARCHAR(40) NOT NULL,
    CONSTRAINT pk_messure PRIMARY KEY (id_messure)
);

CREATE TABLE t_material (
    id_material INT NOT NULL,
    names VARCHAR(100) NOT NULL,
    id_messure INT NOT NULL,
    CONSTRAINT pk_material PRIMARY KEY (id_material),
    CONSTRAINT fk_material_messure FOREIGN KEY (id_messure)
        REFERENCES t_messure (id_messure)
);

CREATE TABLE t_inprice (
    id_material INT NOT NULL,
    price_date DATE NOT NULL,
    price NUMERIC(10, 2) CHECK (price >= 0),
    CONSTRAINT fk_inprice_material FOREIGN KEY (id_material)
        REFERENCES t_material (id_material)
);

CREATE TABLE t_caterer (
    id_caterer INT NOT NULL,
    names VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL,
    fax VARCHAR(100) NOT NULL,
    CONSTRAINT pk_caterer PRIMARY KEY (id_caterer)
);

CREATE TABLE t_store (
    id_store INT NOT NULL,
    names VARCHAR(100) NOT NULL,
    CONSTRAINT pk_store PRIMARY KEY (id_store)
);

CREATE TABLE t_supply (
    id_supply INT NOT NULL,
    id_caterer INT NOT NULL,
    id_store INT NOT NULL,
    id_material INT NOT NULL,
    supply_date DATE NOT NULL,
    value INT NOT NULL,
    CONSTRAINT pk_supply PRIMARY KEY (id_supply),
    CONSTRAINT fk_supply_caterer FOREIGN KEY (id_caterer)
        REFERENCES t_caterer (id_caterer),
    CONSTRAINT fk_supply_store FOREIGN KEY (id_store)
        REFERENCES t_store (id_store),
    CONSTRAINT fk_supply_material FOREIGN KEY (id_material)
        REFERENCES t_material (id_material)
);

CREATE TABLE t_surplus (
    id_material INT NOT NULL,
    id_store INT NOT NULL,
    value INT NOT NULL,
    CONSTRAINT fk_surplus_material FOREIGN KEY (id_material)
        REFERENCES t_material (id_material),
    CONSTRAINT fk_surplus_store FOREIGN KEY (id_store)
        REFERENCES t_store (id_store)
);

CREATE TABLE t_employer (
    id_employer INT NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    firs_name VARCHAR(50) NOT NULL,
    father_name VARCHAR(50) NOT NULL,
    CONSTRAINT pk_employer PRIMARY KEY (id_employer)
);

CREATE TABLE t_section (
    id_section INT NOT NULL,
    names VARCHAR(50) NOT NULL,
    id_employer INT NOT NULL,
    CONSTRAINT pk_section PRIMARY KEY (id_section),
    CONSTRAINT fk_section_employer FOREIGN KEY (id_employer)
        REFERENCES t_employer (id_employer)
);

CREATE TABLE t_deliver (
    id_deliver INT NOT NULL,
    id_material INT NOT NULL,
    id_store INT NOT NULL,
    id_section INT NOT NULL,
    deliver_date DATE NOT NULL,
    CONSTRAINT pk_deliver PRIMARY KEY (id_deliver),
    CONSTRAINT fk_deliver_material FOREIGN KEY (id_material)
        REFERENCES t_material (id_material),
    CONSTRAINT fk_deliver_store FOREIGN KEY (id_store)
        REFERENCES t_store (id_store),
    CONSTRAINT fk_deliver_section FOREIGN KEY (id_section)
        REFERENCES t_section (id_section)
);

/*second*/
ALTER TABLE t_caterer
DROP address,
ADD legal_address text,
ADD fact_address text,
ADD mail varchar(250);

/*third*/
ALTER TABLE t_inprice
DROP CONSTRAINT fk_inprice_material,
ADD CONSTRAINT pk_inprice_price_date 
PRIMARY KEY (price_date, id_material);

/*fouth*/
CREATE TABLE t_group
(
	id_group int NOT NULL,
	id_material int NOT NULL,
	group_name VARCHAR(20) NOT NULL,
	CONSTRAINT fk_group_material FOREIGN KEY (id_material) 
        REFERENCES t_material (id_material) ON DELETE SET NULL
);