/*
   < SELECT >
   데이터 조회할 때 사용되는 구문
   
   >> RESULT SET : SELECT문을 통해 조회된 결과물 (즉, 조회된 행들의 집합을 의미)
   
   >> 표현법<<
   SELECT 조회하고자 하는 컬럼, 컬럼, 컬럼, ...
   조회하고자 하는 컬럼들은 반드시 FROM절에 기술한 테이블에 존재하는 컬럼
*/

-- EMPLOYEE 테이블에 전체 사원의 모든 컬럼 정보 조회
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 전체 사원들의 사번, 이름, 급여만을 조회
-- SELECT 절에 조회하고자 하는 컬럼명들 나열
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

---------------- 실습문제 ------------------
-- 1. JOB 테이블의 모든 컬럼 정보 조회
SELECT *
FROM JOB;
-- 2. JOB 테이블의 직급명 컬럼만 조회
SELECT JOB_NAME
FROM JOB;
-- 3. DEPARTMENT 테이블의 모든 컬럼 정보 조회
SELECT *
FROM DEPARTMENT;
-- 4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일(HIRE_DATE) 정보만 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;
-- 대소문자 가리지 않음 (단, 대문자 위주로 기술)

-- 5. EMPLOYEE 테이블의 입사일, 사원명, 급여 조회
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;
---------------------------------------------------
/*
    < 컬럼값을 통한 산술연산 >
    SELECT 절 컬럼명 입력 부분에 산술연산을 이용해서 결과를 조회할 수 있다.
*/

-- EMPLOYEE 테이블에서 직원명, 직원의 연봉(연봉 = 급여 * 12)
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 연봉, 보너스 포함된 연봉((급여 + 보너스*급여)*12) 조회
SELECT EMP_NAME, SALARY * 12, (SALARY + BONUS * SALARY) * 12
FROM EMPLOYEE;
--> 산술연산 중 NULL값이 존재할 경우 산술연산한 결과값 마저도 무조건 NULL값이다.

-- EMPLOYEE 테이블에서 직원명, 입사일, 근무일수(오늘날짜 - 입사일)
-- DATE 형식끼리도 연산 가능
-- 오늘 날짜 : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
-- 결과 값은 일 수가 맞음
-- 단, 값이 지저분한 이유는 DATE형은 년/월/일/시/분/초 단위로 시간정보를 관리하기 때문

-----------------------------------------------------------------------
/*
    < 컬럼명에 별칭 지정하기 >
    산술연산을 하게 되면 컬럼명이 지저분 함.. 이때 컬럼명에 별칭 부여해서 깔끔하게 보여줌
    
    >> 표현법 <<
    컬럼명 AS 별칭 / 컬럼명 AS "별칭" / 컬럼명 "별칭" / 컬럼명 별칭
    
    부여하고자 하는 별칭에 띄어쓰기 혹은 특수문자가 포함될 경우 반드시 더블퀘테이션("")을 써야됨  
*/

-- EMPLOYEE 테이블에서 직원명(별칭:이름), 연봉(별칭:연봉(원)), 보너스포함연봉(별칭:총소득(원))
SELECT EMP_NAME AS 이름, SALARY*12 AS "연봉(원)", (SALARY + BONUS * SALARY) * 12 "총소득(원)"
FROM EMPLOYEE;

------------------------------------------------------------------------------------

/*
    < 리터럴>
    임의로 지정한 문자열('')을 SELECT절에 사용하면 테이블에 존재하는 데이터처럼 조회가능
    리터럴은 RESULT SET의 모든 행에 반복적으로 출력됨.
*/

-- EMPLOYEE 테이블에서 직원번호, 직원명, 급여, 단위(데이터 값 : 원) 조회
SELECT EMP_ID, EMP_NAME, SALARY, '원' AS 단위
FROM EMPLOYEE;

-----------------------------------------------------------------------------

/*
    < DISTINCT >
    컬럼에 포함된 중복값을 한 번씩만 표시하고자 할 때 사용
*/

-- EMPLOYEE 테이블에서 직급코드 조회
SELECT JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직급코드(중복제거) 조회 , 단독으로만 쓰여야함. 다른 컬럼명과 쓸 수 없음
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 부서코드(중복제거) 조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

/*
SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE 
FROM EMPLOYEE;
--> DISTINCT는 SELECT절에 딱 한 번만 기술 할 수 있다.
*/

---------------------------------------------------------------------

/*
    < WHERE절 >
    조회하고자 하는 테이블에서 해당 조건에 만족하는 결과만을 조회하고자 할 떄 사용
    조건식에서는 다양한 연산자들 사용가능
    
    >> 표현법 <<
    SELECT 조회하고자 하는 컬럼, 컬럼, 컬럼, ..
    FROM 테이블명
    WHERE 조건식;

    < 비교연산자 >
    >, <, >=, <=,       --> 대소비교
    =                   --> 동등비교
    !=, ^=, <>          --> 같지않다
    
*/

-- EMPLOYEE 테이블에서 부서코드가 'D9'와 일치하는 사원들의 모든 컬럼정보
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'; -- 문자열은 '' 로 표기해야한다.

