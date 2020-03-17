# 데이터불러오기와 내보내기
# 내장 데이터셋 확인
?datasets
# 전체 데이터셋의 확인
library(help="datasets")
data("mtcars")
mtcars

# file 모록에서 thieves.txt 불러오기
# read.csv 기본적으로는 , 구분자, sep 파라미터로 구분자 지정
thieves <- read.csv("thieves.txt", sep="\t", fileEncoding="utf-8", header=FALSE) # header=false : 헤더를 비워놓겠다(아니면 데이터값이 들어감)
thieves
# 컬럼에 이름 붙이기
names(thieves)
names(thieves) <- c("name", "height", "weight")
thieves
# 저장
write.csv(thieves, fileEncoding = "utf-8", file="thieves.csv", row.names=FALSE)

# 엑셀 불러오기(별도 패키지 필요)
install.packages("readxl")
# 엑셀 패키지 로드
library(readxl)
wstudents <- read_excel("wstudents.xlsx", sheet=1)
wstudents

# class_scores.csv 를 import 해서 약간의 조작을 한 후 .rda 파일로 저장
class_scores <- read.csv("class_scores.csv")
class_scores
# 데이터셋의 구조 확인
str(class_scores)
# 총 몇개의 변수가 있는가 : length
length(class_scores)
# 총 몇개의 관측치가 있는가? : nrow
nrow(class_scores)
# 2학년 데이터만 추출
class_scores$grade==2
class_scores.grade2 <- class_scores[class_scores$grade==2,] # 해당 행의 전체 열 
nrow(class_scores.grade2)
# grade 2인 학생의 데이터를 .rda(RDA는 R 전용 파일로 협엽에 용이)파일로 저장 
save(class_scores.grade2, file="class_scores.grade2.rda")
#class_scores.grade2 객체를 삭제
rm(class_scores.grade2)
class_scores.grade2 # ERROR -> 객체가 존재하지 않음 
# .rda를 이용해서 복원 -> 로드
load("class_scores.grade2.rda")
class_scores.grade2 # 다시 확인 가능 