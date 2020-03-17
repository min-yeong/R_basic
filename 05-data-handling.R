# data를 불러오기
data("mtcars")
?mtcars
# 데이터의 앞부분 확인
head(mtcars) # 기본 6개 행
head(mtcars, n=10) # 행 개수 지정
# 데이터의 뒷부분 확인
tail(mtcars, n=1) # 가장 마지막 행
# 데이터의 형식
is(mtcars)
# 컬럼 이름과 행 이름 확인
colnames(mtcars)
rownames(mtcars)
# 실제 데이터의 모양 확인
View(mtcars) # sheet 형태로 확인 가능
# 데이터의 생김새(차원) 정보
dim(mtcars)
# 데이터의 구조 확인 -> 변수명과 관측치의 수 등을 확인
str(mtcars)
# 요약 통계량 확인 : summary
summary(mtcars)
# 특정 변수의 요약 통계량 확인
summary(mtcars$mpg) # 연비 정보의 요약 통계량 -> 이름이 있는 벡터
# mtcars의 mpg 변수 요약 통계량 중 1사분위수, 3사분위수를 추출
summary(mtcars$mpg)[c("1st Qu.", "3rd Qu.")]
# 특정 변수 (mpg, wt) 요약 통계량 확인
summary(mtcars[c("mpg", "wt")])
# 특정 컬럼을 배제한 나머지 변수의 통계량 확인(3, 5컬럼을 제외한) 
summary(mtcars[c(-3, -5)])
# wt 변수의 boxplot
boxplot(mtcars$wt)$stat
# wt와 mpg 변수의 boxplot 
boxplot(mtcars$wt, mtcars$mpg)
# wt변수를 가지고 outlier 확인
# 1.wt의 중앙값 확인
wt.median <- median(mtcars$wt)
wt.median
wt.1q <- summary(mtcars$wt)['1st Qu.'] # 1사분위수
wt.1q
wt.3q <- summary(mtcars$wt)['3rd Qu.']
wt.3q
wt.iqr <- wt.3q - wt.1q # IQR
wt.iqr
names(wt.iqr) <- "IQR"
wt.iqr
# 1사분위수에서 IQR*1.5를 빼면 하단 극단치 경계
wt.1q - wt.iqr*1.5
# 3사분위수에서 IQR*1.5를 더하면 상단 극단치 경계
wt.3q + wt.iqr*1.5
# mtcars$wt 중에서 상단 극단치 경계를 넘어가는 값을 뽑아보기
mtcars$wt > wt.3q + wt.iqr*1.5 # 상단 극단치 여부
mtcars$wt < wt.1q - wt.iqr*1.5 # 하단 극단치 여부
# 실제 중량이 극단치를 넘어가는 자동차 정보 추출
outliers <- mtcars$wt[mtcars$wt > wt.3q + wt.iqr*1.5]
outliers
# IQR를 뽑아내는 함수 
IQR(mtcars$wt) == wt.iqr


# 연습
# wstudents.xlsx를 불러와서 데이터 프레임으로 확인하기
library(readxl)
wstudents <- read_excel("wstudents.xlsx", sheet=1)
wstudents
# 테이블의 구조확인
str(wstudents)
# 테이블의 사이즈 확인
dim(wstudents)
# 앞, 뒤 열개의 데이터 확인
head(wstudents, 10)
tail(wstudents, 10)
# 요약 통계량 확인
summary(wstudents)


# 연습
# seoul_pop_2017_3-4.xls 불러오기
library(readxl)
seoul.pop <- read_excel("seoul_pop_2017_3-4.xls", sheet=1, skip=3) # header를 맞추기 위해 skip 사용
seoul.pop
seoul.pop.filtered <- seoul.pop[, 2:6] # 2번컬럼부터 6번컬럼까지
str(seoul.pop.filtered)
colnames(seoul.pop.filtered) <- c("자치구", "세대", "계", "남자", "여자")
seoul.pop.filtered
save(seoul.pop.filtered, file="seoul.pop.filtered.rda")

# seoul_cctv.xlsx 불러오기
seoul.cctv <-  read_excel("seoul_cctv.xlsx", sheet=1)
seoul.cctv.filtered <- seoul.cctv[, 1:2]
save(seoul.cctv.filtered, file="seoul.cctv.filtered.rda") 

# 정제
colnames(seoul.cctv.filtered)
colnames(seoul.pop.filtered) # seoul.cctv.filtered 의 기관명을 자치구로 바꿔야 merge가 가능하다
colnames(seoul.cctv.filtered) <- c("자치구", "CCTV 수")
str(seoul.cctv.filtered) # CCTV 수 컬럼이 숫자가 아님 -> 숫자로 변경
seoul.cctv.filtered[[2]] <- as.numeric(seoul.cctv.filtered[[2]])
str(seoul.cctv.filtered)

