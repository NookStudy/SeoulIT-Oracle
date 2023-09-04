/******************************************************************************
파일명: Or17PLSQL.sql
PL/SQL
설명: 오라클에서 제공하는 프로그래밍 언어
*******************************************************************************/
--hr계정에서 진행합니다.
/*
PL/SQL(procedure Language)
    : 일반 프로그래밍 언어에서 가지고 있는 요소를 모두 가지고 있으며 DB업무를
     처리하기 위해 최적화된 언어이다.
*/
--예제1] PL/SQL 맛보기
--화면상에 내용을 출력하고 싶을때 on으로 설정. off일때는 출력되지 않는다.
set serveroutput on;

declare--선언부 주로 변수선언
    cnt number;--숫자타입 변수 선언.
begin--실행부: begin~end절 사이에서 실행. 자바의 메인
    cnt :=10;
    cnt := cnt +1;
    dbms_output.put_line(cnt); --java의 println과 동일하다.
end;
/
/*
 PL/SQL 문장의 끝에는 /를 붙여야 하는데, 만약 없으면
호스트 환경으로 빠져나오지 못한다.
 즉, PL/SQL 문장을 위해 필요하다.
 호스트 환경이란 쿼리문을 입력하기 위한 SQL상태를 말한다.
*/

--예제2] 일반변수 및 into
/*
시나리오] 사원테이블에서 사원번호가 120인 사원의 이름과 연락처를 출력하는
    PL/SQL문을 작성하시오.
*/
select * from employees where employee_id=120;

select concat(first_name||' ',lastname), phone_number
from employees where employee_id =120;

declare
--    empName varchar2(50);
    empName varchar2(60);
    empPhone varchar2(30);
    /*
    선언부에서 변수를 선언할 때는 테이블 생성시와 동일하게 선언한다.
    => 변수명 자료형(크기)
    단, 기존에 생성된 컬럼의 타입과 크기를 참조하여 선언해주는것이 좋다.
     아래 '이름' 의 경우 두개의 컬럼이 합쳐진 상태이므로 조금 더 넉넉한 크기로
    설정해 주는것이 좋다.
    */
begin
    /*
    실행부 :  select 절에서 가져온 결과를 선언부에서 선언한 변수에
    1:1로 대입하여 값을 저장한다. 이 때 into를 사용한다.
    */
    select
        concat(concat(first_name,' '),last_name),
        phone_number
    into
        empName, empPhone
    from employees
    where employee_id=120;
    
    dbms_output.put_line(empName||' '||empPhone);
end;
/

--예제3] 참조변수1(하나의 컬럼 참조)
/*
    참조변수 : 특정 테이블의 컬럼을 참조하는 변수로써 동일한 자료형과 크기로
        선언하고 싶을 때 사용한다.
      형식] 테이블명.컬럼명%type
        => 테이블의 '하나'의 컬럼만 참조한다.
*/
/*
시나리오] 부서번호 10사원의 사원번호,급여,부서번호를 가져와서 아래변수에 대입후
화면상에 출력하는 PL/SQL문을 작성하시오. 
    단, 변수는 기존테이블의 자료형을참조하는 '참조변수'로 선언하시오
*/
--시나리오의 조건에 맞는 select 문을 작성해서 확인
select employee_id,salary, department_id from employees
    where department_id=10;
    
declare
    --사원테이블의 특정 컬러의 타입과 크기를 그대로 참조하는 변수로 선언한다.
    empNo employees.employee_id%type;   --number(6,0)
    empSal employees.salary%type;       --number(8,2)
    deptID employees.department_id%type;--number(4,0)
begin
    --select의 결과는 into를 통해서 선언한 변수에 할당한다.
    select employee_id, salary, department_id
        into empNo, empSal, deptId
    from employees
    where department_id=10;
    
    dbms_output.put_line(empNo||' '||EMPSal||' '||deptID);--출력
end;
/

