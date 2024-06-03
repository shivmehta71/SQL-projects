use data_analyst_project;

select * from finance_1;
select * from finance_2;

SET SQL_SAFE_UPDATES =0;


/* KPI_1 :- Year wise loan amount Stats*/


select year((issue_d)) as year, sum(loan_amnt) as Total_Loan_amnt from finance_1
group by year;


/* KPI_2 :- Grade and sub grade wise revol_bal */

select grade, sub_grade,sum(revol_bal) as Total_revol_bal
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id) 
group by grade,sub_grade
order by grade;

/* KPI_3 :- Total Payment for Verified Status Vs Total Payment for Non Verified Status */

select verification_status, round(sum(total_pymnt),2) as Total_payment
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id) 
where verification_status in('Verified', 'Not Verified')
group by verification_status;



/* KPI_4 :- State wise and last_credit_pull_d wise loan status - Final */

select addr_state as States, MAX(DATE_FORMAT(STR_TO_DATE(last_credit_pull_d, '%b-%y'),'%Y-%m')) ,max(loan_status)
from finance_1 inner join finance_2 
on(finance_1.id = finance_2.id) 
group by addr_state, DATE_FORMAT(STR_TO_DATE(last_credit_pull_d, '%b-%y'),'%Y')
order by addr_state;


/* KPI_4 :- State wise and last_credit_pull_d wise loan status - Final */

select addr_state as States, max(last_credit_pull_d) as Last_credit_pull_date ,loan_status
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id) 
group by addr_state, DATE_FORMAT(STR_TO_DATE(last_credit_pull_d, '%b-%y'),'%Y'),
order by addr_state;






/* KPI_5 :- Home ownership Vs last payment date stats */

select home_ownership,
max(last_pymnt_d)
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id) 
group by home_ownership, DATE_FORMAT(STR_TO_DATE(last_pymnt_d, '%b-%y'),'%Y') order by home_ownership;


select * from finance_2;
select * from finance_1;









