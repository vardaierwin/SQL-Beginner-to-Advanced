# 📘 Extended Description (English)
## 🏢 Database Purpose & Structure
This database models an HR system for the fictional Parks and Recreation Department. It contains employees’ demographic and salary data, as well as department-level metadata. It also includes examples of procedural SQL: stored procedures, triggers, events, subqueries, window functions, joins, and common SQL clauses.

## 🗃️ Tables Overview
* 'employee_demographics'
Contains personal information: 'ID, name, age, gender, birth date'.

* 'employee_id' is the primary key.
Used as the authoritative source of individual identity data.

* 'employee_salary'
Stores compensation and job-related data: salary, job title, and department.

* Connected to 'employee_demographics' via 'employee_id'.
Includes fields that mirror 'first_name' and 'last_name' for redundancy (useful for testing joins and duplication scenarios).

* parks_departments
Stores department names with an auto-incremented department_id.

Links with 'employee_salary' via 'dept_id'.

## ⚙️ SQL Features Demonstrated
### ✅ Basic Queries
'SELECT, WHERE, ORDER BY, GROUP BY, HAVING, LIMIT, DISTINCT, and filtering via LIKE, !='.

#### 🔄 Joins
* Inner joins ('INNER JOIN') between employees and salaries.
* Left/right outer joins to show differences in matching.
* Self joins to simulate hierarchical or paired relationships.
* Multi-table joins combining demographics, salary, and department.

#### 🧠 Aggregates & Analysis
Aggregation by gender and occupation using 'AVG, MAX, MIN, COUNT'.

Conditional logic via 'CASE' and 'IF' statements.

Aliases (AS) used for readability.

#### 📈 Window Functions
'SUM() OVER(PARTITION BY ...)' to calculate rolling totals by gender.

'ROW_NUMBER(), RANK(), DENSE_RANK()' to rank employees by salary.

#### 📦 Common Table Expressions (CTEs)
'WITH' clause used to define temporary, readable query logic blocks for:
* Average salary comparison.
* Gender-based salary statistics.
* Departmental breakdowns.

#### 🧪 Subqueries
Nested queries used to extract statistics from grouped data.

#### 🗃️ Temporary Tables
Demonstrates usage of 'CREATE TEMPORARY TABLE' for ad hoc analysis.
E.g., creating a filtered table for salaries over 50,000.

#### 💾 Stored Procedures
Several examples of 'CREATE PROCEDURE', including:
* Simple salary filtering ('large_salaries')
* Parameterized procedures ('large_salaries4')
* Multi-select procedures
* Parameter passing ('IN').

#### 🔔 Triggers
'AFTER INSERT' trigger on 'employee_salary' automatically inserts demographic data into 'employee_demographics'.

#### ⏰ Events
An 'EVENT' is scheduled every 30 seconds to delete retirees (age ≥ 60) from 'employee_demographics'.

Requires event scheduler to be activated with 'SET GLOBAL event_scheduler=ON'.

# 📗 Extended Description (magyarul)
🏛️ Adatbázis célja és szerkezete
Ez az adatbázis egy fiktív Önkormányzati Park- és Rekreációs Hivatal HR-rendszerének modellje. Tartalmaz személyi adatokat, fizetéseket és osztályszintű adatokat, valamint bemutatja a haladó SQL-eszközök használatát: tárolt eljárások, triggerek, események, ablakfüggvények, összetett lekérdezések és ideiglenes táblák.

## 🗃️ Táblák összefoglalása
* 'employee_demographics'
Személyes adatok: azonosító, név, életkor, nem, születési dátum.

* 'employee_id' az elsődleges kulcs.
Fő forrása az alkalmazotti személyazonosságnak.

* 'employee_salary'
Bér- és pozíció-információk: munkakör, fizetés, osztály.

* Az 'employee_id' mezőn keresztül kapcsolódik a demográfiai táblához.
Redundáns mezők ('first_name, last_name') tesztelési célból.

* 'parks_departments'
Osztálynevek tárolása, 'AUTO_INCREMENT' azonosítóval.

A 'dept_id' mezővel kapcsolódik az employee_salary táblához.

## ⚙️ Bemutatott SQL-funkciók
### ✅ Alap SQL-lekérdezések
'SELECT, WHERE, ORDER BY, GROUP BY, HAVING, LIMIT, DISTINCT, LIKE, !='.

#### 🔗 Kapcsolatok és JOIN-ok
* Belső ('INNER JOIN') és külső ('RIGHT JOIN') kapcsolatok.
* Önkapcsolat ('SELF JOIN') példákra.
* Többtáblás kapcsolások a három fő tábla között.

#### 📊 Aggregált lekérdezések és analitika
* Nemek és munkakörök szerinti átlag-, maximum-, minimum- és darabszám lekérdezések.
* Feltételes logika CASE és IF használatával.
* Olvashatóbb eredmények névátadással (AS).

#### 📈 Ablakfüggvények (Window Functions)
Görgetett összeg ('SUM() OVER), sorrend (ROW_NUMBER(), RANK(), DENSE_RANK()').

#### 📦 CTE – Közös lekérdezési kifejezések
* WITH blokkok az ideiglenes, olvasható lekérdezésekhez.
* Átlagos fizetés összehasonlítás.
* Osztályonkénti bontás.
* Nemek szerinti összesítés.

#### 🧪 Allekérdezések (Subqueries)
Bonyolultabb, statisztikai lekérdezések tömbösített táblákból.

#### 🔄 Ideiglenes táblák
'CREATE TEMPORARY TABLE' használata ad hoc szűrt lekérdezésekhez (pl. fizetés > 50000).

#### 🛠️ Tárolt eljárások
Több példa, köztük:
* Szűrt listázás paraméter nélkül ('large_salaries')
* Paraméteres eljárások ('large_salaries4')
* 'IN' paraméterkezelés példái.

#### 🔔 Triggerek
'AFTER INSERT' trigger, amely az 'employee_salary' új sorai alapján demográfiai rekordot is beszúr.

####⏰ Események ('Events')
30 másodpercenként futó esemény, amely eltávolítja a nyugdíjasokat (age >= 60) az 'employee_demographics' táblából.
Aktiválása szükséges: 'SET GLOBAL event_scheduler = ON'.