-- EMPLOYEE 테이블에서 부서코드가 'D9'와 일치하는 사원들의 직원명, 부서코드 ,급여만 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 테이블에서 급여가 400만원 이상인 직원들의 직원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE 테이블에서 부서코드가 'D9'가 아닌 사원들의 사번, 사원명, 부서코드만 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D9';
-- WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE 테이블에서 재직중(ENT _YN컬럼값이 'N')인 직원들의 사번, 이름, 입사일
SELECT EMP_ID, EMP_NAME, HIRE_DATE,'재직중' 근무여부
FROM EMPLOYEE
WHERE ENT_YN = 'N';

--------------------------- 실습문제 -----------------------
-- 1. Employee테이블에서 급여(SALARY)가 300만원 이상인 직원의 직원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. EMPLOYEE 테이블에서 급여등급 (SAL_LEVEL)이 'S1'인 직원의 직원명, 급여, 연락처 조회
SELECT EMP_NAME, SALARY, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

-- 3. EMPLOYEE 테이블에서 연봉이 5000만원 이상인 직원의 직원명 , 급여, 연봉, 입사일 조회
SELECT EMP_NAME, SALARY, SALARY*12, HIRE_DATE -- 3 마지막으로 걸러준 테이블 제외하고 가져올 테이블만 가져오기
FROM EMPLOYEE               -- 1 FROM절 먼저 가져온 후
WHERE SALARY*12 >= 50000000; -- 2 조건으로 걸러준 다음

-------------------------------------------------------------------------------

/*
    < 논리 연산자 >
    여러개의 조건을 엮을 때 사용
    
    AND(~이면서, 그리고), OR(~이거나, 또는)
*/

-- 부서코드가 'D9'이면서 급여가 500DLTKDDLS 직원의 직원명, 부서명코드, 급여조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- 부서코드가 'D6'이거나 급여가 300만원 이상 받는 직원의 직원명, 부서코드 , 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- 급여가 400만원 이상이고 직급코드가 'J2'인 사원의 모든 컬럼 조회

SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';

-- 급여를 350만원 이상 600만원 이하를 받는 직원의 직원명, 사번, 급여, 부서코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-----------------------------------------------

/*
    < BETWEEN AND >
    조건절(WHERE)에서 사용되는 구문
    몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용
    
    >> 표현법 <<
    비교대상컬럼명 BETWEEN 하한값 AND 상한값
    --> 해당 컬럼값이 하한값 이상이고 상한값 이하인 경우
*/

SELECT EMP_NAME, EMP_ID, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;
-- 위를 제외한 컬럼들
SELECT EMP_NAME, EMP_ID, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;

-- 입사일이  '90/01/01' ~ '01/01/01' 인 사원의 모든 컬럼
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-- 반대로 저 사이의 범위에 입사한 사원들이 아닌 그 외에 입사한 사원
SELECT *
FROM EMPLOYEE
--WHERE NOT HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';
WHERE HIRE_DATE NOT BETWEEN '90/01/01' AND '01/01/01';
-- NOT은 컬럼명 앞 또는 BETWEEN 앞에 기입가능

--------------------------------------------------------------------

/*
    < LIKE >
    비교하려는 컬럼값이 내가 지정한 특정 패턴에 만족될 경우 조회
    
    >> 표현법 <<
    비교대상컬럼 LIKE '특정패턴'
    
    - 특정패턴에 '%', '_'를 와일드카드로 사용할 수 있음
    >> '%' : 0글자이상
    EX) 비교대상컬럼명 lIKE '문자%' --> 컬럼값 중에 '문자'로 "시작"되는 걸 조회
        비교대상컬럼명 LIKE '%문자' --> 컬럼값 중에 '문자'로 "끝"나는 걸 조회
        비교대상컬럼명 LIKE '%문자%' --> 컬럼갑 ㅅ중에 '문자'가 "포함"되는 걸 조회
        
    >> '_' : 1글자
    EX) 비교대상컬럼명 LIKE '_문자' --> 컬럼값 중에 '문자'앞에 무조건 한 글자가 올 경우 조회
        비교대상컬럼명 LIKE '__문자' --> 컬럼값 중에 '문자'앞에 무조건 두 글자가 올 경우 조회
        
*/
-- EMPLOYEE 테이블에서 성이 전씨인 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 이름 중에 하가 포함된 사원의 사원명, 주민번호, 부서코드 조회
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 전화번호가 4번째 자리가 9로 시작하는 사번, 이름 , 전화번호, 이메일 조회
-- 와일드 카드 : _(1글자), %(0글자이상)
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- EMAIL중 _ 앞 글자가 3자리인 이메일 주소를 가진 사원의 사번, 이름, 이메일 조회
-- EX) sun_di@kh.or.kr,     yoo_js@kh.or.kr
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';
-- 와일드카드로 사용되는 문자와 비교할 컬럼값에 담긴 문자가 동일해서 문제 발생
--> 어떤게 와일드 카드고 어떤게 데이터 값인지 구분지어야함.
--> 데이터로 처리할 값 앞에 임의로 나만의 와일드 카드를 제시하고 나만의 와일드 카드를 ESCAPE OPTION 등
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';

