# DataFrame 
# 생성 : 여러 개의 벡터가 열로 연결된 형태, 각 열은 변수로 작동
names <- c("홍길동", "전우치", "임꺽정", "장길산")
height <- c(176, 170, 186, 188)
weight <- c(74, 65, 88, 90)

# 각 변수 벡터의 길이가 동일해야 한다.
thieves <- data.frame(names, height, weight)
thieves

# 변수명의 사용
thieves$names
thieves['height']
thieves['weight']

# 각 변수는 벡터이므로 벡터에서 사용한 indexing, slicing 사용가능
thieves$height[2]
thieves$height[2:3]
length(thieves) # 컬럼의 개수
nrow(thieves) # 총 관측치의 개수

# Vector, Matrix에서 사용했던 통계함수 사용 가능
mean(thieves$height)
mean(thieves$weight)

# 통계함수 수행시에는 문자열을 포함시킬 수 없다. 수치형이여야만 가능
colMeans(thieves) # ERROR 
colMeans(thieves[2:3])
colMeans(thieves[c("height", "weight")])
colMeans(thieves[c(-1)]) # 1번 컬럼만 통계함수 적용 제외         

# DataFrame을 한번에 만들기
thieves <- data.frame(name=c("홍길동", "전우치", "임꺽정", "장길산"), 
                      heights=c(176, 170, 186, 188),
                      weights=c(74, 65, 88, 90))
thieves

# rbind : 새로운 행의 연결
thief.new <- data.frame(name="일지매", heights=176, weights=63)
rbind(thieves, thief.new) # 원본데이터는 유지

# 파생변수 생성
thieves$bmi <- thieves$weights/(thieves$heights/100)^2 # 원본데이터에 새로운 컬럼 추가
thieves

# cbind : 새로운 열의 연결
bt <- data.frame(bloodtype=c("A", "B", "AB", "O")) # cbind의 경우는 두 데이터 프레임의 행의 개수가 일치해야함
thieves <- cbind(thieves, bt)
thieves

# merge : 단순 병합이 아닌 특정 컬럼을 기준으로 병합 
footsizes <- data.frame(footsize=c(260, 300, 290, 275),
                        name=c("임꺽정", "장길산", "홍길동", "전우치"))
# 단순 병합(cbind)
cbind(thieves, footsizes) # 관계없는 컬럼으로 병합
# 특정 컬럼을 기준으로 병합 by 
merge(thieves, footsizes, by="name") # by 파라미터로 병합할 컬럼 지정 

# List(범용 자료형) : 모든 데이터 타입을 제약없이 담을 수 있다.
lst <- list(name="홍길동", # 문자열
            physical=c(176, 74), # 벡터
            scores=data.frame(intellect=95, health=90) #데이터 프레임
            )
lst

# length : 리스트 안에 담긴 객체의 수
length(lst)
# 구조 확인
str(lst)

# 리스트의 원소 뽑아오기 : [] -> 리턴값이 list, [[]] -> 내부 데이터   
is(lst['name']) # 리스트
lst['name'] 
is(lst[['name']]) # 벡터
lst[['name']] 
lst['physical'][1] # 리스트
lst[['physical']][1] # 리스트안의 첫번쨰 값, 내부데이터 접근가능

# lapply : 리스트의 여러 요소에 함수를 적용하기 위한 함수 
v1 <- 10:30
v2 <- 50:70
lst2 <- list(v1, v2)
lst2
lapply(lst2, median) # 리턴값을 list로 반환 
sapply(lst2, median) # 리턴값을 vector로 반환
is(sapply(lst2, median))
sapply(lst2, median, simplify = FALSE) # sapply 적용결과를 내부데이터와 동일한 타입(list)으로 반환해줌

# Factor : 질적데이터(명목형 변수, 순서형 변수를 다루는 자료형)
var1 <- c(1, 2, 3, 2, 1)
var1
var2 <- factor(c(1, 2, 3, 2, 1))
var2 # 하단에 Levels 확인(범주값)
is.factor(var1) # v1은 범주형인가? -> FALSE
is.factor(var2) # v2는 범주형인가? -> TRUE
var2 * 2 # ERROR -> 범주형은 산술연산이 불가 
# 범주형이 아닌 변수를 범주형으로 변환 : as.factor
var3 <- as.factor(var1)
is.factor(var3)
var3
# 범주 구성 확인 : levels 
levels(var3)

sizes <- factor(c("medium", "small", "large", "huge", "small"))
sizes
#levels() 함수를 이용하여 factor의 표시 순서 변경 가능, factor형 변수는 순서가 없기 떄문에 표시 순서만 바뀜
levels(sizes) <- c("small", "medium", "large", "huge")
sizes
sizes > "medium" # ERROR 단순 factor형이기 떄문에 대소비교불가 
# 단순 순서만 바뀌는게 아니라 매칭되는 값도 함께 바뀐다.
# 레벨 조정이 필요한 경우 factor도 레벨로 잡아주는 것이 제일 이상적
# sizes -> factor(sizes, levels = c("small", "medium", "large", "huge"))

# Ordered Factor : 순서가 있는 명목형 변수
sizes <- ordered(c("medium", "small", "large", "huge", "small"),
                 levels=c("small", "medium", "large", "huge"))
sizes
levels(sizes)

# Ordered Factor는 순서가 있으므로 대소비교 가능
sizes > "medium" 
# 내부 데이터 중에서 medium보다 큰 데이터 추출
sizes[sizes > "medium"]
