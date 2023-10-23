"""
Prepare> SQL> Advanced Join> Interviews
https://www.hackerrank.com/challenges/interviews/problem

"""








"""오답노트"""

-- 231023: 
-- 1. 맞게 짠듯 싶은데 정답이 아니다. 한번씩 쿼리 날리면 결과 나오는데 한참 걸려서 참 집중하기 어렵다.
SELECT cts.contest_id, cts.hacker_id, cts.name, SUM(total_submissions), SUM(total_accepted_submissions), SUM(total_views), SUM(total_unique_views)
FROM CONTESTS cts, COLLEGES colg, CHALLENGES chls, VIEW_STATS vs, SUBMISSION_STATS subs
WHERE 1=1 
    AND cts.contest_id = colg.contest_id 
    AND colg.college_id = chls.college_id 
    AND chls.challenge_id = vs.challenge_id
    AND chls.challenge_id = subs.challenge_id
GROUP BY cts.contest_id, cts.hacker_id, cts.name
HAVING SUM(total_submissions) +SUM(total_accepted_submissions) +SUM(total_views) +SUM(total_unique_views)!=0
ORDER BY 1 ASC;
""" 결과
845 579 Rose 2566 841 2447 869 
858 1053 Angela 1930 441 1464 511 
883 1055 Frank 2689 734 1794 593 
1793 2655 Patrick 2488 655 2257 762 
2374 2765 Lisa 6349 1924 7405 2026 
2963 2845 Kimberly 8499 2395 7261 2460 
3584 2873 Bonnie 6417 1574 5839 1872 
4044 3067 Michael 2594 984 3000 939 
4249 3116 Todd 2102 546 1729 490 
4269 3256 Joe 3115 1042 3122 950 
4483 3386 Earl 3564 870 3063 791 
4541 3608 Robert 3423 953 3115 821 
4601 3868 Amy 3991 1427 4256 1280 
4710 4255 Pamela 3580 896 3421 1004 
4982 5639 Maria 4849 1304 4414 1213 
5913 5669 Joe 4269 1301 5005 1236 
5994 5713 Linda 6090 1697 5414 1681 
6939 6550 Melissa 6399 1893 6358 1845 
7266 6947 Carol 5873 1435 5370 1627 
7280 7030 Paula 3094 960 2636 858 
7484 7033 Marilyn 7231 2094 7659 2034 
7734 7386 Jennifer 8067 2149 8405 2307 
7831 7787 Harry 7143 1799 5493 1892 
7862 8029 David 2385 719 2611 819 
8812 8147 Julia 1916 494 1785 545 
8825 8438 Kevin 5203 1582 5329 1578 
9136 8727 Paul 7392 2629 7516 2294 
9613 8762 James 7889 2133 8282 2503 
10568 8802 Kelly 4892 1668 5812 1746 
11100 8809 Robin 3382 1091 3326 1138 
12742 9203 Ralph 3443 866 3258 934 
12861 9644 Gloria 2825 903 2840 936 
12865 10108 Victor 2379 709 2182 789 
13503 10803 David 722 230 720 180 
13537 11390 Joyce 2994 1117 3418 1071 
13612 12592 Donna 3358 939 3369 952 
14502 12923 Michelle 3335 1066 2982 1032 
14867 13017 Stephanie 4078 1227 4947 1117 
15164 13256 Gerald 4218 1454 4647 1405 
15804 13421 Walter 3317 1046 3430 1025 
15891 13569 Christina 4337 1447 3770 1386 
16063 14287 Brandon 4565 1438 5161 1674 
16415 14311 Elizabeth 9336 2716 9543 2881 
18477 14440 Joseph 1954 640 2211 747 
18855 16973 Lawrence 7378 2271 7361 2362 
19097 17123 Marilyn 6942 2121 6045 1775 
19575 17562 Lori 4871 1458 4867 1485 
"""
  
-- 2. 이 쿼리는 콘테스트 별 해커 별 학교 아이디와 챌린지 아이디가 나오게 되어있다.
-- 그가 그 학교에서 어떤 챌린지를 했는지 볼 수 있는데 결과가 상당히 지저분하다. 챌린지가 네개면 같은 줄이 4줄이 나오게 되는 식이다.
SELECT cts.contest_id, cts.hacker_id, cts.name, chls.college_id, subs.challenge_id
-- SUM(total_submissions), SUM(total_accepted_submissions), SUM(total_views), SUM(total_unique_views)
FROM CONTESTS cts, COLLEGES colg, CHALLENGES chls, VIEW_STATS vs, SUBMISSION_STATS subs
WHERE 1=1 
    AND cts.contest_id = colg.contest_id 
    AND colg.college_id = chls.college_id 
    AND chls.challenge_id = vs.challenge_id
    AND chls.challenge_id = subs.challenge_id
-- GROUP BY cts.contest_id, cts.hacker_id, cts.name
-- HAVING SUM(total_submissions) +SUM(total_accepted_submissions) +SUM(total_views) +SUM(total_unique_views)!=0
ORDER BY 1, 2, 3, 4, 5 LIMIT 30;
""" 결과
845 579 Rose 96 145 
845 579 Rose 96 145 
845 579 Rose 96 145 
845 579 Rose 96 145 
845 579 Rose 96 276 
845 579 Rose 96 276 
845 579 Rose 96 276 
845 579 Rose 96 276 
845 579 Rose 96 773 
845 579 Rose 96 773 
845 579 Rose 96 773 
845 579 Rose 96 773 
845 579 Rose 96 773 
845 579 Rose 96 773 
845 579 Rose 96 773 
845 579 Rose 96 773 
845 579 Rose 96 791 
845 579 Rose 96 791 
845 579 Rose 96 791 
845 579 Rose 96 829 
845 579 Rose 96 829 
845 579 Rose 96 829 
845 579 Rose 96 829 
845 579 Rose 96 829 
845 579 Rose 96 829 
845 579 Rose 96 829 
845 579 Rose 96 829 
845 579 Rose 191 1003 
845 579 Rose 191 1003 
845 579 Rose 191 1183 
"""
-- 결과를 보면 학교 아이디와 도전 아이디가 상당히 여러개로 되어있는 것을 볼 수 있다. 
-- 문제에서 원하는 건 contest별, 제출자와, 그가 속한 학교내에서 제출했던 기록에 대한 SUM인데 상당히 크게 나올 수 밖에 없는 상황으로 보인다.
