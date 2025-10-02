# run.py


import my_module # my_module 실행. 현재 실행 모듈(run.py)와 같은 디렉토리(패키지)에서 찾는다.

# my_package 모듈 안에 있는 todo_module을 실행(사용)
# as(alias) 뒤에 별칭을 달아주어서 길게 써야하는 과정을 생략, my_package.todo_module 대신 todo
# import my_package.todo_module as todo

# 경로와 모듈 이름 구분
from my_package import todo_module as todo

# 모듈 내 함수 전부 사용(호출)
# 모듈 내 모든 함수를 알고 있으면 문제가 없지만, 그렇지 못할 시 중복함수로 인해 오류 발생이 가능하다
# from my_module import *

# 모듈 내 일부 함수 호출, 메인보드에 있는 내용처럼 사용 가능(중복 있을 시 앞에 my_module을 붙여야함)
from my_module import plus, divide

def plus():
    print("run의 plus")

# r = my_module.plus(10, 20)
# print(r)
# r = my_module.minus(230, 100)
# print(r)

# 위에 plus 함수가 정의되어 있기 때문에 사용불가
# print(plus(100,200))
# print(my_module.plus(100,200))
print(divide(10 ,4))

# print(todo.plus(100))

# todo를 별칭으로 둬서 찾을 수가 없다.
# my_package.todo_module.print_gugudan(5)

# todo.print_gugudan(5)

# python run.py