--예제4] 참조변수2 (전체컬럼을 참조)
/*
시나리오] 사원번호가 100인 사원의 레코드를 가져와서 emp_row변수에 
    전체 컬럼을 저장한 후 화면에 다음 정보를 출력하시오.
  단, emp_row는 사원테이블이 전체컬럼의 저장할 수 있는 참조변수로 선언해야한다.
  출력정보 : 사원번호, 이름, 이메일, 급여
*/

select employee_id, first_name, email, salary from employees where employee_id=100;

declare
    /*
    사원테이블 전체 컬럼을 참조하는 참조변수를 선언한다.
    이 때 테이블명 뒤에 %rowtype을 붙여 선언한다.
    */
    emp_row employees%rowtype;
begin 
    /*
    와일드 카드 *를 통해 얻어온 전체컬럼을 변수 emp_row에 한꺼번에 저장한다.
    */
    select *
        into emp_row
        from employees where employee_id=100;
    
  --emp_row 에는 전체컬럼의 정보가 저장되므로 출력시 변수명.컬럼명 형태로 기술.
        
    dbms_output.put_line(emp_row.employee_id||' '||
                        emp_row.first_name||' '||   
                        emp_row.email||' '||
                        emp_row.salary);
end;
/

--예제5] 복합변수
/*
복합변수 
    : class를 정의하듯 필요한 자료형을 묶어 하나의 자료형을 만든 후 
        생성하는 변수를 말한다.
    형식]
        type 복합변수자료형 is record(
            컬럼명1 자료형(크기),
            컬럼명2 테이블명.컬럼명%type
        );
    앞에서 선언한 자료형을 기반으로 변수를 생성한다.
    복합변수 자료형을 만들 때는 일반변수와 참조변수 2가지를 복합해서 사용가능.
*/
/*
시나리오] 사원번호, 이름(first_name+last_name), 담당업무명을 저장할 수 있는 
복합변수를 선언한 후, 100번 사원의 정보를 출력하는 PL/SQL을 작성하시오.
*/
select employee_id, first_name||' '||last_name, job_id
from employees where employee_id =100;

declare
    --3개의 타입을 저장할수 있는 복합변수 선언
    type emp_3type is record(
    emp_id employees.employee_id%type,
    emp_name varchar2(50),
    emp_job employees.job_id%type
    );
    /*앞에서 선언한 복합변수 자료형을 통해 서언한 복합변수로 3개의 값을
    저장할 수 잇따. */
    record3 emp_3type; --메소드마냥 이름지정"반드시 필요"
begin
    select employee_id, first_name||' '||last_name, job_id
        into record3
    from employees where employee_id=100;
    dbms_output.put_line(record3.emp_id||' '||
                        record3.emp_name||' '||   
                        record3.emp_job);
end;
/

/*
연습문제
아래 절차에 따라 PL/SQL문을 작성하시오.
1.복합변수생성
    - 참조테이블 : employees
    - 복합변수자료형의 이름 : empTypes
            멤버1 : emp_id -> 사원번호
            멤버2 : emp_name -> 사원의전체이름(이름+성)
            멤버3 : emp_salary -> 급여
            멤버4 : emp_percent -> 보너스율
    위에서 생성한 자료형을 이용하여 복합변수 rec2를 생성후 
    사원번호 100번의 정보를 할당한다.
 2.1의 내용을 출력한다.
3.위 내용을 완료한후 치환연산자를 사용하여 
    사원번호를 사용자로부터 입력받은 후 
    해당 사원의 정보를 출력할수있도록 수정하시오.[보류]
*/
declare
    type empTypes is record(
    emp_id employees.employee_id%type,
    emp_name varchar2(50),
    emp_salary employees.salary%type,
    emp_percent employees.commission_pct%type
    );
    rec2 empTypes;
begin
    select employee_id,first_name||' '||last_name, 
        salary,nvl(commission_pct,0)
        INTO REC2
    FROM EMPLOYEES  WHERE employee_id=100;  
        dbms_output.put_line('사원번호/사원명/급여/보너스율');
        dbms_output.put_line(rec2.emp_id||' '||
                            rec2.emp_name||' '||
                            rec2.emp_salary||' '||
                            rec2.emp_percent);
end;
/

