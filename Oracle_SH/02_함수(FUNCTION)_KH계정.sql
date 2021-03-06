
/*
    < 함수 RUNCTION >
    컬럼값을 읽어서 계산한 결과를 반환
    
    - 단일행 함수 : N개의 값을 읽어서 N개의 결과를 리턴
    - 그룹 함수   : N개의 값을 읽어서 1개의 결과를 리턴
    
    * SELECT 절에 단일행함수와 그룹함수를 함께 사용 못함 : 결과 행의 개수가 다름
    
    * 함수를 기술할 수 있는 위치 : SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING 절
*/

----------------------------- < 단일행 함수 > --------------------------------------

/*
    < 문자 관련 함수 >
    
    * LENGTH / LENGTHB      => 결과값 NUMBER
    
    LENGTH(컬럼|'문자값') : 글자 개수 반환
    LENGTHB(컬럼|'문자값') : 글자의 바이트수 반환
    
    '강' '나' 한글 한글자 => 3BYTE
    영문자, 숫자 특수문자 한글자 => 1BYTE
    
*/
-- 한글은 한 글자당 3BYTE
-- 영문자는 한 문자당 1BYTE
SELECT LENGTH('오라클'), LENGTHB('오라클') 
FROM DUAL; -- 가상테이블 (DUMMY TABLE)

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL), 
       EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)  
FROM EMPLOYEE;

-------------------------------------------------------------------------

/*
    *INSTR
    지정한 위치부터 지정한 숫자번째로 나타내는 문자의 시작 위치 반환
    자바와 다르게 숫자가 1부터 시작
    
    INSTR(컬럼명|'문자값', '문자', [찾을 위치의 시작 값, 순번])       => 결과값 NUMBER
    
    찾을 위치의 시작값
    1 : 앞에서부터 찾겠다
    -1 : 뒤에서부터 찾겠다
    
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;    -- 3 번째 자리 B
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 3 번째 자리 B
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;-- 10 번째 자리 B
SELECT INSTR('AABAACAABBAA', 'B', 1, 3) FROM DUAL; -- 앞에서부터 3번째 해당하는 B의 위치
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL,'@') "@위치", INSTR(EMAIL, 'S', 1, 21 )
FROM EMPLOYEE;

-----------------------------------------------------------------

/*
    SUBSTR
    문자열에서 지정한 위치부터 지정한 개수 만큼의 문자열을 추춯해서 반환
    (자바에서의 SUBSTRING(START, END) 와 유하
    SUBSTR(STRING, POSITION, [LENGTH])      => 결과값이 CHARACTER
    STRING : 문자타입 컬럼 또는 '문자값'
    POSITION : 문자열을 잘라낼 시작위치
    LENGTH : 추출할 문자 개수 (생략시 끝까지 의미)
*/

SELECT SUBSTR('SHOWMETHEMONEY' , 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY' , 5, 2) FROM DUAL; 
SELECT SUBSTR('SHOWMETHEMONEY' , 1, 6) FROM DUAL; 
SELECT SUBSTR('SHOWMETHEMONEY' , -8, 3) FROM DUAL;
SELECT SUBSTR('쇼우 미 더 머니', 2, 5) FROM DUAL;

-- 주민번호에서 성별에 나타내는 부분만 잘라보기
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1)
FROM EMPLOYEE;

-- 남자사원만 조회
SELECT EMP_NAME, '남' 성별
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1';

-- 여자사원만 조회
SELECT EMP_NAME, '여' 성별
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2';

-- 함수 중첩사용
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) 아이디
FROM EMPLOYEE;

--------------------------------------------------------------------------

/*
    * LPAD(LEFT) / RPAD(RIGHT)
    문자에 대해 통일감있게 보여주고자 할 때 사용
    
    LPAD/RPAD(STRING, 최종적으로 반환할 문자의 길이(바이트), [덧붙이고자하는 문자])
    => 결과값 CHARACTER
    
    제시한 문자열에 임의의 문자를 왼쪽 또는 오른쪽에 덧붙여 최종 N길이만큼의 문자열을 반환
    덧붙이고자 하는 문자 생략시 공백으로 처리
*/
-- 20만큼의 길이 중 EMAIL값은 오른쪽 정렬하고 공백을 왼쪽으로 채우겠다.
SELECT LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 891201-2******   => 총글자수 : 14글자
SELECT RPAD('891201-2', 14, '*')
FROM DUAL;

