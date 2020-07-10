-- �� ������б��� �а� �̸��� �迭
SELECT DEPARTMENT_NAME "�а� ��" , CATEGORY �迭
FROM TB_DEPARTMENT;

-- �а��� �а� ������ ������ ���� ���·� ȭ�鿡 ���
SELECT DEPARTMENT_NAME || '�� ������ ' || CAPACITY || '�� �Դϴ�'
FROM TB_DEPARTMENT;

-- ������а��� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001' AND SUBSTR(STUDENT_SSN, 8, 1) = '2' AND ABSENCE_YN = 'Y';

-- ���������� ���� ���� ��� ��ü�ڵ��� ã�� �̸��� �Խ��ϰ��� �Ѵ�
-- A513079, A513090, A513091, A513110, A513119 ã��
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO = 'A513079' OR STUDENT_NO = 'A513090' OR STUDENT_NO = 'A513091'
    OR STUDENT_NO = 'A513110' OR STUDENT_NO = 'A513119';
    
-- ���������� 20�� �̻� 30�� ������ �а����� �а� �̸��� �迭�� �����ÿ�
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
--WHERE CAPACITY >= 20 AND CAPACITY <= 30;
WHERE CAPACITY BETWEEN 20 AND 30;

-- �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�.
-- �׷� �� ������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL������ �ۼ��Ͻÿ�
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� �Ѵ�.
-- ��� SQL������ ����ϸ� �� ������ �ۼ��Ͻÿ�
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- ������û�� �Ϸ��� �Ѵ�. �������� ���θ� Ȯ���ؾ��ϴµ�, 
-- ���������� �����ϴ� ������� � �������� �����ȣ�� ��ȸ�غ��ÿ�
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT ;

-- 02�й� ���� �����ڵ��� ������ ������� �Ѵ�. 
-- ������ ������� ������ �������� �л����� �й�, �̸�, �ֹι�ȣ�� ���
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ENTRANCE_DATE LIKE '02%' AND STUDENT_ADDRESS LIKE '����%' AND ABSENCE_YN = 'N';

------------------------------------------------------------------------------------
-- ������а� (�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ���� ������ ǥ���ϴ� SQL���� �ۼ�
SELECT STUDENT_NO �й�, STUDENT_NAME �̸�, TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') ���г⵵
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE;

-- �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� �Ѵ�. 
-- �� ������ �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL���� �ۼ�

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) <> 3;

-- �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL������ �ۼ�
-- ���� � ~ ���� / 2000�� ���� �����X /��� �����̸�, ���� / ���̴� ������ ���

SELECT PROFESSOR_NAME, TO_CHAR(SYSDATE, 'YYYY') - 
        TO_CHAR(TO_DATE(SUBSTR(PROFESSOR_SSN, 1,6),'RRMMDD'),'RRRR')
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8,1) = 1 AND SUBSTR(PROFESSOR_SSN, 1,2) > 20; 

-- �������� �� ���� �̸��� ����ϴ� SQL�� �ۼ��Ͻÿ�
SELECT SUBSTR(PROFESSOR_NAME,2,2)
FROM TB_PROFESSOR;

-- ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�. �̶� 19�쿡 �����ϸ� ����� ���� ���� ������ ����
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT;
--WHERE ENTRANCE_DATE - TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN,1,6),'RRMMDD','RRRR');


-- 2020 ũ���������� ���� ����?
SELECT TO_CHAR(TO_DATE('20201225','YYMMDD'),'DAY') 
FROM DUAL;
-- �� �⵵ �� �� ��ĥ?
--TO_DATE('99/10/11', YY/MM/DD') -- 2099/10/11
--TO_DATE('49/10/11, 'YY/MM/DD') -- 2049/10/11
--TO_DATE('99/10/11','RR/MM/DD') -- 1999/10/11
--TO_DATE('49/10/11','RR/MM/DD') -- 1049/10/11

SELECT TO_DATE('49/10/11','RRRR/MM/DD')
FROM DUAL;

-- 8. �� ������б� 2000�⵵ ���� �����ڵ��� �й��� A�� �����ϰ� �Ǿ��ִ�. 
-- 2000�⵵ ���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL�� �ۼ�
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- 9. �й��� A517178�� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL���� �ۼ� ����� ���� ������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ�����
SELECT ROUND(SUM(POINT)/COUNT(POINT),1) ����
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10. �а��� �л����� ���Ͽ� '�а���ȣ', '�л���(��)'�� ���·� ����� ����� ������� ��µǵ���
SELECT DEPARTMENT_NO �а���ȣ, COUNT(*) �л���
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- 11. ���� ������ �������� ���� �л��� ���� �� �� ����?
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12. �й��� A112113�� ���� �л��� �⵵ �� ������ ���ϴ� SQL��
SELECT SUBSTR(TERM_NO,1,4) �⵵, AVG(POINT) "�⵵ �� ����"
FROM TB_GRADE
GROUP BY TERM_NO
HAVING STUDENT_NO LIKE 'A112113'
ORDER BY TERM_NO;

-- �а� �� ���л� ���� �ľ��ϰ��� �Ѵ�. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL������ �ۼ�
SELECT DEPARTMENT_NO, COUNT(ABSENCE_YN)
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
HAVING SUBSTR(ABSENCE_YN,1,1) = 'Y'
ORDER BY DEPARTMENT_NO

