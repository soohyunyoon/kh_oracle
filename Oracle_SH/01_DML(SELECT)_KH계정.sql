/*
   < SELECT >
   ������ ��ȸ�� �� ���Ǵ� ����
   
   >> RESULT SET : SELECT���� ���� ��ȸ�� ����� (��, ��ȸ�� ����� ������ �ǹ�)
   
   >> ǥ����<<
   SELECT ��ȸ�ϰ��� �ϴ� �÷�, �÷�, �÷�, ...
   ��ȸ�ϰ��� �ϴ� �÷����� �ݵ�� FROM���� ����� ���̺� �����ϴ� �÷�
*/

-- EMPLOYEE ���̺� ��ü ����� ��� �÷� ���� ��ȸ
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ��ü ������� ���, �̸�, �޿����� ��ȸ
-- SELECT ���� ��ȸ�ϰ��� �ϴ� �÷���� ����
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

---------------- �ǽ����� ------------------
-- 1. JOB ���̺��� ��� �÷� ���� ��ȸ
SELECT *
FROM JOB;
-- 2. JOB ���̺��� ���޸� �÷��� ��ȸ
SELECT JOB_NAME
FROM JOB;
-- 3. DEPARTMENT ���̺��� ��� �÷� ���� ��ȸ
SELECT *
FROM DEPARTMENT;
-- 4. EMPLOYEE ���̺��� �����, �̸���, ��ȭ��ȣ, �Ի���(HIRE_DATE) ������ ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;
-- ��ҹ��� ������ ���� (��, �빮�� ���ַ� ���)

-- 5. EMPLOYEE ���̺��� �Ի���, �����, �޿� ��ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;
---------------------------------------------------
/*
    < �÷����� ���� ������� >
    SELECT �� �÷��� �Է� �κп� ��������� �̿��ؼ� ����� ��ȸ�� �� �ִ�.
*/

-- EMPLOYEE ���̺��� ������, ������ ����(���� = �޿� * 12)
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ������, ����, ���ʽ� ���Ե� ����((�޿� + ���ʽ�*�޿�)*12) ��ȸ
SELECT EMP_NAME, SALARY * 12, (SALARY + BONUS * SALARY) * 12
FROM EMPLOYEE;
--> ������� �� NULL���� ������ ��� ��������� ����� ������ ������ NULL���̴�.

-- EMPLOYEE ���̺��� ������, �Ի���, �ٹ��ϼ�(���ó�¥ - �Ի���)
-- DATE ���ĳ����� ���� ����
-- ���� ��¥ : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
-- ��� ���� �� ���� ����
-- ��, ���� �������� ������ DATE���� ��/��/��/��/��/�� ������ �ð������� �����ϱ� ����

-----------------------------------------------------------------------
/*
    < �÷��� ��Ī �����ϱ� >
    ��������� �ϰ� �Ǹ� �÷����� ������ ��.. �̶� �÷��� ��Ī �ο��ؼ� ����ϰ� ������
    
    >> ǥ���� <<
    �÷��� AS ��Ī / �÷��� AS "��Ī" / �÷��� "��Ī" / �÷��� ��Ī
    
    �ο��ϰ��� �ϴ� ��Ī�� ���� Ȥ�� Ư�����ڰ� ���Ե� ��� �ݵ�� ���������̼�("")�� ��ߵ�  
*/

-- EMPLOYEE ���̺��� ������(��Ī:�̸�), ����(��Ī:����(��)), ���ʽ����Կ���(��Ī:�Ѽҵ�(��))
SELECT EMP_NAME AS �̸�, SALARY*12 AS "����(��)", (SALARY + BONUS * SALARY) * 12 "�Ѽҵ�(��)"
FROM EMPLOYEE;

------------------------------------------------------------------------------------

/*
    < ���ͷ�>
    ���Ƿ� ������ ���ڿ�('')�� SELECT���� ����ϸ� ���̺� �����ϴ� ������ó�� ��ȸ����
    ���ͷ��� RESULT SET�� ��� �࿡ �ݺ������� ��µ�.
*/