# 자치구를 기준으로 merge 수행
seoul.merged <- merge(seoul.pop.filtered, seoul.cctv.filtered, by="자치구") # 자치구를 기준으로 합병
seoul.merged

# seoul.merged 의 순위
seoul.merged[order(seoul.merged[6]),] # 인덱스를 잡을 때 특정 컬럼를 기준으로 sort 가능(CCTV 수가 가장 적은 구부터 정렬)
seoul.merged[order(-seoul.merged[6]),] # 역순 정렬

# 파생변수
seoul.merged$PERCCTV <- seoul.merged[6]/seoul.merged[3]
seoul.merged

# rda 저장
save(seoul.merged, file="seoul_pop_cctv.rda")

# bar chart로 출력
# 서울 자치구별 인구수 그래프
barplot(seoul.merged[[3]] / 1000, 
        main="서울 자치구별 인구 분포", # 메인이름
        names.arg=seoul.merged[[1]], # x축 자치구 이름 출력
        col=rainbow(nrow(seoul.merged)), # 색
        las=2, # x축 자치구 이름 세로 출력
        xlab="자치구", # x축 라벨
        ylab="인구(천명)") # y축 라벨 
# 인구당 CCTV 대수 그래프
barplot(seoul.merged[[6]]/seoul.merged[[3]], 
        main="서울 자치구 인구당 CCTV 대수",
        names.arg=seoul.merged$자치구,
        las=2,
        col="Pink",
        border="Blue",
        xlab="자치구",
        ylab="인구당 CCTV")


# 데이터 전처리 : dplyr
install.packages("dplyr")
library(dplyr)
# 데이터 불러오기
scores <- read.csv("class_scores.csv")
# 데이터 셋 확인
head(scores)
tail(scores)
# 데이터 구조 확인
str(scores) # 600개의 관측치, 9개의 변수 확인 가능 
# 통계량
summary(scores)
# filter : 조건에 맞는 행 선택(SQL의 WHERE절과 유사)
# grade가 1인 학생들
scores[scores$grade==1,] # 기본 방식
filter(scores, grade==1) # dplyr 방식
head(filter(scores, grade==1)) # dplyr의 장점
# gender가 F인 데이터를 추출
scores[scores$gender=='F',] # 기본 방식
filter(scores, gender=='F') # dplyr 방식
# 조건이 여러 개일 경우 논리 연산자로 조합 가능
# grade가 1이고 등급이 B인 학생들
filter(scores, grade==1 & class=='B')
# English 점수가 80점 이상이거나, Writing 점수가 80점 이상인  할생들 
filter(scores, English>=80 | Writing>=80)
# 조건에 여러 개의 값을 비교하고자 할 때 : %in%(dplyr연산자)
# grade가 3이고 등급이 A이거나 E인 학생들
filter(scores, grade==3 & class%in% c("A", "E"))
# select : 데이터셋으로부터 특정변수를 추출 
# scores로부터 Math, English, Writing 점수만 추출
select(scores, Math, English, Writing)
# scores로주터 Stu_ID, grade, class를 제외한 나머지 컬럼 -> 제외 : -
select(scores, -Stu_ID, -grade, -class)
# 특정 범위의 컬럼만 추출 -> :
select(scores, Math:Writing)
# filter와 select이용, 성별이 F이고 grade가 3인 학생들의 Stu_ID와 점수정보 출력
select(filter(scores, gender=='F' & grade==3), c(Stu_ID, Math:Writing))
# mutate : 파생 변수 생성
# scores 데이터 셋이서 Math ~ Writing 점수를 합산 -> total변수 파생, -> avg변수 파생
mutate(scores, Total=Math+English+Science+Marketing+Writing, Avg=(Math+English+Science+Marketing+Writing)/5)


# 연습문제
# scores에서 grade가 1이고 gender=='F'인 데이터 추출 
# Total과 Avg 파생
# Math, English, Science, Marketing, Writing 제외
# 나머지 컬럼만 선택
# scores.refind 변수에 할당
# 방법1. 순차실행 
temp.filtered <- filter(scores, gender=="F"&grade==1)
temp.filtered
temp.mutated <- mutate(temp.filtered, Total=Math+English+Science+Marketing+Writing,
                         Avg=(Math+English+Science+Marketing+Writing)/5)
scores.refined <- select(temp.mutated, -c(Math:Writing))
scores.refined
# 방법2. 함수의 중첩
rm(scores.refined)
scores.refined <- select(
                    mutate(
                      mutate(
                        filter(scores, grade==1&gender=='F'),
                            Total=Math+English+Science+Marketing+Writing
                        ),Avg = Total /5
                      ),-c(Math:Writing
                    )
                  )
