/**********************************
파일명: Or05String.sql
문자열 처리함수
설명: 문자열에 대해 대소문자를 변환하거나 문자열의 길이를 반환하는등
    문자열을 조작하는 함수
***********************************/
--HR계정

/*
concat(문자열1,문자열2)
    :문자열1과 문자열2를 연결해서 출력하는 함수
    사용법1 : select concat('문자열1','문자열2') from dual;
    사용법2 : select '문자열1' ||'문자열2'
    || <- vertical bar
*/
select concat('Good ' ,'morning') as "아침인사" from dual;
select concat('Good ' ,'morning') "아침인사" from dual;
select 'Good '||'morning' from dual;
select first_name||' '||last_name "Full name" from employees;

select 'Oracle ' ||'21C '||'Good..!!'  from dual;
--=> 위 SQL문을 concat()으로 변경
select concat(concat('Oracle ','21C '),'Good..!!')from dual;
--conacat은 두개밖에 합치질 못해서 명령어가 중복으로 나와야함

/*
시나리오] 사원테이블에서 사원의 이름을 연결해서 아래와 같이 출력하시오
    출력내용: first+last name, 급여, 부서번호
*/
-- step1 : 이름을 연결해서 출력하지만 띄어쓰기가 안돼서 가독성이 떨어진다.
select concat(first_name,last_name) Full_name,salary "급여",Department_id "부서번호"
from employees;
--step2 : 스페이스 추가를 위해 concat의 중복사용. 이름 사이에 공백을 포함해 줌.
select concat(concat(first_name,' '),last_name) as "Full name",salary "급여",Department_id "부서번호"
from employees;
--step3 : 2개의 함수를 사용하는 것보다 ||vertical bar를  이용하면 간결하게 표현된다.
--    또한컬럼명에는 alias를 이용하여 별칭을 부여한다.
select first_name||' '||last_name as Fullname,salary "급여",Department_id "부서번호"
from employees;

/*
initcap(문자열(
    :문자열의 첫문자만 대문자로 변환하는 함수.
    단, 첫문자를 인식하는 기준은 다음과 같다.
    -공백문자 다음에 나오는 첫문자를 대문자로 변환한다.
    -알파벳과 숫자를 제외한 나머지 문자 다음에 나오는 첫번재 문자를 대문자로 변환.
    -대문자로 있던건 소문자로 전환한다.
*/   
select initcap('hi hello 안녕mynameis nook') from dual;
--첫글자를 대문자로 변경.
select initcap('good/bad morning')from dual; --Good/Bad Morning
--슬래쉬 다음 문자도 대문자로 변경(슬래쉬도 공백처리)

select initcap('naver6say*good가bye') from dual; --Naver6say*Good가Bye
--한글, 특수문자 뒤의 영어가 대문자로 바뀜. 숫자뒤는 안바뀜.

/*
시나리오] 사원테이블에서 first_name이 john인 사원을 찾아 인출하시오.
*/
select * from employees where first_name = 'john'; --대소문자 구분해서 안나옴.
--이런 쿼리문(이와같이 쿼리하면) 작성시 결과가 나오지 않는다.
--따라서 함수 이용/대문자 포함한 이름을 사용해야 한다.
select * from employees where first_name = initcap('john');
select * from employees where first_name = 'John';

/*
대소문자 변경하기
lower() : 소문자로 변경함.
upper() : 대문자로 변경함.
*/
-- 위와같이 john을 검색하기 위해 다음과 같이 활용할 수도 있다.
-- 컬럼자체를 대문자 혹은 소문자로 변경한 후 쿼리한다.
select lower('Good'), upper('bad') from dual;
select * from employees where lower(first_name) = 'john';
select * from employees where upper(first_name) = 'JOHN';
select * from employees where initcap(upper(first_name)) = 'John';
select initcap('jOHN') from dual;

