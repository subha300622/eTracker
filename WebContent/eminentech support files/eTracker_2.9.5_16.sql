create table bugvalue(status varchar2(50),p1s1 number,p1s2 number,p1s3 number,p1s4 number,p2s1 number,p2s2 number,p2s3 number,p2s4 number,p3s1 number,p3s2 number,p3s3 number,p3s4 number,p4s1 number,p4s2 number,p4s3 number,p4s4 number);
create table enhancementvalue(status varchar2(50),p1s1 number,p1s2 number,p1s3 number,p1s4 number,p2s1 number,p2s2 number,p2s3 number,p2s4 number,p3s1 number,p3s2 number,p3s3 number,p3s4 number,p4s1 number,p4s2 number,p4s3 number,p4s4 number);
create table newtaskvalue(status varchar2(50),p1s1 number,p1s2 number,p1s3 number,p1s4 number,p2s1 number,p2s2 number,p2s3 number,p2s4 number,p3s1 number,p3s2 number,p3s3 number,p3s4 number,p4s1 number,p4s2 number,p4s3 number,p4s4 number);

alter table issue add rating varchar2(25);
alter table issue add feedback varchar2(100);