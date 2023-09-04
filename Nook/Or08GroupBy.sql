/**********************************
파일명: Or08GroupBy.sql
그룹함수(select문 2번째)
설명: 전체 레코드(로우)에서 통계적인 결과를 구하기 위해 하나이상의 레코드를 그룹으로 묶어서 연산 후
    결과를 반환하는 함수. 혹은 쿼리문
***********************************/
--HR계정

--사원 테이블에서 담당업무 인출 : 총 107개가 인출 됨.
select job_id from employees;

/*
distinct
    -동일한 값이 있는 경우 중복된 레코드를 제거한 후 하나의 레코드만 가져와서 보여준다.
    -하나의 순수한 레코드 이므로 통계적인 값을 계산할 수 있다.
*/
select distinct job_id from employees; --한번씩만 나옴.
select distinct job_id, count(*) from employees group by job_id; --한번씩만 나옴.

/*
group by 
    -동일한 값이 있는 레코드를 하나의 그룹으로 묶어서 가져온다.
    -보여지는 건 ㅎ나ㅏ의 레코드짐나 다수의 레코드가 하나의 그룹으로 묶여진 결과이므로 
       통계적인 값을 게산할 수 있다.
    -최대,최소,평균, 합산등의 연산이 가능하다.
*/
--각 담당업무별 직원 수가 몇명인지 카운트 한다.
select job_id, count(*) from employees group by job_id;
select job_id from employees group by job_id;

--검증을 위해 해당 업무를 통해 select해서 인출되는 행의 갯수와 비교해 본다.
select first_name, job_id from employees where job_id='FI_ACCOUNT';--5개 확인.
select first_name, job_id from employees where job_id='ST_CLERK'; --20

/*
group 절이 포함된 select 문의 형식
    select
        컬럼1,컬럼2,...혹은 전체(*)
    from
        테이블명
    where
        조건1 and 조건2 or 조건3
    group by
        레코드 그룹화를 위한 컬럼명
    having
        그룹에서의 조건
    order by
        정렬을 위한 컬럼명과 정렬방식
*쿼리의 실행순서        
    from 테이블 -> where조건 -> group by  그룹화 -> having(그룹조건)
        -> select(컬럼지정) -> order by (정렬방식)
*/
/*
sum() : 합계를 구할 때 사용하는 함수.
    -number 타임의 컬럼에서만 사용할 수 있다.
    -필드명이 필요한 경우 as를 이용해서 별칭을 부여할 수 있다.
*/
--전체 직원의 급여의 합계를 출력하시오.
--where절이 없으므로 전체직원을 대상으로 한다.
select 
    sum(salary) "sumsal1"
    to_char(sum(salary),'999,000')"sumsalary2",
    ltrim(to_char(sum(salary),'L999,000')) "sumSalary3", --"좌측 공백 제거,원화표시(자동)"
    ltrim(to_char(sum(salary),'$999,000')) "sumSalary4" --"통화기호삽입";
from employees;   

select 
    sum(salary) sumsal1,
    to_char(sum(salary),'999,000')sumsalary2,
     ltrim(to_char(sum(salary),'L999,000'))  sumSalary3,
    ltrim(to_char(sum(salary),'$999,000')) sumSalary4
from employees;    
--10번 부서에 근무하는 사원들의 급여의 합게는 얼마인지 출력하시오.
select 
    sum(salary) "급여합계",
    to_char(sum(salary),'999,000')"세자리 컴머",
     ltrim(to_char(sum(salary),'L999,000'))  "좌측 공백 제거,원화표시(자동)",
    ltrim(to_char(sum(salary),'$999,000')) "통화기호삽입"
from employees where department_id=10;    


--sum()과 같은 그룹함수는 number타입인 컬럼에서만 사용할 수 있다.
select sum(first_name) from employees; --error