-- NOT LIKE
-- 김씨 성이 아닌 직원의 사번, 이름 , 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE NOT EMP_NAME LIKE '김%';
WHERE EMP_NAME NOT LIKE '김%';

--------------------------------- 실습문제 -----------------------------------
-- 1. EMPLOYEE 테이블에서 이름 끝이 '연'으로 끝나는 사원의 사원명, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

-- 3. DEPARTMENT 테이블에서 해외영업부에 대한 모든 컬럼 조회
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%';

------------------------------------------------------------------------

/*
    < IS NULL / IS NOT NULL >
    비교대상컬럼명 IS NULL : 컬럼값이 NULL인 경우
    비교대상컬럼명 IS NOT NULL : 컬럼값이 NULL이 아닌 경우
*/

-- 보너스를 받지 않는 사원의 사번, 이름, 급여
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- 관리자(사수)가 없는 사원들의 이름, 사수사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- 관리자도 없고 부서배치도 받지 않은 사원 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 부서배치를 받지 않았지만 보너스를 받는 사원 조회 (이름, 보너스, 부서코드)
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-----------------------------------------------------------------------------

/*
    < IN >
    비교대상컬럼값 목록중에 일치하는 값이 있는지
    
    비교대상컬럼명 IN ('값', '값', '값', ...)
*/
-- D6부서원들과 D8부서원들 D5인 부서원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

---------------------------------------------------------------------------

/*
    < 연결 연산자 : || >
    여러 컬럼값들을 하나의 컬럼인 것처럼 연결하거나, 컬럼과 리터럴을 연결할 수도 있다.
    
*/
--SYSTEM.OUT.PRINTLN("NUM : " + NUM); + 와 비슷한 느낌으로 알면 됨(연결)

-- 사번, 이름, 급여를 연결해서 조회
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- 컬럼과 리터럴과 연결
SELECT EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.' "급여 정보" -- 공백 특수문자 있으면 "" 로 묶어주고 아니면 그냥 써도 됨.
FROM EMPLOYEE;

------------------------------------------------------------------------------------

/*
    < 연산자 우선순위 >
    0. ()
    1. 산술연산자
    2. 연결연산자
    3. 비교연산자
    4. IS NULL    LIKE    IN
    5. BETWEEN AND 
    6. NOT(논리연산자)
    7. AND(논리연산자)
    8. OR(논리연산자)
    9. 
*/
-- 0R보다 AND가 먼저 실행
-- 직급코드가 J7 또는 J2 직급인 사원들 중 급여가 200 만원 이상인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
--WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J2' AND SALARY >=2000000; -- AND연산부터 시작하므로 J2의 월급 200만원 이상인사원과 J7모두 조회가 된 것임.
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >=2000000;

-------------------------------------------------------------------------------------------------

/*
    < ORDER BY절 >
    SELECT문 가장 마지막에 기입하는 구문
    SELECT문 가장 마지막 작성 뿐만 아니라 실행 순서 또한 가장 마지막
    
    >> 표현법 <<
    SELECT 조회할컬럼, 컬럼, ...
    FROM 조회하고자 하는 테이블명
    WHERE 조건식
    ORDER BY 정렬시키고자하는컬럼명|별칭|컬럼순번 [ASC|DESC] [NULLS FIRST|NULLS LAST];
    
    - ASC : 오름차순 정렬 (ASC 또는 DESC 생략시 기본값)
    - DESC : 내림차순 정렬
    
    - NULLS FIRST : 정렬하고자 하는 컬럼값에 NULL이 있는 경우 해당 데이터 값을 맨 앞
    - NULLS LAST  : 정렬하고자 하는 컬럼값에 NULL이 있는 경우 해당 데이터 값을 맨 뒤
    
    ** 실행(해석)되는 순서 **
    1. FROM 절
    2. WHERE 절
    3. SELECT 절
    4. ORDER BY 절
    
*/

SELECT *
FROM EMPLOYEE
--ORDER BY BONUS;
--ORDER BY BONUS ASC;     -- 오름차순 정렬은 기본적으로 NULLS LAST(NULL이 끝에 정렬됨)
--ORDER BY BONUS ASC NULLS FIRST;
ORDER BY BONUS DESC;      -- 내림차순 정렬은 기본적으로 NULLS FIRST


-- BONUS 내림차순 정렬 (단, BONUS 값이 일치할 경우 그 때는 SALARY가지고 오름차순 정렬
SELECT *
FROM EMPLOYEE
ORDER BY BONUS DESC, SALARY ASC; -- 정렬 기준 여러개 제시 가능

-- 연봉별 내림차순 정렬로 조회 (이름, 연봉)
SELECT EMP_NAME 이름, SALARY * 12 연봉
FROM EMPLOYEE
--ORDER BY SALARY * 12 DESC;
--ORDER BY 연봉 DESC; -- SELECT절은 이미 수행된 후이기 때문에  ORDER BY절에서 별칭 사용도 가능하다.
ORDER BY 2 DESC; -- 컬럼 순번도 사용 가능 (연봉으로 내림차순)






