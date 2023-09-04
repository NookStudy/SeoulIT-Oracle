/**********************************
파일명: Or03SelectBasic.sql
처음으로 실행해보는 질의어(SQL문 or Query문)
개발자들 사이에서는 '시퀄' 이라고 표현하기도 합니다.
설명:  select, where 등 가장 기본적인 DQL문 사용해보기. 
***********************************/
--HR계정으로 연결
/******
*SQL Developer 에서 주석사용하기
--*    블럭단위주석: 자바와 동일./*    */
--*    라인단위주석: -- 실행문장 . 하이픈 2개를 연속으로 사용한다.
--***********/

--select문 : 테이블에 저장된 레코드를 조회하는 SQL문으로 DQL문에 해당한다.
/*
형식]
    select 컬럼1, 컬럼2,... 혹은*(아스타)
        from 테이블명
        where 조건1 and 조건2 or 조건3
        oder by 정렬할컬럼 asc(오름차순), desc(내림차순);<-문장종료. ctrl+enter:실행
*/
--사원테이블에 저장된 모든레코드(행)를 대상으로 모든 컬럼(열)을 조회하기
--모든테이블 가져오겠단 뜻임
--(쿼리문은 대소문자를 구분하지 않는다.)
select * from employees;
SELECT * FROM EMPLOYEES;

/*
컬럼명을 지정해서 조회하고 싶은 컬럼만 조회하기
=> 사번, 이름,이메일,부서번호만 조회
*/
SELECT employee_id, first_name,last_name,email,department_id
    from employees; --하나의 쿼리문이 끝날때 세미콜론을 반드시 기술해야함.
    
--테이블의 구조와 컬럼별 자료형 및 크기를 출력한다.
--즉, 테이블의 스키마를 알 수 있다.
desc employees;
/*
이름             널?       유형           
-------------- -------- ------------ 
EMPLOYEE_ID    NOT NULL NUMBER(6)    
FIRST_NAME              VARCHAR2(20) 
LAST_NAME      NOT NULL VARCHAR2(25) 
EMAIL          NOT NULL VARCHAR2(25) 
PHONE_NUMBER            VARCHAR2(20) 
HIRE_DATE      NOT NULL DATE         
JOB_ID         NOT NULL VARCHAR2(10) 
SALARY                  NUMBER(8,2)  
COMMISSION_PCT          NUMBER(2,2)  돈, 소수 2째자리까지
MANAGER_ID              NUMBER(6)    
DEPARTMENT_ID           NUMBER(4)    
*/
--as는 생략할 수 있다.
-- 컬럼의 항목을 바꿔서 프린트 할 수 있다.
select employee_Id"사원아이디",first_name "이름", last_name "성"
    from employEes where firSt_naMe = 'William';
/*
오라클은  기본적으로 대소문자를 구분하지 않는다.
예악어의 경우 대소문자 구분없이 사용할수 있다.
*/
--단, 데이터는 대소문자 구분함.(***중요***)
--alias 생략자는 더블쿼테이션. 데이터 불러올 때는 싱글 쿼테이션.
SELECT EMPLOYEE_ID"사원아이디",first_name"이름",last_name"성" 
    FROM Employees WHERE first_name = 'William';

--단, 레코드인 경우 대소문자를 구분한다. 
--따라서 아래 SQL문을 실행하면 아무런 결과도 나오지 않는다.(**중요**)
select employee_id"사원 아이디", first_name"이름" , last_name"성"
    from employees where first_name = 'WILLIAM';

/*
where 절을 이용해서 조건에 맞는 레코드 추출하기
->last name 이 Smith인 레코드를 추출하시오
*/
select * from employees where last_name='Smith';
/*
where 절에 2개이상의 조건이 필요할 때 and 혹은 or를 사용할 수 있다.
-> last_name이 Smith, 급여가 8000인 사원을 추출하라.
*/
select * from employees where last_name='Smith' and Salary='8000';
select * from employees where (Salary='8000' and  last_name='Smith') or (salary='2600' or last_name='Taylor');

--컬럼이 문자형인 경우 싱글쿼테이션으로 감싼다. 숫자인 경우 생략한다.

select *from employees where last_name ='Smith' and salary=8000;
--에러발생. 컬럼이 문자형인 경우 싱글 쿼테이션이 없으면 에러가 발생한다.
select *from employees where last_name=Smith and salary=8000;
--컬럼이 숫자형일때는 싱글쿼테이션 생략이 기본이지만, 쓰더라도 상관없다.
select *from employees where last_name ='Smith' and salary='8000';
/*
비교연산자를 통한 쿼리문 작성
    : 이상, 이하와 같은 조건에 >, <=와 같은 비교연산자를 사용할 수 있다.
    날짜인 경우 이전, 이후와 같은 조건도 가능하다.
*/
--급여가 5000미만 사원의 정보를 추출하시오.
SELECT * from employees where salary < 5000;
--입사일이 04년 01월 01이후인 사원 정보를 추출하시오.
Select * From Employees Where Hire_Date > '04/01/01';

