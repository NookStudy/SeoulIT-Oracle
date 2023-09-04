/******************************************************************************
파일명: Or11join.sql
테이블 조인
설명: 두개 이상의 테이블을 동시에 참조하여 
        데이터를 가져와야 할 때 사용하는 SQL문
*******************************************************************************/
--HR계정
/***
1] inner join (내부조인)
    -가장 많이 사용되는 조인문으로 테이블간에 연결조건을 모두 만족하는
    레코드를 검색할 때 사용한다.
    - 일반적으로 기본키(Primary key)와 외래키(foreign key)를 사용하여 
    join하는 경우가 대부분이다.
    -두개의 테이블에 이름의 컬럼이 존재하면 "테이블명.컬럼명"형태로 기술.
    -별칭을 쓰면 "별칭.컬럼명" 형태로 기술가능.
    
형식1(표준방식)
    select 컬럼1,컬럼2,...
    from 테이블1 inner join 테이블2
        on 테이블1.기본키컬럼 = 테이블2. 외래키컬럼
    where 조건1 and 조건2...;    
**/
/*
시나리오] 사원테이블과 부서테이블을 조인하여 각 직원이 
    어떤부서에서 근무하는지 출력하시오. 단 표준방식으로 작성.
    출력결과 : 사원아이디, 이름1, 이름2, 이메일, 부서번호, 부서명
*/
desc employees;
--첫번째 쿼리문은 에러가 발생한다.
/*
ORA-00918 : 열의 정의가 애매합니다.
00918.00000 - "column ambigously defined"
department_id는 join한 양쪽 테이블에 존재하는 컬럼이므로
어떤 테이블에서 가져와 출력할지 결정해야 된다.
*/
select 
    employee_id, first_name, last_name, email, department_id, department_name
from 
    employees inner join departments
ON
    Employees.department_id = departments.department_id;
    --열의 정의가 애매한 경우 컬럼앞에 테이블명을 추가한다.
--ANSI표준이라 돌아가지 않는다! 가 아니라 컬럼기준이 애매해서 에러.
select 
    employee_id, first_name, last_name, email, 
    employees.department_id,  --clarify
    department_name
from 
    employees inner join departments
ON
    Employees.department_id = departments.department_id;    
--열의 테이블명을 적확히 해줌.    
    
--as(알리아스)를 통해 테이블에 별칭부여 후 쿼리문 간소화.
select 
    employee_id, first_name, last_name, email, 
    emp.department_id,  --clarify
    department_name
from 
    employees emp inner join departments dep
ON
    Emp.department_id = dep.department_id;
/*
실행 결과에서는 소속된 부서가 없는 1명을 제외한 나머지 모두가 출력됨.
즉, inner join은 조인한 테이블에서 양쪽모두 만족되는 레코드만 가져오게 됨.
*/
select 
    employee_id, first_name, last_name, email, 
    emp.department_id,  --clarify
    department_name
from 
    employees emp full outer join departments dep
ON
    Emp.department_id = dep.department_id
where dep.department_id is not null; --or  dep.department_id is null;

--3개 이상의 테이블 조인하기
/*
시나리오] seattle에 위치한 부서에서 근무하는 직원의 정보를 출력하는 쿼리문 작성.
    단 표준방식으로.
    출력결과] 사원이름, 이메일, 부서아이디, 부서명, 담당업무아이디,
        담당업무명, 근무지역
    위 출력결과는 다음 테이블에 존재한다. 
    사원테이블 : 사원이름, 이메일, 부서아이디, 담당업무아이디
    부서테이블 : 부서아이디(참조), 부서명, 지역일련번호(참조), etc
    담당업무테이블 : 담당업무명, 담당업무아이디(참조),etc
    지역 테이블 : 지역일련번호(참조),  근무부서, etc
    */
