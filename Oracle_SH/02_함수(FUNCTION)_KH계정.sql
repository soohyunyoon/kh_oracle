
/*
    < ÇÔ¼ö RUNCTION >
    ÄÃ·³°ªÀ» ÀÐ¾î¼­ °è»êÇÑ °á°ú¸¦ ¹ÝÈ¯
    
    - ´ÜÀÏÇà ÇÔ¼ö : N°³ÀÇ °ªÀ» ÀÐ¾î¼­ N°³ÀÇ °á°ú¸¦ ¸®ÅÏ
    - ±×·ì ÇÔ¼ö   : N°³ÀÇ °ªÀ» ÀÐ¾î¼­ 1°³ÀÇ °á°ú¸¦ ¸®ÅÏ
    
    * SELECT Àý¿¡ ´ÜÀÏÇàÇÔ¼ö¿Í ±×·ìÇÔ¼ö¸¦ ÇÔ²² »ç¿ë ¸øÇÔ : °á°ú ÇàÀÇ °³¼ö°¡ ´Ù¸§
    
    * ÇÔ¼ö¸¦ ±â¼úÇÒ ¼ö ÀÖ´Â À§Ä¡ : SELECTÀý, WHEREÀý, ORDER BYÀý, GROUP BYÀý, HAVING Àý
*/

----------------------------- < ´ÜÀÏÇà ÇÔ¼ö > --------------------------------------

/*
    < ¹®ÀÚ °ü·Ã ÇÔ¼ö >
    
    * LENGTH / LENGTHB      => °á°ú°ª NUMBER
    
    LENGTH(ÄÃ·³|'¹®ÀÚ°ª') : ±ÛÀÚ °³¼ö ¹ÝÈ¯
    LENGTHB(ÄÃ·³|'¹®ÀÚ°ª') : ±ÛÀÚÀÇ ¹ÙÀÌÆ®¼ö ¹ÝÈ¯
    
    '°­' '³ª' ÇÑ±Û ÇÑ±ÛÀÚ => 3BYTE
    ¿µ¹®ÀÚ, ¼ýÀÚ Æ¯¼ö¹®ÀÚ ÇÑ±ÛÀÚ => 1BYTE
    
*/
-- ÇÑ±ÛÀº ÇÑ ±ÛÀÚ´ç 3BYTE
-- ¿µ¹®ÀÚ´Â ÇÑ ¹®ÀÚ´ç 1BYTE
SELECT LENGTH('¿À¶óÅ¬'), LENGTHB('¿À¶óÅ¬') 
FROM DUAL; -- °¡»óÅ×ÀÌºí (DUMMY TABLE)

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL), 
       EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)  
FROM EMPLOYEE;

-------------------------------------------------------------------------

/*
    *INSTR
    ÁöÁ¤ÇÑ À§Ä¡ºÎÅÍ ÁöÁ¤ÇÑ ¼ýÀÚ¹øÂ°·Î ³ªÅ¸³»´Â ¹®ÀÚÀÇ ½ÃÀÛ À§Ä¡ ¹ÝÈ¯
    ÀÚ¹Ù¿Í ´Ù¸£°Ô ¼ýÀÚ°¡ 1ºÎÅÍ ½ÃÀÛ
    
    INSTR(ÄÃ·³¸í|'¹®ÀÚ°ª', '¹®ÀÚ', [Ã£À» À§Ä¡ÀÇ ½ÃÀÛ °ª, ¼ø¹ø])       => °á°ú°ª NUMBER
    
    Ã£À» À§Ä¡ÀÇ ½ÃÀÛ°ª
    1 : ¾Õ¿¡¼­ºÎÅÍ Ã£°Ú´Ù
    -1 : µÚ¿¡¼­ºÎÅÍ Ã£°Ú´Ù
    
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;    -- 3 ¹øÂ° ÀÚ¸® B
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 3 ¹øÂ° ÀÚ¸® B
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;-- 10 ¹øÂ° ÀÚ¸® B
SELECT INSTR('AABAACAABBAA', 'B', 1, 3) FROM DUAL; -- ¾Õ¿¡¼­ºÎÅÍ 3¹øÂ° ÇØ´çÇÏ´Â BÀÇ À§Ä¡
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL,'@') "@À§Ä¡", INSTR(EMAIL, 'S', 1, 21 )
FROM EMPLOYEE;

-----------------------------------------------------------------

/*
    SUBSTR
    ¹®ÀÚ¿­¿¡¼­ ÁöÁ¤ÇÑ À§Ä¡ºÎÅÍ ÁöÁ¤ÇÑ °³¼ö ¸¸Å­ÀÇ ¹®ÀÚ¿­À» Ãß­ŒÇØ¼­ ¹ÝÈ¯
    (ÀÚ¹Ù¿¡¼­ÀÇ SUBSTRING(START, END) ¿Í À¯ÇÏ
    SUBSTR(STRING, POSITION, [LENGTH])      => °á°ú°ªÀÌ CHARACTER
    STRING : ¹®ÀÚÅ¸ÀÔ ÄÃ·³ ¶Ç´Â '¹®ÀÚ°ª'
    POSITION : ¹®ÀÚ¿­À» Àß¶ó³¾ ½ÃÀÛÀ§Ä¡
    LENGTH : ÃßÃâÇÒ ¹®ÀÚ °³¼ö (»ý·«½Ã ³¡±îÁö ÀÇ¹Ì)
*/

