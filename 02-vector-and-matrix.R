# vector의 생성 - c, seq, rep 등으로 생성, 인덱스는 1부터 시작, 하나의 백터는 단일 자료형으로 사용가능, 결측자는 NA 
v <- c(1, 2, 3, 4, 5, NA, 6, 7, 8, 9, 10)

# 인덱싱 : 범위를 벗어나도 오류는 없지만 NA(결측치)반환 
v[0] # 0번 인덱스는 해당 벡터 그 자신을 가리킨다. 
v[1] # 실제 내부데이터 접근을 위한 인덱스는 1부터 
#길이 : length
length(v)
v[length(v)] # 가장 마지막 요소
vec <- c(6, 1, 3, 2, 6, 10, 11)
vec[1]
vec[7]
vec[8] # 인덱스 범위를 벗어난 접근 -> 결측치(NA) 

# 결측치가 포함된 벡터의 통계값 추출 -> NA
mean(v)
# 결측치 제거 후 통계값 추출 : na.rm=T
mean(v, na.rm = T)

# seq 함수 
seq(1, 10, 3) # from, to, by : 1부터 10까지 3간격
# 파라미터 이름으로 넘겨줄 경우는 순서가 중요하지 않음
seq(to=10, by=3, from=1)

#rep : 수열의 반복
rep(1:3, 3) # 1,2,3 수열을 세번 반복
rep(c(1,3,5), each=3) # each : 각각 개별로 3번씩 반복

# 슬라이싱 
# 1500 ~ 4000 사이 구간을 12로 균등 분할 
incomes <- seq(1500, 4000, length.out=12)
incomes
# 1번째, 3번쨰, 5번쨰, 7번째 인덱스 추출 
incomes[c(1, 3, 5, 7)]
# 1,3,5,7 인덱스를 제외한 나머지 인덱스 추출 : 음수
incomes[c(-1, -3, -5, -7)]
# 특정 범위의 값(3번 인덱스부터 8번인덱스까지)을 추출 
incomes[3:8]
# incomes 내부 데이터 중에서 2500보다 큰값 추출 
incomes > 2500
# 인덱싱, 슬라이싱시 true, false 벡터를 전달 (true값인 인덱스만 추출)
incomes[incomes > 2500]

# 벡터의 요소 이름 
scores <- c(80, 90, 85)
scores
# 벡터 각 요소의 이름 확인 : names 함수
names(scores)
# 이름 변경
names(scores) <- c("Eng", "Math", "Science")
names(scores)
scores
# 이름을 붙여주면 이름으로 요소를 참조 할 수 있음
scores['Eng']
scores['Math']

# 벡터관련 수치 함수들
x <- seq(1, 12, by=2)
y <- seq(2, 7)
x; y
# 상관계수 -1.0 ~ 1.0, 1.0에 가까울 수록 정상관계 
cor(x, y) 
# 평균
mean(x)
# 표준편차
sd(x)
# 분산
var(x)
# 통계 요약
summary(x) 
# 4분위수
quantile(x)
# 1사분위수
quantile(x)['25%']

# 벡터의 산술연산
v <- 1:10
v
# 벡터와 스칼라의 산술 연산 : BroadCasting
v + 2 
# 벡터와 벡터의 산술 연산 : 같은 위치의 요소끼리 연산
v1 <- c(1, 3, 5)
v2 <- c(2, 3, 4)
v1 + v2
# 벡터의 비교연산
v1 == v2 

# 벡터를 인덱싱할 때 true , false 값으로 확인가능
v2
v2[c(FALSE, TRUE, TRUE)]

v3 <- seq(1, 100)
v3
# v3에서 3의 배수만 추출 
v3 %% 3 == 0
# 3의 배수의 벡터
v3[v3 %% 3 == 0] 

# MATRIX(행렬) : 2차원자료형, 내부 데이터는 벡터로 취급하여 벡터의 특성과 함수를 그대로 사용
m1 <- matrix(1:10, ncol=2) # 2열짜리 매트릭스
m1 
m2 <- matrix(1:10, ncol=2, byrow=TRUE) # 행 기준으로 먼저 값을 채움
m2
m3 <- matrix(1:10, nrow=3) # 빈 공간이 생기기 때문에 경고, 순환법칙에 의해서 빈공간은 첫번째 데이터값부터 채워짐
m3

# 인덱싱
m1
m1[3, 2]==8 # 3행 2열 

# 행이름과 열이름 
rownames(m1) # 초기값은 NULL
colnames(m1) 
rownames(m1) <- paste0("row", 1:5)
rownames(m1)
colnames(m1) <- paste("col", c(1, 2), sep="")
m1

