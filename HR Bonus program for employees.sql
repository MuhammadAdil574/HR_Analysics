use hr_project;
show tables;

select * from absenteeism_at_work;
select * from compensation;
select * from reasons;

-- joining tables


select * from absenteeism_at_work as a
left join compensation as c on
a.ID = c.ID
left join reasons as r on 
a.Reason_for_absence = r.`Number` ;

-- healthiest employees for the bonus

select * from absenteeism_at_work
where Social_drinker = 0 and Social_smoker = 0 
and Body_mass_index < 25 and 
Absenteeism_time_in_hours < (Select avg ( Absenteeism_time_in_hours) as AVG_time_in_hours
from absenteeism_at_work);


-- to get the healthiest employees we get workers with 0 smoker and drinking level having less body index
-- and the total working hours should be less than avg hours
-- we get average of total working hours to get the comparison bw total and avg working hrs

-- compensation increase for no-smokers  / Total budgt given 983,221$

select count(*) as non_smokers from absenteeism_at_work
where Social_smoker = 0;

-- since 983,221 is provided budgt for non-smokers which means 1 non-smoker gets yearly bonus of 1433.26$
-- and total working hours per year are 2080 hrs if a person works 8 hrs/day and 5 days/week
-- The increase per hour would be 0.68$

select Reason, count(*) as count_of_Reason_for_absence from absenteeism_at_work as a
left join compensation as c on
a.ID = c.ID
left join reasons as r on 
a.Reason_for_absence = r.`Number`
group by Reason 
order by count_of_Reason_for_absence desc ;


select Reason, count(*) as count_of_Reason_for_absence from absenteeism_at_work as a
left join compensation as c on
a.ID = c.ID
left join reasons as r on 
a.Reason_for_absence = r.`Number`
group by Reason 
order by count_of_Reason_for_absence desc ;

-- optimize the querry

select a.ID, r.Reason, `Month`, Body_mass_index,
case when `Month` in (12,1,2) then "Winter"
     when `Month` in (3,4,5) then "Spring"
     when `Month` in (6,7,8) then "Summer"
     when `Month` in (9,10,11) then "Fall"
     else "Unknown"
     end  as Seasons_Names ,
case when Body_mass_index < 18.5 then "Underweight"
     when Body_mass_index between 19 and 25 then "Healthy"
     when Body_mass_index between 26 and 30 then "Overweight"
     when Body_mass_index > 31 then "Obese"
     else " Unknown"
     end as BMI_Catagory,
Height, Day_of_the_week, Transportation_expense, Son, Social_drinker, 
Social_smoker, Pet, Absenteeism_time_in_hours, Work_load, Age
from absenteeism_at_work as a
left join compensation as c on
a.ID = c.ID
left join reasons as r on 
a.Reason_for_absence = r.`Number` ;

-- Weekly Transportation expense
select Transportation_expense, Day_of_the_week from absenteeism_at_work as a
left join compensation as c on
a.ID = c.ID
left join reasons as r on 
a.Reason_for_absence = r.`Number` 
group by Transportation_expense
order by Day_of_the_week;

-- BMI catagory


select a.ID , Body_mass_index,
case when Body_mass_index < 18.5 then "Underweight"
     when Body_mass_index between 19 and 25 then "Healthy"
     when Body_mass_index between 26 and 30 then "Overweight"
     when Body_mass_index > 31 then "Obese"
     else " Unknown"
     end as BMI_Catagory
from absenteeism_at_work as a
left join compensation as c on
a.ID = c.ID
left join reasons as r on 
a.Reason_for_absence = r.`Number` 
group by a.ID
order by BMI_Catagory;

-- Education
select a.ID, Age, Education from absenteeism_at_work as a
left join compensation as c on
a.ID = c.ID
left join reasons as r on 
a.Reason_for_absence = r.`Number` 
group by a.ID
order by Education ;