-- 주민번호 첫 번째자리부터 성별까지를 추출한 결과값에 오른쪽에 * 문자 채워서 최종적으로 14글자 반환
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') 주민등록번호 
FROM EMPLOYEE;

-----------------------------------------------------------------------------

/*
    * LTRIM / RTRIM
    
    LTRIM / RTRIM(STRING, [제거하고자 하는 문자들])       => 결과값 CHARACTER
    
    문자열의 왼쪽 혹은 오른쪽에서 제거하고자하는 문자들을 찾아서 제거한 나머지를 반환
    
*/
SELECT LTRIM('   KH') FROM DUAL;    -- 제거하고자하는 문자 생략시 기본값이 공백. 
                                    -- LTRIM이므로 왼쪽은 다 지워주고 공백이 아닌 곳이 나오면 그 이후로 공백 나와도 안지워줌
SELECT LTRIM('000123456','0') FROM DUAL; -- 왼쪽의 0지워줘 / 123456이 나옴
SELECT LTRIM('123123KH123','123') FROM DUAL; -- 1,2,3이 아닌 문자가 나온 이후로는 지워주지 않음
                                             -- KH123 이 나옴/ 제시된 숫자 다 지워줌
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL; -- 제시한 문자 다 지워줌 / KH가 나옴
SELECT LTRIM('5782KH123', '0123456789') FROM DUAL; -- 숫자 다 제시해주면 제시한 숫자가 아닌 부분 나온 후로는 안지워짐
                                                   -- KH123 이 나옴
                                                   
SELECT RTRIM('K H    ', ' ') FROM DUAL; -- K H
SELECT RTRIM('0012300456000','0') FROM DUAL; -- 0012300456

---------------------------------------------------------------------------------

/*
    * TRIM
    문자열의 앞/뒤/양쪽에 있는 지정한 문자를 제거한 나머지를 반환
*/
-- 기본적으로는 양쪽에 있는 문자 제거
SELECT TRIM('   K H   ') FROM DUAL; -- 제거하고자 하는 문자 생략
-- SELECT TRIM('ZZZKHZZZ','Z') FROM DUAL; -- 오류
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL; -- KH 제거할 문자 앞에 먼저 제시
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- LEADING : 앞 / 앞에있는 Z지우자
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- TRAILING : 뒤
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- 기본값

-- TRIM([[LEADING) TRAILING|BOTH] 제거하고자하는 문자 FROM ] STRIMG)

----------------------------------------------------------------------

/*
    * LOWER / UPPER / INITCAP
    
    LOWER : 다 소문자로
    UPPER : 다 대문자로
    INITCAP : 앞글자만 대문자로
    
    LOWER/UPPER/INITCAP(STRING)     => 결과값 CHARACTER
*/

SELECT LOWER('Welcome To My World!') FROM DUAL;
SELECT UPPER('Welcome To My World!') FROM DUAL;
SELECT INITCAP('welcome to myworld!') FROM DUAL; -- 공백기준 바로 뒤 단어 대문자로

------------------------------------------------------------------------------

/*
    * CONCAT
    문자열 두개 전달받아 하나로 합친 후 결과 반환
    
    CONCAT(STRING, STRING)          => 결과값 CHARACTER
*/

SELECT CONCAT('가나다라', 'ABCD') FROM DUAL;
SELECT '가나다라' || 'ABCD' FROM DUAL; -- 연결연산자랑 동일한 내용 수행

----------------------------------------------------------------------

/*
    * REPLACE
    
    REPLACE(STRING, STR1, STR2) ==> 결과값 CHARACTER
    STRING에서 STR1을 STR2로 변경
*/
SELECT REPLACE('서울시 강남구 역삼동', '역삼', '삼성') FROM DUAL;

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
FROM EMPLOYEE;