/*in 연산자
    : or 연산자와 같이 하나의 컬럼에 여러개의 값으로 조건을 걸고싶을때 사용.
    => 급여가 4200,6400,8000인 사원을 추출하시오*/
--방법1. or사용. 이때 컬럼명을 반복적으로 기술해야한다.
select * from employees where salary=4200 or salary=6400 or salary=8000;
--방법2. in을 사용하면 컬럼명은 한번만 기술하면 된다.
select * from employees where salary in(4200,6400,8000);
/*
not 연산자
    : 해당 존건이 아닌 레코드를 추출.
    -> 부서번호가 50이 아닌 사원정보를 조회하는 SQL문을 작성하시오.
*/
select * from employees where department_id <> 50;
select * from employees where not(department_id = 50);
/*
between and 연산자
    : 컬럼의 구간을 ㄹ정해 검색할때 사용한다.
    => 급여가 4000~8000사이의 사원을 추출하시오.
*/
--방법1.
select *from employees where salary >=4000 and salary<=8000;
--방법2
select *from employees where salary between 4000 and 8000;
--select *from employees where salary in(between 4000 and 8000,between 2000 and 3000);사용불가

/*
distinct
    : 컬럼에서 중복되는 레코드를 제거할때 사용한다.
    특정 조건으로 select 했을 때 하나의 컬럼에서 중복되는 값이 있는경우 
    중복값을 제거한 후 결과를 출력할 수 있다.
    =>담당업무 아이디를 중복을 제거한 후 출력하시오.
*/
select job_id  from employees;
--전체사원에 대한 담당업무
select distinct job_id  from employees ;
--담당업무만 출력

/*
like 연산자
    : 특정 키워드를 통한 문자열을 검색할대 사용한다.
    형식] 컬럼명 like '%검색어%'
    와일드 카드 사용법.
        %: 모든문자 혹은 문자열을 대체한다.
            ex) D로 시작되는 단어 : D& -> da, dea, daewoo,
                Z로 끝나는 단어 : %Z -> aZ, adxZ
                C가 포함된 단어 : %C% -> aCb, abCd, Vitamin-C
        _: 언더바는 하나의 문자를 대체한다.
            ex) D로 시작하는 3글자 단어 : D__ -> Dae, Dad
                Z로 끝나는 3글자 단어 : __Z -> edZ, kaZ
                A가 중간에 들어가는 3글자 단어 : _A_ -> dAd, gAg;
            
*/            
--first name 이 'D'로 시작하는 직원을 검색하시오.
select * from employees where first_name like 'D%';
--first_name 이 세번째 문자가 a인 직원을 추출하시오.
select *from employees where first_name like '__a%';
--last name 에서 y로 끝나느 직원을 검색하시오
select *from employees where last_name like '%y';
--전화번호에 1344가 포함된 직원 전체를 인출하시오.
select * from employees where phone_number like '%1344%';

/*
레코드 정렬하기(sorting)
    오름차순 정렬 : order by 컬럼명 asc(혹은 생략가능)
    내림차순 정렬 : order by 컬럼명 desc
    
    2개이상의 컬럼으로 정렬해야 할 경우 컴마(,)로 구분해서 정렬한다.
    단, 이때 먼저 입력한 컬럼으로 정렬된 상태에서 두번째 컬럼이 정렬된다.
*/
/*
사원정보 테이블에서 급여가 낮은 순서에서 높은 순서로 인출되도록 정렬하여 조회하라.
출력할 컬럼 : first_name , salary, email,phone_number
*/
select first_name, salary,  phone_number from employees
    order by salary asc;
select first_name, salary,  phone_number from employees
    order by salary ;
/*
부서번호를 내림차순으로 정렬한 후 
해당 부서에서 낮은급여를 받는 직원이 먼저 출력되도록 하는 SQL문 작성하시오
출력항목 : 사원번호, 이름, 성, 급여 부서번호
*/
select employee_id "사원번호",  first_name "이름",last_name"성", salary "연봉",department_id "부서번호" 
    from employees
    order by department_id desc, salary asc;
/*
is null 혹은 is not null
    :값이 null 이거나 null이 아닌 레코드 가져오기
    컬럼중 null값을 허용하는 경우 값을 입력하지 않으면 null값이 되는데 이를 대상으로 select할때 사용한다.
    */