/*
lpad(),rpad() 
    : 문자열의 왼쪽, 오른쪽을 특정한 기호로 채울 때 사용한다.
    형식]  lpad('문자열', '전체자리수','채울문자열')
        => 전체자리수에서 문자열의 길이만큼을 채워주는 함수.
            rpad는 오른쪽을 채워줌.
*/    
select
    'good', lpad('good',7,'#'), rpad('good',7,'#'), lpad('good',7)
    -- [good]    [###good]          [good###]             [   good]
    from dual;
-- 열맞춤이 가능하고, 공백 혹은 문자를 죄다 채워넣을수 있다!
select rpad(first_name,10,'*') from employees;--긴사람 짤림
select rpad(first_name,12,'*') from employees;
--이름 전체로 12자로 간주하여 이름을 제외한 나머지 부분을 *로 채운다.
select rpad(first_name,12) , rpad(last_name,12) from employees;
select rpad(first_name,12) || rpad(last_name,12) as Fullname from employees;

/*
시나리오] 사원테이블의 first_name을 첫글자를 제외한 나머지 부분을 
    *로 마스킹 처리하는 쿼리문을 작성하시오.
*/
--substr(문자열 혹은 컬럼, 시작인덱스, 길이) : 시작인덱스부터 길이만큼 잘라낸다.
select substr('abcdefg',1,1) from dual; --시작 인덱스, 길이
select substr(first_name,1,1) from employees;
--문자열의 길이를 10으로 지정 후 남은 부분은 *로 채운다.
select rpad('Ellen',10,'*') from dual;
--length(문자열 혹은 컬럼명) : 해당 문자열의 길이를 반환한다.
select
    first_name, rpad(substr(first_name,1,1), length(first_name),'*')"마스킹"
    --length를 넣음으로써 스트링 길이만큼 *를 채울수 있다.
    from employees;

/*
trim() : 공백을 제거할 때 사용한다.
    형식] trim([leading | trailling | both] 제거할 문자
        - leading : 왼쪽에서 제거함
        - trailing : 오른쪽에서 제거함;
        - both : 양쪽에서 제거함. 설정값이 없으면 both가 default;
        [주의1] 양쪽 끝에 문자만 제거되고, 중간에 있는 문자는 제거되지 않는다.
        [주의2]  '문자'만 제거할 수 있고, '문자열'은 제거할 수 없다. 에러발생.
*/
select 
    ' 공백제거테스트 ' as trim1,
    trim(' 공백제거테스트    ') trim2, --양쪽의 공백 전부 제거됨
    trim('다' from '다람쥐가 나무를 탑니다') trim3, -- 양쪽의 '다'제거
    trim(both '다' from '다람쥐가 나무를 탑니다') trim4, --both가 default라 3,4같음
    trim(leading '다' from '다람쥐가 나무를 탑니다') trim5, --좌측만 사라짐
    trim(trailing '다' from '다람쥐가 나무를 탑니다') trim6 --우측만 사라짐
    from dual;
--trim()은 중간의 문자는 제거할 수 없고, 양쪽 끝의 문자만 제거할 수 있다.

select 
    trim('다람쥐' from '다람쥐가 나무를 탑다가 떨어졌어욤 ㅜㅜ') TrimError
from dual;
--trim()은 하나의 문자만 제거할수 있다. 문자열을 지우려하면 에러!
/*
ltrim(), rtrim() :L[eft]Trim, R[ight]Trim
    : 좌측, 우측 '문자' 혹은 '문자열'을 제거할 때 사용한다.
    *Trim은 문자열을 제거할 수 없지만, LTRiM, RTRIM은 문자열까지 제거할 수 있다.
*/
select 
    ltrim('    좌측공백제거  ') as ltrim,
    ltrim('    좌측공백제거  ','좌측') ltrim2, --좌측에 공백이 있으면 제거할수 없다.
    ltrim('좌측공백제거  ','좌측') ltrim3,
    ltrim('좌측공백제거  ') ltrim4,-- 제거할 공백이 없으면  그냥 둔다.
    rtrim('    우측공백제거','제거')rtrim1,
    rtrim('우측공백제거     ','제거')rtrim2,--우측에 공백이 있으면 제거할 수 없다.
    rtrim('우측공백제거','공백')rtrim2--중간 글자는 제거할 수 없다.
 from dual;   
/*
substr() : 문자열에서 시작인덱스부터 길이만큼 잘라서 문자열을 출력한다.
    형식] substr(컬럼, 시작인덱스, 길이)
    
    참고1] 오라클의 인덱스는 1부터 시작한다.
    참고2] '길이'에 해당하는 인자가 없으면 문자열의 끝까지를 의미한다.
    참고3] 시작인덱스가 음수면 우측끝부터 좌로 인덱스를 적용한다.
*/    
select substr('good morning john',8,4) from dual;
--8부터 시작해서 4개까지만 잘라옴. 결과:rnin
select substr('good morning john',8) from dual;
/*
replace() : 문자열을 다른 문자열로 대체할 때 사용된다.
    만약 공백으로 문자열을 대체한다면 문자열이 삭제되는 결과가 된다.
    형식] replace(컬럼명 또는 문자열, '변경할 대상의 문자' , '변경할 문자')
    
    *trim(),ltrim(),rtrim() 함수의 기능을 replace()함수 하나로 대체할 수 있다.
    trim()에 비해 replace()가 훨씬 더 사용빈도가 높다.
*/
--문자열 변경
select replace('good morning john','morning','evening') from dual;

select replace('good morning john','john','') replace from dual; --맨끝에 공백이 옴.
select trim(replace('good morning john','john','')) replace from dual;

select trim('   good morning john    ') "공백제거" from dual;
select replace('   good morning john    ','    ','') "공백제거" from dual;
select replace(' good morning john ',' ','') "공백제거" from dual;--공백전부제거

--102번 사원의 레코드를 대상으로 문자열 변경을 해보자.
select first_name, last_name, 
    ltrim(first_name, 'L')"좌측L제거",
    Rtrim(first_name, 'ex')"우측ex제거",
    replace(last_name, ' ','') "중간 공백제거",
    replace(last_name, 'De','Dea')"이름변경"
from employees
where employee_id = 102;
/*
instri() : 해당 문자열에서 특정문자가 위치한 인덱스값을 반환한다.
instring
    형식1] instr(컬럼명or문자열,'찾을문자') from dual;
        : 문자열의 처음부터 문자를 찾아서 인덱스값을 반환한다.
    형식2] instr(컬럼명or문자열,'찾을문자',탐색시작인덱스,몇번째 문자)
        : 탐색할 인덱스부터 문자를 찾는다. 단, 찾는 문자중 몇번째에 있는 문자인지
            지정할 수 있다.
        *탐색을 시작할 인덱스가 음수인 경우 우측에서 좌측으로 찾게된다.    
*/
SElect instr('good morning john','n')from dual;
--n이 발견된 첫번째 인덱스 반환
SElect instr('good morning john','n',1,2)from dual;
--1부터 검색하기 시작해서 n이 발견된 두번째에 있는 인덱스를 반환.
SElect instr('good morning john','h',8,1)from dual;
--인덱스 8부터 검색해서 h가 발견된 첫번째 인덱스(처음부터 cnt) 반환.