-- EMPLOYEE ���̺��� ������ȣ, ������, �޿�, ����(������ �� : ��) ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, '��' AS ����
FROM EMPLOYEE;

-----------------------------------------------------------------------------

/*
    < DISTINCT >
    �÷��� ���Ե� �ߺ����� �� ������ ǥ���ϰ��� �� �� ���
*/

-- EMPLOYEE ���̺��� �����ڵ� ��ȸ
SELECT JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����ڵ�(�ߺ�����) ��ȸ , �ܵ����θ� ��������. �ٸ� �÷���� �� �� ����
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �μ��ڵ�(�ߺ�����) ��ȸ
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

/*
SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE 
FROM EMPLOYEE;
--> DISTINCT�� SELECT���� �� �� ���� ��� �� �� �ִ�.
*/

---------------------------------------------------------------------

/*
    < WHERE�� >
    ��ȸ�ϰ��� �ϴ� ���̺��� �ش� ���ǿ� �����ϴ� ������� ��ȸ�ϰ��� �� �� ���
    ���ǽĿ����� �پ��� �����ڵ� ��밡��
    
    >> ǥ���� <<
    SELECT ��ȸ�ϰ��� �ϴ� �÷�, �÷�, �÷�, ..
    FROM ���̺��
    WHERE ���ǽ�;

    < �񱳿����� >
    >, <, >=, <=,       --> ��Һ�
    =                   --> �����
    !=, ^=, <>          --> �����ʴ�
    
*/

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D9'�� ��ġ�ϴ� ������� ��� �÷�����
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'; -- ���ڿ��� '' �� ǥ���ؾ��Ѵ�.

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D9'�� ��ġ�ϴ� ������� ������, �μ��ڵ� ,�޿��� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE ���̺��� �޿��� 400���� �̻��� �������� ������, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D9'�� �ƴ� ������� ���, �����, �μ��ڵ常 ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D9';
-- WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE ���̺��� ������(ENT _YN�÷����� 'N')�� �������� ���, �̸�, �Ի���
SELECT EMP_ID, EMP_NAME, HIRE_DATE,'������' �ٹ�����
FROM EMPLOYEE
WHERE ENT_YN = 'N';

--------------------------- �ǽ����� -----------------------
-- 1. Employee���̺��� �޿�(SALARY)�� 300���� �̻��� ������ ������, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. EMPLOYEE ���̺��� �޿���� (SAL_LEVEL)�� 'S1'�� ������ ������, �޿�, ����ó ��ȸ
SELECT EMP_NAME, SALARY, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

-- 3. EMPLOYEE ���̺��� ������ 5000���� �̻��� ������ ������ , �޿�, ����, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, SALARY*12, HIRE_DATE -- 3 ���������� �ɷ��� ���̺� �����ϰ� ������ ���̺� ��������
FROM EMPLOYEE               -- 1 FROM�� ���� ������ ��
WHERE SALARY*12 >= 50000000; -- 2 �������� �ɷ��� ����

-------------------------------------------------------------------------------

/*
    < �� ������ >
    �������� ������ ���� �� ���
    
    AND(~�̸鼭, �׸���), OR(~�̰ų�, �Ǵ�)
*/

-- �μ��ڵ尡 'D9'�̸鼭 �޿��� 500DLTKDDLS ������ ������, �μ����ڵ�, �޿���ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- �μ��ڵ尡 'D6'�̰ų� �޿��� 300���� �̻� �޴� ������ ������, �μ��ڵ� , �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- �޿��� 400���� �̻��̰� �����ڵ尡 'J2'�� ����� ��� �÷� ��ȸ

SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';

-- �޿��� 350���� �̻� 600���� ���ϸ� �޴� ������ ������, ���, �޿�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-----------------------------------------------

/*
    < BETWEEN AND >
    ������(WHERE)���� ���Ǵ� ����
    �� �̻� �� ������ ������ ���� ������ ������ �� ���
    
    >> ǥ���� <<
    �񱳴���÷��� BETWEEN ���Ѱ� AND ���Ѱ�
    --> �ش� �÷����� ���Ѱ� �̻��̰� ���Ѱ� ������ ���
*/

