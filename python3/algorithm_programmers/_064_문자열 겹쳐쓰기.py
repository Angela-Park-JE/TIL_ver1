"""
코딩테스트 연습> 코딩 기초 트레이닝> 문자열 겹쳐쓰기
문제 설명
  문자열 my_string, overwrite_string과 정수 s가 주어집니다. 
  문자열 my_string의 인덱스 s부터 overwrite_string의 길이만큼을 문자열 overwrite_string으로 바꾼 문자열을 return 하는 solution 함수를 작성해 주세요.

제한사항
  my_string와 overwrite_string은 숫자와 알파벳으로 이루어져 있습니다.
  1 ≤ overwrite_string의 길이 ≤ my_string의 길이 ≤ 1,000
  0 ≤ s ≤ my_string의 길이 - overwrite_string의 길이
"""



"""오답노트"""
# 24.02.23: 6번 케이스에서 오답으로 뜨는데 왜 오답으로 뜨는지 모르겠다...
def solution(my_string, overwrite_string, s):
    answer = my_string.replace(my_string[s:s+len(overwrite_string)], overwrite_string)
    return answer
