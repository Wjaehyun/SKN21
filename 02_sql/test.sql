SHOW TABLES;
USE test;
USE telco_churn;

ALTER USER 'root'@'localhost'
IDENTIFIED WITH mysql_native_password BY 'Wjaehyun05~!!';
FLUSH PRIVILEGES;

CREATE TABLE IF NOT EXISTS customer_churn (
    customerID VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(20),
    SeniorCitizen INT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    tenure INT,
    PhoneService VARCHAR(10),
    MultipleLines VARCHAR(50),
    InternetService VARCHAR(50),
    OnlineSecurity VARCHAR(50),
    OnlineBackup VARCHAR(50),
    DeviceProtection VARCHAR(50),
    TechSupport VARCHAR(50),
    StreamingTV VARCHAR(50),
    StreamingMovies VARCHAR(50),
    Contract VARCHAR(50),
    PaperlessBilling VARCHAR(10),
    PaymentMethod VARCHAR(50),
    MonthlyCharges FLOAT,
    TotalCharges FLOAT,
    numAdminTickets INT,
    numTechTickets INT,
    Churn VARCHAR(10)
);

SELECT * FROM customer_churn;
SELECT COUNT(*) FROM customer_churn;

SELECT * FROM customer_churn LIMIT 5;

SELECT * FROM customer_churn;
SELECT DISTINCT customerID FROM customer_churn LIMIT 10;

-- 테이블 구조 변경 (컬럼 삭제)
ALTER TABLE customer_churn
    DROP COLUMN PhoneService,
    DROP COLUMN MultipleLines,
    DROP COLUMN OnlineSecurity,
    DROP COLUMN OnlineBackup,
    DROP COLUMN DeviceProtection,
    DROP COLUMN TechSupport,
    DROP COLUMN StreamingTV,
    DROP COLUMN StreamingMovies,
    DROP COLUMN PaperlessBilling,
    DROP COLUMN TotalCharges,
    DROP COLUMN numAdminTickets,
    DROP COLUMN numTechTickets;
-- (주의: Churn과 customerID는 중요해서 삭제 목록에 안 넣었습니다!)

select * from customer_churn;

CREATE USER 'member'@'%' IDENTIFIED BY '1234!';
GRANT SELECT, INSERT, UPDATE ON telco_churn.* TO 'member'@'%';
FLUSH PRIVILEGES;

ALTER USER 'member'@'%' IDENTIFIED WITH mysql_native_password BY 'team1234!';




DROP table IF exists region;

CREATE TABLE region
(
	region_id 	INT 		NOT NULL COMMENT '지역 식별 코드',
    region 		VARCHAR(20) NOT NULL COMMENT '지역',
    primary KEY (region_id)
) COMMENT '지역 식별';

DROP table IF exists h2_FAQ;
CREATE TABLE h2_FAQ
(
  faq_id   INT          AUTO_INCREMENT COMMENT '식별코드',
  question VARCHAR(500) NOT NULL COMMENT '질문',
  answer   VARCHAR(2000) NOT NULL COMMENT '답변',
  PRIMARY KEY (faq_id)
) COMMENT '수소차 충전소 인프라 FAQ';

DROP table IF exists annual_h2_ev_registrations;
CREATE TABLE annual_H2_ev_registrations
(
  year_id      	INT   AUTO_INCREMENT COMMENT '식별코드',
  year			varchar(10)  NOT NULL COMMENT '연도',
  h2_car_total 	INT  NULL     COMMENT '수소차  등록 대수',
  ev_car_total 	INT  NULL     COMMENT '전기차  등록 대수',
  PRIMARY KEY (year_id)
) COMMENT '연도별 H2/ EV 자동차 등록대수';

DROP table IF exists h2_stations_by_region;
CREATE TABLE h2_stations_by_region
(
  region_id         INT         NOT NULL COMMENT '지역 식별 코드',
  number_of_station INT         NOT NULL COMMENT '충전소 개수',
  foreign key (region_id) REFERENCES region(region_id)
) COMMENT '지역별 수소차 충전소 개수';

DROP table IF exists ev_stations_by_region;
CREATE TABLE ev_stations_by_region
(
  region_id         INT  NULL COMMENT '지역 식별 코드',
  number_of_station INT  NOT NULL COMMENT '충전소 개수',
  foreign key (region_id) REFERENCES region(region_id)
) COMMENT '지역별 전기차 충전소 개수';

DROP table IF exists h2_station_info;
CREATE TABLE h2_station_info
(
  station_id   INT         AUTO_INCREMENT COMMENT '식별코드',
  station_name VARCHAR(100)NOT NULL COMMENT '충전소 이름',
  region 		VARCHAR(20) NOT NULL COMMENT '지역',
  price        INT         NULL     COMMENT '충전 가격',
  tel          VARCHAR(20) NULL     COMMENT '전화번호',
  region_id    INT         			COMMENT '지역 식별 코드',
  PRIMARY KEY (station_id),
  foreign key (region_id) REFERENCES region(region_id)
) COMMENT '수소차 충전소 정보';

select * from region;
select * from h2_station_info;
select * from annual_h2_ev_registrations;
select * from h2_stations_by_region;
select * from ev_stations_by_region;
select * from h2_faq;

SELECT reg.region, number_of_station
FROM h2_stations_by_region h2
JOIN region reg ON h2.region_id = reg.region_id
WHERE region in ('경기', '강원','서울', '경상', '전라', '충청', '제주');