SELECT EMP_NAME, EMP_ID, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;
-- ���� ������ �÷���
SELECT EMP_NAME, EMP_ID, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;

-- �Ի�����  '90/01/01' ~ '01/01/01' �� ����� ��� �÷�
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-- �ݴ�� �� ������ ������ �Ի��� ������� �ƴ� �� �ܿ� �Ի��� ���
SELECT *
FROM EMPLOYEE
--WHERE NOT HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';
WHERE HIRE_DATE NOT BETWEEN '90/01/01' AND '01/01/01';
-- NOT�� �÷��� �� �Ǵ� BETWEEN �տ� ���԰���

--------------------------------------------------------------------

/*
    < LIKE >
    ���Ϸ��� �÷����� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
    
    >> ǥ���� <<
    �񱳴���÷� LIKE 'Ư������'
    
    - Ư�����Ͽ� '%', '_'�� ���ϵ�ī��� ����� �� ����
    >> '%' : 0�����̻�
    EX) �񱳴���÷��� lIKE '����%' --> �÷��� �߿� '����'�� "����"�Ǵ� �� ��ȸ
        �񱳴���÷��� LIKE '%����' --> �÷��� �߿� '����'�� "��"���� �� ��ȸ
        �񱳴���÷��� LIKE '%����%' --> �÷��� ���߿� '����'�� "����"�Ǵ� �� ��ȸ
        
    >> '_' : 1����
    EX) �񱳴���÷��� LIKE '_����' --> �÷��� �߿� '����'�տ� ������ �� ���ڰ� �� ��� ��ȸ
        �񱳴���÷��� LIKE '__����' --> �÷��� �߿� '����'�տ� ������ �� ���ڰ� �� ��� ��ȸ
        
*/
-- EMPLOYEE ���̺��� ���� ������ �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- �̸� �߿� �ϰ� ���Ե� ����� �����, �ֹι�ȣ, �μ��ڵ� ��ȸ
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- ��ȭ��ȣ�� 4��° �ڸ��� 9�� �����ϴ� ���, �̸� , ��ȭ��ȣ, �̸��� ��ȸ
-- ���ϵ� ī�� : _(1����), %(0�����̻�)
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- EMAIL�� _ �� ���ڰ� 3�ڸ��� �̸��� �ּҸ� ���� ����� ���, �̸�, �̸��� ��ȸ
-- EX) sun_di@kh.or.kr,     yoo_js@kh.or.kr
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';
-- ���ϵ�ī��� ���Ǵ� ���ڿ� ���� �÷����� ��� ���ڰ� �����ؼ� ���� �߻�
--> ��� ���ϵ� ī��� ��� ������ ������ �����������.
--> �����ͷ� ó���� �� �տ� ���Ƿ� ������ ���ϵ� ī�带 �����ϰ� ������ ���ϵ� ī�带 ESCAPE OPTION ��
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';

-- NOT LIKE
-- �达 ���� �ƴ� ������ ���, �̸� , �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE NOT EMP_NAME LIKE '��%';
WHERE EMP_NAME NOT LIKE '��%';

--------------------------------- �ǽ����� -----------------------------------
-- 1. EMPLOYEE ���̺��� �̸� ���� '��'���� ������ ����� �����, �Ի��� ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- 2. EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

-- 3. DEPARTMENT ���̺��� �ؿܿ����ο� ���� ��� �÷� ��ȸ
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '�ؿܿ���%';

------------------------------------------------------------------------

/*
    < IS NULL / IS NOT NULL >
    �񱳴���÷��� IS NULL : �÷����� NULL�� ���
    �񱳴���÷��� IS NOT NULL : �÷����� NULL�� �ƴ� ���
*/

-- ���ʽ��� ���� �ʴ� ����� ���, �̸�, �޿�
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- ������(���)�� ���� ������� �̸�, ������, �μ��ڵ� ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- �����ڵ� ���� �μ���ġ�� ���� ���� ��� ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- �μ���ġ�� ���� �ʾ����� ���ʽ��� �޴� ��� ��ȸ (�̸�, ���ʽ�, �μ��ڵ�)
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-----------------------------------------------------------------------------

