-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        11.4.2-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- bakery 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `bakery` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `bakery`;

-- 테이블 bakery.cart 구조 내보내기
CREATE TABLE IF NOT EXISTS `cart` (
  `cartNo` int(11) NOT NULL AUTO_INCREMENT,
  `prdNo` int(11) NOT NULL COMMENT '장바구니에서 중복되면 안됨. 동일한 제품은 수량으로 선택해야',
  `userNo` int(11) NOT NULL COMMENT 'cart table에서 login한 userNo 알 수 있게 됨. 중복되면 안 됨.',
  `qty` int(11) NOT NULL,
  PRIMARY KEY (`cartNo`),
  UNIQUE KEY `prdNo_userNo` (`prdNo`,`userNo`),
  KEY `FK_cart_member` (`userNo`),
  CONSTRAINT `FK_cart_member` FOREIGN KEY (`userNo`) REFERENCES `member` (`userNo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_cart_product` FOREIGN KEY (`prdNo`) REFERENCES `product` (`prdNo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='장바구니 테이블';

-- 테이블 데이터 bakery.cart:~4 rows (대략적) 내보내기
INSERT IGNORE INTO `cart` (`cartNo`, `prdNo`, `userNo`, `qty`) VALUES
	(1, 2, 3, 3),
	(2, 3, 2, 2),
	(3, 4, 4, 3),
	(4, 11, 3, 3);

-- 테이블 bakery.member 구조 내보내기
CREATE TABLE IF NOT EXISTS `member` (
  `userNo` int(11) NOT NULL AUTO_INCREMENT COMMENT '데이터베이스 테이블 내의 모든 레코드에서 고유한 아이디를 제공',
  `userEmail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'unique키가 설정되면 중복데이터는 사라짐',
  `birthday` int(11) DEFAULT NULL,
  `userPw` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `userName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `userPhone` char(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `zipCode` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `addr1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `addr2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`userNo`),
  UNIQUE KEY `userEmail` (`userEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='회원관리 테이블\r\n(userEmail, userPw, userName, userPhone, zipCode, addr1,addr2)';

-- 테이블 데이터 bakery.member:~6 rows (대략적) 내보내기
INSERT IGNORE INTO `member` (`userNo`, `userEmail`, `birthday`, `userPw`, `userName`, `userPhone`, `zipCode`, `addr1`, `addr2`) VALUES
	(2, 'admin2@gmail.com', 1993, '1234', '홍길동', '010-1234-1234', '05355', '서울시 구로구 항동로 43', '하버라인 123동 1234호'),
	(3, 'admin3@gmail.com', 2007, '1234', '장나라', '010-1234-1234', '05355', '광주광역시 구로구 항동로 43', '한솔 123동 1234호'),
	(4, 'admin4@gmail.com', 1989, '1234', '김원빈', '010-1234-1234', '05355', '제주시 구로구 항동로 43', '하버라인 123동 1234호'),
	(5, 'admin5@gmail.com', 2004, '1234', '송현빈', '010-1234-1234', '05355', '부산광역시 구로구 항동로 43', '하버라인 123동 1234호'),
	(6, 'admin6@gmail.com', 1950, '1234', '임상빈', '010-1234-1234', '05355', '광주광역시 구로구 항동로 43', '하버라인 123동 1234호'),
	(8, 'admin7@gmail.com', 1999, '1234', '김은영', '010-1234-1234', '05355', '서울시 구로구 항동로 43', '하버라인 123동 1234호');

-- 테이블 bakery.notice 구조 내보내기
CREATE TABLE IF NOT EXISTS `notice` (
  `noticeNo` int(11) NOT NULL AUTO_INCREMENT,
  `writer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `registDate` date NOT NULL,
  `editDate` date NOT NULL,
  `hit` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`noticeNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='공지사항 게시판';

-- 테이블 데이터 bakery.notice:~0 rows (대략적) 내보내기

-- 테이블 bakery.product 구조 내보내기
CREATE TABLE IF NOT EXISTS `product` (
  `prdNo` int(11) NOT NULL AUTO_INCREMENT,
  `category` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `price` int(11) NOT NULL,
  `descript` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `inventory` int(11) DEFAULT 0,
  `reviewCount` int(11) DEFAULT 0,
  `averageRating` float DEFAULT 0,
  `registDate` datetime DEFAULT NULL,
  `editDate` datetime DEFAULT NULL,
  PRIMARY KEY (`prdNo`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- 테이블 데이터 bakery.product:~15 rows (대략적) 내보내기
INSERT IGNORE INTO `product` (`prdNo`, `category`, `title`, `price`, `descript`, `image`, `inventory`, `reviewCount`, `averageRating`, `registDate`, `editDate`) VALUES
	(2, 'bread', '빵2', 1000, '맛있는 빵', NULL, 10, 11, 0, '2024-07-22 00:00:00', '2024-07-22 00:00:00'),
	(3, 'bread', '호빵', 1000, '맛있는 빵', NULL, 10, 12, 0, '2024-07-22 00:00:00', '2024-07-22 00:00:00'),
	(4, 'bread', '붕어빵', 1000, '맛있는 빵', NULL, 10, 13, 0, '2024-07-22 00:00:00', '2024-07-22 00:00:00'),
	(5, 'bread', '빵떡', 1000, '맛있는 빵', NULL, 10, 14, 0, '2024-07-22 00:00:00', '2024-07-22 00:00:00'),
	(11, 'cake', '케이크1', 1000, '맛있는 케이크', NULL, 10, 15, 0, '2024-07-22 14:57:49', '2024-07-22 14:57:49'),
	(12, 'cake', '케이크2', 1000, '맛있는 케이크', NULL, 10, 16, 0, '2024-07-22 14:57:49', '2024-07-22 14:57:49'),
	(13, 'cake', '케이크3', 1000, '맛있는 케이크', NULL, 10, 17, 0, '2024-07-22 14:57:49', '2024-07-22 14:57:49'),
	(14, 'cake', '케이크4', 1000, '맛있는 케이크', NULL, 10, 18, 0, '2024-07-22 14:57:49', '2024-07-22 14:57:49'),
	(15, 'cake', '케이크5', 1000, '맛있는 케이크', NULL, 10, 19, 0, '2024-07-22 14:57:49', '2024-07-22 14:57:49'),
	(21, 'sandwich', '샌드위치1', 1000, '맛있는 샌드위치', NULL, 10, 20, 0, '2024-07-22 14:59:13', '2024-07-22 14:59:13'),
	(22, 'sandwich', '샌드위치2', 1000, '맛있는 샌드위치', NULL, 10, 21, 0, '2024-07-22 14:59:13', '2024-07-22 14:59:13'),
	(23, 'sandwich', '샌드위치3', 1000, '맛있는 샌드위치', NULL, 10, 22, 0, '2024-07-22 14:59:13', '2024-07-22 14:59:13'),
	(24, 'sandwich', '샌드위치4', 1000, '맛있는 샌드위치', NULL, 10, 23, 0, '2024-07-22 14:59:13', '2024-07-22 14:59:13'),
	(25, 'sandwich', '샌드위치5', 1000, '맛있는 샌드위치', NULL, 10, 24, 0, '2024-07-22 14:59:13', '2024-07-22 14:59:13'),
	(26, 'bread', '빵1', 1000, '맛있는 빵', NULL, 0, 0, 0, '2024-07-22 16:07:34', '2024-07-22 16:07:34');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
