"""
코딩테스트 연습> 2023 KAKAO BLIND RECRUITMENT> 개인정보 수집 유효기간
https://school.programmers.co.kr/learn/courses/30/lessons/150370
"""


"""오답노트"""

"""1"""
# 기본적으로 로직을 생각하고 짠 것까지 40분 정도 걸림: zip, dictionary iterating 찾아봄
# 문제는 날짜 조건 관련해서 해결이 안됨 자꾸...

def solution(today, terms, privacies):
    # one_months = 28
    terms_dict, destruct_term_num_list = {}, []
    today = [int(i) for i in today.split(' ')[0].split('.')]

    # term month info with dictionary
    for i in terms:
        terms_dict[i.split(' ')[0]] = int(i.split(' ')[1])

    # calculating privacies and saving number's which has to be deleted
    # 먼저 해당 자리 값을 바꾸는 방향으로 date 계산
    for i, n in zip(privacies, range(len(privacies))):
        types = i.split(' ')[1]
        dates = [int(i) for i in i.split(' ')[0].split('.')]    # 계산하기 편하게 정수화
        
        # print(dates) #
        
        # dictionary iterating 
        for k, v in terms_dict.items():
            if types == k:
                dates[1] = dates[1] + v
                if dates[1] > 12:
                    # some month goes next year
                    dates[0] = dates[0] + 1
                    dates[1] = dates[1] % 12
        
        # print('-', dates) #
        
        # destruction or not?
        # 계산된 날짜가 today 보다 큰 지 아닌지. 
        # (28일이란 정보는 필요가 없었음. 정수화 하고 결과는 약관 번호만 주면 되어서 MM 형식도 의미없었음.)
        if today[0] > dates[0]:
            # privacies[i]는 i+1번 개인정보의 수집 일자와 약관 종류를 나타냅니다.
            destruct_term_num_list.append(n+1) 
        elif (today[0] == dates[0]) and (today[1] > dates[1]):
            destruct_term_num_list.append(n+1) 
        elif (today[0] == dates[0]) and (today[1] == dates[1]) and (today[2] >= dates[2]):
            destruct_term_num_list.append(n+1) 
            
        # cond1, cond2, cond3 = today[0] > dates[0], today[1] > dates[1], today[2] >= dates[2]
        # if cond1 == True:
        #     destruct_term_num_list.append(n+1) 
        # elif cond1cond2 == True:
        #     destruct_term_num_list.append(n+1) 
        # elif cond3 == True:
        #     destruct_term_num_list.append(n+1) 
        
        # 이 방법은 사용할 수 없음 연도 상관업싱 돌아서
        for j in range(3):
            if today[j] > dates[j]:
                destruct_term_num_list.append(n+1)
            

    return destruct_term_num_list

"""2"""
# 조항 기간이 연단위일 수도 있다는 생각으로 고쳤는데 더 망한 케이스;
def solution(today, terms, privacies):
    # one_months = 28
    terms_dict, destruct_term_num_list = {}, []
    today = [int(i) for i in today.split(' ')[0].split('.')]

    # term month info with dictionary
    for i in terms:
        terms_dict[i.split(' ')[0]] = int(i.split(' ')[1])

    # calculating privacies and saving number's which has to be deleted
    # 먼저 해당 자리 값을 바꾸는 방향으로 date 계산
    for i, n in zip(privacies, range(len(privacies))):
        types = i.split(' ')[1]
        dates = [int(i) for i in i.split(' ')[0].split('.')]    # 계산하기 편하게 정수화
        
        print(dates) #
        
        # dictionary iterating 
        # dates : valid date
        for k, v in terms_dict.items():
            # v : 개인정보를 보관할 수 있는 달 수를 나타내는 정수이며, 1 이상 100 이하입니다.

            if types == k:
                v_year = v//12
                v_month = v%12
                dates[0] = dates[0] + v_year   # year calculating
                dates[1] = dates[1] + v_month  # month calculating
                dates[2] = dates[2] - 1  # valid dates : `dates`'s day- 1
                
                if dates[2] == 0:
                    dates[2] = 28
                    dates[1] = dates[1] - 1
                if dates[1] == 0:
                    dates[1] = 12
                    dates[0] = dates[0] - 1
                elif dates[1] > 12:
                    dates[1] = dates[1] % 12
                    dates[0] = dates[0] + 1 
                
                
#                 ##
#                 if dates[1] > 12:
#                     # some month goes next year
#                     dates[0] = dates[0] + 1
#                     dates[1] = dates[1] % 12
#                 if dates[2] == 0:
#                     # some day goes previous month
#                     dates[2] = 28
#                     dates[1] = dates[1] - 1
#                     if dates[1] == 0:
#                         dates[1] = 12
#                         dates[0] = dates[0] - 1
#                  ##
    
        print(today, v, '=', dates) #
        
        # destruction or not?
        # 계산된 날짜가 today 보다 큰 지 아닌지. 
        # (28일이란 정보는 필요가 없었음. 정수화 하고 결과는 약관 번호만 주면 되어서 MM 형식도 의미없었음.)
        
#         if today[0] > dates[0]:
#             # privacies[i]는 i+1번 개인정보의 수집 일자와 약관 종류를 나타냅니다.
#             destruct_term_num_list.append(n+1)
#             continue
#         elif (today[0] == dates[0]) and (today[1] > dates[1]): #
#             destruct_term_num_list.append(n+1) 
#             continue
#         elif (today[0] == dates[0]) and (today[1] == dates[1]) and (today[2] > dates[2]): #
#             destruct_term_num_list.append(n+1)
#             continue
#         else:
#             continue
        


#     return destruct_term_num_list
