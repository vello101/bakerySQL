DBMS(Database Management System):
데이터베이스를 관리하고 운영하는 소프트웨어


마리아DB 설치
- 사용 자체는 무료.
- 배포할 때는 마리아db서버에 올려야함 -> 비용청구

DBMS에서 다루는 언어 SQL
- 프론트엔드와 마찬가지로 제공하는 편집기가 있음.
mariaDB 편집 프로그램 -> HedidiSQL

순서
1. 데이터베이스 생성
2. table 생성 ex.member
3. column(열,field)
김은영: 이메일, 비번, 이름, 기본주소,상세주소,우편번호,전화번호

- 밑에 써지는 파란색코드들 ->SQL문
Q. SQL(structured query language)이란 무엇인가요?
구조적 쿼리 언어(SQL)는 관계형 데이터베이스에 정보를 저장하고 처리하기 위한 프로그래밍 언어입니다. 관계형 데이터베이스는 정보를 표 형식으로 저장하며, 행과 열은 다양한 데이터 속성과 데이터 값 간의 다양한 관계를 나타냅니다. SQL 문을 사용하여 데이터베이스에서 정보를 저장, 업데이트, 제거, 및 검색할 수 있습니다. 데이터베이스 성능을 유지 관리하고 최적화하는 데 SQL을 사용할 수도 있습니다.
출처: aws

create database 데이터베이스명;
use 데이터베이스명; 데이터베이스를 만들고 사용하기 위한 코드
java할 때 sql구문들 집어넣어야 하므로 기억 필요

상품,게시판,회원data 구분해서 집어넣어야 ->table필요
실제 저장할 정보는 table만들어야

데이터유형: VARCHAR(유동적) 단, 처리속도가 좀 더 느림
길이:255
ex. CHAR(고정적, 처리속도가 살짝 빠름) 
길이:100 -> 길이가3밖에 안된다->리소스 낭비

userEmail..은 필수정보->null허용하면 안됨.
table마다 중복되지 않는 고윳값을 갖는 field를 만들어줘야
auto-increment: insert할때마다 1씩 증가
->프라이머리 키(노란열쇠)를 반드시 설정해야(왜? 절대 중복되지 않음) ->데이터관리 편해짐.
즉 이 table의 핵심을 userNo

최초 글 작성날짜,수정날짜->date 2개

insert부터는 java에서 쓸 일이 많다.->쿼리연습
insert는 테이블에 데이터를 삽입하는 명령어

db table의 data 한줄한줄을 (record,row,tuple)라고 함.

관리자만 볼 수 있는 사이트
검색하면 회원목록 뜨게 ->select문(원하는 데이터 가져옴)

% 대체문자
where절의 =는 비교연산자 ->%사용불가

SQL 문법
동시에,이면서,이고,모든:AND
같지않다 <>, !=

product.json table생성
prdNo auto-increment 항목1

상품테이블(entity)
-상품번호
-분류
-상품명
-상품가격
-상품요약설명
(er 다이어그램 그리기)

update table명;

insert, update, select

SELECT COUNT(*) FROM product;
SELECT COUNT(*) AS '제품 총 갯수' FROM product;
SELECT MIN(reviewCount) FROM product;
SELECT MAX(reviewCount) FROM product;
SELECT AVG(reviewCount) FROM product;
SELECT COUNT(DISTINCT category) FROM product; //중복 데이터제거

특정 table data를 다른 table에서 참조하려면
1.primary key가 존재해야
2.prdNo랑 cart table prdNo 연결하려면
외래키 사용
product table은 부모 cart table은 자식이 됨.

userNo 2,3,4
proNo 2,3,4
외래키는 부모table에 반드시 존재해야