------------------------------------------------------------------------

/*
    < 숫자 관련 함수 >
    
    * ABS
    절대값 구하는 함수
    
    ABS(NUMBER)         => 결과값 NUMBER
    
*/
SELECT ABS(-10.9) FROM DUAL;
SELECT ABS(-10) FROM DUAL;

---------------------------------------------------------------------------

/*
    * MOD 
    두 수를 나눈 나머지를 반환해주는 함수
    
    MOD(NUMBER, NUMBER) ==> 결과값 NUMBER
*/
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(-10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;
SELECT MOD(-10.9, 3) FROM DUAL;

---------------------------------------------------------------------
/*
    * ROUND
    반올림 해주는 함수
    
    ROUND(NUMBER, [위치])     => 결과값 NUMBER
*/
SELECT ROUND(123.456) FROM DUAL; -- 위치 지정 안하면 0으로 해준거와 똑같다
SELECT ROUND(123.456, 0) FROM DUAL; -- 123
SELECT ROUND(123.456, 1) FROM DUAL; -- 123.5 반올림함
SELECT ROUND(123.456, 2) FROM DUAL; -- 123.46
SELECT ROUND(123.456, 4) FROM DUAL; -- 123.456 없는 값 제시하면 원래 값 나옴
SELECT ROUND(123.456, -1) FROM DUAL; -- 120
SELECT ROUND(123.456, -2) FROM DUAL; -- 100

----------------------------------------------------------------

/*
    * CEIL
    올림처리해주는 함수
    
    CEIL(NUMBER)
*/
SELECT CEIL(123.456) FROM DUAL; -- 무조건 올림

----------------------------------------------------------------
/*
    *FLOOR
    소수점 아래 버림하는 함수
    
    FLOOR(NUMBER)
*/
SELECT FLOOR(123.456) FROM DUAL; -- 123
SELECT FLOOR(123.987) FROM DUAL; -- 123
---------------------------------------------------------------------

/*
    * TRUNC
    위치 지정가능한 버림처리해주는 함수
    
    TRUNC(NUMBER, [위치])
*/
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;

-------------------------------------------------------------------

/*
    < 날짜 관련 함수 >
*/

-- * SYSDATE : 시스템 날짜 반환(오늘날짜)
SELECT SYSDATE FROM DUAL;

-- * MONTHS_BETWEEN(DATE1, DATE2) : 두 날짜 사이의 개월 수 --> DATE1-DATE2
--  => 결과값 NUMBER
-- EMPLOYEE 테이블에서 직원명, 입사일, 근무개월수
SELECT EMP_NAME, HIRE_DATE, CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))||'개월차' 근무개월수
FROM EMPLOYEE;

-- * ADD_MONTHS(DATE, NUMBER) : 특정 날짜에 해당 숫자만큼의 개월수를 더해서 그 날짜를 리턴
--   => 결과값 DATE
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- EMPLOYEE 테이블에서 직원명, 입사일, 입사 후 6개월이 된 날짜 조회
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;

-- * NEXT_DAY(DATE, 요일(문자|숫자)) : 특정날짜에서 구하려는 요일의 가장 가까운 날짜를 반환해주는 함수
--   => 결과값 DATE
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 5) FROM DUAL; -- 1: 일요일, 2: 월요일.... 7: 토요일
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL; -- 에러(현재 언어가 KOREAN)이기 때문

-- 언어변경
ALTER SESSION SET NLS_LANGUAGE = KOREAN; -- AMERICAN

-- * LAST_DAY(DATE) : 해당 월의 마지막 날짜를 구해서 반환
--   => 결과값 DATE
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE 테이블에서 직원명, 입사일, 입사월의 마지막 날짜 조회
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;

/*
    * EXTRACT : 년도, 월, 일 정보를 추출해서 반환
    
    EXTRACT(YEAR FROM DATE) : 년도만 추출
    EXTRACT(MONTH FROM DATE) : 월만 추출
    EXTRACT(DAY FRM DATE) : 일만 추출
*/