--1.지역 테이블을 통해 레코드 확인하기 -> 지역일련번호 1700확인
select *from locations where lower(city)='seattle';
--2. 지역 일련번호를 기준으로 부서테이블과 연계
select * from departments where location_id =1700;
--3. 부서 일련번호를 통해 사원테이블의 레코드 확인하기 ->6명 확인
select * from employees where department_id=30;
--4. 직원별 담당업무 확인하기
select * from jobs where job_id='PU_MAN';
select * from jobs where job_id='PU_CLERK';

select dep.location_id, first_name, email, dep.department_id, 
    department_name, emp.job_id, job_title, city, state_province
from locations L 
    inner join departments dep on L.location_id=dep.location_id
    inner join employees emp on dep.department_id=emp.department_id
    inner join jobs J on emp.job_id=J.job_id
where lower(city) = 'seattle';    --lower를 박아주자...Seattle임

/*
형식2] 오라클 방식
    select 컬럼1, 컬럼2,....
    from 테이블1, 테이블2...
    where 테이블1.기본키컬럼=테이블2.외래키컬럼
        and 조건1 and 조건2....
*/
/*
시나리오]사원테이블과 부서테이블을 조인하여 각 직원이 
    어떤부서에서 근무하는지 출력하시오. 단 오라클방식으로 작성.
    출력결과 : 사원아이디, 이름1, 이름2, 이메일, 부서번호, 부서명
*/

select employee_id, first_name, last_name , email, 
    emp.department_id as D_ID, department_name
from employees emp, departments dep
--where emp.department_id = dep.department_id;
Where Emp.Department_Id= Dep.Department_Id;
/*
시나리오] seattle에 위치한 부서에서 근무하는 직원의 정보를 출력하는 쿼리문 작성.
    단 오라클방식으로.
    출력결과] 사원이름, 이메일, 부서아이디, 부서명, 담당업무아이디,
        담당업무명, 근무지역
    위 출력결과는 다음 테이블에 존재한다. 
    사원테이블 : 사원이름, 이메일, 부서아이디, 담당업무아이디
    부서테이블 : 부서아이디(참조), 부서명, 지역일련번호(참조), etc
    담당업무테이블 : 담당업무명, 담당업무아이디(참조),etc
    지역 테이블 : 지역일련번호(참조),  근무부서, etc
*/
select first_name, email, E.department_id, department_name, 
    J.job_id, job_title, city, state_province
from locations L, departments D, employees E, jobs J
where L.location_id=D.location_id and
    D.department_id = E.department_id and
    J.job_id = E.job_id and
    city=initcap('seattle');
/*
2] outer join(외부조인)
   -outer join 은 inner join과는 달리 
      두 테이블에 조인조건이 정확히 일치하지 않아도 기준이 되는 테이블에서
      레코드를 인출하는 join방식이다.
   -outer join을 사용할 때는 반드시 outer 전에 기준이 되는 테이블을 결정하고
      쿼리문을 작성해야 한다.
    -> left(왼쪽 테이블), right(오른쪽 테이블), full(양쪽 테이블)

형식 1(표준방식)
    select 컬럼1, 컬럼2,...
    from 테이블 1 
            left[right,full] outer join 테이블2
                on 테이블1.기본키 = 테이블2.외래키
    where 조건1 and 조건2 or....
*/    
/*
시나리오] 전체직원의 사원번호, 이름, 부서아이디, 부서명, 지역을 
    외부조인 left를 통해 출력하시오
*/          
--실행결과를 보면 inner join 과는 다르게 107개가 인출됨.
--부서가 미지정된 사원가지 인출되기 때문인데, 이때 레코드에 부서아이디가 없으므로
--null값이 출력된다.
select employee_id, first_name, emp.department_id , department_name, city
    from employees  emp
        right outer join departments dep
            on emp.department_id=dep.department_id
--        left outer join locations L
        left outer join locations L
            on dep.location_id = L.location_id;
    --employees를 기준으로 left면 emplyee, right면 right옆테이블을 기준으로 
    --  밖쪽으로 색칠된 영역이다.
