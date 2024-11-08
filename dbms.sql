-- Customer searches products according to his preferred category. 
select P_ID,Price,category,S_ID from product where category='Baby Products'; 

-- Amazon makes payment to the concerned sellers on placement of an order which includes their product 
select s.s_id,s.bank_acc,p.category,p.price from product_o po,product p,seller s where 
po.p_id=p.p_id and p.s_id=s.s_id and po.o_id='O0003'; 

--  In which warehouse is a particular product placed? 
select location from warehouse w,orders o where w.w_id=o.w_id and o.o_ID='O0005'; 

-- Valuable customers - Customers are arranged on the basis of the amount spent by them on Amazon.
select c.c_id, c.first_name,c.last_name,sum(o.amount) as 'Total Amount' from customer 
c,orderpayment o where o.c_id=c.c_id group by c.c_id order by sum(o.amount) desc 

-- Seller checks the status of all the applications he has written.
select at.type,at.description,a.status from application a,app_type at,seller s where s.s_id=a.s_id 
and a.type=at.type and s.username='amy'; 

-- Unanswered queries of customer 
select distinct q.query,s.username from query q,query_ans qa,seller s where q.s_id=s.s_id and 
q.query not in(select query from query_ans); 

-- Coupons available for a particular order.
select coup_category from coupon_category where discount in(select cc.discount from coupon_category cc,coupon c,orders o where cc.coup_category=c.coup_category and c.s_id=o.s_id and o.O_ID='O0004');

-- Which products are present in the wishlist of a particular customer? 
select p.p_id, p.category, p.price from product p,product_w pw, wishlist w, customer c where p.p_id=pw.p_id and pw.wish_id=w.wish_id and w.c_id=c.c_id and c.first_name='Hem'; 
 
 
-- What are the queries and answers for a particular product 
select qa.query,qa.answer from query q,query_ans qa, product p where q.s_id=p.s_id and q.query=qa.query and p.p_id='PR16'; 
 
 
-- Display the orders for which expiry dates of their coupons is before the given date. 
select oc.o_id,oc.Coupon_id from order_coupon oc, coupon c where oc.coupon_id=c.coupon_id and c.expiry_date<'2020-01-02';  
 
-- Which employees live in the same city as the city of the amazon branch they work for? 
select e.first_name,e.last_name,ep.position, ep.salary,a.location,e.address from employee e, emppos ep, amazon a where ep.position=e.position and a.a_id=e.a_id and e.address like concat('%',a.location); 
 
-- Order details of a particular order payment of a particular customer. 
select c.first_name,c.last_name,c.default_payment_method,o.amount,o.cus_acc,o.pnr from customer c,orderpayment o where o.c_id=c.c_id and o.opay_id='OP015'; 
 
 
 
-- Total expenditure of  Amazon on basis of different positions of employees. 
select e.position,sum(p.salary) as 'Total expenditure',count(a.a_id) as 'Total Employees' from employee e,emppos p, amazon a where e.a_id=a.a_id and e.position=p.position group by e.position; 
 
 
 
-- Customer tracks his order. (related to warehouse)(notification regarding status of his package) 
select o.o_id,o.status,w.name from orders o inner join warehouse w inner join customer c where o.W_id=w.w_id and o.c_id=c.c_id and c.first_name='jay' and c.last_name='goel';  
 
-- Amazon branches arranged in order of their total earnings from their sellers and customers 
select a.a_id,a.name,sum(o.amount)+sum(s.closing_fee)+sum(s.referral_fee) as 'Total Earnings' from sellerpayment s,amazon a,orderpayment o where a.a_id=s.a_id and a.a_id=o.a_id group by a.name order by sum(o.amount)+sum(s.closing_fee)+sum(s.referral_fee) desc; 
 
-- Customer applies the best coupon available and gets the discounted price on his cart before proceeding for payment. 
select c.cart_id,cu.first_name,cu.last_name,sum(p.price) as 'Total Price',max(cc.discount) as 'Best Coupon',(sum(p.price)-(max(cc.discount)/100)*sum(p.price)) as 'Discounted Price' from product_c c,product p,coupon_category cc,customer cu,cart ca where c.p_id=p.p_id and p.category=cc.coup_category and cu.c_id=ca.c_id and ca.cart_id=c.cart_id group by c.cart_id; 
 
