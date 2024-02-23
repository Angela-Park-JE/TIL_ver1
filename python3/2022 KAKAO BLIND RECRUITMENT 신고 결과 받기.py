"""
코딩테스트 연습> 2022 KAKAO BLIND RECRUITMENT> 신고 결과 받기
문제 설명
문제 설명
신입사원 무지는 게시판 불량 이용자를 신고하고 처리 결과를 메일로 발송하는 시스템을 개발하려 합니다. 무지가 개발하려는 시스템은 다음과 같습니다.
  각 유저는 한 번에 한 명의 유저를 신고할 수 있습니다.
  신고 횟수에 제한은 없습니다. 서로 다른 유저를 계속해서 신고할 수 있습니다.
  한 유저를 여러 번 신고할 수도 있지만, 동일한 유저에 대한 신고 횟수는 1회로 처리됩니다.
  k번 이상 신고된 유저는 게시판 이용이 정지되며, 해당 유저를 신고한 모든 유저에게 정지 사실을 메일로 발송합니다.
  유저가 신고한 모든 내용을 취합하여 마지막에 한꺼번에 게시판 이용 정지를 시키면서 정지 메일을 발송합니다.
  이용자의 ID가 담긴 문자열 배열 id_list, 각 이용자가 신고한 이용자의 ID 정보가 담긴 문자열 배열 report, 
  정지 기준이 되는 신고 횟수 k가 매개변수로 주어질 때, 각 유저별로 처리 결과 메일을 받은 횟수를 배열에 담아 return 하도록 solution 함수를 완성해주세요.
"""



"""오답노트"""
# 제작년 즈음 하다가 만 것으로 보이는 것
def solution(id_list, report, k):
    # dictionary where saves report number of times
    dic_ids = {}
    for id in id_list:
        dic_ids[id] = 0
    # add the report times step by step 
    reportuser_list = []
    for sentence in report:
        tmp = sentence.split(sep = ' ')
        who, whom = tmp[0], tmp[1]
        dic_ids[whom] = dic_ids[whom] + 1
        if who not in reportuser_list:
            reportuser_list.append(who)
    # if bigger than k...
    blacklist = []
    for key, value in dic_ids.items():
         if value >= k:
            blacklist.append(key)
    # and who's gonna get report email
    dic_email = {}
    for id in reportuser_list:
        dic_email[id] = 0
    for m in blacklist:
        for n in report:
            tmp = n.split(sep = ' ')
            who, whom = tmp[0], tmp[1]
            if whom == m:
                dic_email[who] = dic_email[who] + 1
    # and done
    return list(dic_email.values())