/*
형식2 (오라클방식)
    select 컬럼1, 컬럼2,....
    from 테이블1, 테이블2
    where
        테이블1.기본키=테이블2.참조키(+)
        and 조건1 or 조건2 ...;
=>오라클 방식으로 변경시에는 outer join 연산자인(+)를 붙여준다.
=> 위의경우 왼쪽 테이블이 기준이된다.
=> 기준이 되는 테이블을 변경할때는 테이블의 위치를 옮겨준다.
    (+)를 옮기지 않는다.
*/
select emplyee_id, first_name, E.department_id, department_name, city
from Employees E, departments D, locations L
where
    E.department_id= D.department_id(+)
    D.location_id = L.location_id (+) ;
/*
연습문제] 2007년 입사사원 조회. 단, 부서에 배치되지않았으면 <부서없음 출력>
단, 표준방식으로 작성.
출력 : 사번, 이름, 성, 부서명
*/
select employee_id, first_name, last_name, nvl(department_name,'부서없음')
from employees E
    left outer join departments D
        on E.department_id = D.department_id
where to_char(hire_date,'yyyy') = 2007;        

--현재 데이터 확인
select first_name,hire_date,to_char(hire_date,'yyyy') from employees;
--07년 입사사원 인출
--방법1: like를 이용하여 07로 시작하는 레코드 인출
select first_name,hire_date from employees where hire_date like'07%';
--방법2: to_char로 날짜서식 만든후 레코드 출력
select first_name,hire_date from employees where to_char(hire_date,'yyyy')='2007';
--외부조인
select employee_id, first_name, last_name, nvl(E.department_id,'<부서 없음>')
from employees E
    left outer join departments D 
        on E.department_id = D.department_id
where to_char(hire_date,'yyyy')=2007;

select employee_id, first_name, last_name, nvl(department_name,'부서없음')
from employees E
    left outer join departments D
        on E.department_id = D.department_id
where to_char(hire_date,'yyyy') = 2007; 


/*
연습문제] 2007년 입사사원 조회. 단, 부서에 배치되지않았으면 <부서없음 출력>
단, 오라클방식로 작성.
출력 : 사번, 이름, 성, 부서명
*/
select employee_id, first_name, last_name, nvl(department_name,'부서없음')
from employees E, departments D
where E.department_id = D.department_id (+)  and
    to_char(hire_date,'yyyy') = 2007; 

/*
셀프 조인.
형식]
select
    별칭1. 컬럼, 별칭2.컬럼...
from 
    테이블A 별칭1, 테이블A 별칭2
where
    별칭1.컬럼=별칭2.컬럼;
*/        

/*
시나리오] 사원테이블에서 각 사원이 매니저 아이디와 매니저이름을 출력하시오.
단, 이름은 first_name 과 last_name을 하나로 연결해서 출력.
*/
/*
여기서는 사원입장ㅇ의 테이블 empClerk와 매니저입장의 테이블 empManager를
별칭으로 생성한 후 where절에 셀프조인 조건을 기술한다.
매니저도 사원이기 때문에 
사원입장의  매니저아이디는 매니져입장에서는 사원아이디가 된다.
*/
select 
    empClerk.employee_id "사원번호", 
    concat(empClerk.first_name||' ', empClerk.last_name) "사원이름",
    empManager.employee_id "매니저사원번호", 
    empManager.first_name||' '|| empManager.last_name "매니저이름"
from
    employees empClerk, employees empManager
where
--    empClerk.manager_id=empManager.employee_id;
    empClerk.manager_id=empManager.employee_id;
    
    
--Nook 한명의 매니저가 몇명을 데리고 있는지 알고싶음.
select 
    count(empClerk.first_name) "매니저 밑 인원수",
    empManager.employee_id "매니저사원번호", 
    empManager.first_name||' '|| empManager.last_name "매니저이름"
from
    employees empClerk, employees empManager
where
    empClerk.manager_id=empManager.employee_id
group by empManager.manager_id    ;


    
    
/*
시나리오] self join을 사용하여 "Kimberely/ Grant " 사원보다 
    입사일이 늦은 사원의 이름과 입사일 출력
    출력목록 : first_name,last_name,hire_date
*/
--1.kimberely 정보확인
select * from employees where upper(first_name) = 'KIMBERELY';
--2. 07/05/24 이후 입사한 사원의 레코드 출력
select * from employees where hire_date > '07/05/24' order by hire_date asc;
--3. self join으로 쿼리문 합치기
select
    Clerk.first_name,Clerk.last_name, Clerk.hire_date