-- Which number to dial when a customer has a complaint against a particular seller for a particular product? 
select c.first_name,c.last_name,po.p_id,e.phoneno from customer c,product_o po, orders o, phone_emp e,application a where c.c_id=o.c_id and o.o_id=po.o_id and o.s_id=a.s_id and a.e_id=e.e_id and c.first_name='Sneha' and po.p_id='PR030'; 
  
-- Total amount before discount (Amount before applying coupon) 
select o.o_id,cc.discount,op.amount,c.coup_category,(op.amount+((cc.discount/100)*op.amount)) as 'Actual Amount' from orders o,coupon c,coupon_category cc, orderpayment op where o.c_id=op.c_id and c.s_id=o.s_id and c.coup_category=cc.coup_category; 
 
-- Which customers are getting max discount 
select c.c_id, c.first_name,c.last_name, cc.discount,p.category from customer c,coupon_category cc,product p, orders o,product_o po where c.c_id=o.c_id and po.o_id=o.o_id and po.p_id=p.p_id and cc.coup_category=p.category and cc.discount=(select max(discount) from coupon_category); 
 
-- Total discounts provided by the stores through their coupons. 
select s.s_id,s.username,s.storename,count(c.coup_category) as 'No. of coupons',sum(cc.discount) as 'Total discount' from coupon c,seller s,coupon_category cc where c.s_id=s.s_id and cc.coup_category=c.coup_category group by c.s_id; 

-- Which city has placed orders the maximum number of times? (Customer’s city) 
select substr(c.default_shipping_address,6) as 'City' ,count(o.o_id) as 'Number of orders placed' from orders o,customer c where c.c_id=o.c_id group by substr(c.default_shipping_address,6); 

-- Check number of days of validity of coupons 
select c.coupon_id,concat(datediff(c.expiry_date,c.start_date),' days') as 'No. of days of validity',c.coup_category,cc.discount from coupon c,coupon_category cc where c.coup_category=cc.coup_category order by datediff(c.expiry_date,c.start_date) desc; 
 
-- Seller checks success of his coupon-No of orders the coupon has been applied on and total discount given through that particular coupon. 
select c.coupon_id,s.storename,count(oc.o_id) as 'No. of orders',sum(cc.discount) as 'Total discount' from coupon c,order_coupon oc,coupon_category cc,seller s where cc.coup_category=c.coup_category and oc.coupon_id=c.coupon_id and c.s_id=s.s_id group by c.coupon_id; 
 
-- Arrange categories in order of their success. 
select p.category,sum(p.price),count(po.o_id) from product p,product_o po where po.p_id=p.p_id group by p.category order by p.price desc; 
 
-- Sellers arranged according to quality of product sold by them as perceived by their customers 
select s.username,s.storename,avg(r.rating) as 'Average rating' from seller s, reviews r, product p where s.s_id=p.s_id and r.p_id=p.p_id group by s.s_id order by avg(r.rating) desc; 

---- Functions

-- Calculate total amount of a customer’s cart. 
 
delimiter @@; 
create function total_amount1(cart_id varchar(10)) 
returns int 
begin 
declare amount1 int; 
select sum(p.price) into amount1 from product p,product_c c where p.p_id=c.p_id and c.cart_id=cart_id; 
return amount1; 
end @@; 
 
select total_amount('C09') as 'Total Amount'\g 
  
-- Average Rating of a product 
 
delimiter @@; 
create function avg_rating4(pr_id varchar(10)) 
returns decimal(10,2) 
begin 
declare rating1 decimal(10,2); 
select avg(r.rating) into rating1 from reviews r where r.p_id=pr_id; 
return rating1; 
end @@ 
 
select avg_rating4('PR019') as 'Average Rating'\g 
 
-- Number of days of validity 
 
delimiter @@; 
create function no_of_days(coupid varchar(10)) 
returns int 
begin 
declare days1 int; 
select datediff(c.expiry_date,c.start_date) into days1 from coupon c where c.coupon_id=coupid; 
return days1; 
end @@; 
 
select no_of_days('CP008') as 'No. of days of validity'\g 

-- Number of orders on which a particular coupon is applied 
 
