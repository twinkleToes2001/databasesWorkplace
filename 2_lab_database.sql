
create sequence seq
	minvalue 1
	maxvalue 5
	start with 1
	increment by 1
	cycle;

insert into t_measure values (nextval('seq'), 'something_measure_1');
insert into t_measure values (nextval('seq'), 'm');
insert into t_measure values (nextval('seq'), 'something_measure_3');
insert into t_measure values (nextval('seq'), 'something_measure_4');
insert into t_measure values (nextval('seq'), 'something_measure_5');

insert into t_material values (nextval('seq'), 'something_material_1', currval('seq'));
insert into t_material values (nextval('seq'), 'something_material_2', currval('seq'));
insert into t_material values (nextval('seq'), 'something_material_3', currval('seq'));
insert into t_material values (nextval('seq'), 'something_material_4', currval('seq'));
insert into t_material values (nextval('seq'), 'something_material_5', currval('seq'));

insert into t_inprice values (nextval('seq'), to_date('11.11.2011','dd-mm-yyyy'), 12345);
insert into t_inprice values (nextval('seq'), to_date('12.11.2012','dd-mm-yyyy'), 54321);
insert into t_inprice values (nextval('seq'), to_date('01.01.2021','dd-mm-yyyy'), 51423);
insert into t_inprice values (nextval('seq'), to_date('14.11.2014','dd-mm-yyyy'), 13245);
insert into t_inprice values (nextval('seq'), to_date('31.12.2020','dd-mm-yyyy'), 51234);

insert into t_caterer values (nextval('seq'), 'random_name_1', 'random_phone_1', 'random_fax_1', 'random_legal_address_1', 'random_fact_address_1', 'random_mail_1');
insert into t_caterer values (nextval('seq'), 'random_name_2', 'random_phone_2', 'random_fax_2', 'random_legal_address_2', 'random_fact_address_2', 'random_mail_2');
insert into t_caterer values (nextval('seq'), 'random_name_3', 'random_phone_3', 'random_fax_3', 'random_legal_address_3', 'random_fact_address_3', 'random_mail_3');
insert into t_caterer values (nextval('seq'), 'random_name_4', 'random_phone_4', 'random_fax_4', 'random_legal_address_4', 'random_fact_address_4', 'random_mail_4');
insert into t_caterer values (nextval('seq'), 'random_name_5', 'random_phone_5', 'random_fax_5', 'random_legal_address_5', 'random_fact_address_5', 'random_mail_5');

insert into t_store values (nextval('seq'), 'random_store_1');
insert into t_store values (nextval('seq'), 'random_store_2');
insert into t_store values (nextval('seq'), 'random_store_3');
insert into t_store values (nextval('seq'), 'random_store_4');
insert into t_store values (nextval('seq'), 'random_store_5');

insert into t_supply values (nextval('seq'), currval('seq'), currval('seq'), currval('seq'), to_date('06.07.2013', 'dd.mm.yyyy'), 23);
insert into t_supply values (nextval('seq'), currval('seq'), currval('seq'), currval('seq'), to_date('12.01.2016', 'dd.mm.yyyy'), 124);
insert into t_supply values (nextval('seq'), currval('seq'), currval('seq'), currval('seq'), to_date('02.12.2006', 'dd.mm.yyyy'), 123);
insert into t_supply values (nextval('seq'), currval('seq'), currval('seq'), currval('seq'), to_date('12.01.2019', 'dd.mm.yyyy'), 225);
insert into t_supply values (nextval('seq'), currval('seq'), currval('seq'), currval('seq'), to_date('03.09.2026', 'dd.mm.yyyy'), 14);

insert into t_surplus values (nextval('seq'), currval('seq'), 123);
insert into t_surplus values (nextval('seq'), currval('seq'), 133);
insert into t_surplus values (nextval('seq'), currval('seq'), 522);
insert into t_surplus values (nextval('seq'), currval('seq'), 826);
insert into t_surplus values (nextval('seq'), currval('seq'), 328);

alter table t_employer
	add sex char(1) default 'M' check(sex in ('M', 'F')),
	add birthdate date,
	add marriage char(1) default 'N' check(marriage in ('N', 'Y');
insert into t_employer values (nextval('seq'), 'first_name_1', 'second_name_1', 'patronymic_1', 'M', '12.01.2016', 'Y');
insert into t_employer values (nextval('seq'), 'first_name_2', 'second_name_2', 'patronymic_2', 'F', '02.03.2009', 'N');
insert into t_employer values (nextval('seq'), 'first_name_3', 'second_name_3', 'patronymic_3', 'F', '17.09.2010', 'Y');
insert into t_employer values (nextval('seq'), 'first_name_4', 'second_name_4', 'patronymic_4', 'M', '22.11.2016', 'N');
insert into t_employer values (nextval('seq'), 'first_name_5', 'second_name_5', 'patronymic_5', 'M', '19.10.2013', 'Y');

insert into t_section values (nextval('seq'), 'section_1', currval('seq'));
insert into t_section values (nextval('seq'), 'section_2', currval('seq'));
insert into t_section values (nextval('seq'), 'section_3', currval('seq'));
insert into t_section values (nextval('seq'), 'section_4', currval('seq'));
insert into t_section values (nextval('seq'), 'section_5', currval('seq'));

insert into t_deliver values (nextval('seq'), currval('seq'), currval('seq'), currval('seq'), to_date('12.02.2014', 'dd.mm.yyyy'));
insert into t_deliver values (nextval('seq'), currval('seq'), currval('seq'), currval('seq'), to_date('02.11.2014', 'dd.mm.yyyy'));
insert into t_deliver values (nextval('seq'), currval('seq'), currval('seq'), currval('seq'), to_date('17.03.2014', 'dd.mm.yyyy'));
insert into t_deliver values (nextval('seq'), currval('seq'), currval('seq'), currval('seq'), to_date('09.10.2014', 'dd.mm.yyyy'));
insert into t_deliver values (nextval('seq'), currval('seq'), currval('seq'), currval('seq'), to_date('15.01.2014', 'dd.mm.yyyy'));

alter table t_material
	drop constraint fk_material_measure,
	add constraint fk_material_measure
		foreign key (id_measure) references t_measure (id_measure) on delete cascade;
alter table t_supply
	drop constraint fk_supply_material,
	add constraint fk_supply_material
		foreign key (id_material) references t_material (id_material) on delete cascade;
alter table t_deliver
	drop constraint fk_deliver_material,
	add constraint fk_deliver_material
		foreign key (id_material) references t_material (id_material) on delete cascade;
alter table t_surplus
	drop constraint fk_surplus_material,
	add constraint fk_surplus_material
		foreign key (id_material) references t_material (id_material) on delete cascade;
delete from t_measure
	where length(names) = 1; 	
delete from t_inprice
	where price_date < to_date('31.12.2020','dd.mm.yyyy');
update t_surplus 
	set value = 0 
	where id_store = 1;
update t_employer 
	set sex = 'F', birthdate = to_date('12.12.1999', 'dd.mm.yyyy')
	where id_employer = 1;
update t_caterer 
	set phone = 89129841284
	where id_caterer = 1;
update t_inprice 
	set price_date = current_date
	where id_material = 3;
update t_inprice 
	set price = price * 0.85
	where price_date = current_date;
select * from t_measure;
select * from t_material;
select * from t_inprice;
select * from t_caterer;
select * from t_store;
select * from t_supply;
select * from t_surplus;
select * from t_employer;
select * from t_section;
select * from t_deliver;
