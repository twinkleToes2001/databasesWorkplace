/*14*/
select * from t_caterer;
select * from t_deliver;
select * from t_employer;
select * from t_group;
select * from t_inprice;
select * from t_material;
select * from t_measure;
select * from t_section;
select * from t_store;
select * from t_supply;
select * from t_surplus;

/*15*/
select names from t_material;

/*16*/
select last_name, first_name, father_name, birthdate from t_employer;

/*17*/
select * from t_employer
where sex = 'M';

/*18*/
select * 
from t_caterer
where id_caterer in(select id_caterer
                    from t_supply
                    where supply_date between '01.04.2009' and '30.06.2009');

/*19*/
select * 
from t_section
where id_section in(select id_section
                    from t_deliver
                    where deliver_date between '01.08.2009' and '31.08.2009');

/*20*/
select names 
from t_section
where id_section in(select id_section
                    from t_deliver
                    where deliver_date = current_date);

/*21*/
select names 
from t_material
where id_material in(select id_material
                    from t_supply
                    where extract(year from supply_date) = extract(year from current_date));
                    
/*22???*/
select names 
from t_material
where   id_material in(select id_material
                    from t_supply
                    where extract(year from supply_date) != extract(year from current_date))
and     id_material in(select id_material
                    from t_surplus
                    where value = 0);

/*23*/
select sec.names as "Цех", emp.last_name||' '||emp.first_name||' '||emp.father_name as "Ответственное лицо"
from t_section sec join t_employer emp on sec.id_employer = emp.id_employer;

/*24*/
create table t_job (
    id_job int not null,
    job_name text not null,
    constraint pk_job primary key (id_job)
);
insert into t_job values (1, 'Директор');
insert into t_job values (2, 'Работяга');
insert into t_job values (3, 'Дудка	  ');
insert into t_job values (4, 'Трубник ');

alter table t_employer
    add column id_job int not null default 2;
alter table t_employer
    add constraint fk_employer_job foreign key(id_job) references t_job(id_job);

select 	sec.names as "Цех", 
		emp.last_name||' '||emp.first_name||' '||emp.father_name as "Ответственное лицо",
		job.job_name as "Должность"
from t_section sec 	join t_employer emp on sec.id_employer = emp.id_employer 
					join t_job job on emp.id_job = job.id_job;

/*25*/
select  cat.names as "Поставщик",
        mat.names as "Материал", 
        inp.price as "Цена",
        sup.value as "Количество"
        sup.supply_date as "Дата поставки"
from t_supply sup  join t_caterer cat on sup.id_caterer = cat.id_caterer
                   join t_material mat on sup.id_material = mat.id_material
                   join t_inprice inp on sup.id_material = inp.id_material
where supply_date between '01.01.2009' and '31.03.2009';

/*26*/
select  cat.names as "Поставщик",
        mat.names as "Материал", 
        inp.price as "Цена",
        sup.value as "Количество"
from t_supply sup  join t_caterer cat on sup.id_caterer = cat.id_caterer
                   join t_material mat on sup.id_material = mat.id_material
                   join t_inprice inp on sup.id_material = inp.id_material
where supply_date between '01.01.2009' and '31.03.2009'
and (cat.legal_address like '%Пермь%' or cat.fact_address like '%Пермь%');

/*27*/
select  mat.names as "Материал",
        str.names as "Склад", 
        sur.value as "Остаток"
from t_material mat join t_surplus sur on mat.id_material = sur.id_material
                    join t_store str on str.id_store = sur.id_store;

/*28*/
select  cat.names as "Поставщик",
        mat.names as "Материал", 
        inp.price as "Цена",
        sup.value as "Количество",
        sup.supply_date as "Дата поставки"
from t_supply sup  join t_caterer cat on sup.id_caterer = cat.id_caterer
                   join t_material mat on sup.id_material = mat.id_material
                   join t_inprice inp on sup.id_material = inp.id_material
where supply_date between '01.01.2009' and '31.03.2009';

/*29*/
select  cat.names as "Поставщик",
        mat.names as "Материал", 
        inp.price as "Цена",
        sup.value as "Количество",
        sup.supply_date as "Дата поставки"
from t_supply sup  right join t_caterer cat on sup.id_caterer = cat.id_caterer
                   left join t_material mat on sup.id_material = mat.id_material
                   left join t_inprice inp on sup.id_material = inp.id_material
where supply_date between '01.01.2009' and '31.03.2009';

/*30*/
select  mat.names as "Материал",
        str.names as "Склад", 
        sur.value as "Остаток"
from t_material mat join t_surplus sur on mat.id_material = sur.id_material
                    join t_store str on str.id_store = sur.id_store;

/*31*/
select  mat.names as "Материал",
        mea.names as "Единица измерения",
        inp.price as "Цена"
