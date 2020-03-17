# Graph 함수
# 산점도 차트 : 두 변수간의 관계를 파악하기 위한 그래프
# 데이터셋 확인
?mtcars
#구조 확인
str(mtcars)
# wt(중량)과 mpg(연비)를 Scatter Plot으로 표현
plot(mtcars$wt, mtcars$mpg) # 중량이 작을수록 대략적으로 연비도 작은것을 확인할 수 있음(역상관관계) -> 경향성 확인
cor(mtcars$wt, mtcars$mpg) # -1~1에서 -1에 가까울수록 역상관관계 
# 꾸미기
plot(x=mtcars$wt, y=mtcars$mpg,
     xlab="차량중량", ylab="연비",
     main="중량 vs 연비",
     col="Red")
# 산점도 매트릭스 : 지정한 변수간 상관관계를 한눈에 보여주는 그래프 
?pairs
pairs(data=mtcars, ~wt+mpg+hp+cyl, main="ScatterPlot Matrix") # mtcars의 wt, mpg, hp, cyl의 상관관계를 한번에 확인 가능

# 파이차트 : 전체 중에 해당 데이터가 차지하는 비율을 표시 
scores <- data.frame(grade=c("A", "B", "C", "D"), cnt=c(3, 12, 11, 2)) 
str(scores)
pie(scores$cnt, labels=scores$grade, radius=1, 
    #col=c("red", "blue", "yellow", "green")
    col=rainbow(4),# 색 자동 지정
    main="2019년 성적")
# Legend (범례) : label 대신 퍼센트 정보로 출력
scores$percent <- round(scores$cnt / sum(scores$cnt)*100, 1) # 소숫점 1자리까지 퍼센트율 구하기
sum(scores$percent) # 합산된 값이 100
pie(scores$cnt, labels=scores$percent, col=rainbow(length(scores$cnt)), main="2019년 성적")
legend("topright", legend=scores$grade, fill=rainbow(length(scores$cnt)))

# 바차트 : 항목간의 값을 비교 
# 데이터 새엉
rev <- sample(1:20, 6, rep=T)
rev
barplot(rev)
names <- c("MAR", "APR", "MAY", "JUN", "JUL", "AUG")
barplot(rev, names.arg=names, xlab="Month", ylab="Revenue", main="Revenue Chart", col="pink", border="purple")
# Stacked Bar Chart
rev2 <- sample(1:20, 18, rep=T)
# 3행 6열의 Matrix 
rev2 <- matrix(rev2, nrow=3)
rev2
barplot(rev2, names.arg=names, xlab="Month", ylab="Revenue", main="Revenue Chart", col=c("pink", "lightgreen", "lightblue"))
# 범례 표시
legend("topright", c("A", "B", "C"), fill=c("pink", "lightgreen", "lightblue"))

# Box Plot : 데이터의 전체적인 분포를 확인
# mtcars의 mpg와 cyl 데이터의 분포를 확인 
bp.input <- mtcars[, c("mpg", "cyl")]
bp.input
boxplot(mpg ~cyl, data=bp.input, xlab="Cylinder", ylab="MPG", col=c("lightgreen", "pink", "lightblue"), names=c("Low", "Medium", "High"))

# 히스토그램 : 구간별 관측 획수(비율)을 그래프로 확인 
wstudents$height
# histogram -> 빈도 그래프
hist(wstudents$height, main="Height of wstudents", xlab="Height", col="pink", border="gray")
# freq=FALSE 로 주면 밀도 그래프로 변경 -> 합산된 값이 1
stat <- hist(wstudents$height, freq=FALSE, main="Height of wstudents(Density)", xlab="Height", col="black", border="gray")

# R의 그래프 함수들은 단순히 그래프를 그리는 것이 아니라 해당 그래프를 만들때 필요했던 통계치들을 함께 데이터로 가지고 있다
stat # 그래프에 사용된 통계치들 확인 가능 
is.list(stat)
# histogram의 구간 경계 값
stat$breaks
# 각 구간별 데이터의 개수(빈도)
stat$counts
# 각 구간별 데이터의 밀도
stat$density
sum(stat$density * 5) == 1 # 구간의 데이터 밀도의 합은 1 (5개의 구간)

# Line 그래프 : 주로 데이터의 시간흐름에 따라 추세 혹은 트렌드 변화를 표시해주는 그래프 
v <- sample(10:20, 5, rep=T)
plot(v, type="p") # 점그래프 
plot(v, type="l") # 선그래프
plot(v, type="o") # 점과 선이 함께 있는 그래프
plot(v, type="o", main="Line Graph", xlab="HORZ", ylab="VERT", col="red")
# legend, lins, points 등의 함수는 기존 그래프위에 다른 그래프를 덧그릴 수 있다.
v2 <- sample(10:20, 5, rep=T)
lines(v2, type="o", col="blue")     

# ggplot2 : 시각화를 위한 그래픽 라이브러리
# mpg 데이터셋으로 그래프만드는 연습하기 
library(ggplot2)
?mpg
# displ(배기량), hwy(고속도로 연비)의 그래프
plt <- ggplot(data=mpg)
plt
# 레이어를 얹을 때는 + 사인으로 연결
plt+geom_point(aes(x=displ, y=hwy))+xlab("배기랑")+ylab("고속도로연비")

# 자치구별 인구수를 데이터로 시각화 연습
seoul.merged
plt <- ggplot(seoul.merged, aes(x=자치구, y=계/1000))               
plt
# 데이터에 bar char 추가
plt <- plt + geom_bar(stat="identity", fill=rainbow(nrow(seoul.merged)))+
        ggtitle("서울 자치구별 인구")+xlab("자치구")+ylab("인구수")+
        theme(axis.text.x=element_text(angle=90), axis.title.x=element_text(size=9), 
        axis.title.y=element_text(size=9))
# 인터랙티브 그래프로 만들기 :plotly패키지 이용
plt
install.packages("plotly")
library(plotly)
ggplotly(plt)