SELECT SUBSTR('SHOWMETHEMONEY' , 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY' , 5, 2) FROM DUAL; 
SELECT SUBSTR('SHOWMETHEMONEY' , 1, 6) FROM DUAL; 
SELECT SUBSTR('SHOWMETHEMONEY' , -8, 3) FROM DUAL;
SELECT SUBSTR('¼î¿ì ¹Ì ´õ ¸Ó´Ï', 2, 5) FROM DUAL;

-- ÁÖ¹Î¹øÈ£¿¡¼­ ¼ºº°¿¡ ³ªÅ¸³»´Â ºÎºÐ¸¸ Àß¶óº¸±â
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1)
FROM EMPLOYEE;

-- ³²ÀÚ»ç¿ø¸¸ Á¶È¸
SELECT EMP_NAME, '³²' ¼ºº°
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1';

-- ¿©ÀÚ»ç¿ø¸¸ Á¶È¸
SELECT EMP_NAME, '¿©' ¼ºº°
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2';

-- ÇÔ¼ö ÁßÃ¸»ç¿ë
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) ¾ÆÀÌµð
FROM EMPLOYEE;

--------------------------------------------------------------------------

/*
    * LPAD(LEFT) / RPAD(RIGHT)
    ¹®ÀÚ¿¡ ´ëÇØ ÅëÀÏ°¨ÀÖ°Ô º¸¿©ÁÖ°íÀÚ ÇÒ ¶§ »ç¿ë
    
    LPAD/RPAD(STRING, ÃÖÁ¾ÀûÀ¸·Î ¹ÝÈ¯ÇÒ ¹®ÀÚÀÇ ±æÀÌ(¹ÙÀÌÆ®), [µ¡ºÙÀÌ°íÀÚÇÏ´Â ¹®ÀÚ])
    => °á°ú°ª CHARACTER
    
    Á¦½ÃÇÑ ¹®ÀÚ¿­¿¡ ÀÓÀÇÀÇ ¹®ÀÚ¸¦ ¿ÞÂÊ ¶Ç´Â ¿À¸¥ÂÊ¿¡ µ¡ºÙ¿© ÃÖÁ¾ N±æÀÌ¸¸Å­ÀÇ ¹®ÀÚ¿­À» ¹ÝÈ¯
    µ¡ºÙÀÌ°íÀÚ ÇÏ´Â ¹®ÀÚ »ý·«½Ã °ø¹éÀ¸·Î Ã³¸®
*/
-- 20¸¸Å­ÀÇ ±æÀÌ Áß EMAIL°ªÀº ¿À¸¥ÂÊ Á¤·ÄÇÏ°í °ø¹éÀ» ¿ÞÂÊÀ¸·Î Ã¤¿ì°Ú´Ù.
SELECT LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 891201-2******   => ÃÑ±ÛÀÚ¼ö : 14±ÛÀÚ
SELECT RPAD('891201-2', 14, '*')
FROM DUAL;

-- ÁÖ¹Î¹øÈ£ Ã¹ ¹øÂ°ÀÚ¸®ºÎÅÍ ¼ºº°±îÁö¸¦ ÃßÃâÇÑ °á°ú°ª¿¡ ¿À¸¥ÂÊ¿¡ * ¹®ÀÚ Ã¤¿ö¼­ ÃÖÁ¾ÀûÀ¸·Î 14±ÛÀÚ ¹ÝÈ¯
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') ÁÖ¹Îµî·Ï¹øÈ£ 
FROM EMPLOYEE;

-----------------------------------------------------------------------------

/*
    * LTRIM / RTRIM
    
    LTRIM / RTRIM(STRING, [Á¦°ÅÇÏ°íÀÚ ÇÏ´Â ¹®ÀÚµé])       => °á°ú°ª CHARACTER
    
    ¹®ÀÚ¿­ÀÇ ¿ÞÂÊ È¤Àº ¿À¸¥ÂÊ¿¡¼­ Á¦°ÅÇÏ°íÀÚÇÏ´Â ¹®ÀÚµéÀ» Ã£¾Æ¼­ Á¦°ÅÇÑ ³ª¸ÓÁö¸¦ ¹ÝÈ¯
    
*/
SELECT LTRIM('   KH') FROM DUAL;    -- Á¦°ÅÇÏ°íÀÚÇÏ´Â ¹®ÀÚ »ý·«½Ã ±âº»°ªÀÌ °ø¹é. 
                                    -- LTRIMÀÌ¹Ç·Î ¿ÞÂÊÀº ´Ù Áö¿öÁÖ°í °ø¹éÀÌ ¾Æ´Ñ °÷ÀÌ ³ª¿À¸é ±× ÀÌÈÄ·Î °ø¹é ³ª¿Íµµ ¾ÈÁö¿öÁÜ