/*
치환연산자 : PL/SQL문에서 사용자로부터 데이터를 입력받을 때 사용하는 연산자로
변수앞에 &를 붙여주면된다. 실행시 입력창이 뜬다.
*/
--앞에서 작성한 PL/SQL을 치환연산자를 적용하여 수정해 본다.

declare
    type empTypes is record(
    emp_id employees.employee_id%type,
    emp_name varchar2(50),
    emp_salary employees.salary%type,
    emp_percent employees.commission_pct%type
    );
    --복합변수 자료형을 통해 변수 생성.
    rec2 empTypes;
    --치환연산자를 통해 입력받은 값을 할당하여 변수 선언.
    inputNum number(3);
begin
    select employee_id,first_name||' '||last_name, 
        salary,nvl(commission_pct,0)
        INTO REC2
    FROM EMPLOYEES  WHERE employee_id=&inputNum; --&연산자와 변수명으로 입력받음. 
        dbms_output.put_line('사원번호/사원명/급여/보너스율');
        dbms_output.put_line(rec2.emp_id||' '||
                            rec2.emp_name||' '||
                            rec2.emp_salary||' '||
                            rec2.emp_percent);
end;
/


/*
바인드 변수
    : 호스트 환경에서 선언된 변수로써  비 PL/SQL변수이다.
    호스트환경이란 PL/SQL의 블럭을 제외한 나머지 부분을 말한다.
    콘솔(cmd창)에서는 SQL> 명령프롬프트가 있는 상태를 말한다.
*/
set serveroutput on;
--호스트환경에서 바인드 변수 선언
var return_var number;
--PL/SQL작성
declare
    --선언부는 이와같이 공백일수도 있음
begin
    --바인드 변수는 일반변수와의 구분을 위해 :(콜론)을 추가해야 한다.
    :return_var :=999;
    dbms_output.put_line(:return_var);
end;
/
--호스트환경에서 출력시에는 print를 사용한다.
--만약 출력이 안된다면 cmd에서 확인해보면 정상적으로 출력된다.
print return_var;

/*
시나리오] 변수에 저장된 숫자가 홀수 or 짝수인지 판단하는 PL/SQL을 작성하시오
*/
--if문 : 홀수와 짝수를 판단하는 if문 작성
declare
    --선언부에서 숫자타입 변수 선언
    num number;
begin
    num :=10;
    --10을 할당한 후 짝수인지 판단한다.
    if mod(num,2)=0 then
    --mod(변수,정수) : 변수를 정수로 나눈 나머지를 반환하는 정수
        dbms_output.put_line(num||'은 짝수');
    else 
        dbms_output.put_line(num||'은 홀수');
    end if;
end;
/
--퀴즈]위 예제를 치환연산자를 통해 숫자를 입력받을수 있도록 수정하시오         
declare
    --선언부에서 숫자타입 변수 선언
    num number;
begin
/*
치환 연산자는 선언부, 실행부 어디서든 사용할 수 있다.
**/
    num := &num;
    --10을 할당한 후 짝수인지 판단한다.
    if mod(num,2)=0 then
    --mod(변수,정수) : 변수를 정수로 나눈 나머지를 반환하는 정수
        dbms_output.put_line(num||'은 짝수');
    else 
        dbms_output.put_line(num||'은 홀수');
    end if;
end;
/        

--예제8] 제어문(조건문: if-elseif)
/*
시나리오] 사원번호를 사용자로부터 입력받은 후 해당 사원이 어떤부서에서
근무하는지를 출력하는 PL/SQL문을 작성하시오. 단, if~elsif문을 사용하여
구현하시오.
*/
declare  
    --치환연산자를 통해 사원번호를 입력받음
    emp_id employees.employee_id%type := &emp_id;
    emp_name varchar2(50);
    emp_dept employees.department_id%type;
    dept_name varchar2(30) := '부서정보없음';
    --부서명은 선언과 동시에 초기화한다. 일치하는 정보가 없는경우
    --초기값으로 출력된다.
