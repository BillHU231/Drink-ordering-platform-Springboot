--建立資料庫:
create database Drink;

--建立資料表:
use Drink;

------------------------------ 會員 ------------------------------

--刪除表格
drop table SQLMemberID
drop table SQLMemberData;
drop table SQLMemberDataVendor;

--開表格
create table SQLMemberID(
UserID varchar(50) not null PRIMARY KEY,--帳號
UserPaws varchar(50) not null,--密碼
ClassMember varchar(10) not null,--類別
VAT varchar(10), --統編
Email varchar(50),
picture varbinary(max))

create table SQLMemberData(
UserID varchar(50) not null,--帳號
Name varchar(50) ,--姓名
Birthday varchar(10)) --生日

create table SQLMemberDataVendor(
UserID varchar(50) not null,--帳號
Vendor varchar(50) ,--企業名稱
Principal varchar(10) ,--負責人
Address varchar(50))--地址

-------------------------------
------------------------------------------------------------------------------------------------------
--加入資料
--ClassMember 使用者類別 a:一般 b:企業 c:店家 d:員工 fa:一般會員忘記密碼未修改 fb:企業會員忘記密碼未修改
--UserID 使者帳號, UserPaws 使用者密碼, ClassMember 使用者類別, VAT 統一編號, Email
insert into SQLMemberID (UserID, UserPaws, ClassMember, Email) values ('admin', 'admin', 'gm','ordermealsystem@gmail.com');

insert into SQLMemberID (UserID, UserPaws, ClassMember, Email) values ('a123456', 'a123', 'a','asbill920166@gmail.com');
insert into SQLMemberID (UserID, UserPaws, ClassMember, Email) values ('asd546666', 'a123', 'a','asd546666@gmail.com');
insert into SQLMemberID (UserID, UserPaws, ClassMember, Email) values ('qwe124532', 'a123', 'a','addd2121@gmail.com');
insert into SQLMemberID (UserID, UserPaws, ClassMember, Email) values ('gff7655666', 'a123', 'a','dsa5566655333@gmail.com');
insert into SQLMemberID (UserID, UserPaws, ClassMember, Email) values ('dsa1321323', 'a123', 'a','asd546666@gmail.com');
insert into SQLMemberID (UserID, UserPaws, ClassMember, Email) values ('gg123456', 'a123', 'a','ordermealsystem@gmail.com');

insert into SQLMemberID (UserID, UserPaws, ClassMember, Email) values ('dhggg1321323', 'a123', 'a','dhggg1321323@gmail.com');
insert into SQLMemberID (UserID, UserPaws, ClassMember, Email) values ('dfff321323', 'a123', 'a','dfff321323@gmail.com');
insert into SQLMemberID (UserID, UserPaws, ClassMember, Email) values ('ggsds1323', 'a123', 'a','ggsds1323@gmail.com');
insert into SQLMemberID (UserID, UserPaws, ClassMember, Email) values ('dfasdsa21323', 'a123', 'a','dfasdsa21323@gmail.com');


insert into SQLMemberID (UserID, UserPaws, ClassMember, VAT, Email) values ('b123456', 'a123', 'b','12345678','ordermealsystem@gmail.com');
insert into SQLMemberID (UserID, UserPaws, ClassMember, VAT, Email) values ('g656666', 'a123', 'b','2343683','hgfs23443@gmail.com');
insert into SQLMemberID (UserID, UserPaws, ClassMember, VAT, Email) values ('jg12333213', 'a123', 'b','1413264','trtr234555@gmail.com');
insert into SQLMemberID (UserID, UserPaws, ClassMember, VAT, Email) values ('ff1245555423', 'a123', 'b','13213222','dsadd23333@gmail.com');

--UserID 使者帳號, Name 使者名子, Birthday 生日
insert into SQLMemberData (UserID, Name, Birthday) values ('a123456', '王大明', '2021-07-15');
insert into SQLMemberData (UserID, Name, Birthday) values ('asd546666', '李曉龍', '2000-02-10');
insert into SQLMemberData (UserID, Name, Birthday) values ('qwe124532', '李家濠', '1999-04-08');
insert into SQLMemberData (UserID, Name, Birthday) values ('gff7655666', '霖糕旻', '1997-05-15');
insert into SQLMemberData (UserID, Name, Birthday) values ('dsa1321323', '中橋庵', '2021-07-10');
insert into SQLMemberData (UserID, Name, Birthday) values ('gg123456', '鵠餅瑞', '1996-03-21');

insert into SQLMemberData (UserID, Name, Birthday) values ('dhggg1321323', '烏龍綠', '1990-01-31');
insert into SQLMemberData (UserID, Name, Birthday) values ('dfff321323', '富冠圍', '1992-02-12');
insert into SQLMemberData (UserID, Name, Birthday) values ('ggsds1323', '吳蘇辰', '1996-09-01');
insert into SQLMemberData (UserID, Name, Birthday) values ('dfasdsa21323', '高淨梁', '2021-09-01');