SELECT LTRIM('000123456','0') FROM DUAL; -- ¿ÞÂÊÀÇ 0Áö¿öÁà / 123456ÀÌ ³ª¿È
SELECT LTRIM('123123KH123','123') FROM DUAL; -- 1,2,3ÀÌ ¾Æ´Ñ ¹®ÀÚ°¡ ³ª¿Â ÀÌÈÄ·Î´Â Áö¿öÁÖÁö ¾ÊÀ½
                                             -- KH123 ÀÌ ³ª¿È/ Á¦½ÃµÈ ¼ýÀÚ ´Ù Áö¿öÁÜ
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL; -- Á¦½ÃÇÑ ¹®ÀÚ ´Ù Áö¿öÁÜ / KH°¡ ³ª¿È
SELECT LTRIM('5782KH123', '0123456789') FROM DUAL; -- ¼ýÀÚ ´Ù Á¦½ÃÇØÁÖ¸é Á¦½ÃÇÑ ¼ýÀÚ°¡ ¾Æ´Ñ ºÎºÐ ³ª¿Â ÈÄ·Î´Â ¾ÈÁö¿öÁü
                                                   -- KH123 ÀÌ ³ª¿È
                                                   
SELECT RTRIM('K H    ', ' ') FROM DUAL; -- K H
SELECT RTRIM('0012300456000','0') FROM DUAL; -- 0012300456

---------------------------------------------------------------------------------

/*
    * TRIM
    ¹®ÀÚ¿­ÀÇ ¾Õ/µÚ/¾çÂÊ¿¡ ÀÖ´Â ÁöÁ¤ÇÑ ¹®ÀÚ¸¦ Á¦°ÅÇÑ ³ª¸ÓÁö¸¦ ¹ÝÈ¯
*/
-- ±âº»ÀûÀ¸·Î´Â ¾çÂÊ¿¡ ÀÖ´Â ¹®ÀÚ Á¦°Å
SELECT TRIM('   K H   ') FROM DUAL; -- Á¦°ÅÇÏ°íÀÚ ÇÏ´Â ¹®ÀÚ »ý·«
-- SELECT TRIM('ZZZKHZZZ','Z') FROM DUAL; -- ¿À·ù
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL; -- KH Á¦°ÅÇÒ ¹®ÀÚ ¾Õ¿¡ ¸ÕÀú Á¦½Ã
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- LEADING : ¾Õ / ¾Õ¿¡ÀÖ´Â ZÁö¿ìÀÚ
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- TRAILING : µÚ
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- ±âº»°ª

-- TRIM([[LEADING) TRAILING|BOTH] Á¦°ÅÇÏ°íÀÚÇÏ´Â ¹®ÀÚ FROM ] STRIMG)

----------------------------------------------------------------------

/*
    * LOWER / UPPER / INITCAP
    
    LOWER : ´Ù ¼Ò¹®ÀÚ·Î
    UPPER : ´Ù ´ë¹®ÀÚ·Î
    INITCAP : ¾Õ±ÛÀÚ¸¸ ´ë¹®ÀÚ·Î
    
    LOWER/UPPER/INITCAP(STRING)     => °á°ú°ª CHARACTER
*/

SELECT LOWER('Welcome To My World!') FROM DUAL;
SELECT UPPER('Welcome To My World!') FROM DUAL;
SELECT INITCAP('welcome to myworld!') FROM DUAL; -- °ø¹é±âÁØ ¹Ù·Î µÚ ´Ü¾î ´ë¹®ÀÚ·Î

------------------------------------------------------------------------------

/*
    * CONCAT
    ¹®ÀÚ¿­ µÎ°³ Àü´Þ¹Þ¾Æ ÇÏ³ª·Î ÇÕÄ£ ÈÄ °á°ú ¹ÝÈ¯
    
    CONCAT(STRING, STRING)          => °á°ú°ª CHARACTER
*/

SELECT CONCAT('°¡³ª´Ù¶ó', 'ABCD') FROM DUAL;
SELECT '°¡³ª´Ù¶ó' || 'ABCD' FROM DUAL; -- ¿¬°á¿¬»êÀÚ¶û µ¿ÀÏÇÑ ³»¿ë ¼öÇà

----------------------------------------------------------------------

/*
    * REPLACE
    
    REPLACE(STRING, STR1, STR2) ==> °á°ú°ª CHARACTER
    STRING¿¡¼­ STR1À» STR2·Î º¯°æ
*/
SELECT REPLACE('¼­¿ï½Ã °­³²±¸ ¿ª»ïµ¿', '¿ª»ï', '»ï¼º') FROM DUAL;

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
FROM EMPLOYEE;

------------------------------------------------------------------------

/*
    < ¼ýÀÚ °ü·Ã ÇÔ¼ö >
    
    * ABS
    Àý´ë°ª ±¸ÇÏ´Â ÇÔ¼ö
    
    ABS(NUMBER)         => °á°ú°ª NUMBER
    
*/
SELECT ABS(-10.9) FROM DUAL;
SELECT ABS(-10) FROM DUAL;

---------------------------------------------------------------------------

