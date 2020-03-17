# 주석: 인터프리터가 해석하지 않는다.
# 산술 연산 : +, -, *, /
# 제곱 : ^, **
7^5 # ctrl+enter 실행, 두개 이상의 명령을 한번에 실행할 경우에만 ; 필요
7^5; 7**5

# 나눗셈의 몫과 나머지
# 몫: %/%, 나머지 : %%
7%/%5
7%%5

# 비교연산 : <, <=, >, =>, ==, !=
# 논리값은 : t(true) or f(false)
7==5
7!=5

# 논리연산 : |(OR), &(AND), !(NOT)
7>5 | 8<7
7>5 & 8<7
(7>5 | 8<7) == T
(7>5 & 8<7) == FALSE

# 객체 생성 : 할당 방향에 따라서 <-, -> 
# 명명 규칙 : 문자, 숫자, _, . 을 조합하여 사용, 대소문자 구분, 숫자로 시작할수 없음
eng <- 90
80 -> match
80 -> math
# 삭제
rm(match)

# 일반 프로그래밍언어와 같이 = 할당연산자도 사용 가능 
total = eng+math
# 객체 목록 보기
ls()
# 객체의 삭제
rm(total)
# total이라는 객체가 우리 메모리상에 있는가? 
"total" %in% ls()

# vector : 동일 타입의 데이터를 묶은 1차원 데이터 
v1 <- c(2, 4, 6, 8, 10)
v1
# 시작값:끝값
v2 <- 1:10 
v2
# seq 함수
v3 <- seq(1, 10)
v3
# 1부터 10까지 2간격으로 생성
v4 <- seq(1, 10, by=2)
v4
# 파라미터를 이용해서 각 속성을 지정할 수 있다.
v5 <- seq(from=2, to=10, by=2)
v5
# 12개로 균등분할 
v6 <- seq(1, 100, length.out=12)
v6
# 객체(vector)의 길이를 구하려면 length 함수
length(v6)
# 벡터는 단일 자료형을 다룬다. 여러 형태가 섞여있을 경우 한가지 형태 변화
v7 <- c(1, 2, "3", 4, 5)
v7
c(1, 2, TRUE, FALSE, 5)

# R의 기본 자료형, float(numeric)
n <- 3.14159
# integer : 뒤에 L을 부여
i = 314L
# complex : 복소수 : 실수부 + 허수부i
cpx = 2+3i
# 문자형 : ""
s <- "r programming"

# DATE 날자형 : 문자형처럼 취급되지만 Data 형으로 변환될 수 있다
d <- "2019-11-11"
d

# is() : 객체 함수 확인
v <- c(1, 2, 3, 4, 5)
is(v)
# 값이 하나여도 R은 벡터로 처리
i
is(i)
# is 계열 함수 : 세부적으로 데이터 타입 확인
is.numeric(v)
is.vector(v)
is.integer(v) # 정수형대로 되어있지만 기본적으로 float

# 객체의 데이터 변환 : as 계열 함수
v
v <- as.integer(v)
is.integer(v)

# 특수 데이터 타입들 : NA(결측지), NaN(Not a Number), Inf -> 데이터에 포함되어면 통계치가 왜곡되거나 에러발생 
# NA : 결측지, 측정되지 않은 데이터
scores <- c(90, 80, 100, NA, 75)
is(scores)
is.na(scores) # 결측치 포함 여부 확인
is(NA)
length(NA)
# NA와 NULL 비교
is(NULL)
is.null(scores)
is.null(NULL)
length(NULL) # NA와는 다르게 NULL은 메모리 공간 자체를 점유하지 않는다.
# Finite와 InFinite
is.finite(v) # 유한수 여부 확인
is.infinite(v) # 무한수 여부 확인
div <- 4/0
div
is.infinite(div)
# NaN : 수학적으로 해석 불가능 한 수
1/0 # Inf
1/0 + 1/0 #Inf
1/0 - 1/0 # 수학적으로 해석 불가능, NaN

# 도움말 : help 함수 
help(seq)
?is

# 내장 수치 함수
scores <- c(90, 80, 70, 95, 100)
scores
mean(scores) # 산술평균
sum(scores) # 합산함수
mean(scores) == sum(scores)/length(scores)
median(scores) # 중앙값
min(scores); max(scores) # 최솟값, 최댓값
# 결측치를 포함한 산술 연산
scores2 <- c(90, 80, 70, NA, 100)
is.na(scores2)
mean(scores2) # 결측치가 포함된 벡터의 산술 계산은 NA로 출력