--UserID 使者帳號,Vendor 企業名稱,Principal 負責人,Address 地址
insert into SQLMemberDataVendor (UserID, Vendor,Principal ,Address) values ('b123456', 'III國際', 'Ted','桃園市中壢區中大路300號');
insert into SQLMemberDataVendor (UserID, Vendor,Principal ,Address) values ('g656666', 'TAT', 'Alax','台中市西區美村路一段22號7樓之3');
insert into SQLMemberDataVendor (UserID, Vendor,Principal ,Address) values ('jg12333213', 'QAQ', 'Fank','台北市中山區民權東路二段200號');
insert into SQLMemberDataVendor (UserID, Vendor,Principal ,Address) values ('ff1245555423', 'QQ', 'FH','高雄市大樹區九曲路5巷32弄43號');




--查詢
select * from SQLMemberID;--帳號
select * from SQLMemberData;--一般會員資料
select * from SQLMemberDataVendor;--企業會員資料

------------------------------ 購物車 ------------------------------

--查詢
select * from OrderssItem;
select * from Orderss;
--刪除
  drop table OrderssItem;
  drop table Orderss;

--訂單
create table Orderss(
   OrderssID int identity(1,1) constraint ORD_ORDID_pk primary key ,
   shopcarID  int not null,
   customerID varchar(50) not null,
   customerName varchar(10) not null,
   customerPhone varchar(10) not null,
   storeID int not null,
   shopDate date default getdate() not null,
   storeneworderss varchar(1) not null,
   total numeric not null
   );

   --訂單明細
 create table OrderssItem(
   OrderssID int not null,
   OitemID int identity(100,1) not null,
   poructName varchar(100) not null ,
   actualprice numeric ,
   QTY int not null,
   itemtot numeric not null,
   constraint ORDitem_ORDID_itemID_pk primary key(OrderssID,OitemID),
   constraint ORDitem_ORDIDToORD_fk FOREIGN key(OrderssID) REFERENCES Orderss(OrderssID), );







------------------------------ 討論區 ------------------------------
create table discuss123
(
ID int identity(10001,1) primary key not null,
UserID varchar(50) not null ,
--店家ID
storeid varchar(50) not null ,
--店家名
title varchar(50) not null,
--產品ID
disOitemID varchar(50) not null,
--品名
proname	varchar(50) not null,
--評論
drinkDiscuss varchar (50),
--星星
drinkstar varchar(20),
)

select * from discuss123;


drop table discuss123;








------------------------------ 店家及產品 ------------------------------

--刪除store
drop table store

--刪除產品
drop table storeproduct

--店家
	create table store(
	
	storeid numeric(10) identity(1000,1) constraint store_storeid_pk PRIMARY KEY,
	startdate date default getdate(),
	cuserid varchar(50),
	title varchar(50) constraint store_title_nn NOT NULL,
	manager varchar(10) constraint store_manager_nn NOT NULL,
	stadd varchar(80) constraint store_stadd_nn NOT NULL,
	tel varchar(20),
	intro varchar(200),
	photo varbinary(max)
	)


--產品
create table storeproduct(
proid numeric(10) identity(100,1) constraint storeproduct_proid_pk PRIMARY KEY,
pstartdate date default getdate(),
pstoreid numeric(10),
proname varchar(50) constraint storeproduct_proname_nn NOT NULL,
proprice int constraint storeproduct_proprice_nn NOT NULL,
category varchar(50),
pintro varchar(200),
pphoto varbinary(max)
)



--查詢store
select *
from store

--查詢product
select *
from storeproduct



------------------------------ 活動 ------------------------------

--查詢限時特價資料表
select * from Activity;

--刪除限時特價資料表
drop table Activity;

--新增限時特價資料表
create table Activity(
	-- ID 自動生成，從1000 開始，為 PK
	activityid int identity(1000,1) constraint activity_activityid_pk primary key,
	-- 限時特價主題，最多30字
	activitytopic varchar(30) not null,
	-- 限時特價開始時間，輸入格式'2020-10-10 13:00:00'
	starttime datetime not null,
	-- 限時特價結束時間，輸入格式'2020-10-10 13:00:00'
	endtime datetime not null,
	-- 限時特價內容，最多500 字
	activitycontent varchar(500),
	-- 限時特價封面
	activityimg varbinary(max),
	-- 限時特價店家ID
	pstoreid int
);

--不用 insert 資料

------------------------------

--查詢特價商品資料表
select * from ActivityDiscountItem;

--刪除特價商品資料表
drop table ActivityDiscountItem;

--新增特價商品資料表
create table ActivityDiscountItem(
	-- 每個折扣品項ID 自動生成，從1000 開始，為 PK
	discountid int identity(1000,1) constraint activityDiscountItem_discountid_pk primary key,
	-- 活動ID 
	activityid int not null,
	-- 商品ID
	proid int not null,
	-- 商品名稱
	proname	varchar(50) not null,
	-- 商品原價
	proprice int not null,
	-- 商品折扣價
	disprice int not null,
	-- 該商品店家ID
	storeid int
	);


--不需要 insert 資料


------------------------------ NEW--店家編輯紀錄 ------------------------------
--刪除storerec
--drop table storerec

create table storerec(
seditid numeric(10) identity(1000000,1) constraint storerec_editid_pk PRIMARY KEY,
cuserid varchar(50),
storeid numeric(10),
editdate smalldatetime default getdate(),
item varchar(25), --新增、刪除、編輯
detail varchar(100)
)

--查詢storeRec

select *
from storerec


