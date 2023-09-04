/**********************************
파일명: Or06.sql
형변환 함수/ 기타함수
설명: 
***********************************/
--HR계정
/*
sysdate : 현재날짜와 시간을 초단위로 반환해준다. 
    주로 게시판이나 회원가입에서 새로운 게시물이 있을때 입력한 날짜를 표현하기위해 사용된다.
*/
select sysdate from dual;
/*
날짜포맷 : 오라클은 대소문자를 구분하지 않으므로, 서식문자 역시 구분하지 않는다.
따라서 mm과 MM은 동일한 결과를 출력한다.
*/
select to_char(sysdate,'yyyy/mm/dd') from dual;
select to_char(sysdate,'YY-MM-DD') from dual;

--현재 날짜를 "오늘은 0000년 00월 00일 입니다." 와 같은 형태로 출력하시오
select to_char(sysdate,'오늘은 yyyy년 MM월 dd일 입니다.') "과연될까?" from dual;
--에러발생. 날짜형식 부적합
select to_char(sysdate,'yyyy/MM//dd') "과연될까?" from dual;

/*
-(하이픈) /(슬러쉬) 외의 문자는 인식하지 못하므로 서식문자를 제외한 나머지 문자열을
"(더블쿼테이션)으로 묶어줘야한다. 서식문자를 감싸는게 아님에 주의해야 한다.
*/
select to_char(sysdate,'"오늘은 "yyyy"년 "MM"월 "DD"일 입니다"') "이게된다" from dual;

--요일이나 년도를 표현하는 서식문자들
select 
    to_char(sysdate,'day')"요일(화요일)",
    to_char(sysdate,'dy')"요일(화)",
    to_char(sysdate,'mon')" 월(6월)",
    to_char(sysdate,'mm')" 월(04)",
    to_char(sysdate,'month')" 월",
    to_char(sysdate,'yy')"두자리년도",
    to_char(sysdate,'dd')"일을 숫자로 표현",
    to_char(sysdate,'ddd')"1년중 몇번째일"
from dual;    
/*
시나리오] 사원테이블에서 사원의 입사일을 다음과 같이 출력할 수 있도록
    서석을 지정하여 쿼리문을 작성하시오.
        출력] 0000년 00월 00일 0요일
*/
select first_name,last_name, hire_date,
    to_char(hire_date,'yyyy"년 "mm"월 "dd"일 "day') "입사일"
 from employees;
 select first_name,last_name, hire_date,
    to_char(hire_date,'yyyy"년 "mm"월 "dd"일 "day') "입사일"
 from employees order by "입사일";
 /*
 시간 포맷 : 현재의 시간을 00:00:00 형태로 표시하기
    또는 날자와 시간을 동시에 표현할 수도 있다.
 */
 select
    to_char(sysdate,'HH:MI:SS'),
    to_char(sysdate,'hh:mi:ss'),
    to_char(sysdate,'hh24:mi:ss'),
    to_char(sysdate,'yyyy-mm-dd hh:mi:ss')
from dual;
--자바에서는 MM mm이 각각 월, 분으로 구분됐으나 sql은 대소문자 구분이 없으므로 분을 mi쓴다

/*
숫자포맷
    0: 숫자의 자리수를 나타내며 자리수가 맞지 않는 경우 0으로 자리를 채운다.
    9: 0과 동일하지만, 자리수가 맞지않는 경우 공백으로 채운다.
*/
select
    to_char(123,'0000'),    -- 남는 자리수앞에 0으로 채움
    to_char(123,'9999'),   -- 맨앞에 공백으로 채운후 연결
    trim(to_char(123,'9999')) --맨 앞의 공백이 제거됐다.
from dual;    

--숫자에 3자리마다 컴마(,)표시하기
/*
자리수가 확실히 보장된다면 0를 사용하고, 
자리수가 다른부분에서는 9를 사용하여 서식을 지정한다.
대신 공백은 trim()함수를 이용하여 제거하면 된다.
*/        
select  
    12345,
    to_char(12345,'000,000'),to_char(12345,'999,999'),
