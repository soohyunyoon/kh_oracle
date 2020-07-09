/*
    < JOIN >
    �� �� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ ����� �ϳ��� �����(RESULT SET)�� ����
    
    ������ �����ͺ��̽��� �ּ����� �����ͷ� ������ ���̺� ��� ���� (�ߺ��� �ּ�ȭ�ϱ� ����)
    => ��, ������ �����ͺ��̽����� SQL���� �̿��� ���̺� "����"�� �δ� ���
    
    ������ �����͸� �������°� �ƴ� ���̺� ������� ���谡 �ξ��� �����͸� ��Ī���Ѽ� ��ȸ�ؾߵ�
    
                                    (JOIN ��� ����)
                                    
    JOIN�� ũ�� "����Ŭ ����"�� "ANSI ����"
    ANSI(�̱�����ǥ����ȸ == ���ǥ���� �����ϴ� ��ü)
    
            ����Ŭ DBMS������                         ����Ŭ + �ٸ�DBMS������
                ����Ŭ ����              |               ANSI ����
    ------------------------------------------------------------------------------------
                � ����                |        ���� ���� (INNER JOIN) --> JOIN USING/ON
              (EQUAL JOIN)              |        �ܺ� ����(NATURAL JOIN) --> JOIN USING
    ------------------------------------------------------------------------------------
                ���� ����                |        ���� �ܺ� ����(LEFT OUTER JOIN),
              (LEFT OUTER)              |        ������ �ܺ� ����(RIHGT OUTER JOIN),
              (RIGHT OUTER)             |        ��ü �ܺ� ����(FULL OUTER JOIN, ����Ŭ �������δ� ��� �Ұ�)
    ------------------------------------------------------------------------------------------------------
            ��ü ����, �� ����         |                 JOIN ON
    ---------------------------------------------------------------------------------------
                īŸ�þ� ��               |              ���� ���� (CROSS JOIN)

*/

-- �� ����� ���, �����, �μ��ڵ�, �μ��� ��ȸ�ϰ��� �� ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

/*
    1. �����(EQUAL JOIN) / �������� (INNER JOIN)
       �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εż� ��ȸ (== ��ġ�ϴ� ���� ���� ���� ��ȸX)
*/
-- >> ����Ŭ ���� ����
--    FROM ���� ��ȸ�ϰ��� �ϴ� ���̺�� ���� (, �����ڷ�)
--    WHERE ���� ��Ī��ų �÷���(�����)�� ���� ������ ������

-- 1) ������ �� �÷����� �ٸ� ��� (EMPLOYEE : DEPT_CODE  / DEPARTMENT: DEPT_ID)
-- ���, �����, �μ��ڵ�, �μ����� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> ��ġ�ϴ� ���� ���� ���� ��ȸ���� ���ܵȰ� Ȯ�� ����

-- 2) ������ �� �÷����� ���� ���(EMPLOYEE : JOB_CODE  / JOB:JOB_CODE)
--    ���, �����, �����ڵ�, ���޸�

--    ���1) ���̺���� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;S -- ambiguously(�ָ��ϴ�,, ��ȣ�ϴ�,, Ȯ���� ����ض�,,)
--> ambiquously : �ָ��ϴ� , ��ȣ�ϴ�

--    ���2) ��Ī ��� (�����̺��� ��Ī �ο��ص� �� ����)
SELECT EMP_ID, EMP_NAME, D.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- >> ANST ǥ�� ����
--    FROM���� �����̵Ǵ� ���̺��� �ϳ� ��� �� �� 
--    JOIN������ ������ȸ �ϰ��� �ϴ� ���̺� ��� �� ��Ī��ų �÷��� ���� ���� ���
--    USING������ ON����

-- 1) ������ �� �÷����� �ٸ� ��� (EMPLOYEE:DEPT_CODE  / DEPARTMENT:DEPT_ID)
--    ON�������θ�!!
-- ���, �����, �μ��ڵ�, �μ���

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- 2) ������ �� �÷����� ���� ��� (EMPLOYEE: JOB_CODE  / JOB: JOB_CODE)
--    USING���� ���! (ON�� ���ؼ� ���� ��Ī�� �����ϱ� ��)
-- ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE); -- ambiguously �߻� x => USING�� ���� �÷��̶�� �ν��ؼ�

SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE); --ambiquously�߻� O

SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB ON(JOB_CODE = JOB_CODE); --ambiquously�߻� O

-- [����] --
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB; -- DEPARTMENT���� �ȵ�. JOB�̱� ������ ����

-- �����ȣ, �����, �μ���
-- >> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

-->> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- �� �տ� INNER �� ���� ����! �������� ��� INNER�� �ڵ����� ��.

-- ���, �����, ���޸�
-- >> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- >> ANSI ����
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E
--JOIN JOB USING(JOB_CODE);
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);

-- �߰����� ���ǵ� ��� ���� ����
-- ������ �븮�� ����� ���, �̸�, ���޸�, �޿��� ��ȸ
-- >> ����Ŭ
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND JOB_NAME = '�븮';

-->> ANSI
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮';

---------------------------------- �ǽ����� ------------------------------------
SELECT * FROM DEPARTMENT; --> LOCATION_ID
SELECT * FROM LOCATION; --> LOCAL_CODE

-- �μ��ڵ�, �μ���, �����ڵ�, �������� ��ȸ�Ͻÿ�
-->> ����Ŭ ����
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;
-->> ANSI ����
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT 
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- 2. ���ʽ��� �޴� ������� ���, �����, ���ʽ� ��, �μ��� ��ȸ
-->> ����Ŭ ����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_ID = DEPT_CODE AND BONUS IS NOT NULL ;
-->> ANSI����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE) -- �����ϴ� �÷����� �ٸ��� ������ ON����!
WHERE BONUS IS NOT NULL;
-- 3. �λ�����ΰ� �ƴ� ������� �����, �޿��� ��ȸ�Ͻÿ�
-->> ����Ŭ ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_ID = DEPT_CODE AND DEPT_TITLE != '�λ������';
-->> ANSI ����
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
WHERE DEPT_TITLE <> '�λ������';

-- ���, �����, �μ���, ���޸�
-->> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID AND E.JOB_CODE = J.JOB_CODE;
-->> ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (D.DEPT_CODE = D.DEPT_ID) -- ȸ�翡�� ���� ��Ī�ο� �� �س��� ����� ����ص�
--JOIN JOB USING(JOB_CODE);
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE); -- �׸��� USING���� ON���� ���� ���

-----------------------------------------------------------------------------------------------------

/*
    2. �������� / �ܺ����� (OUTER JOIN)
    �� ���̺��� JOIN�� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ����
    ��, �ݵ�� LEFT/RIGHT �� ��������߸� �Ѵ�.(������ �Ǵ� ���̺� ����)
*/

-- OUTER JOIN�� ���� INNER JOIN ���س���
-- �����, �μ���, �޿�, ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- �μ��� �ο����� �ʴ� ��� 2�� ���� ������ ��ȸ���� ����
-- �μ��� ������ ����� ���� �μ� ���� ��쵵 ��ȸ���� ����

-- 1) LEFT (OUTER) JOIN : �� ���̺� �� ���ʿ� ����� ���̺��� �÷��� �������� JOIN
-- >> ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
LEFT /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
--> �μ��ڵ尡 ���� ���(�ϵ���, �̿���)�� ������ ������ ��

-- >> ����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- �������� ���� �÷��� �ݴ��� + ǥ�ø� �ϸ� LEFT JOIN
                              -- ������ ���̺� �÷��� + ǥ�� (���� ���̺��� ����)

-- 2) RIGHT (OUTER) JOIN : �� ���̺� �� �����ʿ� ����� ���̺��� �÷��� �������� JOIN
-->> ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
RIGHT /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- ��� ���̺� ���.

-->> ����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;


-- 3) FULL (OUTER) JOIN : �� ���̺��� ���� ��� ���� ��ȸ�� �� �ִ�. (��, ����Ŭ���뱸�����δ� �ȵ�)
-->> ANSI����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 
FROM EMPLOYEE
FULL /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-->> ����Ŭ ���� ����(����) OUTER JOIN�� �ϳ��� ����!
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);

----------------------------------------------------------------------------------------


