-- 1. ������ �븮�̸鼭 ASIA������ �ٹ��ϴ� ��������
--    ���, �����, ���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
SELECT E.EMP_ID,
       E.EMP_NAME,
       J.JOB_NAME,
       D.DEPT_TITLE, 
       L.LOCAL_NAME,
       E.SALARY
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE AND L.LOCAL_NAME LIKE 'ASIA%' 
      AND D.DEPT_ID = E.DEPT_CODE 
      AND J.JOB_CODE = E.JOB_CODE AND J.JOB_NAME = '�븮';

-- 2. 70�����̸鼭 �����̰�, ���� ������ ��������
--    �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�

SELECT E.EMP_NAME,
       E.EMP_NO,
       D.DEPT_TITLE,
       J.JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
      AND E.JOB_CODE = J.JOB_CODE
      AND SUBSTR(E.EMP_NO, 1,2) BETWEEN 70 AND 79
      AND SUBSTR(E.EMP_NO, 8,1) = '2'
      AND E.EMP_NAME LIKE '��%';

-- 3. �̸��� '��'�ڰ� ����ִ� ��������
--    ���, �����, ���޸��� ��ȸ�Ͻÿ�
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
      AND E.EMP_NAME LIKE '%��%';

-- 4. �ؿܿ������� �ٹ��ϴ� ��������
--    �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�
SELECT E.EMP_NAME,
       J.JOB_NAME,
       E.DEPT_CODE,
       D.DEPT_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND DEPT_TITLE LIKE '�ؿܿ���%'
      AND E.JOB_CODE = J.JOB_CODE;

-- 5. ���ʽ��� �޴� ��������
--    �����, ���ʽ�, ����, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
SELECT E.EMP_NAME,
       E.BONUS,
       E.SALARY,
       D.DEPT_TITLE,
       L.LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID
      AND D.LOCATION_ID = L.LOCAL_CODE
      AND E.BONUS IS NOT NULL;
       
-- 6. �μ��� �ִ� ��������
--    �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
SELECT E.EMP_NAME,
       J.JOB_NAME,
       D.DEPT_TITLE,
       L.LOCAL_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE
      AND E.DEPT_CODE = D.DEPT_ID AND E.DEPT_CODE IS NOT NULL
      AND D.LOCATION_ID = L.LOCAL_CODE;

-- 7. '�ѱ�'�� '�Ϻ�'�� �ٹ��ϴ� �������� 
--    �����, �μ���, �ٹ�������, �ٹ��������� ��ȸ�Ͻÿ�

SELECT E.EMP_NAME,
       D.DEPT_TITLE,
       L.LOCAL_NAME,
       N.NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID
      AND D.LOCATION_ID = L.LOCAL_CODE 
      AND L.NATIONAL_CODE = N.NATIONAL_CODE AND (NATIONAL_NAME LIKE '�ѱ�' OR NATIONAL_NAME LIKE '�Ϻ�');

-- 8. ���ʽ��� ���� �ʴ� ������ �� �����ڵ尡 J4 �Ǵ� J7�� ��������
--    �����, ���޸�, �޿��� ��ȸ�Ͻÿ�
SELECT E.EMP_NAME, J.JOB_NAME, E.SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE (JOB_CODE = 'J4' OR JOB_CODE = 'J7') AND E.BONUS IS NULL;

-- 9. ���, �����, ���޸�, �޿����, ������ ��ȸ�ϴµ�
--    �̶� ���п� �ش��ϴ� ����
--    �޿������ S1, S2�� ��� '���'
--    �޿������ S3, S4�� ��� '�߱�'
--    �޿������ S5, S6�� ��� '�ʱ�' ���� ��ȸ�ǰ� �Ͻÿ�. //////////����

SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, S.SAL_LEVEL,
    CASE WHEN S.SAL_LEVEL IN ('S1', 'S2') THEN '1���'
         WHEN S.SAL_LEVEL IN ('S3' , 'S4') THEN '2���'
         WHEN S.SAL_LEVEL IN ('S5', 'S6') THEN '3���'
    END ����
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
JOIN SAL_GRADE S ON (E.SALARY BETWEEN MIN_SAL AND MAX_SAL);



-- 10. �� �μ��� �� �޿����� ��ȸ�ϵ�
--     �̶�, �� �޿����� 1000���� �̻��� �μ���, �޿����� ��ȸ�Ͻÿ� ///////
SELECT D.DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE E, DEPARTMENT D
    GROUP BY D.DEPT_TITLE
    HAVING SUM(E.SALARY) >= 10000000;

-- 11. �� �μ��� ��ձ޿��� ��ȸ�Ͽ� �μ���, ��ձ޿� (����ó��)�� ��ȸ�Ͻÿ�.
--      ��, �μ���ġ�� �ȵ� ������� ��յ� ���� �����Բ� �Ͻÿ�.////����
SELECT D.DEPT_TITLE, AVG(SALARY)
FROM EMPLOYEE E, DEPARTMENT D
GROUP BY D.DEPT_TITLE;