begin
    select employee_id, last_name, department_id
        into emp_id,emp_name,emp_dept
    from employees
    where employee_id = emp_id; -- 입력받은 사원번호를 쿼리에 적용
    /*
    여러개의 조건을 사용할 경우 java와 같이 else if를 사용하지 않고
    elsif로 기술해야 한다. 또한 중괄호 대신 then과 end if;가 사용된다.
    */
    if emp_dept = 50 then
        dept_name := 'Shipping';
    elsif emp_dept = 60 then
        dept_name := 'IT';
    elsif emp_dept = 70 then
        dept_name := 'Public Relations';
     elsif emp_dept = 80 then
        dept_name := 'Sales';
     elsif emp_dept = 90 then
        dept_name := 'Executive';
      elsif emp_dept = 100 then
        dept_name := 'Finance';
     end if;
     
     dbms_output.put_line('사원번호'||emp_id||'의 정보');
     dbms_output.put_line('이름:'||emp_name||', 부서번호:'||emp_dept
                            ||', 부서명:'||dept_name);
end;
/
 
/*
case문 : java switch 문과 비슷한 조건문
    형식]
        case 변수
            when 값1 then '할당값1'
            when 값2 then '할당값2'
            when 값4 then '할당값3'..
            ...값N
        end;    
**/        
/*
예제9] 제어문(조건문 : case~when)
시나리오] 앞에서 if~elsif로 작성한 PL/SQL문을 case~when문으로 변경하시오.
*/        
declare  
    emp_id employees.employee_id%type := &emp_id;
    emp_name varchar2(50);
    emp_dept employees.department_id%type;
    dept_name varchar2(30) := '부서정보없음';
begin
    select employee_id, last_name, department_id
        into emp_id,emp_name,emp_dept
    from employees
    where employee_id = emp_id;        
    /*
    case~when문이 if문과 다른점은 할당한 변수를 먼저 선언한 후 문장내에서
    조건을 기술하지 않기 때문이다.------------보고치자..----------
    */           
    dept_name :=
        case emp_dept
            when 50 then 'Shipping'
            when 60 then 'IT'
            when 70 then 'Public Relations'
            when 80 then 'Salse'
            when 90 then 'Executive'
            when 100 then 'Finance'
        end;
        
      dbms_output.put_line('사원번호'||emp_id||'의 정보');
      dbms_output.put_line('이름:'||emp_name||', 부서번호:'||emp_dept
                            ||', 부서명:'||dept_name);  
                            
end;
/


-------------------------------------------------------------------------
--제어문(반복문)
/*
반복문1 : Basic Loop
    java의 do~while문과 같이 조건체크없이 loop진입한 후 탈출조건이 될때까지
    반복한다. 탈출시에는 exit를 사용한다.
*/    
--예제10] 제어문(반복문 : basic loop)    

declare
    num number := 0;
begin
    --조건 체크없이 루프로 진입한다.
    loop
        --0~10까지 출력한다.
        dbms_output.put_line(num);
        --증가연산자 복합입연산자가 없으므로 일반적인 방식으로
        --변수를 증가시켜야 한다.
        num := num+1;
        -- num이 10을 초과하면 loop문을 탈출한다.
        --exit는 자바의 break; 와 동일한 역할을 수행한다.
        exit when (num>10);
    end loop;
end;
/

--예제11] 제어문(반복문 : basic loop)
/*
시나리오] Basic loop문으로 
    1부터 10까지의 정수의 합을 구하는 프로그램을 작성하시오.
*/
DECLARE
    i      NUMBER := 1;
        --반복변수
    sumNum NUMBER := 0;
        --누적합
        --변수명으로 sum 사용 불가. 그룹함수라 사용불가.

BEGIN
    LOOP
        sumnum := sumnum + i;
        --i만큼씩 증가
        i := i + 1;
        --1만큼씩 증가
        EXIT WHEN ( i > 10 );
        --i가 10 넘어가면 탈출
    END LOOP;
    dbms_output.put_line('1~10까지의 합은:' || sumnum);