scores.refined
# 방법3. Chain Operator %>% : 앞에서 실행된 결과를 뒤쪽 함수의 입력으로 즉시 사용, 가독성이 높은 코드작성 가능
rm(scores.refined)
scores.refined <- scores %>% filter(grade==1 & gender=='F') %>% 
                  mutate(Total=Math+English+Science+Marketing+Writing) %>% 
                  mutate(Avg=Total/5) %>%
                  select(-c(Math:Writing))
scores.refined

# mutate 함수 내에서 조건별로 다른 값을 세팅(ifelse를 이용한 파생 변수 추가)
scores.report <- scores.refined %>% mutate(
                        Result=ifelse(Avg>=90, "A", ifelse(Avg>=80, "B", ifelse(Avg>=70,"C", ifelse(Avg>=60, "D", "F")))))
scores.report[,c("Avg", "Result")]
str(scores.report)
# scores.report$Result를 순서형 변수로 변경
scores.report$Result <- ordered(scores.report$Result, levels=rev(c("A", "B", "C", "D", "F")))
str(scores.report)
# scores.report(1학년 여학생)에서 높은 성적순(Avg의 역순)으로 출력
scores.report %>% arrange(desc(Avg))

# summarise와 group 
# scores 수학의 평균 
summarise(scores, mean(Math))
# 여러 통계치의 출력
summarise(scores, mean.math=mean(Math), mean.english=mean(English), mean.science=mean(Science))
# group_by : 데이터 셋을 특정 그룹으로 묶음
# scores 데이터 셋을 학년별로 1차 그루핑한 후 class로 2차 그룹핑
scores.group <- scores %>% group_by(grade, class)
scores.group
# scores.group 과목별(Math, English, Writing) 평균 요약 
scores.group %>% summarise(mean.math=mean(Math), mean.english=mean(English), mean.writing=mean(Writing))
# 반별 총점 평균 구하기
scores %>% group_by(grade, class) %>% mutate(Total=Math+English+Science+Marketing+Writing) %>%
  summarise(sum_tot=sum(Total), mean_tot=mean(Total)) %>% arrange(desc(mean_tot)) %>% head(10)

# 결측치 : 입력되지않은(측정되지 않은) 데이터
# 이상치 : 극단적으로 크거나 작은 데이터 
# 통계를 외곡할 수 있으므로 적절히 처리 후 데이터 분석을 해야함 
library(ggplot2)
# 데이터셋 확인
?mpg
# 시내주행연비(cty)이상치 확인을 위한 boxplot 후 bp 객체에 할당
bp <-boxplot(mpg$cty) # R의 그래프 함수들은 결과 데이터를 함께 가지고 있다
# 내부데이터 확인
bp$stats # 하단극단치경계(==9)와 상단극단치경계(==26) 확인 가능 : 정상범위(9~26)
# mpg 구조확인
str(mpg) # model과 cty, hwy변수만 추출해서 mileage 객체로 다시 할당
# 정제
library(dplyr)
mileage <- mpg %>% select("model", "cty", "hwy")
mileage
# 극단치 뽑아내기
outlier <- mileage %>% filter(cty<9|cty>26)
outlier
# cty 연비의 통계(이상치 포함)
mean(mileage$cty) # 16.85897
# 이상치를 결측치로 대체
mileage$cty <- ifelse(mileage$cty<9|mileage$cty>26, NA, mileage$cty)
mileage$cty
# cty연비 통계
mean(mileage$cty, na.rm=T) # 결측치가 포함되어있기 때문에 제외하고 평균, 16.55895
# 결측치가 많은 경우에도 통계를 왜곡할 수있음 -> NA를 다른 데이터의 통계 대푯값으로 대체하는 것이 가장 이상적
# 결측 빈도수 체크
is.na(mileage$cty)
table(is.na(mileage$cty))
# 결측치를 중앙값으로 대체 
med <- median(mileage$cty, na.rm=T)
med
mileage$cty <- ifelse(is.na(mileage$cty), med, mileage$cty)
mean(mileage$cty)

# Oracle 데이터베이스 연결 :jdbc 연결을 위한 패키지들
install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC")
# 라이버러리 로드
library(rJava)
library(DBI)
library(RJDBC)
# ojdbc 드라이버 경로
driver.path <- "C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6.jar"
driver <- JDBC(driverClass="oracle.jdbc.driver.OracleDriver", classPath=driver.path)
# Connection 얻기
conn <- dbConnect(driver, "jdbc:oracle:thin:@localhost:1521/xe", "hr", "hr")
?dbConnect
conn
# 테이블 목록 확인
dbListTables(conn)
# employees table 열기
# employees <- dbReadTable(conn, "employees") # ERROR 오라클과 연동 에러
# query 만들기
query <- "SELECT * FROM employees"
rs <- dbGetQuery(conn, query) # 쿼리 실행
rs
str(rs)
# db는 항상 마지막에 닫아주는 것이 좋음, db접속헤제
dbDisconnect(conn)
