"""
POE stats 분석하면서 알게된 부분.
컬럼 값에 따라 다른(혹은 같은 컬럼도 된다) 컬럼에 값을 넣고자 할때 이런 식으로 할 수 있다.

df['컬럼명'] = np.where(df[값탐색컬럼명].isin(리스트), 참일경우값, 거짓일경우값)
"""

# 이 경우는 제대로 된다
# Strength
df['stat_Str'] = np.where(df['class'].isin(['Marauder', 'Juggernaut', 'Berserker', 'Chieftain', 
                                            'Duelist', 'Slayer', 'Gladiator', 'Champion', 
                                            'Templar', 'Inquisitor', 'Hierophant', 'Guardian',
                                            'Scion', 'Ascendant']), 1, 0)

# Intelligence
df['stat_Int'] = np.where(df['class'].isin(['Witch', 'Necromancer', 'Elementalist', 'Occultist', 
                                            'Shadow', 'Assassin', 'Saboteur', 'Trickster',
                                            'Templar', 'Inquisitor', 'Hierophant', 'Guardian',
                                            'Scion', 'Ascendant']), 1, 0)

# Dexterity
df['stat_Dex'] = np.where(df['class'].isin(['Ranger', 'Raider', 'Deadeye', 'Pathfinder',
                                            'Duelist', 'Slayer', 'Gladiator', 'Champion',
                                            'Shadow', 'Assassin', 'Saboteur', 'Trickster',
                                            'Scion', 'Ascendant']), 1, 0)


"""
시행착오 두 가지
"""

#1. 이렇게 하면 각 컬럼에서 가장 아래에 있는 조건만 실행되고 만다.

# # Strength
# df['stat_Str'] = np.where(df['class'].isin(Marauder), 1, 0)
# df['stat_Str'] = np.where(df['class'].isin(Duelist), 1, 0)
# df['stat_Str'] = np.where(df['class'].isin(Templar), 1, 0)
# df['stat_Str'] = np.where(df['class'].isin(Scion), 1, 0)

# # Intelligence
# df['stat_Int'] = np.where(df['class'].isin(Witch), 1, 0)
# df['stat_Int'] = np.where(df['class'].isin(Shadow), 1, 0)
# df['stat_Int'] = np.where(df['class'].isin(Templar), 1, 0)
# df['stat_Int'] = np.where(df['class'].isin(Scion), 1, 0)

# # Dexterity
# df['stat_Dex'] = np.where(df['class'].isin(Ranger), 1, 0)
# df['stat_Dex'] = np.where(df['class'].isin(Duelist), 1, 0)
# df['stat_Dex'] = np.where(df['class'].isin(Shadow), 1, 0)
# df['stat_Dex'] = np.where(df['class'].isin(Scion), 1, 0)


#2. 이렇게 하면 or로 묶인 조건이 제대로 실행되지 않더라. 어떤 이유에서인지 어떻게든 이 과정은 틀리고야 말았다.

# # Strength
# df['stat_Str'] = np.where(df['class'].isin(Marauder or Duelist or Templar or Scion), 1, 0)

# # Intelligence
# df['stat_Int'] = np.where(df['class'].isin(Witch or Shadow or Templar or Scion), 1, 0)

# # Dexterity
# df['stat_Dex'] = np.where(df['class'].isin(Ranger or Duelist or Shadow or Scion), 1, 0)
