# 철수와 영화 (by.HYEMINSEO)
###### 기간 : 2019.01.15 ~ 2019.05.13  
### 내용
#### 영화 취향 분석 및 추천 웹 서비스

#### [웹페이지 구현 영상 보러가기](https://www.youtube.com/watch?v=ChMTVMZCoW0&t=11s)
### 개발환경
-	DB: Oracle 11g, MongoDB 2.7.6
-	Server: Tomcat 7.0, Flask
-	Language: Java, Python, JSP
-	Web: HTML5, CSS3, JavaScript, jQuery
-	Tool: STS3, SQL Developer, Pycharm, ER-Win
-	Framework: Spring, MyBatis


### 담당기능
#### 1. 로그인 페이지
- 사용자 식별값을 세션에 저장

#### 2. 회원 가입 페이지
- 정규식을 통한 유효성 검사
- Ajax를 이용한 닉네임, 이메일 주소 중복 확인 및 비밀번호 조건 확인

#### 3. 회원 정보 수정 페이지
- 사용자 이메일 주소를 제외한 정보 변경 가능
- Ajax를 이용한 닉네임 중복 확인 및 변경 사항 바로 반영
- Ajax를 이용한 현재 비밀번호 확인 및 새로운 비밀번호 조건 확인

#### 4. 회원 탈퇴
- 회원 번호(primary key)를 전달해 해당 번호에 해당하는 정보 삭제
 
#### 5. 로그아웃 버튼 클릭시 시작 페이지로 이동
- 저장되어 있던 세션값을 0으로 변경

#### 6. 현재상영작 크롤링
- 크롤링을 이용하여 현재 상영작 정보(제목, 감독, 배우, 장르, 포스터 등) 끌어 옴 
