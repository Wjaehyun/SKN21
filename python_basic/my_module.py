# my_module.py

# 변수
# 라이브러리 버전 작성, 앞뒤로 double underscore
__verion__ = 0.1

# 필요한 재사용 가능한 함수 선언
def plus(num1, num2):
    return num1 + num2

def minus(num1, num2):
    return num1 - num2

def multiply(num1, num2):
    return num1 * num2

def divide(num1, num2):
    return num1 / num2


# 실행구문(script)
# main모듈일 경우에만 실행구문 실행
if __name__ == "__main__":
# 위에 정의한 함수들 호출
    print(__name__)
    result = plus(10, 20)
    print(result)
    result = minus(result, 50)
    print(result)

# python my_module.py(의 경로) 를 넣어서 사용한다.
# Ctrl + j (터미널 실행 단축키)로 터미널을 열어서 경로확인/실행
# C: 드라이브부터 적혀있으면 대체로 절대경로