from employees Kimberely, employees Clerk 
where
    Kimberely.hire_date <= Clerk.hire_date
     and  Kimberely.first_name='Kimberely' --and Kimberely.last_name ='Grant'
     --킴벌리가 두명이면 라스트네임도 확장해주어야 함.
     --킴벌리를 정의함... 뭐이리 복잡해;
    order by hire_date;
    
/*
using : join문에서 주로 사용하는 on절을 대체할 수 있는 문장
    형식] on 테이블1.컬럼 = 테이블2.컬럼
    ==> using(컬럼)
*/
/*
시나리오] seattle에 위치한 부서에서 근무하는 직원의 정보를 출력하는 쿼리문작성.
단, using 사용할 것.
*/
select location_id, first_name, email, department_id, 
    department_name, job_id, job_title, city, state_province
from locations L 
    inner join departments  using(location_id)
    inner join employees  using(department_id)
    inner join jobs  using(job_id)
where lower(city) = 'seattle';

--using 절에서는 select 절에 테이블에 별칭을 붙이면 오류
--using절에 사용된 컬럼은 양쪽의 테이블에 동시에 존재하는 컬럼이라는 것을전제.
-- 알아서 결정함.
-- 결론:using은 테이블의 별칭 및 on절을 제거. simple하게 join쿼리문작성가능.

/*
퀴즈]2005년 입사사원들중 California(State_province)/
    south san Francisco(city)에서 근무하는 사원들의 정보를 출력.
    단, 표준방식과 using사용
    
    출력결과] 사원번호, 이름, 성, 급여, 부서명, 국가코드, 국가명(country_name),
        급여는 3자리마다 컴마표시
        참고] 국가명은 countries에 있다.
*/

------------------------------------------------Nook 출력결과조건 보기전
select * 
from employees
    inner join departments using (department_id)
    inner join locations using(location_id)
where lower(state_province) = 'california' and 
        lower(city) = 'south san francisco'and
        to_char(hire_date,'yyyy')=2005;
----------------------------------------------------Nook 출력결과조건 확인후
select employee_id, first_name,last_name,
    '  '||trim(to_char(salary,'999,999,990')),
    department_name, country_id,  country_name 
from employees
    inner join departments using (department_id)
    inner join locations using(location_id)
    inner join countries using(country_id)
where lower(state_province) = 'california' and 
        lower(city) = 'south san francisco'and
        to_char(hire_date,'yyyy')=2005;
----------------------------------------------------



--1.2005년 입사자
select first_name, hire_date,substr(hire_date,1,2) from employees;
select * from employees where substr(hire_date,1,2)=05 ;
--2.south san francisco에 위치한 부서확인
select * from locations where city='South San Francisco';
        --location_id 1500인것 확인
select * from departments where location_id =1500;
        --department_id 가 50인 것을 확인
--3. 위에서 확인한 정보를 토대로 쿼리문 작성
Select * 
from 
    employees 
where 
    department_id=50 and
    substr(hire_date,1,2)='05';
--50번 부서(Shipping)에서 근무하면서 입사년이 2005년인 사원 추출 : 12명
--4.join 쿼리문 작성하기
select 
    employee_id, first_name||' '||last_name "name", 
    ' '|| trim(to_char(salary,'$990,000'))as"salary",
    ' '||department_name"dep_name",' '||country_id"countryid", country_name
from employees
    inner join departments using(department_id)
    inner join locations using(location_id)
    inner join countries using(country_id)
where 
    substr(hire_date,1,2)=05 and 
    lower(city)= 'south san francisco' and     
    lower(state_province) ='california';