END;
/
/*
반복문2 : while문
    Basic Loop와는 다르게 조건을 먼저 확인한 후 실행한다.
    즉, 조건에 맞지 않는다면 한번도 실행되지 않을 수 있다.
    반복의 조건이 있으므로 특별한 경우아니라면  exit를 사용하지 않아도 된다.
*/        
--예제12] 제어문(반복문 : while)
DECLARE
    num1 NUMBER := 0;
BEGIN
    WHILE num1 < 11 LOOP
        dbms_output.put_line('이번숫자는:' || num1);
        num1 := num1 + 1;
    END LOOP;
END;
/

--   예제13] 제어문(반복문 : while) 
/*
시나리오] while loop문으로 다음과 같은 결과를 출력하시오.
*
**
***
****
*****
*/
DECLARE
    --*을 누적해서 연결할 문자형 변수 선언
    starstr VARCHAR2(100);
    i       NUMBER := 1;
    --반복을 위한 변수 선언
--    j       NUMBER := 1;
BEGIN
    WHILE i <= 5 LOOP
--        WHILE j <= 5 LOOP
            starstr := starstr || '*';
--            EXIT WHEN ( j <= i );
--            j := j + 1;
            i:= i+1;
        dbms_output.put_line(starstr);

        END LOOP;

--        i := i + 1;
--        j := j + 1;
--    END LOOP;
END;
/

--예제14] 제어문(반복문 : while) 
/*
시나리오] while loop문으로 
    1부터 10까지의 정수의 합을 구하는 프로그램을 작성하시오. 
*/
declare 
    i number := 1;
    sumNum number := 0;
begin
    while i<=10 loop
        sumnum := sumNum+ i;
        i:=i+1;
        end loop;
        --별다른 EXIT없어도 알아서 탈출
        dbms_output.put_line('1~10까지의 합은:' || sumnum);
end;
/
/*
반복문 FOR
    : 반복의 횟수를 지정하여 사용하는 반복문.
    반복변수를 별도로 선언하지 않아도 도니다.
    따라서 별 이유가 없으면 선언부(DECLARE)를 기술하지 않아도 된다.
*/
--예제15] 제어문(반복문 : for) 
DECLARE BEGIN
    FOR num2 IN 0..10 LOOP
        dbms_output.put_line('for문 짱인듯:' || num2);
    END LOOP;
END;
/

BEGIN
    FOR num2 IN REVERSE 0..10 LOOP
        dbms_output.put_line('for문 짱인듯:' || num2);
    END LOOP;
END;
/        

-- 예제16] 제어문(반복문:FOR)
/*
연습문제] FOR LOOP 문으로  구구단을 출력하는 프로그램을 작성하시오
*/
begin
    for dan in 2..9 loop
        dbms_output.put_line(dan|| '단');
        --라벨 출력
        for su in 1..9 loop
        dbms_output.put_line(dan||'*'||su||su||'='||(dan*su));
        --구구단을 즉시 출력하고 줄바꿈 처리
        end loop;
    end loop;
end;
/
DECLARE
-- prinf가 없으므로 Str을 새로 지정해줘서 printf의 역할을 대신해야 한다.
--구구단에서 하나의 phrase(x*y=z)를 저장하기 위한 str.
    gugustr VARCHAR2(1000);
BEGIN
    FOR dan IN 2..9 LOOP
        FOR su IN 1..9 LOOP
        --누적해서 연결
            gugustr := gugustr
                       || dan|| '*'|| su || '='|| ( dan * su ) || ' ';
        END LOOP;
        dbms_output.put_line(gugustr);
        gugustr := '';
    END LOOP;