--보너스율이 없는 사원을 조회하시오    
select * from employees where commission_pct is null;    
--영업사원이면서 급여가 8000이상인 사원을 조회하시오.
select * from employees where commission_pct is not null and salary>=8000;
/**********************************
연습문제(scott 계정에서 진행합니다.)
*************************************/
/*
1. 덧셈 연산자를 이용하여 모든 사원에 대해서 $300의 급여인상을 계산한 후 
이름, 급여, 인상된 급여를 출력하시오.
*/
select * from emp ;
select ename, sal, sal+300"Risesalary" from emp;
select ename, sal, (sal+300)"Risesalary" from emp;

select ename, sal, sal+300"Risesalary" from emp
    where sal between 1000 and 5000 AND  job= 'CLERK'
    order by sal desc; 
/*
2. 사원의 이름, 급여, 연봉을 수입이 많은 것부터 적은순으로 출력
연봉은 월급에12를 곱한 후 100을 더해서 계산하시오.
*/
select ename, sal, sal*12+100 "연봉" from emp
    order by sal desc;
--정렬시 물리적으로 존재하는 컬럼명을 사용하는게 기본이다.
--물리적으로 존재하지 않은 컬럼이라면 계산식 그대로를 order by 절에 기술한다.
select ename, sal, sal*12+100 "연봉" from emp
    order by sal*12+100 desc;
select ename, sal, sal*12+100 "연봉" from emp
    order by "연봉" desc;
--Alias로 기술한 컬럼으로도 order by 명령이 성립한다.    
/*
급여가 2000을 넘는 사원의 이름과 급여를 내림차순으로 정렬하여 출력하시오;
*/
select ename, sal from emp
    where sal>2000
    order by ename desc, sal desc;
/*
4. 사원번호가 7782인 사원의 이름과 부서번호를 출력하시오.
*/
select ename, deptno from emp
    where empno = 7782;
    
/*
급여가 2000에서 3000사이에 포함되지 않는 사원의 이름과 급여를 출력하시오.
*/
select ename, sal from emp
    where not (sal between 2000 and 3000);
--    동일결과출력
select ename, sal from emp
    where sal>3000 or  sal<2000;
/*
6.입사일이 81년 2월20일부터 81년 5월1일 사이인 사원의 이름, 담당업무,입사일을 출력
*/
select ename,job,hiredate from emp
    where hiredate between '81/02/20' and '81/05/01' ;
select ename,job,hiredate from emp    
    where hiredate>='81/02/20' and hiredate<='81/05/01' ;
 /*
7.부서번호가 20및 30에 속한 사원의 이름과 부서번호를 출력하되
이름을 (내림차순 으로 정렬하시오.
*/
select ename, deptno from emp
    where deptno in(20,30)
    order by ename desc;
--    동일결과 출력
select ename, deptno from emp
    where deptno= 20 or deptno=30
    order by ename desc;    
/*
8. 사원의 급여가 2000에서 3000 사이이고 부서번호는 20,30
사원의 이름, 급여 , 부서번호 출력 이름순 (오름) 출력
*/
select ename,sal,deptno from emp
    where (sal between 2000 and 3000) and deptno in(20,30)
    order by ename asc;
--동일결과 출력
select ename,sal,deptno from emp
    where (sal between 2000 and 3000) and (deptno=20 or deptno=30)
    order by ename asc;
/*
9. 1981년도에 입사한 사원의 이름과 입사일 출력. like 및 wildcard사용
*/
select ename, hiredate from emp
    where hiredate like '81%';
    
/*
10.관리자가 없는 사원의 이름과 담당업무를 출력하시오.
*/
select ename, job from emp
    where mgr is null;
/*
11. 커미션을 받을 수 있는 자격이 되는 사원의 이름, 급여, 커미션을
출력하되 급여 및 커미션을 기준으로 내림차순하여 출력.
*/
select ename, sal, comm from emp
    WHERE COMM IS NOT NULL
    ORDER BY sal desc, comm desc;
/*
12.이름의 세번째 문자가 R인 사원의 이름을 표시하시오.
*/
select ename from emp
    where ename like '__R%';
/*
13. 이름에 A와 E를 모두 포함하고 있는 사원의 이름을 표시하시오.
*/
select ename from emp
    where ename like '%A%' and ename like '%E%';
/*
아래와 같은 경우 E 뒤에 A는 나오지 않음
*/
select ename from emp
    where ename like '%A%E%';
--//요렇게 쓰면 동일하다    
select ename from emp
    where ename like '%A%E%' or ename like '%E%A%';    
/*
14. 담당업무가  사무원(clerk) 이거나 또는 영업사원(salesman)이면서
급여가 1600, 900 , 1300이 아닌 사원의
이름, 담당업무, 급여를 출력하시오
*/
select ename, job, sal from emp
    where job in ('CLERK','SALESMAN') AND sal not in(1600,900,1300);
/*
15.comm이 500이상인 사원의 이름과 급여 및 커미션 출력
*/
select ename, sal, comm from emp
    where comm>=500;
    

    
        


