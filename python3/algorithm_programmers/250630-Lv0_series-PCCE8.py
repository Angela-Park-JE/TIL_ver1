## PCCE 8번 디버깅: 한 줄만 수정하기
# if 대신 while을, 3대신 4를 넣어야 맞다.

def solution(nickname):
    answer = ""
    for letter in nickname:
        if letter == "l":
            answer += "I"
        elif letter == "w":
            answer += "vv"
        elif letter == "W":
            answer += "VV"
        elif letter == "O":
            answer += "0"
        else:
            answer += letter
    while len(answer) < 4:    # 원본:if len(answer) < 3:
        answer += "o"
    if len(answer) > 8:
        answer = answer[:8]
    return answer