# 행렬의 길이 재기
length(m1) # 내부 데이터의 총길이
nrow(m1) # 행렬의 행 개수
ncol(m1) # 행렬의 열 개수
dim(m1) # 행과 열의 개수를 함께 출력
dim(m1)[1] # 행의 개수
dim(m1)[2] # 열의 개수

# 슬라이싱
m1
m1[2:4, 2] # 2행부터 4행, 2열 ->  단일:벡터
m1[2:4, 1:2] # 2행부터 4행, 1열부터 2열 -> 매트릭스 
m1[2:4, ] # 범위를 생략하면 해당 기준 전체를 의미 
m1[2:4, 1:2] == m1[2:4, ] # 동일한 데이터 

# 행렬의 연산
x <- matrix(1:4, ncol=2, byrow=FALSE)
y <- matrix(1:4, ncol=2, byrow=TRUE)
x; y
# 같은 위치의 요소끼리 연산 수행
x + y
x * y
# 선형대수의 행렬곱
x %*% y 

# 행렬의 주요 함수들
m1
m1.colsum <- colSums(m1) # 컬럼 방향의 합계 벡터
m1.colsum 
m1.colsum[1] # 1번 컬럼의 합계
m1.colmean <- colMeans(m1) # 컬럼 뱡향의 평균 벡터
m1.colmean
rowSums(m1) # 행 방향의 합계 벡터
rowMeans(m1) # 행 방향의 평균 벡터

# 행렬의 전치 : 원래 행렬의 행과 열을 변환
m1
m1.t <- t(m1)
m1.t

# matrix 연결 : rbind(행연결, 두 매트릭스의 열 개수가 같아야함), cbind(열연결, 두 매트릭스의 행 개수가 같아야함)
m3 <- matrix(1:4, ncol=2)
m3
rbind(m1, m3)
cbind(m1, m3) # 두 매트릭스의 행의 수가 다르기 때문에 ERROR
cbind(m1.t, m3)

# apply : matrix의 각행 혹은 각열에 원하는 함수를 적용하여 결과를 반환
scores.matrix <- matrix(c(80, 90, 70, 65, 75, 90, 80, 70, 85), ncol=3)
scores.matrix
# 행을 기준으로 summary 함수를 실행 (행 기준: margin==1, 열 기준: margin==2)
apply(scores.matrix, 1, FUN=summary)
# 열을 기준으로 summary 함수를 실행 
apply(scores.matrix, MARGIN=2, summary) # 순서가 맞으면 정의는 생략가능

# Array : 3차원 데이터(행, 열, 매트릭스), 원본데이터는 벡터, dim을 이용해 각 차원의 크기 설정
arr <- array(1:18, dim=c(3, 3, 2)) # 3행 3열 2매트릭스 
arr

# 배열의 naming 
dimnames(arr) # 초기값은 NULL
arr.names.col <- paste0("col", 1:3) # 열의 이름
arr.names.row <- paste0("row", c(1,2,3)) # 행의 이름
arr.names.matrix <- paste0("matrix", c(1,2)) # 매트릭스의 이름
dimnames(arr) <- list(arr.names.row, arr.names.col, arr.names.matrix) 
arr
# 생성시에 미리 name을 지정할 수 있다
arr2 <- array(1:18, dim=c(3,3,2), dimnames=list(c("row1", "row2", "row3"),
                                                c("col1", "col2", "col3"),
                                                c("matrix1", "matrix2")))
arr2

# 배열의 차원 정보 확인
dim(arr)

# 배열의 인덱싱 : 행인덱스, 열인덱스, 매트릭스인덱스
arr[2, 2, 2] # 배열 arr의 2행 2열 2번 매트릭스의 인덱스 
arr[3, 2, 1] # arr의 3행 2열 1번 매트릭스의 인덱스

# 슬라이싱 : 행범위, 열범위, 매트릭스범위, 범위삭제시 해당 범위 전체
arr[2:3, 1:2, 1] # 1번 매트릭스의 2~3행, 1~2열
arr[c(-2), c(1,3), 1] # 1번 매트릭스의 2행을 제외한 1열, 3열 
arr[,,2] # 범위를 생략하면 해당 방향 전체를 의미, 2번 매트릭스 전체 
arr[,,] # 모두 생략되었으므로 배열 전체를 복제 
arr[3,,1] # 1번 매트릭스의 3행 전체 

# apply : 배열에서 apply를 사용하려면 margin을 이용하여 방향을 결정해줘야함 
# 행방향 : margin==1, 열방향 : margin==2, 매트릭스전체 : margin==3)
apply(arr, MARGIN=3, sum) # 각 매트릭스의 sum함수(총합) 
apply(arr, MARGIN=2, sum) # 열방향으로 sum함수(총합)
apply(arr, MARGIN=1, sum) # 행 방향으로 sum함수(총합)
