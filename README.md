# Amazon Online Shopping Management

## Inroduction

Amazon, one of the biggest businesses in the world, is so because of its system architecture and database implementation. Amazon deals with many entities and aims to form an inclusive and comprehensive interface for clients, connecting sellers and consumers all over the world. It has complicated, huge relationships which are managed carefully so as to not violate any relational database rules. Amazon’s working and its use in daily life interested us and we decided to replicate the system. We in this project have tried to implement the main entities and functionalities of Amazon and amazon like websites. It takes into account different entities and representation of relationships between them, which is followed by an entity relationship diagram. After this, an entire relational schema is formed which gives a clear picture about how the backend is designed. The entire project is implemented in MySQL.  
Amazon works by providing an interface for the customers as well as the sellers on the internet via a website, on the customer side, a catalogue of products is displayed from where the customer can choose any number of items. A customer then adds these items to a cart. He can also save it for later in the Wishlist. A payment method is then used to pay the price after order confirmation. There are various ways in which a customer can pay for the order. Amazon employees deliver the packages. The customer also gets to return the product if any problem is faced, along with writing a review. On the seller side, the seller being a company or a person, can add as many products as he wants to sell. He gets a part of the payment from amazon. The warehouse stores products and deals with its packaging. This is how the entire Amazon system works.  

## Problem Statement

In today’s fast paced world, time management is the need of the hour, and everybody wants the quickest approach. This does not mean that the options are to be compromised with. People want a variety of options to choose from and want the best deals too. All of this, along with the need to delivery on time is of the utmost importance to the customers. To address this issue, and to make the best use of internet serves, there is a need to efficient online shopping systems. These will provide easy access to products which need to be present in the stores in the same location but also the ones in different places and coming from afar but yet on time. Along with quality products, customers also expect a lots of deals, offers and discounts. These can also be done with the help of online shopping portals and hence a proper database should be made to cater to the needs of customer and for the growth of business. This is the problem which we aim to solve with this project. 

## System Architecture

<img width="435" alt="image" src="https://github.com/user-attachments/assets/c8813c49-0b95-42cd-924e-5db092cfc239">

## Entity Relationship Diagram

<img width="438" alt="image" src="https://github.com/user-attachments/assets/e4df3e77-99be-4043-8525-3e790fba1c53">

## Tables After Normalization

1. Amazon(A_ID, name, location, no_of_branches) 
2. Employee(E_ID, first_name, last_name, email, position, address, A_ID) 
3. EmpPos(position, salary) 
4. Phone_emp(Phone_ID, phoneno, E_ID) 
5. Customer(C_ID, first_name, last_name, prime/nonprime, email, password, address, 
default_shipping_address, default_payment_address) 
6. Phone_cus(Ph_ID,phoneno, C_ID) 
7. Wishlist(Wish_ID, C_ID) 
8. Application(App_ID. S_ID,Type, Status, E_ID) 
9. App_Type(Type, description) 
10. Cart(Cart_ID, C_ID) 
11. Warehouse(W_ID, location, name) 
12. Seller(S_ID, username, password, email, bank_acc, address, storename) 
13. Orders(O_ID, status, date_of_order, C_ID, S_ID, W_ID) 
14. Product(P_ID, ASIN, price, category, S_ID) 
15.  Product_c(P_ID, C_ID) 
16. Product_w(P_D, W_ID) 
17. Product_o(P_ID, O_ID) 
18. Reviews(R_ID, rating, description, P_ID) 
19. Query(Q_ID, query, C_ID, S_ID) 
20. Query_ans(query,answer) 
21. Coupon(Coupon_ID, start_date, expiry_date, coup_category, S_ID) 
22. Order_coupon(O_ID, Coupon_ID) 
23. Coup_category(coup_category, discount) 
24. Order_payment(OPay_ID, amount, customer_acc, type, PNR, C_ID, A_ID)  
25. SellerPayment(Spay_ID, closing_fee, referral_fee, A_ID, S_ID)