from t_material mat join t_measure mea on mat.id_measure = mea.id_measure
                    join t_inprice inp on mat.id_material = inp.id_material
where price_date between '01.07.2009' and '30.09.2009';

/*32*/
select  mat.names as "Материал",
        mea.names as "Единица измерения",
        inp.price as "Цена"
from t_material mat join t_measure mea on mat.id_measure = mea.id_measure
                    left join t_inprice inp on mat.id_material = inp.id_material
where price_date between '01.07.2009' and '30.09.2009';

/*33*/
alter table t_employer
    add id_manager int;
update t_employer set id_manager = 1
    where id_employer = 2;
update t_employer set id_manager = 2
    where id_employer = 3;
update t_employer set id_manager = 1
    where id_employer = 4;
update t_employer set id_manager = 3
    where id_employer = 5;

/*34*/
alter table t_group
    add column id_subgroup int;

insert into t_group(id_group, group_name, id_subgroup, id_material) 
    values (1, 'Строительные материалы', 1, 1);
insert into t_group(id_group, group_name, id_subgroup, id_material) 
    values (1, 'Строительные материалы', 1, 4);
insert into t_group(id_group, group_name, id_subgroup, id_material) 
    values (1, 'Строительные материалы', 2, 6);
insert into t_group(id_group, group_name, id_subgroup, id_material) 
    values (2, 'Производственные материалы', 1, 5);
insert into t_group(id_group, group_name, id_subgroup, id_material) 
    values (2, 'Производственные материалы', 2, 3);

select group_name, id_subgroup, id_material from t_group
order by id_group, id_subgroup, id_material;

/*35*/
create table t_exempt as
    select * from t_employer;

delete from t_exempt;
select * from t_exempt;

insert into t_exempt values (nextval('seq'), 'first_name_5', 'second_name_5', 'patronymic_5', 'M', '19.10.2013', 'Y');

/*36*/
alter table t_exampt 
	add column dismissed date default current_date;

/*37*/
create table t_contact (
	id_contact int not null,
	last_name text not null,
	first_name text not null, 
	patronymic text not null, 
	phone bigint not null,
	id_caterer int not null,
	constraint pk_contact primary key (id_contact),
	constraint fk_contact_caterer foreign key (id_caterer)
		references t_caterer (id_caterer)
);

insert into t_contact values (1, 'Мехоношин', 'Иван', 'Егорович', 89121451123, 3);
insert into t_contact values (2, 'Габсалямов', 'Эдуард', 'Викторович', 89127123402, 1);
insert into t_contact values (3, 'Шпадин', 'Александр', 'Андреевич', 89480873224, 2);
insert into t_contact values (4, 'Тутов', 'Кирилл', 'Александрович', 89907654300, 5);
insert into t_contact values (5, 'Муллагалиева', 'Екатерина', 'Константиновна', 89776634328, 4);

select 	last_name as "Фамилия", 
		first_name as "Имя", 
		father_name as "Отчество", 
		null as "phone", 'Сотрудник' as "who(кто?)" 
from t_employer
union
select 	last_name, 
		first_name, 
		patronymic, 
		phone, 
		'Контактное лицо'
from t_contact;

/*38*/
select * from t_caterer
order by names;

/*39*/
select cat.names, cot.last_name, cot.first_name, cot.patronymic, cot.phone
from t_caterer cat join t_contact cot on cat.id_caterer =  cot.id_caterer
order by cat.names, cot.last_name, cot.first_name, cot.patronymic;

/*40*/
select str.names, srp.id_material, srp.value 
from t_store str join t_surplus srp on str.id_store = srp.id_store
order by 1, 3 desc;

/*41*/
select cat.names as "Поставщик", mat.names as "Материал", sum(sup.value) as "Объем"
from t_supply sup join t_caterer cat on sup.id_caterer = cat.id_caterer
				  join t_material mat on sup.id_material = mat.id_material
where extract(year from sup.supply_date) = extract(year from current_date)
group by cat.names, mat.names
order by cat.names, mat.names;

/*42*/
select	mat.names as "Материал",
		avg(sup.value * (select price 
					from t_inprice inp
					where inp.id_material = mat.id_material and 
					sup.supply_date - inp.price_date = (select min(sup.supply_date - inp.price_date) 
														from t_inprice inp
													    where inp.id_material = mat.id_material
													  	and sup.supply_date - inp.price_date >= 0))) as "Средняя цена поставки"
from t_supply sup join t_material mat on sup.id_material = mat.id_material
where extract(year from sup.supply_date) = extract(year from current_date)
group by mat.names;


/*43*/
select mat.names, count(*)
from t_supply sup join t_material mat on sup.id_material = mat.id_material
where extract(year from sup.supply_date) = extract(year from current_date)
group by mat.names;