/*
    * MOD 
    µÎ ¼ö¸¦ ³ª´« ³ª¸ÓÁö¸¦ ¹ÝÈ¯ÇØÁÖ´Â ÇÔ¼ö
    
    MOD(NUMBER, NUMBER) ==> °á°ú°ª NUMBER
*/
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(-10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;
SELECT MOD(-10.9, 3) FROM DUAL;

---------------------------------------------------------------------
/*
    * ROUND
    ¹Ý¿Ã¸² ÇØÁÖ´Â ÇÔ¼ö
    
    ROUND(NUMBER, [À§Ä¡])     => °á°ú°ª NUMBER
*/
SELECT ROUND(123.456) FROM DUAL; -- À§Ä¡ ÁöÁ¤ ¾ÈÇÏ¸é 0À¸·Î ÇØÁØ°Å¿Í ¶È°°´Ù
SELECT ROUND(123.456, 0) FROM DUAL; -- 123
SELECT ROUND(123.456, 1) FROM DUAL; -- 123.5 ¹Ý¿Ã¸²ÇÔ
SELECT ROUND(123.456, 2) FROM DUAL; -- 123.46
SELECT ROUND(123.456, 4) FROM DUAL; -- 123.456 ¾ø´Â °ª Á¦½ÃÇÏ¸é ¿ø·¡ °ª ³ª¿È
SELECT ROUND(123.456, -1) FROM DUAL; -- 120
SELECT ROUND(123.456, -2) FROM DUAL; -- 100

----------------------------------------------------------------

/*
    * CEIL
    ¿Ã¸²Ã³¸®ÇØÁÖ´Â ÇÔ¼ö
    
    CEIL(NUMBER)
*/
SELECT CEIL(123.456) FROM DUAL; -- ¹«Á¶°Ç ¿Ã¸²

----------------------------------------------------------------
/*
    *FLOOR
    ¼Ò¼öÁ¡ ¾Æ·¡ ¹ö¸²ÇÏ´Â ÇÔ¼ö
    
    FLOOR(NUMBER)
*/
SELECT FLOOR(123.456) FROM DUAL; -- 123
SELECT FLOOR(123.987) FROM DUAL; -- 123
---------------------------------------------------------------------

/*
    * TRUNC
    À§Ä¡ ÁöÁ¤°¡´ÉÇÑ ¹ö¸²Ã³¸®ÇØÁÖ´Â ÇÔ¼ö
    
    TRUNC(NUMBER, [À§Ä¡])
*/
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;

-------------------------------------------------------------------

/*
    < ³¯Â¥ °ü·Ã ÇÔ¼ö >
*/

-- * SYSDATE : ½Ã½ºÅÛ ³¯Â¥ ¹ÝÈ¯(¿À´Ã³¯Â¥)
SELECT SYSDATE FROM DUAL;

-- * MONTHS_BETWEEN(DATE1, DATE2) : µÎ ³¯Â¥ »çÀÌÀÇ °³¿ù ¼ö --> DATE1-DATE2
--  => °á°ú°ª NUMBER
-- EMPLOYEE Å×ÀÌºí¿¡¼­ Á÷¿ø¸í, ÀÔ»çÀÏ, ±Ù¹«°³¿ù¼ö
SELECT EMP_NAME, HIRE_DATE, CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))||'°³¿ùÂ÷' ±Ù¹«°³¿ù¼ö
FROM EMPLOYEE;

-- * ADD_MONTHS(DATE, NUMBER) : Æ¯Á¤ ³¯Â¥¿¡ ÇØ´ç ¼ýÀÚ¸¸Å­ÀÇ °³¿ù¼ö¸¦ ´õÇØ¼­ ±× ³¯Â¥¸¦ ¸®ÅÏ
--   => °á°ú°ª DATE
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- EMPLOYEE Å×ÀÌºí¿¡¼­ Á÷¿ø¸í, ÀÔ»çÀÏ, ÀÔ»ç ÈÄ 6°³¿ùÀÌ µÈ ³¯Â¥ Á¶È¸
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;

-- * NEXT_DAY(DATE, ¿äÀÏ(¹®ÀÚ|¼ýÀÚ)) : Æ¯Á¤³¯Â¥¿¡¼­ ±¸ÇÏ·Á´Â ¿äÀÏÀÇ °¡Àå °¡±î¿î ³¯Â¥¸¦ ¹ÝÈ¯ÇØÁÖ´Â ÇÔ¼ö
--   => °á°ú°ª DATE
SELECT SYSDATE, NEXT_DAY(SYSDATE, '¸ñ¿äÀÏ') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '¸ñ') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 5) FROM DUAL; -- 1: ÀÏ¿äÀÏ, 2: ¿ù¿äÀÏ.... 7: Åä¿äÀÏ
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL; -- ¿¡·¯(ÇöÀç ¾ð¾î°¡ KOREAN)ÀÌ±â ¶§¹®

-- ¾ð¾îº¯°æ
ALTER SESSION SET NLS_LANGUAGE = KOREAN; -- AMERICAN

-- * LAST_DAY(DATE) : ÇØ´ç ¿ùÀÇ ¸¶Áö¸· ³¯Â¥¸¦ ±¸ÇØ¼­ ¹ÝÈ¯
--   => °á°ú°ª DATE
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE Å×ÀÌºí¿¡¼­ Á÷¿ø¸í, ÀÔ»çÀÏ, ÀÔ»ç¿ùÀÇ ¸¶Áö¸· ³¯Â¥ Á¶È¸
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;