-------------------------------------------------------연습문제
---------------------------------------------------
---------연습문제
/*
1. inner join 방식중 오라클방식을 사용하여 first_name 이 Janette 인 
사원의 부서ID와 부서명을 출력하시오.
출력목록] 부서ID, 부서명
*/
select E.department_id, department_name 
from employees  E
    inner join departments D on E.department_id = D.department_id
where lower(first_name) = 'janette'    ;
    


/*
2. inner join 방식중 SQL표준 방식을 사용하여 사원이름과 함께 그 사원이 
소속된 부서명과 도시명을 출력하시오
출력목록] 사원이름, 부서명, 도시명
*/
select first_name||' '||last_name "name" , E.department_id, city
from employees E
    inner join departments D on E.department_id= D.department_id
    inner join locations L on D.location_id = L.location_id;    


/*
3. 사원의 이름(FIRST_NAME)에 'A'가 포함된 모든사원의 이름과 부서명을 
출력하시오.
출력목록] 사원이름, 부서명
*/ 
select first_name, department_name
from employees 
    inner join departments using (department_id)
where first_name like '%A%';    


/*
4. “city : Toronto / state_province : Ontario” 에서 근무하는 모든 
사원의 이름, 업무명, 부서번호 및 부서명을 출력하시오.
출력목록] 이름, 업무명, 부서ID, 부서명
*/
select first_name , job_title, department_id, department_name
from employees
    inner join departments using(department_id)
    inner join locations using(location_id)
    inner join jobs using(job_id)
where lower(city) = 'toronto' and lower(state_province) ='ontario';

/*
5. Equi Join을 사용하여 커미션(COMMISSION_PCT)을 받는 모든 
사원의 이름, 부서명, 도시명을 출력하시오. 
출력목록] 사원이름, 부서ID, 부서명, 도시명
*/
select first_name,department_id, department_name, city
from employees
    inner join departments using(department_id)
    inner join locations using(location_id)
    where commission_pct is not null;

/*
6. inner join과 using 연산자를 사용하여 50번 부서(DEPARTMENT_ID)에 
속하는 모든 담당업무(JOB_ID)의 고유목록(distinct)을 부서의 도시명(CITY)을 
포함하여 출력하시오.
출력목록] 담당업무ID, 부서ID, 부서명, 도시명
*/
--using은 조인할 두개의 테이블에 동일한 이름의 컬럼이 있는것을 감안하고 
--사용하므로 테이블의 별칭을 사용하지 않는다.
select distinct job_id,department_id,department_name,city
from employees
    inner join departments using(department_id)
    inner join locations using(location_id)
where department_id =50;    

/*
7. 담당업무ID가 FI_ACCOUNT인 사원들의 메니져는 누구인지 출력하시오. 
단, 레코드가 중복된다면 중복을 제거하시오. 
출력목록] 이름, 성, 담당업무ID, 급여
*/

select distinct man.first_name, man.last_name, emp.job_id, man.salary
from employees emp , employees man, jobs J
where emp.manager_id = man.employee_id and emp.job_id = J.job_id
    and J.job_id = 'FI_ACCOUNT';
    
    


/*
8. 각 부서의 메니져가 누구인지 출력하시오. 출력결과는 부서번호를 
오름차순 정렬하시오.
출력목록] 부서번호, 부서명, 이름, 성, 급여, 담당업무ID
※ departments 테이블에 각 부서의 메니져가 있습니다.
*/

select emp.department_id, --emp.department_name, 
    mg.first_name,mg.last_name, mg.salary,
    distinct mg.job_id
from employees emp
    inner join employees mg on emp.manager_id = mg.employee_id
--    inner join departments D on D.department_id = emp.department_id
--group by emp.job_id
order by emp.department_id asc;
    


/*
9. 담당업무명이 Sales Manager인 사원들의 입사년도와 
입사년도(hire_date)별 평균 급여를 출력하시오. 출력시 년도를 기준으로 
오름차순 정렬하시오. 
출력항목 : 입사년도, 평균급여
*/
select to_char(hire_date,'YYYY') "입사년도",
    to_char(avg(salary),'$999,999')"평균급여"
    from employees
    group by to_char(hire_date,'YYYY')
    order by "입사년도";