--    ltrim(to_char(12345,'999,999'),ltrim(to_char(12345,'990,000')),
    ltrim(to_char(12345,'999,999')), ltrim(to_char(12345,'990,000')) from dual;
-- 통화표시 : L => 각 나라에 맞는 통화표시. 우리나라는 원(윈도우 운영체제기반)
select to_char(1000000,'L9,999,000') from dual;
/*
숫자 변환 함수
    to_number() : 문자형데이터를 숫자형으로 변환한다.
*/    
--두개의 문자가 숫자로 변환되어 덧셈의 결과를 출력한다.
select to_number('123')+to_number('456') from dual; --바뀌어서 더해짐
select to_number('123a')+to_number('456') from dual;
-- 문자인데 숫자만 있는것만 바꿀수 있다.

/*
to_date()
    : 문자열 데이터를 날짜형식으로 변환해서 출력해준다.
        기본서식은 년/월/일 순으로 지정된다.
*/
select
    to_date('2023-06-16') "날짜 기본서식1",
    to_date('20230616') "날짜 기본서식2",
    to_date('2023/06/16') "날짜 기본서식3"
    
from dual;
--내부에 적당한 문자열 날짜 를 입력하면 기본서식으로 변경됌.
--select to_char(yyyy-mm-dd, from hire_date) from employees;
/*
퀴즈] '2023-06-16 14:16:21' 와 같은 형태의 문자열을 날짜로 인식할 수 있도록
쿼리문을 작성하시오
*/
--날짜 서식을 인식하지 못하므로 에러가 발생한다.
select to_date('2023-06-16 14:16:21') from dual;
--방법1. 문자열을 잘라서 사용한다.
select to_date(substr('2023-06-16',1,10) )from dual;
--문자열을 위와 같이 수정한다면 날짜서식으로 인식할 수 있다.
--select to_date(substr(1,10))||' '||to_date(substr(11,20)) "문자열 자르기" from dual;
--방법2 : 날짜와 시간 서식을 활용한다.
select 
    to_date('2023-06-16 14:26:21','yyyy-mm-dd hh24:mi:ss') from dual;
    --년월일 형태가 아니면 서식을 다 넣어줘야 하는데 일까지밖에 안나옴.
/*
퀴즈] 문자열 '2021/05/05' 는 어떤요일인지 변환함수를 통해 출력.
 단 , 문자열은 임의로 변경할 수 없다.
 */
 select 
    to_date('2021/12/25') "1단계: 날짜서식확인",
    to_char(sysdate,'day') "2단계: 요일서식확인",
    to_char(to_date('2021/12/25'),'day') "3단계: 조합"
    from dual;
/*
퀴즈2] 문자열 '2021년01월01일'은 어떤 요일인지 변환함수를 통해 출력.
    단, 문자열은 임의로 변경불가
*/
select 
--    to_date('2021년01월01일','yyyy"년"mm"월"dd"일"') from dual;
    to_char(to_date('2021년01월01일','yyyy"년"mm"월"dd"일"'),'day')
from dual;
/*
nul() : null값을 다른 데이터로 변경하는 함수
    형식] nul(컬럼명, 대체할 값)
*/
---null값은 별도의 처리가 필요하다
select salary+commission_pct from employees;
--null이있는곳과 합치면 null이 되어버림.
select first_name, commission_pct, salary+nvl(commission_pct,0)
from employees;
--null값을 0으로 바꿔준뒤 사칙연사.

/*
decode() : java의 switch문과 비슷하게 특정값에 해당하는 출력문이 있는경우 사용.
    형식] decode(컬럼명,
                값1, 결과1,
                값2, 결과2, 값3,결과3 .....
                기본값)
    *내부적인 코드값을 문자열로 변환하여 출력할 때 많이 사용한다.
*/
select
    first_name, last_name, department_id, 
    decode (department_id, 
            10,'Administration', 
            20,'Marketing',
            30,'Purchasing',
            40,'Human Resources',
            50,'Shipping',
            60,'IT',
            70,'Public Relations',
            80,'Sales',
            90,'Executive',
            100,'Finance',
            110,'Accounting','부서명 확인안됌') as  Department_name from employees;    
/*
case() : java의 if~else문과 비슷한 역할을 하는 함수
    형식] case when 조건1 then 값1
                when 조건2 then 값2
                ///
                else 기본값
            end
*/
/*
시나리오] 사원테이블에서 각 부서번호에 해당하는 부서명을 출력하는 쿼리 by case
*/
select first_name,last_name,department_id,
    case
        /*when 조건 then 값*/
        when department_id = 10 then 'administration'   --경영관리팀
        when department_id = 20 then 'Marketing'        --마케팅팀
        when department_id = 30 then 'Purchasing'       --구매팀
        when department_id = 40 then 'Human Resources'  --인사팀
        when department_id = 50 then 'Shipping'         --물류팀
        when department_id = 60 then 'IT'               --IT
        when department_id = 70 then 'Public Relations' --홍보팀
        when department_id = 80 then 'Sales'            --영업팀
        when department_id = 90 then 'Executive'        --경영
        when department_id = 100 then 'Finance'         --재무
        when department_id = 110 then 'Accounting'      --회계팀
        else'부서명 없음'
    end team_name
    from employees
    order by team_name asc;
/****************************
연습문제
******************************************************/
--scott계정에서 진행됩니다.
/*
1. substr()함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력하시오.
*/
select * from emp;
select
    ename,
    substr(hiredate,1,5)"입사년월2"
from emp;
--2. substr()함수 이용하여 4월에 입사한 사원 출력
--연도무상관.
select * from emp
--where substr(hiredate,4,2)=04; 동일
where substr(hiredate,4,2)='04';
--where to_char(hiredate,dd)=04;   
   
--   3. mod(0함수를 사용하여 사원번호가 짝수인 사람만 출력해라

select * from emp where mod(empno,2)=0;--mod == %in java;
-- 입사일을 연도는 2자리yy,월은 숫자mon으로 표시하고 오일은 약어dy로 출력
select hiredate,
    to_char(hiredate,'yy')"입사년도",
    to_char(hiredate,'mon')"입사월",
    to_char(hiredate,'dy')"입사요일"
from emp;    
select to_char(hiredate,'yy') || ' '||
    to_char(hiredate,'mon')|| ' '||
    to_char(hiredate,'dy') "입사년,월, 요일"
from emp;    

/*
5. 올해 며칠이 지났는지 출력하시오. 현재 날짜에서 올해 1우러1일을 뺀 결과를 출력.
to_date를 사용하여 데이터 형을 일치시켜라.
단, 날짜의 형태는' 01-01-2020' 으로 한다.
wmr sysdate - '01-01-2020'이와 같은 연산이 가능해야 한다.
*/
--sysdate - to_date('01-01-2023) 이와같이 하면 에러가 납니다.
select
    trunc(sysdate - to_date('23/01/01')) "기본날짜 서식사용",
    to_date('01-01-2023','dd-mm-yyyy') "날짜 서식적용",
    trunc(sysdate - to_date('01-01-2023','dd-mm-yyyy')) "날짜 연산"
from dual;    
/*
6. 사원들의 매니저 사번을 출력하되 상관이 없는 사원에 대해서는 
null값 대신 0값을 출력하시오
*/

select ename, nvl(Mgr,0)"매니저 사번" from emp;

/*
7.decode함수로 직급에 따라 급여를 인상해라.
clerk는 200 salseman 은 180 mgr은 150 president는 100
*/
select ename,sal, JOB,
    decode(job,
            'CLERK', sal+200,
            UPPER('salesman'),sal+180,
            'MANAGER', SAL+150,
            'PRESIDENT', SAL+100,
            SAL)
            "인상된 급여"
FROM EMP            
ORDER BY JOB, SAL; 
            
   
   
   
   
   
   
   
   
   
   
   
   
    