/*
count() :그룹화된 레코드의 갯수를 카운트 할 때 사용하는 함수.
*/
select count(*) from employees;
/*
count() 함수를 사용할 때는 위 2갖2ㅣ 방법 모두 가능하지만 *를 사용할 것을 권장.
    컬럼의 특성 혹은 데이터에 따른 방해를 받지 않으므로 실행속도가 빠르다.
*/
/*
count()함수의 
    사용법 1: count(all 컬럼명)
        => 디폴트 사용법으로 컬럼 전체의 레코드를 기준으로 카운트한다.
    사용범 2: count(distinct 컬럼명)
        => 중복을 제거한 상테에서 카운트한다.
*/

select
    count(job_id) "담당업무 전체 갯수1",
    count(*),
    count(all job_id) "담당업무 전체 갯수2",
    count(distinct job_id) "순수 담당업무 갯수"
from employees;    
select count(first_name),count(commission_pct),count(manager_id) from employees;
--null은 없는 것으로 치부함.

/*
avg():평균값을 구할 때 사용하는 함수
*/
--전체사원의 평균급여는 얼마인지 출력하는 쿼리문을 작성하시오

select 
    count(*) "전체사원수",    
    sum(salary) "사원급여의 합",
    trunc(sum(salary)/count(*),2) "평균급여 직접계산",
    round(avg(salary),2) "평균급여 avg()",
    avg(salary) "평균급여 avg()",
    trim(to_char(avg(salary), '$999,000'))"서식 및 공백제거"
from employees;

--영업팀(sales)의 평균급여는 얼마인가요?
--1.부서테이블에서 영업팀의 부서번호가 무엇인지 확인
/*
정보검색시 대소문자 혹은 공백이 포함된 경우 모든 레코드에 대해 
문자열을 확인하는 것은 불가능하므로 일괄적인 규칙의 적용을 위해 
upper()함수와 같은 변환함수를 사용하는것이 좋다.
*/
select * from departments where department_name = initcap('sales');--부서번호확인
select *from departments where lower(department_name) ='sales' ;
select * from departments where upper(department_name)=upper('SALES');
--부서번호가 80인것을 확인한 후 다음 쿼리문을 작성한다.
select ltrim(to_char(avg(salary),'$999,000,00'))
    from employees where department_id =80;
/*
min(),max() 함수 : 최대값, 최소값을 찾을 때 사용하는 함수
*/
--전체 사원중 가장 낮은 급여는 얼마인가요
select min(salary) from employees;
--전체 사원중 급여가 가장 낮은 직원은 누구인가요?
--아래 쿼리문은 error가 발생됌. 그룹함수는 일반컬럼에 사용할 수 없다.
select first_name, salary from employees where salary=min(salary); --error

--사원테이블에서 가장 낮은 급여인 2100을 받는 사원을 인출하시오.
select first_name, salary from employees where salary=2100; 
/*
    사원 중 가장 낮은 급여는 min() 함수로 구할 수 있으나, 가장 낮은 급여를
    받는 사람은 아래와 같이 서브쿼리를 통해 구할 수 있다.
    따라서 문제에 따라 서브쿼리를 사용할지 여부를 결정해야한다.
*/    
select first_name, salary from employees where salary = ( 
    select min(salary) from employees);
    --where절 조건에 서브쿼리문을작성하여 집어넣어버림.
/*
group by 절 : 여러개의 레코드를 하나의 그룹으로 그룹황하여 묶여진
    결과를 반환하는 쿼리문
        *distinct는 단순히 중복값을 제거함.
*/
--사원테이블에서 각 부서별 급여의 합계는 얼마인가요?
--IT부서의 급여 합계
SELECT SUM(salary) FROM employees WHERE department_id=60;
--finance 부서의 급여 함계
SELECT SUM(salary) FROM employees WHERE department_id=100;
SELECT ltrim(to_char(SUM(salary),'$999,000')) FROM employees WHERE department_id=100;