END;
/
/*
커서(Cursor)
    : select 문장에 의해 여러행이 반환되는 경우 각 행에 접근하기 위한 반복개체
    선언 방법]  
        Cursor 커서명 IS
            select 쿼리문. 단 into절이 없는 형태로 기술한다.
        
    Open Cursor
      :쿼리를 수행하라는 의미. 
        즉, Open할때 Cursor선언시의 select문장이 실행되어 결과셋을 얻게된다.
        Cursor는 그 결과셋의 첫번째 행에 위치하게 된다.
    Fetch ~ into~ 
      : 결과셋에 하나의 행을 읽어들이는 작업으로 결과셋의 인출(Fetch)후에
        Curosor는 다음행으로 이동한다.
    Close Cursor    
      : 커서 닫기로 결과셋의 자원을 반납한다.
         select 문자이 모두 처리된 후 Cursor를 닫아준다.
    
    Cursor의 속성
        %Found : 가장 최근에 인출(Fetch)이 행을 Return하면 true 아니면 false.
        %NotFound : %Found의 반대의 값을 반환한다.    
        %RowCount : 지금까지 Return된 행의 갯수를 반환한다.
*/
--예제17] Cursor
/*
시나리오] 부서테이블의 레코드를 Cursor를 통해 출력하는 PL/SQL문을 작성하시오.
*/
declare 
--한줄을 통째로 받는 V_dept 선언
    v_dept departments%rowtype;
    /*
    커서선언 : 부서테이블의 모든 레코드를 조회하는 select문으로 
        into절이 없는 형태로 기술한다.
        쿼리의 실행결과 cur1에 저장된다.
    */    
    cursor cur1 is
        select department_id, department_name, location_id
        from departments;
begin
    /*
    해당 쿼리문을 수행해서 결과셋(ResultSet)을 가져온다. 
    결과셋이란 쿼리(질의)문을 수행한 후 반환되는 레코드의 결과를 말한다.
    */
    open cur1;
    --basic 루프문으로 얻어온 결과셋의 갯수만큼 반복하여 인출한다.
    loop
        fetch cur1 into
            --fetch한 결과는 참조변수에 각각 저장한다.
            --fetch문 자체가 하나의 행을 읽으면 다음행으로 커서가 이동함.
            v_dept.department_id,
            v_dept.department_name,
            v_dept.location_id;
        
        exit when cur1%notfound;
        
        dbms_output.put_line(v_dept.department_id||' '||
                                v_dept.department_name||' '||
                                v_dept.location_id);
    end loop;
    dbms_output.put_line('인출된 행의 갯수:'||cur1%rowcount);
    close cur1;
    --커서의 자원반납(다 삭제)
end;
/
 
--예제18] Cursor
/*
시나리오] Cursor를 사용하여 사원테이블에서 
        커미션이 null이 아닌 사원의 사원번호, 이름, 급여를 출력하시오. 
        출력시에는 이름의 오름차순으로 정렬하시오.
*/
select * from employees where commission_pct is not null;

declare 
    cursor curEMp is
        select employee_id, last_name, salary
        from employees
        where commission_pct is not null
        order by last_name asc;
        --사원테이븕의 전체컬럼을 참조하는 참조변수 선언
    varEmp employees%rowType;
begin
    open curEmp;
    
    loop 
        fetch curemp 
            into varemp.employee_id, varemp.last_name, varemp.salary;
        --인출할 결과셋이 없으면 루프문 탈출
        exit when curemp%notfound;
        dbms_output.put_line(varemp.employee_id||' '||
                                varemp.last_name||' '||
                                varemp.salary);
        end loop;
       dbms_output.put_line('인출된 행의 갯수:'||curemp%rowcount);--행 수 비교
    close curemp;
    --커서닫기
end;
/
/*
컬렉션(배열)
    :일반 프로그래밍 언어에서 사용하는 배열타입을 
       PL/SQL에서는 테이블타입이이라고 한다.
     1,2차원 배열을 생각해보면 테이블(표)와 같은 형태이기 때문이다.
종류
    -연관배열
    -Varray
    -중첩테이블
1. 연관배열(Associative Array)
    : key와 Value의 한쌍으로 구성된 컬렉션으로 JAVA의 해시맵과 같은 개념이다.
    KEY : 자료형은 주로 숫자를 사용한다. 
        binary_interfrt, pls_interger를 주로 사용하는데 
         number타입보다 크기는 작지만, 산술연산에 빠른 특징을 가진다.
    Value : 문장형을 주로 사용하고 varchar2를 쓰면 된다.
    
    형식] 
        Type 연관배열자료형 is 
            TABLE of 값의 타입
            index by 키의 타입;
*/
--예제19] 연관배열(Associative Array)
/*
시나리오] 다음의 조건에 맞는 연관배열을 생성한 후 값을 할당하시오.
    연관배열 자료형 명 : avType, 값의자료형:문자형, 키의자료형:문자형
    key : girl, boy
    value : 트와이스, 방탄소년단
    변수명 : var_array
*/
declare
    type avtype is  --avtype 이라는 연관배열(맵) 생성
        table of varchar2(30) --value의 type 선언
        index by varchar2(10); -- key의 type 선언
    var_array avtype; --연관배열 변수 var_array 선언