-- EMPLOYEE 테이블에서 직원명, 입사년도, 입사월, 입사일 조회
SELECT EMP_NAME, 
       EXTRACT(YEAR FROM HIRE_DATE) 입사년도,
       EXTRACT(MONTH FROM HIRE_DATE) 입사월,
       EXTRACT(DAY FROM HIRE_DATE) 입사일
FROM EMPLOYEE
ORDER BY 입사년도, 입사월, 입사일;

-- 날짜 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
ALTER SESSION SET NLS_DATE_FORMAT='RR/MM/DD'; -- YY는 현재 21세기이고 RR은 유도리있음

SELECT SYSDATE FROM DUAL;

--------------------------------------------------------------------------

/*
    < 형변환 함수 >
    
    * 숫자/날짜     --> 문자로 변환
    
    TO_CHAR(날짜|숫자, [포맷]) : 날짜형 또는 숫자형 데이터를 문자타입으로 변환
    
*/

-- 숫자 --> 문자
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 5칸짜리 공간확보, 오른쪽정렬, 빈칸을 공백으로 채운다(9의 의미)
SELECT TO_CHAR(1234,'00000') FROM DUAL; -- 5칸짜리 공간확보, 오른쪽정렬, 빈칸은 0으로 채워줌
SELECT TO_CHAR(1234,'L00000') FROM DUAL; -- 현재 설정된 나라(LOCAL)의 화폐단위 + 위의 내용
SELECT TO_CHAR(1234, 'L99999') FROM DUAL; -- 현재 설정된 나라(LOCAL)의 화폐단위 + 위의 내용
SELECT TO_CHAR(1234,'$99999') FROM DUAL;
SELECT TO_CHAR(1234,'L99,999') FROM DUAL; --자릿수 구분 콤마

-- EMPLOYEE 사원명, 급여조회
SELECT EMP_NAME, TO_CHAR(SALARY,'L999,999,999')
FROM EMPLOYEE;

-- 날짜 --> 문자
SELECT TO_CHAR(SYSDATE,'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'AM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'MON DY, YYYY') FROM DUAL;  --MON월 DY요일
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE;

-- 1990년 02월 06일
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') -- -는 포맷에 내장되어 있지만 문자는 아니므로 ""로 표시해야함
FROM EMPLOYEE;

-- 년도 포맷들
-- 년도에 관련한 포맷문자는 'Y', 'R' 있음 / Y는 무조건 현재 R은 50년 미만이면 현재고 50 이상이면 이전세기로 반영
-- YY는 무조건 현재세기를 반영
-- RR은 50미만이면 현재세기를 반영, 50이상이면 이전세기 반영
-- 20  18  90  --> YY --> 2020  2018  2090
-- 20  18  90  --> RR --> 2020  2018  1990

SELECT TO_CHAR(SYSDATE, 'YYYY'), -- 2020
       TO_CHAR(SYSDATE, 'RRRR'), -- 2020
       TO_CHAR(SYSDATE, 'YY'), -- 20
       TO_CHAR(SYSDATE, 'RR'), -- 20
       TO_CHAR(SYSDATE, 'YEAR') --TWENTY TWENTY
FROM DUAL;

-- 월에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'MM'), -- 07
       TO_CHAR(SYSDATE, 'MON'), -- 7월
       TO_CHAR(SYSDATE, 'MONTH'), -- 7월
       TO_CHAR(SYSDATE, 'RM') -- VII (로마기호)
FROM DUAL;

-- 일에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'DDD'), --189   1년 기준으로 며칠째인지
       TO_CHAR(SYSDATE, 'DD'), -- 07    1달 기준으로 며칠째인지
       TO_CHAR(SYSDATE, 'D') - 3        1주 기준으로 며칠째인지
FROM DUAL;

-- 요일에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'DY'), -- 화
       TO_CHAR(SYSDATE, 'DAY') -- 화요일