/*
    * EXTRACT : ³âµµ, ¿ù, ÀÏ Á¤º¸¸¦ ÃßÃâÇØ¼­ ¹ÝÈ¯
    
    EXTRACT(YEAR FROM DATE) : ³âµµ¸¸ ÃßÃâ
    EXTRACT(MONTH FROM DATE) : ¿ù¸¸ ÃßÃâ
    EXTRACT(DAY FRM DATE) : ÀÏ¸¸ ÃßÃâ
*/

-- EMPLOYEE Å×ÀÌºí¿¡¼­ Á÷¿ø¸í, ÀÔ»ç³âµµ, ÀÔ»ç¿ù, ÀÔ»çÀÏ Á¶È¸
SELECT EMP_NAME, 
       EXTRACT(YEAR FROM HIRE_DATE) ÀÔ»ç³âµµ,
       EXTRACT(MONTH FROM HIRE_DATE) ÀÔ»ç¿ù,
       EXTRACT(DAY FROM HIRE_DATE) ÀÔ»çÀÏ
FROM EMPLOYEE
ORDER BY ÀÔ»ç³âµµ, ÀÔ»ç¿ù, ÀÔ»çÀÏ;

-- ³¯Â¥ Æ÷¸Ë º¯°æ
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
ALTER SESSION SET NLS_DATE_FORMAT='RR/MM/DD'; -- YY´Â ÇöÀç 21¼¼±âÀÌ°í RRÀº À¯µµ¸®ÀÖÀ½

SELECT SYSDATE FROM DUAL;

--------------------------------------------------------------------------

/*
    < Çüº¯È¯ ÇÔ¼ö >
    
    * ¼ýÀÚ/³¯Â¥     --> ¹®ÀÚ·Î º¯È¯
    
    TO_CHAR(³¯Â¥|¼ýÀÚ, [Æ÷¸Ë]) : ³¯Â¥Çü ¶Ç´Â ¼ýÀÚÇü µ¥ÀÌÅÍ¸¦ ¹®ÀÚÅ¸ÀÔÀ¸·Î º¯È¯
    
*/

-- ¼ýÀÚ --> ¹®ÀÚ
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 5Ä­Â¥¸® °ø°£È®º¸, ¿À¸¥ÂÊÁ¤·Ä, ºóÄ­À» °ø¹éÀ¸·Î Ã¤¿î´Ù(9ÀÇ ÀÇ¹Ì)
SELECT TO_CHAR(1234,'00000') FROM DUAL; -- 5Ä­Â¥¸® °ø°£È®º¸, ¿À¸¥ÂÊÁ¤·Ä, ºóÄ­Àº 0À¸·Î Ã¤¿öÁÜ
SELECT TO_CHAR(1234,'L00000') FROM DUAL; -- ÇöÀç ¼³Á¤µÈ ³ª¶ó(LOCAL)ÀÇ È­Æó´ÜÀ§ + À§ÀÇ ³»¿ë
SELECT TO_CHAR(1234, 'L99999') FROM DUAL; -- ÇöÀç ¼³Á¤µÈ ³ª¶ó(LOCAL)ÀÇ È­Æó´ÜÀ§ + À§ÀÇ ³»¿ë
SELECT TO_CHAR(1234,'$99999') FROM DUAL;
SELECT TO_CHAR(1234,'L99,999') FROM DUAL; --ÀÚ¸´¼ö ±¸ºÐ ÄÞ¸¶

-- EMPLOYEE »ç¿ø¸í, ±Þ¿©Á¶È¸
SELECT EMP_NAME, TO_CHAR(SALARY,'L999,999,999')
FROM EMPLOYEE;

-- ³¯Â¥ --> ¹®ÀÚ
SELECT TO_CHAR(SYSDATE,'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'AM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'MON DY, YYYY') FROM DUAL;  --MON¿ù DY¿äÀÏ
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE;

-- 1990³â 02¿ù 06ÀÏ
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"³â" MM"¿ù" DD"ÀÏ"') -- -´Â Æ÷¸Ë¿¡ ³»ÀåµÇ¾î ÀÖÁö¸¸ ¹®ÀÚ´Â ¾Æ´Ï¹Ç·Î ""·Î Ç¥½ÃÇØ¾ßÇÔ
FROM EMPLOYEE;

-- ³âµµ Æ÷¸Ëµé
-- ³âµµ¿¡ °ü·ÃÇÑ Æ÷¸Ë¹®ÀÚ´Â 'Y', 'R' ÀÖÀ½ / Y´Â ¹«Á¶°Ç ÇöÀç RÀº 50³â ¹Ì¸¸ÀÌ¸é ÇöÀç°í 50 ÀÌ»óÀÌ¸é ÀÌÀü¼¼±â·Î ¹Ý¿µ
-- YY´Â ¹«Á¶°Ç ÇöÀç¼¼±â¸¦ ¹Ý¿µ
-- RRÀº 50¹Ì¸¸ÀÌ¸é ÇöÀç¼¼±â¸¦ ¹Ý¿µ, 50ÀÌ»óÀÌ¸é ÀÌÀü¼¼±â ¹Ý¿µ
-- 20  18  90  --> YY --> 2020  2018  2090
-- 20  18  90  --> RR --> 2020  2018  1990