/*
    3. ī�׽þȰ�(CARTESIAN PRODUCT) / ��������(CROSS JOIN)
    ���εǴ� ��� ���̺��� �� ����� ���μ��� ��� ���ε� �����Ͱ� �˻���(������)
    
    �� ���̺��� ����� ��� ������ ����� ������ ��� --> ����� ������ ��� --> ����ȭ�� ����
*/

-- �����, �μ���
-- >> ����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT; -- 23 * 9 => 207

-->> ANSI ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

------------------------------------------------------------------------------  

/*
    4. �� ����(NON EQUAL JOIN)
    '='(��ȣ)�� ������� �ʴ� ���ι�
    ������ �÷� ���� ��ġ���� ��찡 �ƴ�, ���� '����'�� ���ԵǴ� ����� �����ϴ� ���
    
    ANSI�������δ� JOIN ON�������θ� ��� ����(USING�� ��� �Ұ�)
*/

-- EMPLOYEE�� SAL_LEVEL�÷� �����
ALTER TABLE EMPLOYEE DROP COLUMN SAL_LEVEL;

-- �����, �޿�, �޿����
-->> ����Ŭ ����
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
--WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-->> ANSI ����
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

-----------------------------------------------------------------

/*
    5. ��ü ����(SELF JOIN)
    ���� ���̺��� �����ϴ� ���
    �ڱ� �ڽŰ� ������ �δ� ��
*/
SELECT * FROM EMPLOYEE;

-- ������ ����� ������, �����, ����μ��ڵ�, ������, �����

-->> ����Ŭ ����
SELECT E.EMP_ID ������, 
       E.EMP_NAME �����, 
       E.DEPT_CODE ����μ��ڵ�, 
       E.MANAGER_ID ������, 
       M.EMP_NAME �����, 
       M.DEPT_CODE ����μ��ڵ�, 
       M.SALARY ����޿�
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+); -- ���� ��ȣ��

-->> ANSI ����
SELECT E.EMP_ID ������, E.EMP_NAME �����, E.JOB_CODE ��������ڵ�,
       M.EMP_ID ������, M.EMP_NAME �����, M.JOB_CODE ��������ڵ�
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);

-------------------------------------------------------------------------------------------

SELECT * FROM EMPLOYEE;     -- DEPT_CODE     JOB_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID
SELECT * FROM JOB;          --               JOB_CODE

/*
    < ���� JOIN >
    N���� ���̺��� JOIN
*/

-- ���, �����, �μ���, ������ ��ȸ
SELECT * FROM EMPLOYEE;     -- DEPT_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE

-->> ����Ŭ ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT, LOCATION, JOB J
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE AND E.JOB_CODE = J.JOB_CODE;


-->> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN JOB USING(JOB_CODE);
-- ���� ������ ������ �߿�!

------------------ �ǽ����� -------------------------
--1. ���, �����, �μ���, ������, ������ ��ȸ
SELECT * FROM EMPLOYEE;     -- DEPT_CODE
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;
SELECT * FROM NATIONAL;
-->> ����Ŭ ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N;
WHERE E.DEPT_CODE = D.DEPT_ID AND LOCATION_ID = LOCAL_CODE AND L.NATIONAL_CODE = N.NATIONAL_CODE;
-->> ANSI ����
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, N.NATIONAL_NAME, L.LOCAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (D.DEPT_ID = E.DEPT_CODE)
JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE);

--2. ���, �����, �μ���, ���޸�, ������, ������, �޿����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, NATIONAL_NAME, LOCAL_NAME, SAL_LEVEL
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE E.DEPT_CODE = D.DEPT_ID 
      AND E.JOB_CODE = J.JOB_CODE 
      AND D.LOCATION_ID = L.LOCAL_CODE
      AND L.NATIONAL_CODE = N.NATIONAL_CODE
      AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;
      
-->> ANSI ����
SELECT E.EMP_ID ���, 
       E.EMP_NAME �����, 
       D.DEPT_TITLE �μ���, 
       J.JOB_NAME ���޸�, 
       N.NATIONAL_NAME �ٹ�������, 
       L.LOCAL_NAME �ٹ�������, 
       S.SAL_LEVEL �޿����
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);