FROM DUAL;

--EMPLOYEE테이블에서 직원명, 입사일 조회
-- 입사일을 포맷지정해서 조회(2017년 12월 06일 (수))
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일" (DY)')
FROM EMPLOYEE;

----------------------------------------------------------------------------

/*
    * 숫자 / 문자 --> 날짜
    
    TO_DATE(숫자|문자, [포맷]) : 숫자형 또는 문자형 데이터를 날짜 타입으로 변환   => 결과값 DATE
*/
SELECT TO_DATE(20200101) FROM DUAL;
SELECT TO_DATE('20200101') FROM DUAL;
SELECT TO_DATE('200101') FROM DUAL;
SELECT TO_DATE('20200101', 'YYYYMMDD') FROM DUAL;

SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL; -- 98/06/30 2098 / YY : 무조건 현재세기
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL; -- 98/06/30 1998 / RR : 50이상이면 이전세기, 50미만이면 현재세기

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL;
SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL;

-- EMPLOYEE 테이블에서 1998년도 이후에 입사한 사원의 사번, 이름, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('980101', 'RRMMDD');

----------------------------------------------------------------------------

/*
    * 문자    --> 숫자
    
    TO_NUMBER(문자데이터, [포맷]) : 문자형 데이터를 숫자타입으로 변환
    
*/
SELECT TO_NUMBER('0123456789') FROM DUAL;

SELECT '123' + '456' FROM DUAL; --> 알아서 자동으로 숫자로 형변환 한 뒤 연산처리 수행
SELECT '123' + '456A' FROM DUAL; --> 에러발생

-- 문자안에 숫자들만 담겨있을 때 자동 형변환됨.
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID >= 210; -- EMP_ID는 문자값이지만 자유롭게 형변환 돼서 숫자인 210랑 비교가 됨

SELECT '10,000,000' + '555,000' FROM DUAL; -- 완전 숫자만 있는게 아니라 , 가 있기 떄문에 자동형변환 안됨. 에러발생
SELECT TO_NUMBER('10,000,000', '99,999,999') + TO_NUMBER('555,000', '999,999') FROM DUAL; -- TO_NUMBER로 형변환 시켜준 후 덧셈가능

------------------------------------------------------------------------------------------------------

/*
    < NULL 처리 함수 >
*/
-- * NVL(컬럼명, 컬럼값이 NULL일 경우 바꿀 값)
SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

SELECT EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, 'D0')
FROM EMPLOYEE;

-- * NVL2(컬럼명, 바꿀 값1, 바꿀 값2)
-- 컬럼 값이 존재하면 바꿀 값1로
-- 컬럼 값이 NULL값이면 바꿀 값 2로 변경

SELECT EMP_NAME, BONUS, NVL(BONUS,0), NVL2(BONUS, 0.7, 0)
FROM EMPLOYEE;

-- * NULLIF(비교대상1, 비교대상2)
-- 두 개의 값이 동일하면 NULL값 반환
--            동일하지 않으면 비교대상1 반환
SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '567') FROM DUAL;

------------------------------------------------------------------------

/*
    < 선택함수 > 
    여러가지 경우에 선택을 할 수 있는 기능을 제공
    
    * DECODE(비교하고자하는대상(컬럼명|계산식), 조건값1, 결과값1, 조건값2, 결과값2, ...)
    비교하고자하는 값이 조건값과 일치할 경우 그에 해당하는 결과값 반환해주는 함수
    
    
    
    SWITCH(비교하고자하는대상) {
    CASE 조건값1: 결과값1
    CASE 조건값2: 결과값2
    DEFAULT: 결과값
    }
    
*/
-- 사번, 사원명, 주민번호, 성별
SELECT EMP_ID, EMP_NAME, EMP_NO,
       DECODE(SUBSTR(EMP_NO,8, 1), '1', '남', '2', '여') 성별
FROM EMPLOYEE;