SELECT TO_CHAR(SYSDATE, 'YYYY'), -- 2020
       TO_CHAR(SYSDATE, 'RRRR'), -- 2020
       TO_CHAR(SYSDATE, 'YY'), -- 20
       TO_CHAR(SYSDATE, 'RR'), -- 20
       TO_CHAR(SYSDATE, 'YEAR') --TWENTY TWENTY
FROM DUAL;

-- ¿ù¿¡ ´ëÇÑ Æ÷¸Ë
SELECT TO_CHAR(SYSDATE, 'MM'), -- 07
       TO_CHAR(SYSDATE, 'MON'), -- 7¿ù
       TO_CHAR(SYSDATE, 'MONTH'), -- 7¿ù
       TO_CHAR(SYSDATE, 'RM') -- VII (·Î¸¶±âÈ£)
FROM DUAL;

-- ÀÏ¿¡ ´ëÇÑ Æ÷¸Ë
SELECT TO_CHAR(SYSDATE, 'DDD'), --189   1³â ±âÁØÀ¸·Î ¸çÄ¥Â°ÀÎÁö
       TO_CHAR(SYSDATE, 'DD'), -- 07    1´Þ ±âÁØÀ¸·Î ¸çÄ¥Â°ÀÎÁö
       TO_CHAR(SYSDATE, 'D') - 3        1ÁÖ ±âÁØÀ¸·Î ¸çÄ¥Â°ÀÎÁö
FROM DUAL;

-- ¿äÀÏ¿¡ ´ëÇÑ Æ÷¸Ë
SELECT TO_CHAR(SYSDATE, 'DY'), -- È­
       TO_CHAR(SYSDATE, 'DAY') -- È­¿äÀÏ
FROM DUAL;

--EMPLOYEEÅ×ÀÌºí¿¡¼­ Á÷¿ø¸í, ÀÔ»çÀÏ Á¶È¸
-- ÀÔ»çÀÏÀ» Æ÷¸ËÁöÁ¤ÇØ¼­ Á¶È¸(2017³â 12¿ù 06ÀÏ (¼ö))
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"³â" MM"¿ù" DD"ÀÏ" (DY)')
FROM EMPLOYEE;

----------------------------------------------------------------------------

/*
    * ¼ýÀÚ / ¹®ÀÚ --> ³¯Â¥
    
    TO_DATE(¼ýÀÚ|¹®ÀÚ, [Æ÷¸Ë]) : ¼ýÀÚÇü ¶Ç´Â ¹®ÀÚÇü µ¥ÀÌÅÍ¸¦ ³¯Â¥ Å¸ÀÔÀ¸·Î º¯È¯   => °á°ú°ª DATE
*/
SELECT TO_DATE(20200101) FROM DUAL;
SELECT TO_DATE('20200101') FROM DUAL;
SELECT TO_DATE('200101') FROM DUAL;
SELECT TO_DATE('20200101', 'YYYYMMDD') FROM DUAL;

SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL; -- 98/06/30 2098 / YY : ¹«Á¶°Ç ÇöÀç¼¼±â
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL; -- 98/06/30 1998 / RR : 50ÀÌ»óÀÌ¸é ÀÌÀü¼¼±â, 50¹Ì¸¸ÀÌ¸é ÇöÀç¼¼±â

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL;
SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL;

-- EMPLOYEE Å×ÀÌºí¿¡¼­ 1998³âµµ ÀÌÈÄ¿¡ ÀÔ»çÇÑ »ç¿øÀÇ »ç¹ø, ÀÌ¸§, ÀÔ»çÀÏ Á¶È¸
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('980101', 'RRMMDD');

----------------------------------------------------------------------------

/*
    * ¹®ÀÚ    --> ¼ýÀÚ
    
    TO_NUMBER(¹®ÀÚµ¥ÀÌÅÍ, [Æ÷¸Ë]) : ¹®ÀÚÇü µ¥ÀÌÅÍ¸¦ ¼ýÀÚÅ¸ÀÔÀ¸·Î º¯È¯
    
*/
SELECT TO_NUMBER('0123456789') FROM DUAL;

SELECT '123' + '456' FROM DUAL; --> ¾Ë¾Æ¼­ ÀÚµ¿À¸·Î ¼ýÀÚ·Î Çüº¯È¯ ÇÑ µÚ ¿¬»êÃ³¸® ¼öÇà
SELECT '123' + '456A' FROM DUAL; --> ¿¡·¯¹ß»ý

-- ¹®ÀÚ¾È¿¡ ¼ýÀÚµé¸¸ ´ã°ÜÀÖÀ» ¶§ ÀÚµ¿ Çüº¯È¯µÊ.
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID >= 210; -- EMP_ID´Â ¹®ÀÚ°ªÀÌÁö¸¸ ÀÚÀ¯·Ó°Ô Çüº¯È¯ µÅ¼­ ¼ýÀÚÀÎ 210¶û ºñ±³°¡ µÊ

