-- 춘 기술대학교의 학과 이름과 계열
SELECT DEPARTMENT_NAME "학과 명" , CATEGORY 계열
FROM TB_DEPARTMENT;

-- 학과의 학과 정원을 다음과 같은 형태로 화면에 출력
SELECT DEPARTMENT_NAME || '의 정원은 ' || CAPACITY || '명 입니다'
FROM TB_DEPARTMENT;

-- 국어국문학과에 다니는 여학생 중 현재 휴학중인 여학생을 찾아달라는 요청
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001' AND SUBSTR(STUDENT_SSN, 8, 1) = '2' AND ABSENCE_YN = 'Y';

-- 도서관에서 대출 도서 장기 연체자들을 찾아 이름을 게시하고자 한다
-- A513079, A513090, A513091, A513110, A513119 찾기
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO = 'A513079' OR STUDENT_NO = 'A513090' OR STUDENT_NO = 'A513091'
    OR STUDENT_NO = 'A513110' OR STUDENT_NO = 'A513119';
    
-- 입학정원이 20명 이상 30명 이하인 학과들의 학과 이름과 계열을 적으시오
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
--WHERE CAPACITY >= 20 AND CAPACITY <= 30;
WHERE CAPACITY BETWEEN 20 AND 30;

-- 춘 기술대학교는 총장을 제외하고 모든 교수들이 소속 학과를 가지고 있다.
-- 그럼 춘 기술대학교 총장의 이름을 알아낼 수 있는 SQL문장을 작성하시오
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 전산상의 착오로 학과로 지정되어 있지 않은 학생이 있는지 확인하고자 한다.
-- 어떠한 SQL문장을 사용하면 될 것인지 작성하시오
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- 수강신청을 하려고 한다. 선수과목 여부를 확인해야하는데, 
-- 선수과목이 존재하는 과목들은 어떤 과목인지 과목번호를 조회해보시오
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 춘 대학에는 어떤 계열(CATEGORY)들이 있는지 조회해보시오.
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT ;

-- 02학번 전주 거주자들의 모임을 만들려고 한다. 
-- 휴학한 사람들은 제외한 재학중인 학생들의 학번, 이름, 주민번호를 출력
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ENTRANCE_DATE LIKE '02%' AND STUDENT_ADDRESS LIKE '전주%' AND ABSENCE_YN = 'N';

------------------------------------------------------------------------------------
-- 영어영문학과 (학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른 순으로 표시하는 SQL문장 작성
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE;

-- 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다. 
-- 그 교수의 이름과 주민번호를 화면에 출력하는 SQL문장 작성

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) <> 3;

-- 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL문장을 작성
-- 나이 어린 ~ 많은 / 2000년 이후 출생자X /헤더 교수이름, 나이 / 나이는 만으로 계산

SELECT PROFESSOR_NAME, TO_CHAR(SYSDATE, 'YYYY') - 
        TO_CHAR(TO_DATE(SUBSTR(PROFESSOR_SSN, 1,6),'RRMMDD'),'RRRR')
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8,1) = 1 AND SUBSTR(PROFESSOR_SSN, 1,2) > 20; 

-- 교수들의 성 빼고 이름만 출력하는 SQL을 작성하시오
SELECT SUBSTR(PROFESSOR_NAME,2,2)
FROM TB_PROFESSOR;

-- 재수생 입학자를 구하려고 한다. 어떻게 찾아낼 것인가. 이때 19살에 입학하면 재수를 하지 않은 것으로 간주
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT;
--WHERE ENTRANCE_DATE - TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN,1,6),'RRMMDD','RRRR');


-- 2020 크리스마스는 무슨 요일?
SELECT TO_CHAR(TO_DATE('20201225','YYMMDD'),'DAY') 
FROM DUAL;
-- 몇 년도 몇 월 며칠?
--TO_DATE('99/10/11', YY/MM/DD') -- 2099/10/11
--TO_DATE('49/10/11, 'YY/MM/DD') -- 2049/10/11
--TO_DATE('99/10/11','RR/MM/DD') -- 1999/10/11
--TO_DATE('49/10/11','RR/MM/DD') -- 1049/10/11

SELECT TO_DATE('49/10/11','RRRR/MM/DD')
FROM DUAL;

-- 8. 춘 기술대학교 2000년도 이후 입학자들은 학번이 A로 시작하게 되어있다. 
-- 2000년도 이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL문 작성
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- 9. 학번이 A517178인 한아름 학생의 학점 총 평점을 구하는 SQL문을 작성 헤더는 평점 점수는 반올림하여 소수점 이하 한 자리까지
SELECT ROUND(SUM(POINT)/COUNT(POINT),1) 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10. 학과별 학생수를 구하여 '학과번호', '학생수(명)'의 형태로 헤더를 만들어 결과값이 출력되도록
SELECT DEPARTMENT_NO 학과번호, COUNT(*) 학생수
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- 11. 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도?
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12. 학번이 A112113인 김고운 학생의 년도 별 평점을 구하는 SQL문
SELECT SUBSTR(TERM_NO,1,4) 년도, AVG(POINT) "년도 별 평점"
FROM TB_GRADE
GROUP BY TERM_NO
HAVING STUDENT_NO LIKE 'A112113'
ORDER BY TERM_NO;

-- 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL문장을 작성
SELECT DEPARTMENT_NO, COUNT(ABSENCE_YN)
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
HAVING SUBSTR(ABSENCE_YN,1,1) = 'Y'
ORDER BY DEPARTMENT_NO