delimiter @@; 
create function no_of_orders(couponid varchar(10)) 
returns int 
begin 
declare orderno int; 
select count(oc.o_id) into orderno from coupon c,order_coupon oc where oc.coupon_id=c.coupon_id and 
oc.coupon_id=couponid; 
return orderno; 
end @@; 
 
select no_of_orders('CP003') as 'No of Orders'\g 
 
-- % of customers have prime account 
 
delimiter @@; 
create function percentage_prime() 
returns decimal(10,2) 
begin 
declare prime int; 
declare percentage decimal(10,2); 
select count(prime_nonprime) into prime from customer where prime_nonprime='P'; 
select (prime/count(c_Id))*100 into percentage from customer; 
return percentage; 
end @@; 
 
select percentage_prime() as 'Percentage of Prime Customers'\g

------- Procedures

-- Change password for employee 
 
delimiter @@; 
create procedure change_password(in uid varchar(30),in new_password varchar(30)) 
begin 
update seller set password=new_password where username=uid; 
end @@; 
 
call change_password('hop','iamhopping12345')\g 
 
-- Total amount before discount (Amount before applying coupon 
 
delimiter @@; 
create procedure before_amount() 
begin 
select o.o_id,cc.discount,op.amount,c.coup_category,(op.amount+((cc.discount/100)*op.amount)) as 
'Actual Amount' from orders o,coupon c,coupon_category cc, orderpayment op where o.c_id=op.c_id 
and c.s_id=o.s_id and c.coup_category=cc.coup_category; 
end @@ 
 
call before_amount()\g 
 
-- Which employees work in a particular branch of amazon 
 
delimiter @@; 
create procedure no_of_employees(in amazonname varchar(30),out empno int) 
begin 
select count(e.e_id) into empno from employee e, amazon a where a.a_id=e.a_id and a.name=amazonname; 
end @@; 
 
call no_of_employees('Nagpur Amazon',@empno)\g 
select @empno\g 

-- Promoting an employee while considering his preferred location 
 
delimiter @@; 
create procedure promotion(in employeeid varchar(10),in preferred_location varchar(30)) 
begin 
update employee set position='Manager' where E_id=employeeid; 
update employee set a_id=(select a_id from amazon where location=preferred_location); 
end @@; 
 
call promotion('E1015','Nagpur')\g 

-- Display performance of sellers on basis of the price of the products sold by them. 
 
delimiter @@; 
create procedure seller_performance() 
begin 
select s.username, s.storename,sum(p.price) from seller s,product p,product_o po where s.s_id=p.s_id and 
p.p_id=po.p_id group by s.s_id order by sum(p.price) desc; 
end @@; 
 
call seller_performance()\g

------------ Triggers

-- Update sellers password 
 
create table updatepassword(s_id varchar(10) primary key,username varchar(30),password varchar(30),action 
varchar(20),changedon datetime); 
 
delimiter @@; 
create trigger updatepassword 
after update on seller 
for each row 
begin 
insert into updatepassword set action='Update',s_id=old.s_id, username=old.username, 
password=old.password,changedon=now(); 
end @@; 
 
-- Adding a new product to a particular cart 
 
delimiter @@; 
create trigger insert_product 
before insert on product_c 
for each row 
begin 
insert into insertproduct_c set action='Insert',p_id=new.p_id,cart_id=new.cart_id,changedon=now(); 
end @@; 
 
-- Extend expiry date of a particular coupon 
 
delimiter @@; 
create trigger coupon_extend 
before update on coupon 
for each row 
begin 
insert into updatecoupon set 
action='Update',coupon_id=new.coupon_id,start_date=new.start_date,expiry_date=new.expiry_date,changedo
 n=now(); 
end @@; 
 
-- Writing a new application to an employee. 
 
delimiter @@; 
create trigger insert_app 
after insert on application 
for each row 
begin 
insert into insertapplication set 
action='Insert',app_id=new.app_id,s_id=new.s_id,type=new.type,status=new.status,e_id=new.e_id,changedon
 =now(); 
end @@; 
 
insert into application values('A1011','S1001','1','Under Review','E1008');\g 
 
-- Updating status of a delivery package 
 
delimiter @@; 
create trigger order_update 
before update on orders 
for each row 
begin 
insert into updateorders set action='Update',o_id=new.o_id,status=new.status,changedon=now(); 
end @@; 