# sampling 함수 (표본추출)
data = 1:45
data
# 추출 size, 복원 여부 replace 설정
sample(data, size=10, replace=F) #복원을 안했으므로 중복 추출은 안됌
sample(data, size=10, replace=T) # 중복 추출 허용

# 문자열의 기본적인 출력함수 : print
print("Hello")
#문자열 합치기 : paste
paste("Hello", "R", "Programming") # 기본적으로는 공백문자를 기준을 합침
paste("Hello", "R", "Programming", sep=",") # , 를 기준으로 합침
paste("A", c(1, 2, 3, 4, 5))
paste("A", c(1, 2, 3, 4, 5), sep="") # 공백제거
# sep 없는 paste는 paste0로 별도 구분되어 있다
paste0("A", c(1, 2, 3, 4, 5))

# 수치 함수 : R의 내장객체
pi 
round(pi) # 소숫점 1자리에서 반올림
round(3.678, 2) # 소숫점 2자리 다음에서 반올림
ceiling(3.678); floor(3.678) # 올림, 버림

# 사용자 정의 함수
stat <- function(x) {
  # 벡터로 return하면 여러값을 동시에 반환할 수 있음
  return (c(min(x), max(x), sum(x), mean(x), median(x)))
}
scores
summary <- stat(scores)
summary

# 패키지 : 필요할 때 기능을 추가, 설치 후 로드하면 추가된 기능 사용가능 
installed.packages() # 설치된 패키지 확인
# 패키지의 도움말 확인
library(help="base")
# 패키지 설치 : install.packages()
install.packages("ggplot2")
# 패키지 업데이트 : update.packages()
update.packages("ggplot2")

# 라이브러리 불러오기
library("ggplot2")
x <- c("a", "b", "c", "d", "c", "b", "a")
qplot(x) # ggplot2의 퀵플롯 함수 사용 가능

# 조건 분기
x <- 10L
# 객체가 양수인지 음수인지 0인지 판별하는 함수
# if 객체의 값 분기
check.posstive <- function(x) {
  if(x > 0) {
    print("x는 양수입니다.")
  }
  else if(x< 0) {
      print("x는 음수입니다.")
  }
  else {
    print("x는 0입니다.")
  }
}
check.posstive(x)
check.posstive(0)
#switch 객체의 값을 분기
test_switch <- function(x) {
  res <- switch( x, "1번째 조건", "2번째 조건", "3번째 조건") # default는 없음
  return (res)
}
test_switch(1)
test_switch(2)
test_switch(4)
#isfelse(조건이 참 반환 값, 거짓일 대 반환 값)
test_ifesle <- function(x) {
  paste("x는", ifelse( x > 0, "양수입니다.", ifelse(x==0, "0입니다", "음수입니다.")))
}
test_ifesle(10)
test_ifesle(0)

# 반복문 
# repeat: 최소 1 회 실행, 중단 로직은 직접 작성할 것 
test_repeat <- function(to=9) { # 9는 to의 기본값
  # 1부터 to까지 반복하면서 값을 출력
  cnt <- 1
  repeat {
    print(cnt)
    cnt <- cnt+1
    if(cnt > to) {
      break
    }
  }
}
test_repeat(5)
test_repeat() # to는 기본값 9가 있으므로 생략가능 
test_repeat(to=1) #repeat는 최소 1회는 수행

# while문 : 특정 조건을 만족하는 동안 반복 
test_while <- function(to=10) {
  cnt <- 1
  while(cnt < to) {
    print(cnt)
    cnt <- cnt+1
  }
}
test_while(to=5)
test_while() # to는 기본값이 있으므로 생략가능
test_while(1) # 조건에 따라 단 1 번도 실행되지 않을 수 있다

# for문(객체 in 벡터) : 반복을 위한 인덱스 변수는 없음
test_for <- function() {
  nums <- c(2,3,4,5,6,7,8,9)
  for (num in nums) {
    print(num)
  }
}
test_for()
# 구구단 만들기
test_gugudan <- function() {
  dans <- seq(2, 9)
  for(dan in dans) {
    print(paste0(dan, "단"))
    for(num in 1:9) {
      print(paste(dan, "*", num, "=", dan*num))
    }
  }
}
test_gugudan()
