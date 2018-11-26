--
-- H2 port of the PostgreSQL port of the MySQL "World" database.
--
-- The sample data used in the world database is Copyright Statistics 
-- Finland, http://www.stat.fi/worldinfigures.
--

CREATE TABLE IF NOT EXISTS product (
    id integer NOT NULL,
    name varchar NOT NULL,
    barcode character(3) NOT NULL,
    wspPence integer NOT NULL
    rrpPence integer NOT NULL
);


CREATE TABLE IF NOT EXISTS country (
    code character(3) NOT NULL,
    name varchar NOT NULL,
    continent varchar NOT NULL,
    region varchar NOT NULL,
    surfacearea real NOT NULL,
    indepyear smallint,
    population integer NOT NULL,
    lifeexpectancy real,
    gnp numeric(10,2),
    gnpold numeric(10,2),
    localname varchar NOT NULL,
    governmentform varchar NOT NULL,
    headofstate varchar,
    capital integer,
    code2 character(2) NOT NULL
);

CREATE TABLE IF NOT EXISTS countrylanguage (
    countrycode character(3) NOT NULL,
    language varchar NOT NULL,
    isofficial boolean NOT NULL,
    percentage real NOT NULL
);

INSERT INTO product VALUES (4078, 'Nablus', 'PSE', 'Nablus', 100231);
INSERT INTO product VALUES (4079, 'Rafah', 'PSE', 'Rafah', 92020);

--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: chriskl
--
INSERT INTO country VALUES ('ZWE', 'Zimbabwe', 'Africa', 'Eastern Africa', 390757, 1980, 11669000, 37.799999, 5951.00, 8670.00, 'Zimbabwe', 'Republic', 'Robert G. Mugabe', 4068, 'ZW');
INSERT INTO country VALUES ('PSE', 'Palestine', 'Asia', 'Middle East', 6257, NULL, 3101000, 71.400002, 4173.00, NULL, 'Filastin', 'Autonomous Area', 'Yasser (Yasir) Arafat', 4074, 'PS');

--
-- Data for Name: countrylanguage; Type: TABLE DATA; Schema: public; Owner: chriskl
--

INSERT INTO countrylanguage VALUES ('USA', 'Portuguese', false, 0.2);


ALTER TABLE product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);

    ALTER TABLE country
        ADD CONSTRAINT country_capital_fkey FOREIGN KEY (capital) REFERENCES product(id);

ALTER TABLE country
    ADD CONSTRAINT country_pkey PRIMARY KEY (code);

ALTER TABLE countrylanguage
    ADD CONSTRAINT countrylanguage_pkey PRIMARY KEY (countrycode, language);



ALTER TABLE countrylanguage
    ADD CONSTRAINT countrylanguage_countrycode_fkey FOREIGN KEY (countrycode) REFERENCES country(code);


CREATE OR REPLACE FUNCTION getCountries(n integer, OUT c refcursor) AS '
BEGIN
    OPEN c FOR SELECT name FROM country LIMIT n;
END;
' LANGUAGE plpgsql;

COMMIT;