/*
    < IN >
    �񱳴���÷��� ����߿� ��ġ�ϴ� ���� �ִ���
    
    �񱳴���÷��� IN ('��', '��', '��', ...)
*/
-- D6�μ������ D8�μ����� D5�� �μ������� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

---------------------------------------------------------------------------

/*
    < ���� ������ : || >
    ���� �÷������� �ϳ��� �÷��� ��ó�� �����ϰų�, �÷��� ���ͷ��� ������ ���� �ִ�.
    
*/
--SYSTEM.OUT.PRINTLN("NUM : " + NUM); + �� ����� �������� �˸� ��(����)

-- ���, �̸�, �޿��� �����ؼ� ��ȸ
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- �÷��� ���ͷ��� ����
SELECT EMP_NAME || '�� ������ ' || SALARY || '�� �Դϴ�.' "�޿� ����" -- ���� Ư������ ������ "" �� �����ְ� �ƴϸ� �׳� �ᵵ ��.
FROM EMPLOYEE;

------------------------------------------------------------------------------------

/*
    < ������ �켱���� >
    0. ()
    1. ���������
    2. ���Ῥ����
    3. �񱳿�����
    4. IS NULL    LIKE    IN
    5. BETWEEN AND 
    6. NOT(��������)
    7. AND(��������)
    8. OR(��������)
    9. 
*/
-- 0R���� AND�� ���� ����
-- �����ڵ尡 J7 �Ǵ� J2 ������ ����� �� �޿��� 200 ���� �̻��� ������� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
--WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J2' AND SALARY >=2000000; -- AND������� �����ϹǷ� J2�� ���� 200���� �̻��λ���� J7��� ��ȸ�� �� ����.
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >=2000000;

-------------------------------------------------------------------------------------------------

/*
    < ORDER BY�� >
    SELECT�� ���� �������� �����ϴ� ����
    SELECT�� ���� ������ �ۼ� �Ӹ� �ƴ϶� ���� ���� ���� ���� ������
    
    >> ǥ���� <<
    SELECT ��ȸ���÷�, �÷�, ...
    FROM ��ȸ�ϰ��� �ϴ� ���̺��
    WHERE ���ǽ�
    ORDER BY ���Ľ�Ű�����ϴ��÷���|��Ī|�÷����� [ASC|DESC] [NULLS FIRST|NULLS LAST];
    
    - ASC : �������� ���� (ASC �Ǵ� DESC ������ �⺻��)
    - DESC : �������� ����
    
    - NULLS FIRST : �����ϰ��� �ϴ� �÷����� NULL�� �ִ� ��� �ش� ������ ���� �� ��
    - NULLS LAST  : �����ϰ��� �ϴ� �÷����� NULL�� �ִ� ��� �ش� ������ ���� �� ��
    
    ** ����(�ؼ�)�Ǵ� ���� **
    1. FROM ��
    2. WHERE ��
    3. SELECT ��
    4. ORDER BY ��
    
*/

SELECT *
FROM EMPLOYEE
--ORDER BY BONUS;
--ORDER BY BONUS ASC;     -- �������� ������ �⺻������ NULLS LAST(NULL�� ���� ���ĵ�)
--ORDER BY BONUS ASC NULLS FIRST;
ORDER BY BONUS DESC;      -- �������� ������ �⺻������ NULLS FIRST


-- BONUS �������� ���� (��, BONUS ���� ��ġ�� ��� �� ���� SALARY������ �������� ����
SELECT *
FROM EMPLOYEE
ORDER BY BONUS DESC, SALARY ASC; -- ���� ���� ������ ���� ����

-- ������ �������� ���ķ� ��ȸ (�̸�, ����)
SELECT EMP_NAME �̸�, SALARY * 12 ����
FROM EMPLOYEE
--ORDER BY SALARY * 12 DESC;
--ORDER BY ���� DESC; -- SELECT���� �̹� ����� ���̱� ������  ORDER BY������ ��Ī ��뵵 �����ϴ�.
ORDER BY 2 DESC; -- �÷� ������ ��� ���� (�������� ��������)






