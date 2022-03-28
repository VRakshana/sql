create database HMS;
use HMS;

create table DOCTOR_MASTER(
	doctor_id varchar(15) primary key not null,
    doctor_name varchar(15) not null,
    Dept varchar(15) not null,
    constraint HMS_Docid(doctor_id)
    );
drop table DOCTOR_MASTER;

insert into DOCTOR_MASTER(doctor_id, doctor_name, dept)
values("D0001", "Ram", "ENT"),("D0002", "Rajan", "ENT"), ("D0003", "Smita", "Eye"),
("D0004","Bhavan", "Surgery"), ("D0005", "Sheela", "Surgery"),("D0006", "Nethra", "Surgery");

select*from DOCTOR_MASTER;

create table ROOM_MASTER(
	room_no varchar(15) not null,
    room_type varchar(15) not null,
    status varchar(15) not null,
    constraint HMS_roomno(room_no)
    );
desc ROOM_MASTER;
    
insert into ROOM_MASTER(room_no, room_type, status)
values("R0001", "AC", "occupied"), ("R0002", "Suite", "vacant"), ("R0003", "NonAC", "vacant"),
("R0004", "NonAC", "occupied"), ("R0005", "AC", "vacant"), ("R0006", "AC", "occupied");

select * from ROOM_MASTER;

create table PATIENT_MASTER(
    pid varchar(15) not null,
    name varchar(15) not null,
    age int(15) not null,
    weight int(15) not null,
    gender varchar(10) not null,
    address varchar(50) not null,
    phone_no varchar(10) not null,
    Disease varchar(50) not null,
    Doctor_id varchar(5),
    constraint hms_fk foreign key(Doctor_id)
    references doctor_master(doctor_id),
    constraint hms_pid unique(pid)
    );
drop table PATIENT_MASTER;

insert into PATIENT_MASTER(pid, name, age, weight, gender, address, phone_no,disease, Doctor_id)
values("P0001", "Gita", 35, 65, "F", "Chennai", "9867145678", "Eye infection", "D0003"),
("P0002", "Ashish", 40,  70, "M", "Delhi", "9845675678", "Asthma", "D0003"),
("P0003", "Radha", 25, 60, "F", "Chennai", "9867166678", "Pain in heart", "D0003");
("P0004", "Chandra", 28, 55, "F", "Bangalore", "9978675567", "Asthma", "D0001"),
("P0005", "Goyal", 42, 65, "M", "Delhi", "8967533223", "Pain in stomach", "D0004");

select * from PATIENT_MASTER;

create table room_allocation(
	room_no varchar(15) not null,
    pid varchar(15),
    admission_date date not null,
    release_date date,
    constraint hms_roomNo foreign key(room_no) references room_master(room_no),
    constraint hms_cst foreign key(pid) references patient_master(pid)
    );
desc room_allocation;

insert into room_allocation(room_no, pid, admission_date, release_date)
values("R0001", "P0001", "2016-10-15", "2016-10-26");
  ("R0002", "P0002", "2016-11-15", "2016-11-26"),("R0002", "P0003", "2016-12-01", "2016-12-30"),
 ("R0004", "P0001", "2017-01-17", "2017-01-30");
    
select*from room_allocation;


#Query1
select p.name from patient_master p
join room_allocation r on p.pid=r.pid
where month(admission_date) = 01;
    
#Query2

select name from patient_master
where gender="F" and disease!="Asthma";

#Query3
select
   (select count(*) from patient_master
    where gender="F") as "Female",
    (select count(*) from patient_master
    where gender="M") as "Male"
    ;

#Query4
show tables;
select p.pid, r.room_type, p.name, d.doctor_id, d.doctor_name, r.room_no, rA.admission_date from doctor_master d
join patient_master p on d.doctor_id=p.doctor_id
join room_allocation rA on rA.pid=p.pid
join room_master r on rA.room_no=r.room_no;