/*44*/
select	mat.names as "Материал",
		avg(sup.value * (select price 
					from t_inprice inp
					where inp.id_material = mat.id_material and 
					sup.supply_date - inp.price_date = (select min(sup.supply_date - inp.price_date) 
														from t_inprice inp
													    where inp.id_material = mat.id_material
													  	and sup.supply_date - inp.price_date >= 0))) as "Средняя цена поставки",
		sur.sum "Остаток на складе",
		avg(sup.value * (select price 
					from t_inprice inp
					where inp.id_material = mat.id_material and 
					sup.supply_date - inp.price_date = (select min(sup.supply_date - inp.price_date) 
														from t_inprice inp
													    where inp.id_material = mat.id_material
													  	and sup.supply_date - inp.price_date >= 0))) / supValue.sum * sur.sum as "Стоимость отстатков"
from t_supply sup join t_material mat on sup.id_material = mat.id_material
				  join (select id_material, sum(value) 
						from t_surplus
						group by id_material) sur on sup.id_material = sur.id_material
				  join (select id_material, sum(value)
						from t_supply
						group by id_material) supValue on sup.id_material = supValue.id_material
group by mat.names, sur.sum, supValue.sum;

/*45.1*/
select	mat.names as "Материал",
		(select price
		from t_inprice inp
		where inp.id_material = mat.id_material
		and (current_date - price_date) =  (select min(current_date - price_date)
											from t_inprice inp
											where inp.id_material = mat.id_material)) as "Текущая цена",
		(select price
		from t_inprice inp
		where inp.id_material = mat.id_material
		and (current_date - price_date) = (select min(current_date - price_date)
										  from t_inprice inp
										  where inp.id_material = mat.id_material
										  and price < (select price
													   from t_inprice inp
													   where inp.id_material = mat.id_material
													   and (current_date - price_date) = (select min(current_date - price_date)
																						  from t_inprice inp
																						  where inp.id_material = mat.id_material)))) as "Действующая цена"
from t_material mat
group by id_material;

/*45.2*/
select str.names
from t_store str join t_surplus sur on str.id_store = sur.id_store
group by str.names
having sum(sur.value) = 0;

/*46*/
select  cat.names,
		sum(sup.value * (select price 
					from t_inprice inp
					where inp.id_material = mat.id_material and 
					sup.supply_date - inp.price_date = (select min(sup.supply_date - inp.price_date) 
														from t_inprice inp
													    where inp.id_material = mat.id_material
													  	and sup.supply_date - inp.price_date >= 0))) as "Итоговая цена за поставки"
from t_supply sup join t_material mat on sup.id_material = mat.id_material
				  join t_caterer cat on sup.id_caterer = cat.id_caterer
where extract(year from sup.supply_date) = extract(year from current_date)
group by cat.names
having sum(sup.value * (select price 
					from t_inprice inp
					where inp.id_material = mat.id_material and 
					sup.supply_date - inp.price_date = (select min(sup.supply_date - inp.price_date) 
														from t_inprice inp
													    where inp.id_material = mat.id_material
													  	and sup.supply_date - inp.price_date >= 0))) < 1000;


/*47*/
select  cat.names,
		sum(sup.value * (select price 
					from t_inprice inp
					where inp.id_material = mat.id_material and 
					sup.supply_date - inp.price_date = (select min(sup.supply_date - inp.price_date) 
														from t_inprice inp
													    where inp.id_material = mat.id_material
													  	and sup.supply_date - inp.price_date >= 0))) as "Итоговая цена за поставки"
from t_supply sup join t_material mat on sup.id_material = mat.id_material
				  join t_caterer cat on sup.id_caterer = cat.id_caterer
where extract(year from sup.supply_date) = extract(year from current_date)
group by cat.names
having sum(sup.value * (select price 
						from t_inprice inp
						where inp.id_material = mat.id_material and 
						sup.supply_date - inp.price_date = (select min(sup.supply_date - inp.price_date) 
															from t_inprice inp
															where inp.id_material = mat.id_material
															and sup.supply_date - inp.price_date >= 0))) = (select max(tab.sum)
																											from (select sum(sup.value * (select price 
																																		 from t_inprice inp
																																		 where inp.id_material = mat.id_material and 
																																		 sup.supply_date - inp.price_date = (select min(sup.supply_date - inp.price_date) 
																																											from t_inprice inp
																																											where inp.id_material = mat.id_material
																																											and sup.supply_date - inp.price_date >= 0)))
																												 from t_supply sup join t_material mat on sup.id_material = mat.id_material
																												 				   join t_caterer cat on sup.id_caterer = cat.id_caterer
																												 where extract(year from sup.supply_date) = extract(year from current_date)
																												 group by cat.names) as "tab");