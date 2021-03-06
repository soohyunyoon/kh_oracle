-- 1. 직급이 대리이면서 ASIA지역에 근무하는 직원들의
--    사번, 사원명, 직급명, 부서명, 근무지역명, 급여를 조회하시오
SELECT E.EMP_ID,
       E.EMP_NAME,
       J.JOB_NAME,
       D.DEPT_TITLE, 
       L.LOCAL_NAME,
       E.SALARY
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE AND L.LOCAL_NAME LIKE 'ASIA%' 
      AND D.DEPT_ID = E.DEPT_CODE 
      AND J.JOB_CODE = E.JOB_CODE AND J.JOB_NAME = '대리';

-- 2. 70년대생이면서 여자이고, 성이 전씨인 직원들의
--    사원명, 주민번호, 부서명, 직급명을 조회하시오

SELECT E.EMP_NAME,
       E.EMP_NO,
       D.DEPT_TITLE,
       J.JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
      AND E.JOB_CODE = J.JOB_CODE
      AND SUBSTR(E.EMP_NO, 1,2) BETWEEN 70 AND 79
      AND SUBSTR(E.EMP_NO, 8,1) = '2'
      AND E.EMP_NAME LIKE '전%';

-- 3. 이름에 '형'자가 들어있는 직원들의
--    사번, 사원명, 직급명을 조회하시오
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
      AND E.EMP_NAME LIKE '%형%';

-- 4. 해외영업팀에 근무하는 직원들의
--    사원명, 직급명, 부서코드, 부서명을 조회하시오
SELECT E.EMP_NAME,
       J.JOB_NAME,
       E.DEPT_CODE,
       D.DEPT_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND DEPT_TITLE LIKE '해외영업%'
      AND E.JOB_CODE = J.JOB_CODE;

-- 5. 보너스를 받는 직원들의
--    사원명, 보너스, 연봉, 부서명, 근무지역명을 조회하시오
SELECT E.EMP_NAME,
       E.BONUS,
       E.SALARY,
       D.DEPT_TITLE,
       L.LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID
      AND D.LOCATION_ID = L.LOCAL_CODE
      AND E.BONUS IS NOT NULL;
       
-- 6. 부서가 있는 직원들의
--    사원명, 직급명, 부서명, 근무지역명을 조회하시오
SELECT E.EMP_NAME,
       J.JOB_NAME,
       D.DEPT_TITLE,
       L.LOCAL_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE
      AND E.DEPT_CODE = D.DEPT_ID AND E.DEPT_CODE IS NOT NULL
      AND D.LOCATION_ID = L.LOCAL_CODE;

-- 7. '한국'과 '일본'에 근무하는 직원들의 
--    사원명, 부서명, 근무지역명, 근무국가명을 조회하시오

SELECT E.EMP_NAME,
       D.DEPT_TITLE,
       L.LOCAL_NAME,
       N.NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID
      AND D.LOCATION_ID = L.LOCAL_CODE 
      AND L.NATIONAL_CODE = N.NATIONAL_CODE AND (NATIONAL_NAME LIKE '한국' OR NATIONAL_NAME LIKE '일본');

-- 8. 보너스를 받지 않는 직원들 중 직급코드가 J4 또는 J7인 직원들의
--    사원명, 직급명, 급여를 조회하시오
SELECT E.EMP_NAME, J.JOB_NAME, E.SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE (JOB_CODE = 'J4' OR JOB_CODE = 'J7') AND E.BONUS IS NULL;

-- 9. 사번, 사원명, 직급명, 급여등급, 구분을 조회하는데
--    이때 구분에 해당하는 값은
--    급여등급이 S1, S2인 경우 '고급'
--    급여등급이 S3, S4인 경우 '중급'
--    급여등급이 S5, S6인 경우 '초급' 으로 조회되게 하시오. //////////오류

SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, S.SAL_LEVEL,
    CASE WHEN S.SAL_LEVEL IN ('S1', 'S2') THEN '1등급'
         WHEN S.SAL_LEVEL IN ('S3' , 'S4') THEN '2등급'
         WHEN S.SAL_LEVEL IN ('S5', 'S6') THEN '3등급'
    END 구분
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
JOIN SAL_GRADE S ON (E.SALARY BETWEEN MIN_SAL AND MAX_SAL);



-- 10. 각 부서별 총 급여합을 조회하되
--     이때, 총 급여합이 1000만원 이상인 부서명, 급여합을 조회하시오 ///////
SELECT D.DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE E, DEPARTMENT D
    GROUP BY D.DEPT_TITLE
    HAVING SUM(E.SALARY) >= 10000000;

-- 11. 각 부서별 평균급여를 조회하여 부서명, 평균급여 (정수처리)로 조회하시오.
--      단, 부서배치가 안된 사원들의 평균도 같이 나오게끔 하시오.////오류
SELECT D.DEPT_TITLE, AVG(SALARY)
FROM EMPLOYEE E, DEPARTMENT D
GROUP BY D.DEPT_TITLE;