/*
step1 : 부서가 많은 경우 일일이 부서별로 확인할 수 없으므로 부서를 그룹화한다.
    중복이 제거된 결과로 보이지만 동일한 레코드가 하나의 그룹으로 합쳐진 결과인출.
*/
select department_id from employees group by department_id;
/*
step2 : 각 부서별로 급여의 합계를 구할 수 있다. 4자리가 넘어가는 경우
    가독성이 떨어지므로 서식을 이용해서 세자리마다 컴마를 표시한다.
*/
Select Department_Id , Sum(Salary), Trim(To_Char(Sum(Salary),'$999,000')) 
From Employees
Group By Department_Id
Order By Sum(Salary) Desc;

/*
퀴즈] 사원테이블에서 각 부서별 사원수와 평균급여는 얼마인지 출력하는 쿼리문.
출력결과 : 부서번호, 급여총합, 사원총합, 평균급여
출력시 부서번호를 기주으로 오름차순 정렬.
*/

select department_id, sum(salary), count(*), avg(salary) 
from employees
group by department_id
order by department_id;

select sum(salary), count(*), avg(salary) 
from employees;
--group by department_id
--order by department_id;

select 
    department_id "부서번호", 
    ltrim(to_char(sum(salary),'$999,999,990'))"부서별 연봉합계", 
    count(*)"부서인원수", 
    to_char(avg(salary),'$999,990') "부서별 연봉평균"
from employees
group by department_id
order by department_id;

select 
    department_id "부서번호", 
    ltrim(to_char(sum(salary),'$999,999,990'))"부서별 연봉합계", 
    count(first_name)"부서인원수", 
    to_char(avg(salary),'$999,990') "부서별 연봉평균"
from employees
group by department_id
order by department_id;


--기본형
select
    department_id,sum(salary), count(*),avg(salary)
from employees
group by deartment_id
order by department_id asc;

--서식과 소수점 정리
select
    department_id "부서번호",
    rtrim(to_char(sum(salary),'999,000')) "급여합계", 
    count(*) "사원 수",
    rtrim(to_char(avg(salary),'999,000')) "평균급여"
from employees
group by department_id
order by department_id asc;    

/*
앞에서 사용했던 쿼리문을 아래와 같이 first_name컬럼을 추가하여 수정하면 에러.
group by 절에서 사용한 컬럼은 select절에서 사용할 수 있으나 그 외의 단일컬럼은
select절에서 사용할 수 없다.
그룹화된 상태에서 특정 레코드 하나만 선택하여 인출하는 것은 애매하기 때문이다.
*/
select
    department_id,sum(salary), count(*),avg(salary), first_name
from employees
group by deartment_id
order by department_id asc;

/*
시나리오] 부서아이디가 50인 사원들의 직원총합, 평균급여, 급여총합이
    얼마인지 출력하는 쿼리문 작성하시오.
*/
select count(*), avg(salary),sum(salary)
from employees
group by department_id
having department_id='50';

select '50번부서', count(*), round(avg(salary)),sum(salary)
from employees where department_id = '50'
group by department_id;
--having department_id='50';

