/******************************************************************************
파일명: Or12SubQuery.sql
서브쿼리
설명: 쿼리문 안에 또 다른 쿼리문이 들어가는 형태의 select문
    where구에 select문을 사용하면 서브쿼리라고 한다.
*******************************************************************************/
--HR계정

/*
단일행 서브쿼리
    단 하나의 행만 반환하는 서브쿼리로 비교연산자(=,<,<=,>,>=,<>)를 사용.
  형식]
    select *from 테이블명 where 컬럼=(
            select 컬럼 from 테이블명 where 조건
        );
    *괄호안의 서브쿼리는 반드시! 하나의! 결과를 인출해야 한다.(복수행은 좀 다름)    
*/
/*
시나리오] 사원테이블에서 전체사원의 평균급여보다 낮은 급여를 받는 사원들을 추출.
    출력항목 : 사원번호, 이름, 이메일, 연락처, 급여
*/
-------------------------Nook
select employee_id, first_name , email, phone_number, salary 
    from employees
    where salary<(select avg(salary) from employees);
-----------------------------
--1. 평균급여 구하기 : 6462
select avg(salary) from employees;

--2.해당 쿼리문은 문맥상 맞는 듯 하지만 그룹함수를 단일행의 적용한 실패한 쿼리.
select * from employees where salary<avg(salary);
--3. 앞에서 구한 평균 급여를 조건으로 select문 작성
select * from employees where salary<3632;--숫자로 박으니까 가능하네?
--4. 두개의 쿼리문을 하나의 서브쿼리문으로 합쳐서 결과를 확인한다.
select employee_id, first_name, email, phone_number, salary
    from employees 
    where salary<(
        select avg(salary) from employees);
/*
퀴즈] 전체 사원중 급여가 가장작은 사원의 이름과 급여를 출력하는 
    서브쿼리문 작성하시오.
    출력항목 : 이름1,이름2,이메일, 급여
*/
--------------------------------NOOOK
select first_name||' '||last_name "name",email, salary
from employees
where salary =(select min(salary) from employees);
--------------------------------------------------------
--1단계 : 최소급여를 확인한다.
select min(salary) from employees;
--2단계 : 2100을 받는 직원의 정보를 인출한다.
select * from employees where salary= 2100;
--3단계 : 두개의 쿼리문을 합쳐서 서브쿼리를 만든다.
select * from employees where salary=(select min(salary) from employees);

/*
시나리오] 평균급여가 많은 급여를 받는 사람들의  명단을 조회할 수 있는
서브쿼리문 작성
    출력 내용 : 이름1,이름2, 담당업무명, 급여
    *담당업무명은 jobs테이블에 있으므로 join해야함.
*/
-----------------------------------------------------NOOK
select first_name,last_name, job_title, salary
from employees
    inner join jobs using(job_id)
where salary>(select avg(salary) from employees)
order by salary;
---------------------------------------------------------------
--단계 1.평균급여
select avg(salary) from employees;
--2단계 : 테이블 조인
select first_name, last_name, job_title, salary
from employees
    inner join jobs using (job_id)
where salary>6462;
--3단계 : 서브쿼리문으로 병합
select first_name, last_name, job_title, salary
from employees
    inner join jobs using (job_id)
where salary>(select avg(salary) from employees);

/*
복수 서브쿼리문
**/
/*
시나리오] 담당업무별로 가장 높은 급여를 받는 사원의 명단을 조회하시오.
    출력목록 : 사원아이디, 이름, 담당업무 아이디, 급여
*/
--------------------------------------------NOOK
select employee_id,first_name,job_id,salary
from employees where salary in 
(select max(salary) from employees group by job_id)
group by job_id;
--복수행이 나오므로 in 박아줘야징~~실패
------------------------------------------------------------
--1단계 담당업무별 가장 높은 급여 확인
select job_id ,  max(salary) from employees group by job_id;
--select max(salary) from employees group by job_id;

--2단계. 위의결과를 단순한 or 조건으로 묶는다.
select * from employees
where 
    (job_id='SH_CLERK' and salary=4200) or
    (job_id='AD_ASST' and salary=4400) or
    (job_id='MK_MAN' and salary=1300) or
    (job_id='MK_REP' and salary=6000);
--3단계. : 복수형 연산자를 통해 서브쿼리로 병합한다.
select employee_id,first_name,job_id,salary
from employees 
where (job_id, salary) 
    in
    ( 
    select job_id ,  max(salary) from employees group by job_id
    )
order by salary;

/*
복수행 연산자 : any
    메인쿼리의 비교조건이 
    서브쿼리의 검색결과와 하나이상 일치하면 참이되는 연산자.
    즉, 둘중 하나만 참이면 인출(or와 쓰임새 비슷)
*/
/*
시나리오] 전체 사원중에서 부서번호가 20인 사원들의 급여보다 높은 급여를 
    받는 직원들을 인출하는 서브쿼리문을 작성하시오.
    단, 둘중 하나만 만족하더라도 인출하시오.
*/
---------------------------------------------NOOK
select * from employees where salary >any
( select salary from employees where department_id  = 20);
---------------------------------------------------
--1단계 : 20부서 급여확인
select salary from employees where department_id  = 20;
--2단계 : 1번의 결과를 단순한 or절로 작성
select first_name, salary from employees
where salary >13000 or salary>6000;
--3단계 : 둘중 하나만 만족하면 되므로 복수행 연산자 any를 이용해서 
--  서브쿼리를 만들면된다. 즉 6000보다 크고 또는 13000보다 큰 조건으로 생성.
select 
    first_name, salary 
