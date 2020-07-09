-- 한 줄짜리 주석
/*
    여러줄 주석
*/

-- 사용자계정 생성하는 구문 (관리자 계정만 할 수 있는 역할)
-- (표현법) CREATE USER 계정명 IDENTIFIED BY 계정비밀번호; (;을 안쓰면 이어져서 만들어짐. 끊는다는 표시니 꼭 작성하자)
CREATE USER KH IDENTIFIED BY KH;

-- 위에서 만들어진 사용자 계정에게 최소한의 권한(데이터관리, 접속) 부여
-- (표현법) GRANT 권한1, 권한2, ... TO 계정명;
GRANT RESOURCE, CONNECT TO KH;