/*
group by 의 조건절 having절 
 -물리적으로 존재하는 컬럼이 아닌 그룹함수를 통해 
    논리적으로 생성된 컬럼의 조건을 추가할 때 사용한다.
    해당 조건을 WHERE절에추가하면 에러가 발생한다.
*/
/*
시나리오] 사원테이블에서 각 부서별로 근무하고 있는 직원의 담당업무별
    사원수와 평균급여가 얼마인지 출력하는 쿼리문을 작성하시오.
    단, 사원수가 10을 초과하는 레코드만 인출하시오.
*/
/*
같은 부서에 근무하더라도 담당업무는 다를 숭 ㅣㅅ으므로 이 문제에서는
group by 절에 2개의 컬럼을 명시해야 한다. 즉 부서로 그룹화 한후
다시 담당업무별로 그룹화 한다.
*/3
SELECT DEPARTMENT_ID, job_id, count(first_name), avg(salary)
from employees
--where count(*)>10  --여기서 에러발생
group by department_id, job_id;
--having count(*)>10;
/*
담당업무별 사원수는 물리적으로 존재하는 컬럼이 아니므로 where절에 박으면 에러.
이런 경우 having절에 조건을 넣어야함.
ex) 평균 급여가 3000인 사원 => 논리적연산의 결과물로 존재하므로 having절 사용
                                즉, 그룹함수로만 구할 수 있는 데이터임.
*/
SELECT DEPARTMENT_ID, job_id, count(first_name), avg(salary)
from employees
--where count(*)>10  --여기서 에러발생
group by department_id, job_id
having count()>10;
/**/
SELECT DEPARTMENT_ID, job_id, count(first_name), avg(salary)
from employees
--where count(*)>10  --여기서 에러발생
group by rollup(department_id, job_id)
having count()>10;

/******************
퀴즈] 담당업무별 사원의 최저급여를 출력하시오.
단,(관리자(manager)가 없는 사원과 최저급여가 3000미만인 그룹) 은 제외.
결과는 급여의 내림차순으로 정리
********************/

select job_id, min(salary) from employees
where  manager_id is not null --and  salary =(min(salary) from employees)
group by job_id
having not min(salary)<3000 --min(salary)>=3000(결과는 같으나 앞 쿼리문이 문제문장에 가까움
order by min(salary) desc;

/*
 문제에서는 급여의 내림차순으로 정렬하라는 지시사항이 있으나,
 현재 select되는 항목이 급여의 최소값이므로 order by 절에는 min(salary)를 사용해야 한다.
 */
 
 --해당문제는 hr계정의 employees 테이블 사용한다.
 /*
 1. 전체 사원의 급여최고액, 최저액, 평균급여출력.
 컬렴 별칭은 아래와 같이. 평균은 정수형태로 반올림.
 급여 최저액 -> MinPay
 급여 최고액 -> MaxPay
 급여 평균 -. AvgPay
 */
 select
    Max(salary)"MaxPay", Min(salary) as MinPay, 
    trim(to_char(avg(salary),'999,000'))  Avgtochartrim,
    round(avg(salary)) avground,
    trunc(avg(salary)) avgtrunc,
    avg(salary) avgorigin,
    to_char(avg(salary),'999,000')  Avgtochar
from     employees;
 /*
 2. 각 담당업무 유형별로 급여최고액, 최저액 ,총액 및 평균액을 출력.
 컬럼의 ㅂ별칭은 아래왙이. 모든숫자는 tochar로 세자리마다 컴마.
 */
 select job_id,to_char(max(salary),'$999,999')"maxpay",
        to_char(min(salary) ,'$999,999') minpay,
        to_char(sum(salary),'$999,999') sumpay, 
        to_char(avg(salary),'$999,999') avgpay
        from employees
        group by job_id;
 /********
 3. count() 함수. 담당업무 동일사원 출력.
 참고) emplyees 테이블의 job_id 기준.
 */
 select job_id, count(*)"인원수" 
 from employees 
 group by job_id order by "인원수";
 
 /*
 4. 급여가 10000달러 이상인 직원들의 담당업무별 합게인원수 출력
 */

select job_id, count(*)"업무별 인원수" 
from employees
where salary>10000
group by job_id
order by "업무별 인원수";

/**
5. 급여 최고액과 최저액의 차액을 출력하시오.
*/

select max(salary)"급여 최고액" , min(salary)"급여 최저액", 
        (max(salary)-min(salary)) "급여 차액"
    from employees;    
/*
6. 각 부서에 대해 부서번호, 사원수, 부서 내의 모든 사원의 평균급여를 
출력하시오. 평균급여는 소수점 둘째자리로 반올림하시오.
*/
select department_id ,count(*) , round(avg(salary),2) from employees
group  by department_id;