SELECT '10,000,000' + '555,000' FROM DUAL; -- ¿ÏÀü ¼ýÀÚ¸¸ ÀÖ´Â°Ô ¾Æ´Ï¶ó , °¡ ÀÖ±â ‹š¹®¿¡ ÀÚµ¿Çüº¯È¯ ¾ÈµÊ. ¿¡·¯¹ß»ý
SELECT TO_NUMBER('10,000,000', '99,999,999') + TO_NUMBER('555,000', '999,999') FROM DUAL; -- TO_NUMBER·Î Çüº¯È¯ ½ÃÄÑÁØ ÈÄ µ¡¼À°¡´É

------------------------------------------------------------------------------------------------------

/*
    < NULL Ã³¸® ÇÔ¼ö >
*/
-- * NVL(ÄÃ·³¸í, ÄÃ·³°ªÀÌ NULLÀÏ °æ¿ì ¹Ù²Ü °ª)
SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

SELECT EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, 'D0')
FROM EMPLOYEE;

-- * NVL2(ÄÃ·³¸í, ¹Ù²Ü °ª1, ¹Ù²Ü °ª2)
-- ÄÃ·³ °ªÀÌ Á¸ÀçÇÏ¸é ¹Ù²Ü °ª1·Î
-- ÄÃ·³ °ªÀÌ NULL°ªÀÌ¸é ¹Ù²Ü °ª 2·Î º¯°æ

SELECT EMP_NAME, BONUS, NVL(BONUS,0), NVL2(BONUS, 0.7, 0)
FROM EMPLOYEE;

-- * NULLIF(ºñ±³´ë»ó1, ºñ±³´ë»ó2)
-- µÎ °³ÀÇ °ªÀÌ µ¿ÀÏÇÏ¸é NULL°ª ¹ÝÈ¯
--            µ¿ÀÏÇÏÁö ¾ÊÀ¸¸é ºñ±³´ë»ó1 ¹ÝÈ¯
SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '567') FROM DUAL;

------------------------------------------------------------------------

/*
    < ¼±ÅÃÇÔ¼ö > 
    ¿©·¯°¡Áö °æ¿ì¿¡ ¼±ÅÃÀ» ÇÒ ¼ö ÀÖ´Â ±â´ÉÀ» Á¦°ø
    
    * DECODE(ºñ±³ÇÏ°íÀÚÇÏ´Â´ë»ó(ÄÃ·³¸í|°è»ê½Ä), Á¶°Ç°ª1, °á°ú°ª1, Á¶°Ç°ª2, °á°ú°ª2, ...)
    ºñ±³ÇÏ°íÀÚÇÏ´Â °ªÀÌ Á¶°Ç°ª°ú ÀÏÄ¡ÇÒ °æ¿ì ±×¿¡ ÇØ´çÇÏ´Â °á°ú°ª ¹ÝÈ¯ÇØÁÖ´Â ÇÔ¼ö
    
    
    
    SWITCH(ºñ±³ÇÏ°íÀÚÇÏ´Â´ë»ó) {
    CASE Á¶°Ç°ª1: °á°ú°ª1
    CASE Á¶°Ç°ª2: °á°ú°ª2
    DEFAULT: °á°ú°ª
    }
    
*/
-- »ç¹ø, »ç¿ø¸í, ÁÖ¹Î¹øÈ£, ¼ºº°
SELECT EMP_ID, EMP_NAME, EMP_NO,
       DECODE(SUBSTR(EMP_NO,8, 1), '1', '³²', '2', '¿©') ¼ºº°
FROM EMPLOYEE;

-- Á÷¿øÀÇ ±Þ¿© ÀÎ»óÇØ¼­ Á¶È¸
-- Á÷±ÞÄÚµå°¡ J7ÀÎ »ç¿øÀº ±Þ¿©¸¦ 10%ÀÎ»ó
-- Á÷±ÞÄÚµå°¡ J6ÀÎ »ç¿øÀº ±Þ¿©¸¦ 15%ÀÎ»ó
-- Á÷±ÞÄÚµå°¡ J5ÀÎ »ç¿øÀº ±Þ¿©¸¦ 20%ÀÎ»ó
-- ±× ¿ÜÀÇ Á÷±ÞÀÇ »ç¿øÀº ±Þ¿©¸¦ 5%ÀÎ»ó
-- Á÷¿ø¸í, Á÷±ÞÄÚµå, ±âÁ¸±Þ¿©, ÀÎ»óµÈ±Þ¿©

SELECT EMP_NAME, JOB_CODE, SALARY ±âÁ¸±Þ¿©,
       DECODE(JOB_CODE, 'J7', SALARY*1.1,
                        'J6', SALARY*1.15,
                        'J5', SALARY*1.2,
                              SALARY*1.05) ÀÎ»ó±Þ¿©
FROM EMPLOYEE;

/*
    * CASE WHEN THEN
    
    CASE WHEN Á¶°Ç½Ä1 THEN °á°ú°ª1
         WHEN Á¶°Ç½Ä2 THEN °á°ú°ª2
         ELSE °á°ú°ª
    END
    
    ³» ¸¶À½´ë·Î Á¶°Ç½Ä ÀÛ¼º °¡´É (¹üÀ§ÁöÁ¤°¡´É)
    (ÀÚ¹Ù¿¡¼­ IF-ELSE IF¹®)
*/
SELECT EMP_ID, EMP_NAME, EMP_NO,
       CASE WHEN SUBSTR(EMP_NO, 8, 1)='1' THEN '³²'
            WHEN SUBSTR(EMP_NO, 8, 1)='2' THEN '¿©'
        END ¼ºº°