begin
    var_array('girl') := '트와이스';
    var_array('boy') := '방탄소년단';
    
    dbms_output.put_line(var_array('girl'));
    dbms_output.put_line(var_array('boy'));
end;
/


--예제20] 연관배열(Associative Array)
/*
시나리오] 100번 부서에 근무하는 사원의 이름을 저장하는 연관배열을 생성하시오.   
key는 숫자, value는 full_name 으로 지정하시오.
*/
select * from employees where department_id=100;

--fullname을 위한 쿼리
select first_name||' '|| last_name
    from employees where department_id=100;
---문제의 조건을 통한 쿼리에서 다수행이 인출되었으므로 cursor를 사용한다.
declare
        --커서 생성
    cursor emp_cur is
        select first_name||' '|| last_name from employees
        where department_id=100;
     --연관배열 자료형 생성(KEY : 숫자 , value : 문자)   
    Type nameAvtype is
        table of varchar2(30)
        index by binary_integer;
    --자료형 기반으로 변수생성
    names_arr nameavtype;
    --사원의 이름과 인덱스로 사용할 변수생성
    fname varchar2(50);
    idx number :=1;
    
begin
    --커서 오픈후 쿼리문을 실행하여  결과셋 갯수만큼 반복하여 사원명 인출
    open emp_cur;
    loop
        fetch emp_cur into fname;
        --인출내용이 없으면 loop 탈출
        exit when emp_cur%notfound;
        --연관배열 변수에 사람이름을 입력
        names_arr(idx) := fname;
        --키로 사용될 인덱스를 증가시킨다.
        idx := idx+1;
    end Loop;
    close emp_cur;
    
    --연관배열. count : 연관베열에 저장된 원소의 갯수를 반환한다.
    for i in 1.. names_arr.count loop
        dbms_output.put_line(names_arr(i));
    end loop;
end;
/
/*
--예제21] VArray(Variable Array)
    : 고정길이를 가진 배열로써 
    일반 프로그래밍 언어에서 사용하는 배열과 동일하다.
     크기에 제한이 있어서 선언할 때 크기(원소의 갯수)를 지정하면
    이보다 큰 배열로 만들 수 없다.
    형식] 
        Type 배열타입명 IS
            array(배열크기) of 값의 타입;

*/
declare
    --Varray 타입선언: 크기는 5, 저장할 테이터는 문자형
    type vaType is
        array(5) of varchar2(20);--크기5, 문자타입
    v_arr vaType; --array 변수지정(add나 put같은 메소드가 읎다)
    cnt number := 0;
begin
    --생성자를 통한 값의 초기화. 총 개중 3개만 할당
    v_arr := vatype('First','second','third','','');
    --Basic 루프문을 통해 배열의 원소를 출력한다.(*인덱스는1부터 시작한다.)
    loop
        cnt := cnt+1;
        --탈출조건은 where대신 if를 사용할 수도 있다.
        if cnt>5 then
            exit;
        end if; 
        -- 배열처럼 인덱스를 통해 출력한다.
        dbms_output.put_line(v_arr(cnt));
    end loop;    
    --배열의 원소 재할당
    v_arr(3) := '우리는';--덧씌워짐
    v_arr(4) := 'JAVA';
    v_arr(5) := '개발자다';
    
    -- for 루프문으로 출력한다.
    for i in 1..5 loop
        dbms_output.put_line(v_arr(i));
    end loop;
end;
/