-- 직원의 급여 인상해서 조회
-- 직급코드가 J7인 사원은 급여를 10%인상
-- 직급코드가 J6인 사원은 급여를 15%인상
-- 직급코드가 J5인 사원은 급여를 20%인상
-- 그 외의 직급의 사원은 급여를 5%인상
-- 직원명, 직급코드, 기존급여, 인상된급여

SELECT EMP_NAME, JOB_CODE, SALARY 기존급여,
       DECODE(JOB_CODE, 'J7', SALARY*1.1,
                        'J6', SALARY*1.15,
                        'J5', SALARY*1.2,
                              SALARY*1.05) 인상급여
FROM EMPLOYEE;

/*
    * CASE WHEN THEN
    
    CASE WHEN 조건식1 THEN 결과값1
         WHEN 조건식2 THEN 결과값2
         ELSE 결과값
    END
    
    내 마음대로 조건식 작성 가능 (범위지정가능)
    (자바에서 IF-ELSE IF문)
*/
SELECT EMP_ID, EMP_NAME, EMP_NO,
       CASE WHEN SUBSTR(EMP_NO, 8, 1)='1' THEN '남'
            WHEN SUBSTR(EMP_NO, 8, 1)='2' THEN '여'
        END 성별
FROM EMPLOYEE;

-- 사원명, 급여, 급여등급('1등급','2등급','3등급','4등급')
-- SALARY값이 500만원 초과일 경우 1등급
-- SALARY값이 500만원 이하 350만워너 초과일 경우 2등급
-- SALARY값이 350만원 이하 200만원 초과일 경우 3등급
-- 그 외의 경우 4등급

SELECT EMP_NAME, SALARY,
       CASE WHEN SALARY > 5000000 THEN '1등급'
            WHEN SALARY > 3500000 THEN '2등급'
            WHEN SALARY > 2000000 THEN '3등급'
            ELSE '4등급'
        END 등급
FROM EMPLOYEE;

---------------------------------------------------------------------
-- 1. SUM(숫자에 해당하는 컬럼) : 총 합계를 반환해주는 함수
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- 남자사원의 총 급여합
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1'; -- 2

-- 부서코드가 D5인 사원들의 총 연봉합
SELECT SUM(SALARY*12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 2. AVG(숫자에해당하는컬럼) : 평균값을 구해서 반환
-- 전 사원의 급여 평균 조회
SELECT AVG(SALARY)
FROM EMPLOYEE;

SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 3. MIN(컬럼명) : 컬럼값들 중에 가장 작은값 반환
--                 취급하는 자료형은 ANY TYPE임
SELECT MIN(EMP_NAME),MIN(EMAIL), MIN(SALARY), MIN(HIRE_DATE)
FROM EMPLOYEE;

-- 4. MAX(컬럼명) : 컬럼값들 중에 가장 큰 값 반환
                   취급하는 자료형은 ANY TYPE임
SELECT MAX(EMP_NAME), MAX(EMAIL), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- 5. COUNT(*|컬럼명) : 행 개수를 세서 반환
--    COUNT(*) : 조회결과에 해당하는 행 개수 다 세서 반환 (NULL 포함)
--    COUNT(컬럼명) : 해당 컬럼값이 NULL이 아닌 것만 행 개수 다 세서 반환
--    COUNT(DISTINCT 컬럼명) : 중복 제거한 행 개수 세서 반환

-- 전체 사원 수
SELECT COUNT(*)
FROM EMPLOYEE;

SELECT COUNT('1') -- 어떤걸 넣어도 다 세어줌 기본 *로 쓰는것
FROM EMPLOYEE;

SELECT COUNT(NULL) -- 0
FROM EMPLOYEE;

-- 남자 사원 수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1';

-- 부서배치가 된 사원 수 (DEPT_CODE에 값이 있는 사원 수)
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- 현재 사원들이 속해있는 부서들
SELECT COUNT(DISTINCT DEPT_CODE) -- NULL값은 제외(6)
FROM EMPLOYEE;

-- 현재 사원들이 분포되어있는 직급의 수
SELECT COUNT(DISTINCT JOB_CODE)
FROM EMPLOYEE;