from 
    employees
where 
    salary>any(select salary from employees where department_id  = 20);
/*
복수행 연산자3: all은 and의 개념과 유사한다.
    메인쿼리의 비교조건이 서브쿼리의 검색결과와 모두 일치해야 레코드를 인출한다.
*/
/*
시나리오] 전체 사우너중에서 부서번호가 20인 사원들의 급여보다 높은 급여를 받는 
직원들을 인출하는 서브쿼리문을 작성하시오. 단, 둘 다 만족해라.
*/
select first_name, salary 
from employees
where salary >all 
    (select salary from employees where department_id = 20);
--13000보다 큰애들!    
--6000이상 동시에 13000이상이여야 하므로 결과적으로 13000이상인 레코드 인출.
/*
rownum : 테이블에서 레코드를 조회한 순서대로 순번이 부여되는 가상의 컬럼.
해당 컬럼은 모든 테이블에 논리적으로 존재한다.
*/
--모든 계정에 논리적으로 존재하는 테이블이다.
select * from dual;
--레코드의 정렬없이 모든 레코드를 가져와서 rownum을 부여한다.
--이 경우 rownum은 순서대로 출력된다.
select employee_id, first_name,rownum from employees;
--이름의 오름차순으로 정렬하면 rownum이 섞여서 이상하게 나온다.
select employee_id, first_name, rownum from employees order by first_name;
/*
rownum을 우리가 정렬한 순서대로 재부여하기 위해 서브쿼리를 사용한다.
from절에는 테이블이 들어와야 하는데, 아래의 서브쿼리에서는 사원테이블의
전체 레코드를 대상으로 하되 이름의 오름차순으로 정렬된 상태로 레코드를
가져와서 테이블처럼 사용한다.
*/
select first_name, rownum
from (select* from employees order by first_name asc);
--안쪽 테이블을 이름의 오름차순으로 정렬해서 로우넘 init.
--테이블을 정렬해서 새로운 테이블을 쓴 것과 비슷한 효과.

--------------------------------------------------------
--------------- Sub Query 연 습 문 제 ------------------ 
--------------------------------------------------------

-- scott계정에서 진행합니다. 
/*
01.사원번호가 7782인 사원과 담당 업무가 같은 사원을 표시하시오.
출력 : 사원이름, 담당 업무
*/
select* from emp;
select ename,job
    from emp
    where job =(select job from emp where  empno=7782);


/*
02.사원번호가 7499인 사원보다 급여가 많은 사원을 표시하시오.
출력 : 사원이름, 급여, 담당업무
*/
select ename, sal, job
    from emp
    where sal>(select sal from emp where empno=7499);


/*
03.최소 급여를 받는 사원번호, 이름, 담당 업무 및 급여를 표시하시오.
(그룹함수 사용)
*/
select empno,ename,job,sal
from emp 
where sal=(select min(sal) from emp);

/*
04.평균 급여가 가장 적은 직급(job)과 평균 급여를 표시하시오.
*/

select job, avg(sal)  from emp 
group by job
having avg(sal)<=all(select avg(sal) from emp group by job);
/*
05.각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
*/

select ename,sal,deptno from emp
where sal in (select min(sal) from emp group by job);


/*
06.담당 업무가 분석가(ANALYST)인 사원보다 급여가 적으면서 
업무가 분석가(ANALYST)가 아닌 사원들을 표시(사원번호, 이름, 담당업무, 급여)
하시오.
*/
select empno,ename,job,sal from emp
where sal<all(select sal from emp where lower(job)='analyst') and 
    not lower(job)='analyst';


/*
07.이름에 K가 포함된 사원과 같은 부서에서 일하는 사원의 
사원번호와 이름, 부서번호를 표시하는 질의를 작성하시오
*/
select empno, ename, deptno from emp 
where job in 
    (select job from emp where upper(ename) like '%K%');

/*
08.부서 위치가 DALLAS인 사원의 이름과 부서번호 및 담당 업무를 표시하시오.
*/
select deptno from dept where lower(loc) = 'dallas';
select ename,deptno,job from emp where deptno = 20;
select ename, deptno,job from emp 
    where deptno =(select deptno from dept where lower(loc) = 'dallas');

/*
09.평균급여 보다 많은 급여를 받고 이름에 K가 포함된 사원과 같은 
부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오.
*/
select empno,ename, sal, deptno from emp
where deptno in(select deptno from emp where ename like '%K%') and
    sal>(select avg(sal) from emp);

/*
10.담당 업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오.
*/
select * from emp 
where deptno in (select deptno from emp where lower(job)='manager');


/*
11.BLAKE와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 
질의를 작성하시오. (단, BLAKE는 제외)
*/
select ename from emp 
where deptno =(select deptno from emp where lower(ename)='blake')

