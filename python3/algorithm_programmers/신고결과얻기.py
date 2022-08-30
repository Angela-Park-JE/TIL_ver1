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
                

        
# def solution(id_list, report, k):
#     # dictionary where saves who reports.
#     dic_reportedid = {}
#     for id in id_list:
#         dic_id[id] = 0
#     # add who report the id
#     for i in report:
#         rep_ele = report[i]
#         tmp = rep_ele.split(sep = ' ')
#         who, whom = tmp[0], tmp[1]
#         dic_id[whom] = dic_id[whom] + 1