FROM EMPLOYEE;

-- »ç¿ø¸í, ±Þ¿©, ±Þ¿©µî±Þ('1µî±Þ','2µî±Þ','3µî±Þ','4µî±Þ')
-- SALARY°ªÀÌ 500¸¸¿ø ÃÊ°úÀÏ °æ¿ì 1µî±Þ
-- SALARY°ªÀÌ 500¸¸¿ø ÀÌÇÏ 350¸¸¿ö³Ê ÃÊ°úÀÏ °æ¿ì 2µî±Þ
-- SALARY°ªÀÌ 350¸¸¿ø ÀÌÇÏ 200¸¸¿ø ÃÊ°úÀÏ °æ¿ì 3µî±Þ
-- ±× ¿ÜÀÇ °æ¿ì 4µî±Þ

SELECT EMP_NAME, SALARY,
       CASE WHEN SALARY > 5000000 THEN '1µî±Þ'
            WHEN SALARY > 3500000 THEN '2µî±Þ'
            WHEN SALARY > 2000000 THEN '3µî±Þ'
            ELSE '4µî±Þ'
        END µî±Þ
FROM EMPLOYEE;

---------------------------------------------------------------------
-- 1. SUM(¼ýÀÚ¿¡ ÇØ´çÇÏ´Â ÄÃ·³) : ÃÑ ÇÕ°è¸¦ ¹ÝÈ¯ÇØÁÖ´Â ÇÔ¼ö
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- ³²ÀÚ»ç¿øÀÇ ÃÑ ±Þ¿©ÇÕ
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1'; -- 2

-- ºÎ¼­ÄÚµå°¡ D5ÀÎ »ç¿øµéÀÇ ÃÑ ¿¬ºÀÇÕ
SELECT SUM(SALARY*12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 2. AVG(¼ýÀÚ¿¡ÇØ´çÇÏ´ÂÄÃ·³) : Æò±Õ°ªÀ» ±¸ÇØ¼­ ¹ÝÈ¯
-- Àü »ç¿øÀÇ ±Þ¿© Æò±Õ Á¶È¸
SELECT AVG(SALARY)
FROM EMPLOYEE;

SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 3. MIN(ÄÃ·³¸í) : ÄÃ·³°ªµé Áß¿¡ °¡Àå ÀÛÀº°ª ¹ÝÈ¯
--                 Ãë±ÞÇÏ´Â ÀÚ·áÇüÀº ANY TYPEÀÓ
SELECT MIN(EMP_NAME),MIN(EMAIL), MIN(SALARY), MIN(HIRE_DATE)
FROM EMPLOYEE;

-- 4. MAX(ÄÃ·³¸í) : ÄÃ·³°ªµé Áß¿¡ °¡Àå Å« °ª ¹ÝÈ¯
                   Ãë±ÞÇÏ´Â ÀÚ·áÇüÀº ANY TYPEÀÓ
SELECT MAX(EMP_NAME), MAX(EMAIL), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- 5. COUNT(*|ÄÃ·³¸í) : Çà °³¼ö¸¦ ¼¼¼­ ¹ÝÈ¯
--    COUNT(*) : Á¶È¸°á°ú¿¡ ÇØ´çÇÏ´Â Çà °³¼ö ´Ù ¼¼¼­ ¹ÝÈ¯ (NULL Æ÷ÇÔ)
--    COUNT(ÄÃ·³¸í) : ÇØ´ç ÄÃ·³°ªÀÌ NULLÀÌ ¾Æ´Ñ °Í¸¸ Çà °³¼ö ´Ù ¼¼¼­ ¹ÝÈ¯
--    COUNT(DISTINCT ÄÃ·³¸í) : Áßº¹ Á¦°ÅÇÑ Çà °³¼ö ¼¼¼­ ¹ÝÈ¯

-- ÀüÃ¼ »ç¿ø ¼ö
SELECT COUNT(*)
FROM EMPLOYEE;

SELECT COUNT('1') -- ¾î¶²°É ³Ö¾îµµ ´Ù ¼¼¾îÁÜ ±âº» *·Î ¾²´Â°Í
FROM EMPLOYEE;

SELECT COUNT(NULL) -- 0
FROM EMPLOYEE;

-- ³²ÀÚ »ç¿ø ¼ö
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1';

-- ºÎ¼­¹èÄ¡°¡ µÈ »ç¿ø ¼ö (DEPT_CODE¿¡ °ªÀÌ ÀÖ´Â »ç¿ø ¼ö)
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- ÇöÀç »ç¿øµéÀÌ ¼ÓÇØÀÖ´Â ºÎ¼­µé
SELECT COUNT(DISTINCT DEPT_CODE) -- NULL°ªÀº Á¦¿Ü(6)
FROM EMPLOYEE;

-- ÇöÀç »ç¿øµéÀÌ ºÐÆ÷µÇ¾îÀÖ´Â Á÷±ÞÀÇ ¼ö
SELECT COUNT(DISTINCT JOB_CODE)
FROM EMPLOYEE;