--예제22]  VArray(Variable Array)
/*
시나리오] 100번 부서에 근무하는 사원의 사원번호를 인출하여 VArray에 저장한 후
    출력하는 PL/SQL을 작성하시오.
*/
 select * from employees where department_id = 100;
 
 declare
    --VArray 자료형 선언. 배열에 저장될 값은 사원아이디,컬럼을 참조하여 생성
    type vatype1 is
        array(6) of employees.employee_id%type;
    --배열 변수 선언 및 생성자를 통한 초기화를 진행한다.    
    va_one vatype1 := vatype1('','','','','','');
    cnt number :=1;
begin
    /*
    JAVA의 개선된 for문과 비슷하게 
    쿼리의 결과셋 갯수만큼 자동으로 반복하는 형태로 사용.
    select 절의 employee_id가 변수 i에 할당되고 이를 통해 인출할 수 있다.
    */
    for i in (select employee_id from employees
        where department_id=100)
    loop
        va_one(cnt) := i.employee_id;
        cnt := cnt+1;
    end loop;
    
    --배열의 크기만큼 반복하여 각 원소를 인출한다.
    for j in 1..va_one.count loop
        dbms_output.put_line(va_one(j));
    end loop;
end;
/
/*
3. 중첩 테이블(Nested table)
    :Varray와 비슷한 구조의 배열로써 배열의 크기를 명시하지 않으므로
    종적으로 배열의 크기가 설정된다. 여기서 말하는 테이블은 자료가 저장되는
    실제 테이블이 아니라 컬렉션의 한 종류를 의미한다.
    형식] type 중첩테이블 is
            table of 값의 타입;
*/

--예제23] 중첩테이블(Nested Table) 
declare
    --중첩테이블의 자료형을 생성한 후 변수 선언
    type nttype is
        table of varchar2(30);
    nt_array nttype;
begin
    --생성자를 통해 값을 할당한다. 이 때 크기 4인 중첩테이블이 생성된다.
    nt_array :=nttype('첫번째','두번째','세번째','');
    
    dbms_output.put_line(nt_array(1));
    dbms_output.put_line(nt_array(2));
    dbms_output.put_line(nt_array(3));
    nt_array(4) := '네번째값할당';
    dbms_output.put_line(nt_array(4));
    --에러발생. 첨자가 갯수를 넘었습니다.(자동으로 확장되지 않는다.)
    nt_array(5) := '다섯번째값???할당??';
    
    --크기를 확장했을 때 생성자를 통해 배열의 크기를 동적으로 확장한다.
    --크기가 7인 중첩테이블로 확장된다.
    nt_array := nttype('1a','2b','3c','4d','5e','6f','7g');
    
    for i in 1..7 loop
        dbms_output.put_line(nt_array(i));
    end loop;
end;
/

--예제24] 중첩테이블(Nested Table) 
/*
시나리오] 중첩테이블과 for문을 통해 
    사원테이블의 전체 레코드의 사원번호와 이름을 출력하시오.
*/
select employee_id, first_name from employees;

declare
    /*
    중첩테이블의 자료형 선언 및 변수선언 
        -사원테이블 전체 컬럼을 참조하는 참조변수의 형태이므로
        하나의 레코드를 저장할 수 있는 상태로 선언된다.
        
    */
    type nttype is
        table of employees%rowtype;
    nt_array nttype;
begin
    nt_array :=nttype();
        /*
        사원테이블의 레코드 수 만큼 반복하면서 레코드를 하니씩 변수 rec에
        저장한다. 커서처럼 동작하는 for문의 형태로 JAVa의 확장 for문처럼
        사용할 수 있다.
        */
    for rec in(select * from employees) loop
        --중첩테이블의 끝부분을 확장하면서 null을 삽입한다.
        nt_array.extend;
        --마지막 인덱스값을 가져온후 마지막인덱스까지 루프한다.
        nt_array(nt_array.last) := rec;
    end loop;
    
    for i in nt_array.first..nt_array.last loop
    
        dbms_output.put_line(nt_array(i).employee_id||'>'
                            ||nt_array(i).first_name);
    end loop;
    dbms_output.put_line(nt_array.count||'개의 행');
end;
/

