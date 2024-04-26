echo Script running
perl -i -pe 's|Splits \[\.\.\.\]|Splits [ Splits ]|g' Dependencies.txt
echo 1 / 1866 --- Splits to Splits
perl -i -pe 's|Result0 \[\.\.\.\]|Result0 [ T0 ]|g' Dependencies.txt
echo 2 / 1866 --- Result0 to T0
perl -i -pe 's|Result-2 \[\.\.\.\]|Result-2 [ FinishTimeLimit ]|g' Dependencies.txt
echo 3 / 1866 --- Result-2 to FinishTimeLimit
perl -i -pe 's|Result-3 \[\.\.\.\]|Result-3 [ StartResult ]|g' Dependencies.txt
echo 4 / 1866 --- Result-3 to StartResult
perl -i -pe 's|Result-1 \[\.\.\.\]|Result-1 [ FinishResult ]|g' Dependencies.txt
echo 5 / 1866 --- Result-1 to FinishResult
perl -i -pe 's|Result1 \[\.\.\.\]|Result1 [ SelectorStage1 ]|g' Dependencies.txt
echo 6 / 1866 --- Result1 to SelectorStage1
perl -i -pe 's|Result2 \[\.\.\.\]|Result2 [ SelectorStage2 ]|g' Dependencies.txt
echo 7 / 1866 --- Result2 to SelectorStage2
perl -i -pe 's|Result3 \[\.\.\.\]|Result3 [ SelectorStage3 ]|g' Dependencies.txt
echo 8 / 1866 --- Result3 to SelectorStage3
perl -i -pe 's|Result4 \[\.\.\.\]|Result4 [ SelectorStage4 ]|g' Dependencies.txt
echo 9 / 1866 --- Result4 to SelectorStage4
perl -i -pe 's|Result5 \[\.\.\.\]|Result5 [ SelectorStage5 ]|g' Dependencies.txt
echo 10 / 1866 --- Result5 to SelectorStage5
perl -i -pe 's|Result6 \[\.\.\.\]|Result6 [ SelectorStage6 ]|g' Dependencies.txt
echo 11 / 1866 --- Result6 to SelectorStage6
perl -i -pe 's|Result7 \[\.\.\.\]|Result7 [ SelectorStage7 ]|g' Dependencies.txt
echo 12 / 1866 --- Result7 to SelectorStage7
perl -i -pe 's|Result8 \[\.\.\.\]|Result8 [ SelectorStage8 ]|g' Dependencies.txt
echo 13 / 1866 --- Result8 to SelectorStage8
perl -i -pe 's|Result10 \[\.\.\.\]|Result10 [ SelectorAll ]|g' Dependencies.txt
echo 14 / 1866 --- Result10 to SelectorAll
perl -i -pe 's|Result20 \[\.\.\.\]|Result20 [ EntryFeeAsTime ]|g' Dependencies.txt
echo 15 / 1866 --- Result20 to EntryFeeAsTime
perl -i -pe 's|Result101 \[\.\.\.\]|Result101 [ Stage1GCPoints ]|g' Dependencies.txt
echo 16 / 1866 --- Result101 to Stage1GCPoints
perl -i -pe 's|Result102 \[\.\.\.\]|Result102 [ Stage2GCPoints ]|g' Dependencies.txt
echo 17 / 1866 --- Result102 to Stage2GCPoints
perl -i -pe 's|Result103 \[\.\.\.\]|Result103 [ Stage3GCPoints ]|g' Dependencies.txt
echo 18 / 1866 --- Result103 to Stage3GCPoints
perl -i -pe 's|Result104 \[\.\.\.\]|Result104 [ Stage4GCPoints ]|g' Dependencies.txt
echo 19 / 1866 --- Result104 to Stage4GCPoints
perl -i -pe 's|Result105 \[\.\.\.\]|Result105 [ Stage5GCPoints ]|g' Dependencies.txt
echo 20 / 1866 --- Result105 to Stage5GCPoints
perl -i -pe 's|Result106 \[\.\.\.\]|Result106 [ Stage6GCPoints ]|g' Dependencies.txt
echo 21 / 1866 --- Result106 to Stage6GCPoints
perl -i -pe 's|Result107 \[\.\.\.\]|Result107 [ Stage7GCPoints ]|g' Dependencies.txt
echo 22 / 1866 --- Result107 to Stage7GCPoints
perl -i -pe 's|Result108 \[\.\.\.\]|Result108 [ Stage8GCPoints ]|g' Dependencies.txt
echo 23 / 1866 --- Result108 to Stage8GCPoints
perl -i -pe 's|Result111 \[\.\.\.\]|Result111 [ Stage1TeamRiderPoints ]|g' Dependencies.txt
echo 24 / 1866 --- Result111 to Stage1TeamRiderPoints
perl -i -pe 's|Result112 \[\.\.\.\]|Result112 [ Stage2TeamRiderPoints ]|g' Dependencies.txt
echo 25 / 1866 --- Result112 to Stage2TeamRiderPoints
perl -i -pe 's|Result113 \[\.\.\.\]|Result113 [ Stage3TeamRiderPoints ]|g' Dependencies.txt
echo 26 / 1866 --- Result113 to Stage3TeamRiderPoints
perl -i -pe 's|Result114 \[\.\.\.\]|Result114 [ Stage4TeamRiderPoints ]|g' Dependencies.txt
echo 27 / 1866 --- Result114 to Stage4TeamRiderPoints
perl -i -pe 's|Result115 \[\.\.\.\]|Result115 [ Stage5TeamRiderPoints ]|g' Dependencies.txt
echo 28 / 1866 --- Result115 to Stage5TeamRiderPoints
perl -i -pe 's|Result116 \[\.\.\.\]|Result116 [ Stage6TeamRiderPoints ]|g' Dependencies.txt
echo 29 / 1866 --- Result116 to Stage6TeamRiderPoints
perl -i -pe 's|Result117 \[\.\.\.\]|Result117 [ Stage7TeamRiderPoints ]|g' Dependencies.txt
echo 30 / 1866 --- Result117 to Stage7TeamRiderPoints
perl -i -pe 's|Result118 \[\.\.\.\]|Result118 [ Stage8TeamRiderPoints ]|g' Dependencies.txt
echo 31 / 1866 --- Result118 to Stage8TeamRiderPoints
perl -i -pe 's|Result121 \[\.\.\.\]|Result121 [ Stage1TeamScoredRidersPoints ]|g' Dependencies.txt
echo 32 / 1866 --- Result121 to Stage1TeamScoredRidersPoints
perl -i -pe 's|Result122 \[\.\.\.\]|Result122 [ Stage2TeamScoredRidersPoints ]|g' Dependencies.txt
echo 33 / 1866 --- Result122 to Stage2TeamScoredRidersPoints
perl -i -pe 's|Result123 \[\.\.\.\]|Result123 [ Stage3TeamScoredRidersPoints ]|g' Dependencies.txt
echo 34 / 1866 --- Result123 to Stage3TeamScoredRidersPoints
perl -i -pe 's|Result124 \[\.\.\.\]|Result124 [ Stage4TeamScoredRidersPoints ]|g' Dependencies.txt
echo 35 / 1866 --- Result124 to Stage4TeamScoredRidersPoints
perl -i -pe 's|Result125 \[\.\.\.\]|Result125 [ Stage5TeamScoredRidersPoints ]|g' Dependencies.txt
echo 36 / 1866 --- Result125 to Stage5TeamScoredRidersPoints
perl -i -pe 's|Result126 \[\.\.\.\]|Result126 [ Stage6TeamScoredRidersPoints ]|g' Dependencies.txt
echo 37 / 1866 --- Result126 to Stage6TeamScoredRidersPoints
perl -i -pe 's|Result127 \[\.\.\.\]|Result127 [ Stage7TeamScoredRidersPoints ]|g' Dependencies.txt
echo 38 / 1866 --- Result127 to Stage7TeamScoredRidersPoints
perl -i -pe 's|Result128 \[\.\.\.\]|Result128 [ Stage8TeamScoredRidersPoints ]|g' Dependencies.txt
echo 39 / 1866 --- Result128 to Stage8TeamScoredRidersPoints
perl -i -pe 's|Result131 \[\.\.\.\]|Result131 [ Stage1TeamPoints ]|g' Dependencies.txt
echo 40 / 1866 --- Result131 to Stage1TeamPoints
perl -i -pe 's|Result132 \[\.\.\.\]|Result132 [ Stage2TeamPoints ]|g' Dependencies.txt
echo 41 / 1866 --- Result132 to Stage2TeamPoints
perl -i -pe 's|Result133 \[\.\.\.\]|Result133 [ Stage3TeamPoints ]|g' Dependencies.txt
echo 42 / 1866 --- Result133 to Stage3TeamPoints
perl -i -pe 's|Result134 \[\.\.\.\]|Result134 [ Stage4TeamPoints ]|g' Dependencies.txt
echo 43 / 1866 --- Result134 to Stage4TeamPoints
perl -i -pe 's|Result135 \[\.\.\.\]|Result135 [ Stage5TeamPoints ]|g' Dependencies.txt
echo 44 / 1866 --- Result135 to Stage5TeamPoints
perl -i -pe 's|Result136 \[\.\.\.\]|Result136 [ Stage6TeamPoints ]|g' Dependencies.txt
echo 45 / 1866 --- Result136 to Stage6TeamPoints
perl -i -pe 's|Result137 \[\.\.\.\]|Result137 [ Stage7TeamPoints ]|g' Dependencies.txt
echo 46 / 1866 --- Result137 to Stage7TeamPoints
perl -i -pe 's|Result138 \[\.\.\.\]|Result138 [ Stage8TeamPoints ]|g' Dependencies.txt
echo 47 / 1866 --- Result138 to Stage8TeamPoints
perl -i -pe 's|Result141 \[\.\.\.\]|Result141 [ AfterStage1TeamGCPoints ]|g' Dependencies.txt
echo 48 / 1866 --- Result141 to AfterStage1TeamGCPoints
perl -i -pe 's|Result142 \[\.\.\.\]|Result142 [ AfterStage2TeamGCPoints ]|g' Dependencies.txt
echo 49 / 1866 --- Result142 to AfterStage2TeamGCPoints
perl -i -pe 's|Result143 \[\.\.\.\]|Result143 [ AfterStage3TeamGCPoints ]|g' Dependencies.txt
echo 50 / 1866 --- Result143 to AfterStage3TeamGCPoints
perl -i -pe 's|Result144 \[\.\.\.\]|Result144 [ AfterStage4TeamGCPoints ]|g' Dependencies.txt
echo 51 / 1866 --- Result144 to AfterStage4TeamGCPoints
perl -i -pe 's|Result145 \[\.\.\.\]|Result145 [ AfterStage5TeamGCPoints ]|g' Dependencies.txt
echo 52 / 1866 --- Result145 to AfterStage5TeamGCPoints
perl -i -pe 's|Result146 \[\.\.\.\]|Result146 [ AfterStage6TeamGCPoints ]|g' Dependencies.txt
echo 53 / 1866 --- Result146 to AfterStage6TeamGCPoints
perl -i -pe 's|Result147 \[\.\.\.\]|Result147 [ AfterStage7TeamGCPoints ]|g' Dependencies.txt
echo 54 / 1866 --- Result147 to AfterStage7TeamGCPoints
perl -i -pe 's|Result148 \[\.\.\.\]|Result148 [ AfterStage8TeamGCPoints ]|g' Dependencies.txt
echo 55 / 1866 --- Result148 to AfterStage8TeamGCPoints
perl -i -pe 's|Result151 \[\.\.\.\]|Result151 [ Stage1TeamClassificationPlace ]|g' Dependencies.txt
echo 56 / 1866 --- Result151 to Stage1TeamClassificationPlace
perl -i -pe 's|Result152 \[\.\.\.\]|Result152 [ Stage2TeamClassificationPlace ]|g' Dependencies.txt
echo 57 / 1866 --- Result152 to Stage2TeamClassificationPlace
perl -i -pe 's|Result153 \[\.\.\.\]|Result153 [ Stage3TeamClassificationPlace ]|g' Dependencies.txt
echo 58 / 1866 --- Result153 to Stage3TeamClassificationPlace
perl -i -pe 's|Result154 \[\.\.\.\]|Result154 [ Stage4TeamClassificationPlace ]|g' Dependencies.txt
echo 59 / 1866 --- Result154 to Stage4TeamClassificationPlace
perl -i -pe 's|Result155 \[\.\.\.\]|Result155 [ Stage5TeamClassificationPlace ]|g' Dependencies.txt
echo 60 / 1866 --- Result155 to Stage5TeamClassificationPlace
perl -i -pe 's|Result156 \[\.\.\.\]|Result156 [ Stage6TeamClassificationPlace ]|g' Dependencies.txt
echo 61 / 1866 --- Result156 to Stage6TeamClassificationPlace
perl -i -pe 's|Result157 \[\.\.\.\]|Result157 [ Stage7TeamClassificationPlace ]|g' Dependencies.txt
echo 62 / 1866 --- Result157 to Stage7TeamClassificationPlace
perl -i -pe 's|Result158 \[\.\.\.\]|Result158 [ Stage8TeamClassificationPlace ]|g' Dependencies.txt
echo 63 / 1866 --- Result158 to Stage8TeamClassificationPlace
perl -i -pe 's|Result161 \[\.\.\.\]|Result161 [ Stage1_U23_Points ]|g' Dependencies.txt
echo 64 / 1866 --- Result161 to Stage1_U23_Points
perl -i -pe 's|Result162 \[\.\.\.\]|Result162 [ Stage2_U23_Points ]|g' Dependencies.txt
echo 65 / 1866 --- Result162 to Stage2_U23_Points
perl -i -pe 's|Result163 \[\.\.\.\]|Result163 [ Stage3_U23_Points ]|g' Dependencies.txt
echo 66 / 1866 --- Result163 to Stage3_U23_Points
perl -i -pe 's|Result164 \[\.\.\.\]|Result164 [ Stage4_U23_Points ]|g' Dependencies.txt
echo 67 / 1866 --- Result164 to Stage4_U23_Points
perl -i -pe 's|Result165 \[\.\.\.\]|Result165 [ Stage5_U23_Points ]|g' Dependencies.txt
echo 68 / 1866 --- Result165 to Stage5_U23_Points
perl -i -pe 's|Result166 \[\.\.\.\]|Result166 [ Stage6_U23_Points ]|g' Dependencies.txt
echo 69 / 1866 --- Result166 to Stage6_U23_Points
perl -i -pe 's|Result167 \[\.\.\.\]|Result167 [ Stage7_U23_Points ]|g' Dependencies.txt
echo 70 / 1866 --- Result167 to Stage7_U23_Points
perl -i -pe 's|Result168 \[\.\.\.\]|Result168 [ Stage8_U23_Points ]|g' Dependencies.txt
echo 71 / 1866 --- Result168 to Stage8_U23_Points
perl -i -pe 's|Result171 \[\.\.\.\]|Result171 [ Stage1_U23_TeamPoints ]|g' Dependencies.txt
echo 72 / 1866 --- Result171 to Stage1_U23_TeamPoints
perl -i -pe 's|Result172 \[\.\.\.\]|Result172 [ Stage2_U23_TeamPoints ]|g' Dependencies.txt
echo 73 / 1866 --- Result172 to Stage2_U23_TeamPoints
perl -i -pe 's|Result173 \[\.\.\.\]|Result173 [ Stage3_U23_TeamPoints ]|g' Dependencies.txt
echo 74 / 1866 --- Result173 to Stage3_U23_TeamPoints
perl -i -pe 's|Result174 \[\.\.\.\]|Result174 [ Stage4_U23_TeamPoints ]|g' Dependencies.txt
echo 75 / 1866 --- Result174 to Stage4_U23_TeamPoints
perl -i -pe 's|Result175 \[\.\.\.\]|Result175 [ Stage5_U23_TeamPoints ]|g' Dependencies.txt
echo 76 / 1866 --- Result175 to Stage5_U23_TeamPoints
perl -i -pe 's|Result176 \[\.\.\.\]|Result176 [ Stage6_U23_TeamPoints ]|g' Dependencies.txt
echo 77 / 1866 --- Result176 to Stage6_U23_TeamPoints
perl -i -pe 's|Result177 \[\.\.\.\]|Result177 [ Stage7_U23_TeamPoints ]|g' Dependencies.txt
echo 78 / 1866 --- Result177 to Stage7_U23_TeamPoints
perl -i -pe 's|Result178 \[\.\.\.\]|Result178 [ Stage8_U23_TeamPoints ]|g' Dependencies.txt
echo 79 / 1866 --- Result178 to Stage8_U23_TeamPoints
perl -i -pe 's|Result191 \[\.\.\.\]|Result191 [ AfterStage1_U23_GC_Points ]|g' Dependencies.txt
echo 80 / 1866 --- Result191 to AfterStage1_U23_GC_Points
perl -i -pe 's|Result192 \[\.\.\.\]|Result192 [ AfterStage2_U23_GC_Points ]|g' Dependencies.txt
echo 81 / 1866 --- Result192 to AfterStage2_U23_GC_Points
perl -i -pe 's|Result193 \[\.\.\.\]|Result193 [ AfterStage3_U23_GC_Points ]|g' Dependencies.txt
echo 82 / 1866 --- Result193 to AfterStage3_U23_GC_Points
perl -i -pe 's|Result194 \[\.\.\.\]|Result194 [ AfterStage4_U23_GC_Points ]|g' Dependencies.txt
echo 83 / 1866 --- Result194 to AfterStage4_U23_GC_Points
perl -i -pe 's|Result195 \[\.\.\.\]|Result195 [ AfterStage5_U23_GC_Points ]|g' Dependencies.txt
echo 84 / 1866 --- Result195 to AfterStage5_U23_GC_Points
perl -i -pe 's|Result196 \[\.\.\.\]|Result196 [ AfterStage6_U23_GC_Points ]|g' Dependencies.txt
echo 85 / 1866 --- Result196 to AfterStage6_U23_GC_Points
perl -i -pe 's|Result197 \[\.\.\.\]|Result197 [ AfterStage7_U23_GC_Points ]|g' Dependencies.txt
echo 86 / 1866 --- Result197 to AfterStage7_U23_GC_Points
perl -i -pe 's|Result198 \[\.\.\.\]|Result198 [ AfterStage8_U23_GC_Points ]|g' Dependencies.txt
echo 87 / 1866 --- Result198 to AfterStage8_U23_GC_Points
perl -i -pe 's|Result201 \[\.\.\.\]|Result201 [ AfterStage1GCPoints ]|g' Dependencies.txt
echo 88 / 1866 --- Result201 to AfterStage1GCPoints
perl -i -pe 's|Result202 \[\.\.\.\]|Result202 [ AfterStage2GCPoints ]|g' Dependencies.txt
echo 89 / 1866 --- Result202 to AfterStage2GCPoints
perl -i -pe 's|Result203 \[\.\.\.\]|Result203 [ AfterStage3GCPoints ]|g' Dependencies.txt
echo 90 / 1866 --- Result203 to AfterStage3GCPoints
perl -i -pe 's|Result204 \[\.\.\.\]|Result204 [ AfterStage4GCPoints ]|g' Dependencies.txt
echo 91 / 1866 --- Result204 to AfterStage4GCPoints
perl -i -pe 's|Result205 \[\.\.\.\]|Result205 [ AfterStage5GCPoints ]|g' Dependencies.txt
echo 92 / 1866 --- Result205 to AfterStage5GCPoints
perl -i -pe 's|Result206 \[\.\.\.\]|Result206 [ AfterStage6GCPoints ]|g' Dependencies.txt
echo 93 / 1866 --- Result206 to AfterStage6GCPoints
perl -i -pe 's|Result207 \[\.\.\.\]|Result207 [ AfterStage7GCPoints ]|g' Dependencies.txt
echo 94 / 1866 --- Result207 to AfterStage7GCPoints
perl -i -pe 's|Result208 \[\.\.\.\]|Result208 [ AfterStage8GCPoints ]|g' Dependencies.txt
echo 95 / 1866 --- Result208 to AfterStage8GCPoints
perl -i -pe 's|Result211 \[\.\.\.\]|Result211 [ Stage1_U23_Place ]|g' Dependencies.txt
echo 96 / 1866 --- Result211 to Stage1_U23_Place
perl -i -pe 's|Result212 \[\.\.\.\]|Result212 [ Stage2_U23_Place ]|g' Dependencies.txt
echo 97 / 1866 --- Result212 to Stage2_U23_Place
perl -i -pe 's|Result213 \[\.\.\.\]|Result213 [ Stage3_U23_Place ]|g' Dependencies.txt
echo 98 / 1866 --- Result213 to Stage3_U23_Place
perl -i -pe 's|Result214 \[\.\.\.\]|Result214 [ Stage4_U23_Place ]|g' Dependencies.txt
echo 99 / 1866 --- Result214 to Stage4_U23_Place
perl -i -pe 's|Result215 \[\.\.\.\]|Result215 [ Stage5_U23_Place ]|g' Dependencies.txt
echo 100 / 1866 --- Result215 to Stage5_U23_Place
perl -i -pe 's|Result216 \[\.\.\.\]|Result216 [ Stage6_U23_Place ]|g' Dependencies.txt
echo 101 / 1866 --- Result216 to Stage6_U23_Place
perl -i -pe 's|Result217 \[\.\.\.\]|Result217 [ Stage7_U23_Place ]|g' Dependencies.txt
echo 102 / 1866 --- Result217 to Stage7_U23_Place
perl -i -pe 's|Result218 \[\.\.\.\]|Result218 [ Stage8_U23_Place ]|g' Dependencies.txt
echo 103 / 1866 --- Result218 to Stage8_U23_Place
perl -i -pe 's|Result301 \[\.\.\.\]|Result301 [ AfterStage1UphillGCTime ]|g' Dependencies.txt
echo 104 / 1866 --- Result301 to AfterStage1UphillGCTime
perl -i -pe 's|Result302 \[\.\.\.\]|Result302 [ AfterStage2UphillGCTime ]|g' Dependencies.txt
echo 105 / 1866 --- Result302 to AfterStage2UphillGCTime
perl -i -pe 's|Result303 \[\.\.\.\]|Result303 [ AfterStage3UphillGCTime ]|g' Dependencies.txt
echo 106 / 1866 --- Result303 to AfterStage3UphillGCTime
perl -i -pe 's|Result304 \[\.\.\.\]|Result304 [ AfterStage4UphillGCTime ]|g' Dependencies.txt
echo 107 / 1866 --- Result304 to AfterStage4UphillGCTime
perl -i -pe 's|Result305 \[\.\.\.\]|Result305 [ AfterStage5UphillGCTime ]|g' Dependencies.txt
echo 108 / 1866 --- Result305 to AfterStage5UphillGCTime
perl -i -pe 's|Result306 \[\.\.\.\]|Result306 [ AfterStage6UphillGCTime ]|g' Dependencies.txt
echo 109 / 1866 --- Result306 to AfterStage6UphillGCTime
perl -i -pe 's|Result307 \[\.\.\.\]|Result307 [ AfterStage7UphillGCTime ]|g' Dependencies.txt
echo 110 / 1866 --- Result307 to AfterStage7UphillGCTime
perl -i -pe 's|Result308 \[\.\.\.\]|Result308 [ AfterStage8UphillGCTime ]|g' Dependencies.txt
echo 111 / 1866 --- Result308 to AfterStage8UphillGCTime
perl -i -pe 's|Result311 \[\.\.\.\]|Result311 [ Stage1UphillTime ]|g' Dependencies.txt
echo 112 / 1866 --- Result311 to Stage1UphillTime
perl -i -pe 's|Result312 \[\.\.\.\]|Result312 [ Stage2UphillTime ]|g' Dependencies.txt
echo 113 / 1866 --- Result312 to Stage2UphillTime
perl -i -pe 's|Result313 \[\.\.\.\]|Result313 [ Stage3UphillTime ]|g' Dependencies.txt
echo 114 / 1866 --- Result313 to Stage3UphillTime
perl -i -pe 's|Result314 \[\.\.\.\]|Result314 [ Stage4UphillTime ]|g' Dependencies.txt
echo 115 / 1866 --- Result314 to Stage4UphillTime
perl -i -pe 's|Result315 \[\.\.\.\]|Result315 [ Stage5UphillTime ]|g' Dependencies.txt
echo 116 / 1866 --- Result315 to Stage5UphillTime
perl -i -pe 's|Result316 \[\.\.\.\]|Result316 [ Stage6UphillTime ]|g' Dependencies.txt
echo 117 / 1866 --- Result316 to Stage6UphillTime
perl -i -pe 's|Result317 \[\.\.\.\]|Result317 [ Stage7UphillTime ]|g' Dependencies.txt
echo 118 / 1866 --- Result317 to Stage7UphillTime
perl -i -pe 's|Result318 \[\.\.\.\]|Result318 [ Stage8UphillTime ]|g' Dependencies.txt
echo 119 / 1866 --- Result318 to Stage8UphillTime
perl -i -pe 's|Result321 \[\.\.\.\]|Result321 [ AfterStage1UphillCount ]|g' Dependencies.txt
echo 120 / 1866 --- Result321 to AfterStage1UphillCount
perl -i -pe 's|Result322 \[\.\.\.\]|Result322 [ AfterStage2UphillCount ]|g' Dependencies.txt
echo 121 / 1866 --- Result322 to AfterStage2UphillCount
perl -i -pe 's|Result323 \[\.\.\.\]|Result323 [ AfterStage3UphillCount ]|g' Dependencies.txt
echo 122 / 1866 --- Result323 to AfterStage3UphillCount
perl -i -pe 's|Result324 \[\.\.\.\]|Result324 [ AfterStage4UphillCount ]|g' Dependencies.txt
echo 123 / 1866 --- Result324 to AfterStage4UphillCount
perl -i -pe 's|Result325 \[\.\.\.\]|Result325 [ AfterStage5UphillCount ]|g' Dependencies.txt
echo 124 / 1866 --- Result325 to AfterStage5UphillCount
perl -i -pe 's|Result326 \[\.\.\.\]|Result326 [ AfterStage6UphillCount ]|g' Dependencies.txt
echo 125 / 1866 --- Result326 to AfterStage6UphillCount
perl -i -pe 's|Result327 \[\.\.\.\]|Result327 [ AfterStage7UphillCount ]|g' Dependencies.txt
echo 126 / 1866 --- Result327 to AfterStage7UphillCount
perl -i -pe 's|Result328 \[\.\.\.\]|Result328 [ AfterStage8UphillCount ]|g' Dependencies.txt
echo 127 / 1866 --- Result328 to AfterStage8UphillCount
perl -i -pe 's|Result401 \[\.\.\.\]|Result401 [ Stage1ClubScoredRidersPoints ]|g' Dependencies.txt
echo 128 / 1866 --- Result401 to Stage1ClubScoredRidersPoints
perl -i -pe 's|Result402 \[\.\.\.\]|Result402 [ Stage2ClubScoredRidersPoints ]|g' Dependencies.txt
echo 129 / 1866 --- Result402 to Stage2ClubScoredRidersPoints
perl -i -pe 's|Result403 \[\.\.\.\]|Result403 [ Stage3ClubScoredRidersPoints ]|g' Dependencies.txt
echo 130 / 1866 --- Result403 to Stage3ClubScoredRidersPoints
perl -i -pe 's|Result404 \[\.\.\.\]|Result404 [ Stage4ClubScoredRidersPoints ]|g' Dependencies.txt
echo 131 / 1866 --- Result404 to Stage4ClubScoredRidersPoints
perl -i -pe 's|Result405 \[\.\.\.\]|Result405 [ Stage5ClubScoredRidersPoints ]|g' Dependencies.txt
echo 132 / 1866 --- Result405 to Stage5ClubScoredRidersPoints
perl -i -pe 's|Result406 \[\.\.\.\]|Result406 [ Stage6ClubScoredRidersPoints ]|g' Dependencies.txt
echo 133 / 1866 --- Result406 to Stage6ClubScoredRidersPoints
perl -i -pe 's|Result407 \[\.\.\.\]|Result407 [ Stage7ClubScoredRidersPoints ]|g' Dependencies.txt
echo 134 / 1866 --- Result407 to Stage7ClubScoredRidersPoints
perl -i -pe 's|Result408 \[\.\.\.\]|Result408 [ Stage8ClubScoredRidersPoints ]|g' Dependencies.txt
echo 135 / 1866 --- Result408 to Stage8ClubScoredRidersPoints
perl -i -pe 's|Result411 \[\.\.\.\]|Result411 [ Stage1ClubPoints ]|g' Dependencies.txt
echo 136 / 1866 --- Result411 to Stage1ClubPoints
perl -i -pe 's|Result412 \[\.\.\.\]|Result412 [ Stage2ClubPoints ]|g' Dependencies.txt
echo 137 / 1866 --- Result412 to Stage2ClubPoints
perl -i -pe 's|Result413 \[\.\.\.\]|Result413 [ Stage3ClubPoints ]|g' Dependencies.txt
echo 138 / 1866 --- Result413 to Stage3ClubPoints
perl -i -pe 's|Result414 \[\.\.\.\]|Result414 [ Stage4ClubPoints ]|g' Dependencies.txt
echo 139 / 1866 --- Result414 to Stage4ClubPoints
perl -i -pe 's|Result415 \[\.\.\.\]|Result415 [ Stage5ClubPoints ]|g' Dependencies.txt
echo 140 / 1866 --- Result415 to Stage5ClubPoints
perl -i -pe 's|Result416 \[\.\.\.\]|Result416 [ Stage6ClubPoints ]|g' Dependencies.txt
echo 141 / 1866 --- Result416 to Stage6ClubPoints
perl -i -pe 's|Result417 \[\.\.\.\]|Result417 [ Stage7ClubPoints ]|g' Dependencies.txt
echo 142 / 1866 --- Result417 to Stage7ClubPoints
perl -i -pe 's|Result418 \[\.\.\.\]|Result418 [ Stage8ClubPoints ]|g' Dependencies.txt
echo 143 / 1866 --- Result418 to Stage8ClubPoints
perl -i -pe 's|Result421 \[\.\.\.\]|Result421 [ AfterStage1ClubGCPoints ]|g' Dependencies.txt
echo 144 / 1866 --- Result421 to AfterStage1ClubGCPoints
perl -i -pe 's|Result422 \[\.\.\.\]|Result422 [ AfterStage2ClubGCPoints ]|g' Dependencies.txt
echo 145 / 1866 --- Result422 to AfterStage2ClubGCPoints
perl -i -pe 's|Result423 \[\.\.\.\]|Result423 [ AfterStage3ClubGCPoints ]|g' Dependencies.txt
echo 146 / 1866 --- Result423 to AfterStage3ClubGCPoints
perl -i -pe 's|Result424 \[\.\.\.\]|Result424 [ AfterStage4ClubGCPoints ]|g' Dependencies.txt
echo 147 / 1866 --- Result424 to AfterStage4ClubGCPoints
perl -i -pe 's|Result425 \[\.\.\.\]|Result425 [ AfterStage5ClubGCPoints ]|g' Dependencies.txt
echo 148 / 1866 --- Result425 to AfterStage5ClubGCPoints
perl -i -pe 's|Result426 \[\.\.\.\]|Result426 [ AfterStage6ClubGCPoints ]|g' Dependencies.txt
echo 149 / 1866 --- Result426 to AfterStage6ClubGCPoints
perl -i -pe 's|Result427 \[\.\.\.\]|Result427 [ AfterStage7ClubGCPoints ]|g' Dependencies.txt
echo 150 / 1866 --- Result427 to AfterStage7ClubGCPoints
perl -i -pe 's|Result428 \[\.\.\.\]|Result428 [ AfterStage8ClubGCPoints ]|g' Dependencies.txt
echo 151 / 1866 --- Result428 to AfterStage8ClubGCPoints
perl -i -pe 's|Result431 \[\.\.\.\]|Result431 [ Stage1ClubTieBreaker ]|g' Dependencies.txt
echo 152 / 1866 --- Result431 to Stage1ClubTieBreaker
perl -i -pe 's|Result432 \[\.\.\.\]|Result432 [ Stage2ClubTieBreaker ]|g' Dependencies.txt
echo 153 / 1866 --- Result432 to Stage2ClubTieBreaker
perl -i -pe 's|Result433 \[\.\.\.\]|Result433 [ Stage3ClubTieBreaker ]|g' Dependencies.txt
echo 154 / 1866 --- Result433 to Stage3ClubTieBreaker
perl -i -pe 's|Result434 \[\.\.\.\]|Result434 [ Stage4ClubTieBreaker ]|g' Dependencies.txt
echo 155 / 1866 --- Result434 to Stage4ClubTieBreaker
perl -i -pe 's|Result435 \[\.\.\.\]|Result435 [ Stage5ClubTieBreaker ]|g' Dependencies.txt
echo 156 / 1866 --- Result435 to Stage5ClubTieBreaker
perl -i -pe 's|Result436 \[\.\.\.\]|Result436 [ Stage6ClubTieBreaker ]|g' Dependencies.txt
echo 157 / 1866 --- Result436 to Stage6ClubTieBreaker
perl -i -pe 's|Result437 \[\.\.\.\]|Result437 [ Stage7ClubTieBreaker ]|g' Dependencies.txt
echo 158 / 1866 --- Result437 to Stage7ClubTieBreaker
perl -i -pe 's|Result438 \[\.\.\.\]|Result438 [ Stage8ClubTieBreaker ]|g' Dependencies.txt
echo 159 / 1866 --- Result438 to Stage8ClubTieBreaker
perl -i -pe 's|Result441 \[\.\.\.\]|Result441 [ Stage1ClubClassificationPlace ]|g' Dependencies.txt
echo 160 / 1866 --- Result441 to Stage1ClubClassificationPlace
perl -i -pe 's|Result442 \[\.\.\.\]|Result442 [ Stage2ClubClassificationPlace ]|g' Dependencies.txt
echo 161 / 1866 --- Result442 to Stage2ClubClassificationPlace
perl -i -pe 's|Result443 \[\.\.\.\]|Result443 [ Stage3ClubClassificationPlace ]|g' Dependencies.txt
echo 162 / 1866 --- Result443 to Stage3ClubClassificationPlace
perl -i -pe 's|Result444 \[\.\.\.\]|Result444 [ Stage4ClubClassificationPlace ]|g' Dependencies.txt
echo 163 / 1866 --- Result444 to Stage4ClubClassificationPlace
perl -i -pe 's|Result445 \[\.\.\.\]|Result445 [ Stage5ClubClassificationPlace ]|g' Dependencies.txt
echo 164 / 1866 --- Result445 to Stage5ClubClassificationPlace
perl -i -pe 's|Result446 \[\.\.\.\]|Result446 [ Stage6ClubClassificationPlace ]|g' Dependencies.txt
echo 165 / 1866 --- Result446 to Stage6ClubClassificationPlace
perl -i -pe 's|Result447 \[\.\.\.\]|Result447 [ Stage7ClubClassificationPlace ]|g' Dependencies.txt
echo 166 / 1866 --- Result447 to Stage7ClubClassificationPlace
perl -i -pe 's|Result448 \[\.\.\.\]|Result448 [ Stage8ClubClassificationPlace ]|g' Dependencies.txt
echo 167 / 1866 --- Result448 to Stage8ClubClassificationPlace
perl -i -pe 's|Result1000 \[\.\.\.\]|Result1000 [ Stage1StartTime ]|g' Dependencies.txt
echo 168 / 1866 --- Result1000 to Stage1StartTime
perl -i -pe 's|Result1001 \[\.\.\.\]|Result1001 [ Stage1FinishTimeLimit ]|g' Dependencies.txt
echo 169 / 1866 --- Result1001 to Stage1FinishTimeLimit
perl -i -pe 's|Result1100 \[\.\.\.\]|Result1100 [ Stage1Started ]|g' Dependencies.txt
echo 170 / 1866 --- Result1100 to Stage1Started
perl -i -pe 's|Result1101 \[\.\.\.\]|Result1101 [ Stage1AfterLap1Split1 ]|g' Dependencies.txt
echo 171 / 1866 --- Result1101 to Stage1AfterLap1Split1
perl -i -pe 's|Result1102 \[\.\.\.\]|Result1102 [ Stage1AfterLap1Split2 ]|g' Dependencies.txt
echo 172 / 1866 --- Result1102 to Stage1AfterLap1Split2
perl -i -pe 's|Result1103 \[\.\.\.\]|Result1103 [ Stage1AfterLap1Split3 ]|g' Dependencies.txt
echo 173 / 1866 --- Result1103 to Stage1AfterLap1Split3
perl -i -pe 's|Result1104 \[\.\.\.\]|Result1104 [ Stage1AfterLap1Spotter ]|g' Dependencies.txt
echo 174 / 1866 --- Result1104 to Stage1AfterLap1Spotter
perl -i -pe 's|Result1105 \[\.\.\.\]|Result1105 [ Stage1AfterLap1Finish ]|g' Dependencies.txt
echo 175 / 1866 --- Result1105 to Stage1AfterLap1Finish
perl -i -pe 's|Result1106 \[\.\.\.\]|Result1106 [ Stage1AfterLap2Split1 ]|g' Dependencies.txt
echo 176 / 1866 --- Result1106 to Stage1AfterLap2Split1
perl -i -pe 's|Result1107 \[\.\.\.\]|Result1107 [ Stage1AfterLap2Split2 ]|g' Dependencies.txt
echo 177 / 1866 --- Result1107 to Stage1AfterLap2Split2
perl -i -pe 's|Result1108 \[\.\.\.\]|Result1108 [ Stage1AfterLap2Split3 ]|g' Dependencies.txt
echo 178 / 1866 --- Result1108 to Stage1AfterLap2Split3
perl -i -pe 's|Result1109 \[\.\.\.\]|Result1109 [ Stage1AfterLap2Spotter ]|g' Dependencies.txt
echo 179 / 1866 --- Result1109 to Stage1AfterLap2Spotter
perl -i -pe 's|Result1110 \[\.\.\.\]|Result1110 [ Stage1AfterLap2Finish ]|g' Dependencies.txt
echo 180 / 1866 --- Result1110 to Stage1AfterLap2Finish
perl -i -pe 's|Result1111 \[\.\.\.\]|Result1111 [ Stage1AfterLap3Split1 ]|g' Dependencies.txt
echo 181 / 1866 --- Result1111 to Stage1AfterLap3Split1
perl -i -pe 's|Result1112 \[\.\.\.\]|Result1112 [ Stage1AfterLap3Split2 ]|g' Dependencies.txt
echo 182 / 1866 --- Result1112 to Stage1AfterLap3Split2
perl -i -pe 's|Result1113 \[\.\.\.\]|Result1113 [ Stage1AfterLap3Split3 ]|g' Dependencies.txt
echo 183 / 1866 --- Result1113 to Stage1AfterLap3Split3
perl -i -pe 's|Result1114 \[\.\.\.\]|Result1114 [ Stage1AfterLap3Spotter ]|g' Dependencies.txt
echo 184 / 1866 --- Result1114 to Stage1AfterLap3Spotter
perl -i -pe 's|Result1115 \[\.\.\.\]|Result1115 [ Stage1AfterLap3Finish ]|g' Dependencies.txt
echo 185 / 1866 --- Result1115 to Stage1AfterLap3Finish
perl -i -pe 's|Result1116 \[\.\.\.\]|Result1116 [ Stage1AfterLap4Split1 ]|g' Dependencies.txt
echo 186 / 1866 --- Result1116 to Stage1AfterLap4Split1
perl -i -pe 's|Result1117 \[\.\.\.\]|Result1117 [ Stage1AfterLap4Split2 ]|g' Dependencies.txt
echo 187 / 1866 --- Result1117 to Stage1AfterLap4Split2
perl -i -pe 's|Result1118 \[\.\.\.\]|Result1118 [ Stage1AfterLap4Split3 ]|g' Dependencies.txt
echo 188 / 1866 --- Result1118 to Stage1AfterLap4Split3
perl -i -pe 's|Result1119 \[\.\.\.\]|Result1119 [ Stage1AfterLap4Spotter ]|g' Dependencies.txt
echo 189 / 1866 --- Result1119 to Stage1AfterLap4Spotter
perl -i -pe 's|Result1120 \[\.\.\.\]|Result1120 [ Stage1AfterLap4Finish ]|g' Dependencies.txt
echo 190 / 1866 --- Result1120 to Stage1AfterLap4Finish
perl -i -pe 's|Result1121 \[\.\.\.\]|Result1121 [ Stage1AfterLap5Split1 ]|g' Dependencies.txt
echo 191 / 1866 --- Result1121 to Stage1AfterLap5Split1
perl -i -pe 's|Result1122 \[\.\.\.\]|Result1122 [ Stage1AfterLap5Split2 ]|g' Dependencies.txt
echo 192 / 1866 --- Result1122 to Stage1AfterLap5Split2
perl -i -pe 's|Result1123 \[\.\.\.\]|Result1123 [ Stage1AfterLap5Split3 ]|g' Dependencies.txt
echo 193 / 1866 --- Result1123 to Stage1AfterLap5Split3
perl -i -pe 's|Result1124 \[\.\.\.\]|Result1124 [ Stage1AfterLap5Spotter ]|g' Dependencies.txt
echo 194 / 1866 --- Result1124 to Stage1AfterLap5Spotter
perl -i -pe 's|Result1125 \[\.\.\.\]|Result1125 [ Stage1AfterLap5Finish ]|g' Dependencies.txt
echo 195 / 1866 --- Result1125 to Stage1AfterLap5Finish
perl -i -pe 's|Result1126 \[\.\.\.\]|Result1126 [ Stage1AfterLap6Split1 ]|g' Dependencies.txt
echo 196 / 1866 --- Result1126 to Stage1AfterLap6Split1
perl -i -pe 's|Result1127 \[\.\.\.\]|Result1127 [ Stage1AfterLap6Split2 ]|g' Dependencies.txt
echo 197 / 1866 --- Result1127 to Stage1AfterLap6Split2
perl -i -pe 's|Result1128 \[\.\.\.\]|Result1128 [ Stage1AfterLap6Split3 ]|g' Dependencies.txt
echo 198 / 1866 --- Result1128 to Stage1AfterLap6Split3
perl -i -pe 's|Result1129 \[\.\.\.\]|Result1129 [ Stage1AfterLap6Spotter ]|g' Dependencies.txt
echo 199 / 1866 --- Result1129 to Stage1AfterLap6Spotter
perl -i -pe 's|Result1130 \[\.\.\.\]|Result1130 [ Stage1AfterLap6Finish ]|g' Dependencies.txt
echo 200 / 1866 --- Result1130 to Stage1AfterLap6Finish
perl -i -pe 's|Result1131 \[\.\.\.\]|Result1131 [ Stage1AfterLap7Split1 ]|g' Dependencies.txt
echo 201 / 1866 --- Result1131 to Stage1AfterLap7Split1
perl -i -pe 's|Result1132 \[\.\.\.\]|Result1132 [ Stage1AfterLap7Split2 ]|g' Dependencies.txt
echo 202 / 1866 --- Result1132 to Stage1AfterLap7Split2
perl -i -pe 's|Result1133 \[\.\.\.\]|Result1133 [ Stage1AfterLap7Split3 ]|g' Dependencies.txt
echo 203 / 1866 --- Result1133 to Stage1AfterLap7Split3
perl -i -pe 's|Result1134 \[\.\.\.\]|Result1134 [ Stage1AfterLap7Spotter ]|g' Dependencies.txt
echo 204 / 1866 --- Result1134 to Stage1AfterLap7Spotter
perl -i -pe 's|Result1135 \[\.\.\.\]|Result1135 [ Stage1AfterLap7Finish ]|g' Dependencies.txt
echo 205 / 1866 --- Result1135 to Stage1AfterLap7Finish
perl -i -pe 's|Result1136 \[\.\.\.\]|Result1136 [ Stage1AfterLap8Split1 ]|g' Dependencies.txt
echo 206 / 1866 --- Result1136 to Stage1AfterLap8Split1
perl -i -pe 's|Result1137 \[\.\.\.\]|Result1137 [ Stage1AfterLap8Split2 ]|g' Dependencies.txt
echo 207 / 1866 --- Result1137 to Stage1AfterLap8Split2
perl -i -pe 's|Result1138 \[\.\.\.\]|Result1138 [ Stage1AfterLap8Split3 ]|g' Dependencies.txt
echo 208 / 1866 --- Result1138 to Stage1AfterLap8Split3
perl -i -pe 's|Result1139 \[\.\.\.\]|Result1139 [ Stage1AfterLap8Spotter ]|g' Dependencies.txt
echo 209 / 1866 --- Result1139 to Stage1AfterLap8Spotter
perl -i -pe 's|Result1140 \[\.\.\.\]|Result1140 [ Stage1AfterLap8Finish ]|g' Dependencies.txt
echo 210 / 1866 --- Result1140 to Stage1AfterLap8Finish
perl -i -pe 's|Result1141 \[\.\.\.\]|Result1141 [ Stage1AfterLap9Split1 ]|g' Dependencies.txt
echo 211 / 1866 --- Result1141 to Stage1AfterLap9Split1
perl -i -pe 's|Result1142 \[\.\.\.\]|Result1142 [ Stage1AfterLap9Split2 ]|g' Dependencies.txt
echo 212 / 1866 --- Result1142 to Stage1AfterLap9Split2
perl -i -pe 's|Result1143 \[\.\.\.\]|Result1143 [ Stage1AfterLap9Split3 ]|g' Dependencies.txt
echo 213 / 1866 --- Result1143 to Stage1AfterLap9Split3
perl -i -pe 's|Result1144 \[\.\.\.\]|Result1144 [ Stage1AfterLap9Spotter ]|g' Dependencies.txt
echo 214 / 1866 --- Result1144 to Stage1AfterLap9Spotter
perl -i -pe 's|Result1145 \[\.\.\.\]|Result1145 [ Stage1AfterLap9Finish ]|g' Dependencies.txt
echo 215 / 1866 --- Result1145 to Stage1AfterLap9Finish
perl -i -pe 's|Result1146 \[\.\.\.\]|Result1146 [ Stage1AfterLap10Split1 ]|g' Dependencies.txt
echo 216 / 1866 --- Result1146 to Stage1AfterLap10Split1
perl -i -pe 's|Result1147 \[\.\.\.\]|Result1147 [ Stage1AfterLap10Split2 ]|g' Dependencies.txt
echo 217 / 1866 --- Result1147 to Stage1AfterLap10Split2
perl -i -pe 's|Result1148 \[\.\.\.\]|Result1148 [ Stage1AfterLap10Split3 ]|g' Dependencies.txt
echo 218 / 1866 --- Result1148 to Stage1AfterLap10Split3
perl -i -pe 's|Result1149 \[\.\.\.\]|Result1149 [ Stage1AfterLap10Spotter ]|g' Dependencies.txt
echo 219 / 1866 --- Result1149 to Stage1AfterLap10Spotter
perl -i -pe 's|Result1150 \[\.\.\.\]|Result1150 [ Stage1AfterLap10Finish ]|g' Dependencies.txt
echo 220 / 1866 --- Result1150 to Stage1AfterLap10Finish
perl -i -pe 's|Result1190 \[\.\.\.\]|Result1190 [ Stage1AfterFinish ]|g' Dependencies.txt
echo 221 / 1866 --- Result1190 to Stage1AfterFinish
perl -i -pe 's|Result1191 \[\.\.\.\]|Result1191 [ Stage1LastSplitID ]|g' Dependencies.txt
echo 222 / 1866 --- Result1191 to Stage1LastSplitID
perl -i -pe 's|Result1192 \[\.\.\.\]|Result1192 [ Stage1LastSplit ]|g' Dependencies.txt
echo 223 / 1866 --- Result1192 to Stage1LastSplit
perl -i -pe 's|Result1193 \[\.\.\.\]|Result1193 [ Stage1LastFinishID ]|g' Dependencies.txt
echo 224 / 1866 --- Result1193 to Stage1LastFinishID
perl -i -pe 's|Result1194 \[\.\.\.\]|Result1194 [ Stage1LastFinish ]|g' Dependencies.txt
echo 225 / 1866 --- Result1194 to Stage1LastFinish
perl -i -pe 's|Result1195 \[\.\.\.\]|Result1195 [ Stage1LastSplitBunchTime ]|g' Dependencies.txt
echo 226 / 1866 --- Result1195 to Stage1LastSplitBunchTime
perl -i -pe 's|Result1196 \[\.\.\.\]|Result1196 [ Stage1PhotoBunchTime ]|g' Dependencies.txt
echo 227 / 1866 --- Result1196 to Stage1PhotoBunchTime
perl -i -pe 's|Result1200 \[\.\.\.\]|Result1200 [ Stage1Start ]|g' Dependencies.txt
echo 228 / 1866 --- Result1200 to Stage1Start
perl -i -pe 's|Result1201 \[\.\.\.\]|Result1201 [ Stage1Lap1Split1 ]|g' Dependencies.txt
echo 229 / 1866 --- Result1201 to Stage1Lap1Split1
perl -i -pe 's|Result1202 \[\.\.\.\]|Result1202 [ Stage1Lap1Split2 ]|g' Dependencies.txt
echo 230 / 1866 --- Result1202 to Stage1Lap1Split2
perl -i -pe 's|Result1203 \[\.\.\.\]|Result1203 [ Stage1Lap1Split3 ]|g' Dependencies.txt
echo 231 / 1866 --- Result1203 to Stage1Lap1Split3
perl -i -pe 's|Result1204 \[\.\.\.\]|Result1204 [ Stage1Lap1Spotter ]|g' Dependencies.txt
echo 232 / 1866 --- Result1204 to Stage1Lap1Spotter
perl -i -pe 's|Result1205 \[\.\.\.\]|Result1205 [ Stage1Lap1Finish ]|g' Dependencies.txt
echo 233 / 1866 --- Result1205 to Stage1Lap1Finish
perl -i -pe 's|Result1206 \[\.\.\.\]|Result1206 [ Stage1Lap2Split1 ]|g' Dependencies.txt
echo 234 / 1866 --- Result1206 to Stage1Lap2Split1
perl -i -pe 's|Result1207 \[\.\.\.\]|Result1207 [ Stage1Lap2Split2 ]|g' Dependencies.txt
echo 235 / 1866 --- Result1207 to Stage1Lap2Split2
perl -i -pe 's|Result1208 \[\.\.\.\]|Result1208 [ Stage1Lap2Split3 ]|g' Dependencies.txt
echo 236 / 1866 --- Result1208 to Stage1Lap2Split3
perl -i -pe 's|Result1209 \[\.\.\.\]|Result1209 [ Stage1Lap2Spotter ]|g' Dependencies.txt
echo 237 / 1866 --- Result1209 to Stage1Lap2Spotter
perl -i -pe 's|Result1210 \[\.\.\.\]|Result1210 [ Stage1Lap2Finish ]|g' Dependencies.txt
echo 238 / 1866 --- Result1210 to Stage1Lap2Finish
perl -i -pe 's|Result1211 \[\.\.\.\]|Result1211 [ Stage1Lap3Split1 ]|g' Dependencies.txt
echo 239 / 1866 --- Result1211 to Stage1Lap3Split1
perl -i -pe 's|Result1212 \[\.\.\.\]|Result1212 [ Stage1Lap3Split2 ]|g' Dependencies.txt
echo 240 / 1866 --- Result1212 to Stage1Lap3Split2
perl -i -pe 's|Result1213 \[\.\.\.\]|Result1213 [ Stage1Lap3Split3 ]|g' Dependencies.txt
echo 241 / 1866 --- Result1213 to Stage1Lap3Split3
perl -i -pe 's|Result1214 \[\.\.\.\]|Result1214 [ Stage1Lap3Spotter ]|g' Dependencies.txt
echo 242 / 1866 --- Result1214 to Stage1Lap3Spotter
perl -i -pe 's|Result1215 \[\.\.\.\]|Result1215 [ Stage1Lap3Finish ]|g' Dependencies.txt
echo 243 / 1866 --- Result1215 to Stage1Lap3Finish
perl -i -pe 's|Result1216 \[\.\.\.\]|Result1216 [ Stage1Lap4Split1 ]|g' Dependencies.txt
echo 244 / 1866 --- Result1216 to Stage1Lap4Split1
perl -i -pe 's|Result1217 \[\.\.\.\]|Result1217 [ Stage1Lap4Split2 ]|g' Dependencies.txt
echo 245 / 1866 --- Result1217 to Stage1Lap4Split2
perl -i -pe 's|Result1218 \[\.\.\.\]|Result1218 [ Stage1Lap4Split3 ]|g' Dependencies.txt
echo 246 / 1866 --- Result1218 to Stage1Lap4Split3
perl -i -pe 's|Result1219 \[\.\.\.\]|Result1219 [ Stage1Lap4Spotter ]|g' Dependencies.txt
echo 247 / 1866 --- Result1219 to Stage1Lap4Spotter
perl -i -pe 's|Result1220 \[\.\.\.\]|Result1220 [ Stage1Lap4Finish ]|g' Dependencies.txt
echo 248 / 1866 --- Result1220 to Stage1Lap4Finish
perl -i -pe 's|Result1221 \[\.\.\.\]|Result1221 [ Stage1Lap5Split1 ]|g' Dependencies.txt
echo 249 / 1866 --- Result1221 to Stage1Lap5Split1
perl -i -pe 's|Result1222 \[\.\.\.\]|Result1222 [ Stage1Lap5Split2 ]|g' Dependencies.txt
echo 250 / 1866 --- Result1222 to Stage1Lap5Split2
perl -i -pe 's|Result1223 \[\.\.\.\]|Result1223 [ Stage1Lap5Split3 ]|g' Dependencies.txt
echo 251 / 1866 --- Result1223 to Stage1Lap5Split3
perl -i -pe 's|Result1224 \[\.\.\.\]|Result1224 [ Stage1Lap5Spotter ]|g' Dependencies.txt
echo 252 / 1866 --- Result1224 to Stage1Lap5Spotter
perl -i -pe 's|Result1225 \[\.\.\.\]|Result1225 [ Stage1Lap5Finish ]|g' Dependencies.txt
echo 253 / 1866 --- Result1225 to Stage1Lap5Finish
perl -i -pe 's|Result1226 \[\.\.\.\]|Result1226 [ Stage1Lap6Split1 ]|g' Dependencies.txt
echo 254 / 1866 --- Result1226 to Stage1Lap6Split1
perl -i -pe 's|Result1227 \[\.\.\.\]|Result1227 [ Stage1Lap6Split2 ]|g' Dependencies.txt
echo 255 / 1866 --- Result1227 to Stage1Lap6Split2
perl -i -pe 's|Result1228 \[\.\.\.\]|Result1228 [ Stage1Lap6Split3 ]|g' Dependencies.txt
echo 256 / 1866 --- Result1228 to Stage1Lap6Split3
perl -i -pe 's|Result1229 \[\.\.\.\]|Result1229 [ Stage1Lap6Spotter ]|g' Dependencies.txt
echo 257 / 1866 --- Result1229 to Stage1Lap6Spotter
perl -i -pe 's|Result1230 \[\.\.\.\]|Result1230 [ Stage1Lap6Finish ]|g' Dependencies.txt
echo 258 / 1866 --- Result1230 to Stage1Lap6Finish
perl -i -pe 's|Result1231 \[\.\.\.\]|Result1231 [ Stage1Lap7Split1 ]|g' Dependencies.txt
echo 259 / 1866 --- Result1231 to Stage1Lap7Split1
perl -i -pe 's|Result1232 \[\.\.\.\]|Result1232 [ Stage1Lap7Split2 ]|g' Dependencies.txt
echo 260 / 1866 --- Result1232 to Stage1Lap7Split2
perl -i -pe 's|Result1233 \[\.\.\.\]|Result1233 [ Stage1Lap7Split3 ]|g' Dependencies.txt
echo 261 / 1866 --- Result1233 to Stage1Lap7Split3
perl -i -pe 's|Result1234 \[\.\.\.\]|Result1234 [ Stage1Lap7Spotter ]|g' Dependencies.txt
echo 262 / 1866 --- Result1234 to Stage1Lap7Spotter
perl -i -pe 's|Result1235 \[\.\.\.\]|Result1235 [ Stage1Lap7Finish ]|g' Dependencies.txt
echo 263 / 1866 --- Result1235 to Stage1Lap7Finish
perl -i -pe 's|Result1236 \[\.\.\.\]|Result1236 [ Stage1Lap8Split1 ]|g' Dependencies.txt
echo 264 / 1866 --- Result1236 to Stage1Lap8Split1
perl -i -pe 's|Result1237 \[\.\.\.\]|Result1237 [ Stage1Lap8Split2 ]|g' Dependencies.txt
echo 265 / 1866 --- Result1237 to Stage1Lap8Split2
perl -i -pe 's|Result1238 \[\.\.\.\]|Result1238 [ Stage1Lap8Split3 ]|g' Dependencies.txt
echo 266 / 1866 --- Result1238 to Stage1Lap8Split3
perl -i -pe 's|Result1239 \[\.\.\.\]|Result1239 [ Stage1Lap8Spotter ]|g' Dependencies.txt
echo 267 / 1866 --- Result1239 to Stage1Lap8Spotter
perl -i -pe 's|Result1240 \[\.\.\.\]|Result1240 [ Stage1Lap8Finish ]|g' Dependencies.txt
echo 268 / 1866 --- Result1240 to Stage1Lap8Finish
perl -i -pe 's|Result1241 \[\.\.\.\]|Result1241 [ Stage1Lap9Split1 ]|g' Dependencies.txt
echo 269 / 1866 --- Result1241 to Stage1Lap9Split1
perl -i -pe 's|Result1242 \[\.\.\.\]|Result1242 [ Stage1Lap9Split2 ]|g' Dependencies.txt
echo 270 / 1866 --- Result1242 to Stage1Lap9Split2
perl -i -pe 's|Result1243 \[\.\.\.\]|Result1243 [ Stage1Lap9Split3 ]|g' Dependencies.txt
echo 271 / 1866 --- Result1243 to Stage1Lap9Split3
perl -i -pe 's|Result1244 \[\.\.\.\]|Result1244 [ Stage1Lap9Spotter ]|g' Dependencies.txt
echo 272 / 1866 --- Result1244 to Stage1Lap9Spotter
perl -i -pe 's|Result1245 \[\.\.\.\]|Result1245 [ Stage1Lap9Finish ]|g' Dependencies.txt
echo 273 / 1866 --- Result1245 to Stage1Lap9Finish
perl -i -pe 's|Result1246 \[\.\.\.\]|Result1246 [ Stage1Lap10Split1 ]|g' Dependencies.txt
echo 274 / 1866 --- Result1246 to Stage1Lap10Split1
perl -i -pe 's|Result1247 \[\.\.\.\]|Result1247 [ Stage1Lap10Split2 ]|g' Dependencies.txt
echo 275 / 1866 --- Result1247 to Stage1Lap10Split2
perl -i -pe 's|Result1248 \[\.\.\.\]|Result1248 [ Stage1Lap10Split3 ]|g' Dependencies.txt
echo 276 / 1866 --- Result1248 to Stage1Lap10Split3
perl -i -pe 's|Result1249 \[\.\.\.\]|Result1249 [ Stage1Lap10Spotter ]|g' Dependencies.txt
echo 277 / 1866 --- Result1249 to Stage1Lap10Spotter
perl -i -pe 's|Result1250 \[\.\.\.\]|Result1250 [ Stage1Lap10Finish ]|g' Dependencies.txt
echo 278 / 1866 --- Result1250 to Stage1Lap10Finish
perl -i -pe 's|Result1301 \[\.\.\.\]|Result1301 [ Stage1Lap1 ]|g' Dependencies.txt
echo 279 / 1866 --- Result1301 to Stage1Lap1
perl -i -pe 's|Result1302 \[\.\.\.\]|Result1302 [ Stage1Lap2 ]|g' Dependencies.txt
echo 280 / 1866 --- Result1302 to Stage1Lap2
perl -i -pe 's|Result1303 \[\.\.\.\]|Result1303 [ Stage1Lap3 ]|g' Dependencies.txt
echo 281 / 1866 --- Result1303 to Stage1Lap3
perl -i -pe 's|Result1304 \[\.\.\.\]|Result1304 [ Stage1Lap4 ]|g' Dependencies.txt
echo 282 / 1866 --- Result1304 to Stage1Lap4
perl -i -pe 's|Result1305 \[\.\.\.\]|Result1305 [ Stage1Lap5 ]|g' Dependencies.txt
echo 283 / 1866 --- Result1305 to Stage1Lap5
perl -i -pe 's|Result1306 \[\.\.\.\]|Result1306 [ Stage1Lap6 ]|g' Dependencies.txt
echo 284 / 1866 --- Result1306 to Stage1Lap6
perl -i -pe 's|Result1307 \[\.\.\.\]|Result1307 [ Stage1Lap7 ]|g' Dependencies.txt
echo 285 / 1866 --- Result1307 to Stage1Lap7
perl -i -pe 's|Result1308 \[\.\.\.\]|Result1308 [ Stage1Lap8 ]|g' Dependencies.txt
echo 286 / 1866 --- Result1308 to Stage1Lap8
perl -i -pe 's|Result1309 \[\.\.\.\]|Result1309 [ Stage1Lap9 ]|g' Dependencies.txt
echo 287 / 1866 --- Result1309 to Stage1Lap9
perl -i -pe 's|Result1310 \[\.\.\.\]|Result1310 [ Stage1Lap10 ]|g' Dependencies.txt
echo 288 / 1866 --- Result1310 to Stage1Lap10
perl -i -pe 's|Result1320 \[\.\.\.\]|Result1320 [ Stage1LapCount ]|g' Dependencies.txt
echo 289 / 1866 --- Result1320 to Stage1LapCount
perl -i -pe 's|Result1321 \[\.\.\.\]|Result1321 [ Stage1FastestLap ]|g' Dependencies.txt
echo 290 / 1866 --- Result1321 to Stage1FastestLap
perl -i -pe 's|Result1322 \[\.\.\.\]|Result1322 [ Stage1SlowestLap ]|g' Dependencies.txt
echo 291 / 1866 --- Result1322 to Stage1SlowestLap
perl -i -pe 's|Result1323 \[\.\.\.\]|Result1323 [ Stage1AverageLap ]|g' Dependencies.txt
echo 292 / 1866 --- Result1323 to Stage1AverageLap
perl -i -pe 's|Result1324 \[\.\.\.\]|Result1324 [ Stage1LastLap ]|g' Dependencies.txt
echo 293 / 1866 --- Result1324 to Stage1LastLap
perl -i -pe 's|Result1401 \[\.\.\.\]|Result1401 [ Stage1ParcoursStation1Points ]|g' Dependencies.txt
echo 294 / 1866 --- Result1401 to Stage1ParcoursStation1Points
perl -i -pe 's|Result1402 \[\.\.\.\]|Result1402 [ Stage1ParcoursStation2Points ]|g' Dependencies.txt
echo 295 / 1866 --- Result1402 to Stage1ParcoursStation2Points
perl -i -pe 's|Result1403 \[\.\.\.\]|Result1403 [ Stage1ParcoursStation3Points ]|g' Dependencies.txt
echo 296 / 1866 --- Result1403 to Stage1ParcoursStation3Points
perl -i -pe 's|Result1404 \[\.\.\.\]|Result1404 [ Stage1ParcoursStation4Points ]|g' Dependencies.txt
echo 297 / 1866 --- Result1404 to Stage1ParcoursStation4Points
perl -i -pe 's|Result1405 \[\.\.\.\]|Result1405 [ Stage1ParcoursStation5Points ]|g' Dependencies.txt
echo 298 / 1866 --- Result1405 to Stage1ParcoursStation5Points
perl -i -pe 's|Result1406 \[\.\.\.\]|Result1406 [ Stage1ParcoursStation6Points ]|g' Dependencies.txt
echo 299 / 1866 --- Result1406 to Stage1ParcoursStation6Points
perl -i -pe 's|Result1407 \[\.\.\.\]|Result1407 [ Stage1ParcoursStation7Points ]|g' Dependencies.txt
echo 300 / 1866 --- Result1407 to Stage1ParcoursStation7Points
perl -i -pe 's|Result1408 \[\.\.\.\]|Result1408 [ Stage1ParcoursStation8Points ]|g' Dependencies.txt
echo 301 / 1866 --- Result1408 to Stage1ParcoursStation8Points
perl -i -pe 's|Result1409 \[\.\.\.\]|Result1409 [ Stage1ParcoursStation9Points ]|g' Dependencies.txt
echo 302 / 1866 --- Result1409 to Stage1ParcoursStation9Points
perl -i -pe 's|Result1410 \[\.\.\.\]|Result1410 [ Stage1ParcoursStation10Points ]|g' Dependencies.txt
echo 303 / 1866 --- Result1410 to Stage1ParcoursStation10Points
perl -i -pe 's|Result1411 \[\.\.\.\]|Result1411 [ Stage1ParcoursStation11Points ]|g' Dependencies.txt
echo 304 / 1866 --- Result1411 to Stage1ParcoursStation11Points
perl -i -pe 's|Result1412 \[\.\.\.\]|Result1412 [ Stage1ParcoursStation12Points ]|g' Dependencies.txt
echo 305 / 1866 --- Result1412 to Stage1ParcoursStation12Points
perl -i -pe 's|Result1413 \[\.\.\.\]|Result1413 [ Stage1ParcoursStation13Points ]|g' Dependencies.txt
echo 306 / 1866 --- Result1413 to Stage1ParcoursStation13Points
perl -i -pe 's|Result1414 \[\.\.\.\]|Result1414 [ Stage1ParcoursStation14Points ]|g' Dependencies.txt
echo 307 / 1866 --- Result1414 to Stage1ParcoursStation14Points
perl -i -pe 's|Result1415 \[\.\.\.\]|Result1415 [ Stage1ParcoursStation15Points ]|g' Dependencies.txt
echo 308 / 1866 --- Result1415 to Stage1ParcoursStation15Points
perl -i -pe 's|Result1430 \[\.\.\.\]|Result1430 [ Stage1ParcoursTotalPoints ]|g' Dependencies.txt
echo 309 / 1866 --- Result1430 to Stage1ParcoursTotalPoints
perl -i -pe 's|Result1441 \[\.\.\.\]|Result1441 [ Stage1ParcoursStart ]|g' Dependencies.txt
echo 310 / 1866 --- Result1441 to Stage1ParcoursStart
perl -i -pe 's|Result1442 \[\.\.\.\]|Result1442 [ Stage1ParcoursFinish ]|g' Dependencies.txt
echo 311 / 1866 --- Result1442 to Stage1ParcoursFinish
perl -i -pe 's|Result1443 \[\.\.\.\]|Result1443 [ Stage1ParcoursSpotter ]|g' Dependencies.txt
echo 312 / 1866 --- Result1443 to Stage1ParcoursSpotter
perl -i -pe 's|Result1450 \[\.\.\.\]|Result1450 [ Stage1ParcoursTime ]|g' Dependencies.txt
echo 313 / 1866 --- Result1450 to Stage1ParcoursTime
perl -i -pe 's|Result1501 \[\.\.\.\]|Result1501 [ Stage1ParcoursRankingPoints ]|g' Dependencies.txt
echo 314 / 1866 --- Result1501 to Stage1ParcoursRankingPoints
perl -i -pe 's|Result1502 \[\.\.\.\]|Result1502 [ Stage1CrossCountryRankingPoints ]|g' Dependencies.txt
echo 315 / 1866 --- Result1502 to Stage1CrossCountryRankingPoints
perl -i -pe 's|Result1503 \[\.\.\.\]|Result1503 [ Stage1TotalRankingPoints ]|g' Dependencies.txt
echo 316 / 1866 --- Result1503 to Stage1TotalRankingPoints
perl -i -pe 's|Result1611 \[\.\.\.\]|Result1611 [ Stage1Lap1Sector1 ]|g' Dependencies.txt
echo 317 / 1866 --- Result1611 to Stage1Lap1Sector1
perl -i -pe 's|Result1612 \[\.\.\.\]|Result1612 [ Stage1Lap2Sector1 ]|g' Dependencies.txt
echo 318 / 1866 --- Result1612 to Stage1Lap2Sector1
perl -i -pe 's|Result1613 \[\.\.\.\]|Result1613 [ Stage1Lap3Sector1 ]|g' Dependencies.txt
echo 319 / 1866 --- Result1613 to Stage1Lap3Sector1
perl -i -pe 's|Result1614 \[\.\.\.\]|Result1614 [ Stage1Lap4Sector1 ]|g' Dependencies.txt
echo 320 / 1866 --- Result1614 to Stage1Lap4Sector1
perl -i -pe 's|Result1615 \[\.\.\.\]|Result1615 [ Stage1Lap5Sector1 ]|g' Dependencies.txt
echo 321 / 1866 --- Result1615 to Stage1Lap5Sector1
perl -i -pe 's|Result1616 \[\.\.\.\]|Result1616 [ Stage1Lap6Sector1 ]|g' Dependencies.txt
echo 322 / 1866 --- Result1616 to Stage1Lap6Sector1
perl -i -pe 's|Result1617 \[\.\.\.\]|Result1617 [ Stage1Lap7Sector1 ]|g' Dependencies.txt
echo 323 / 1866 --- Result1617 to Stage1Lap7Sector1
perl -i -pe 's|Result1618 \[\.\.\.\]|Result1618 [ Stage1Lap8Sector1 ]|g' Dependencies.txt
echo 324 / 1866 --- Result1618 to Stage1Lap8Sector1
perl -i -pe 's|Result1619 \[\.\.\.\]|Result1619 [ Stage1Lap9Sector1 ]|g' Dependencies.txt
echo 325 / 1866 --- Result1619 to Stage1Lap9Sector1
perl -i -pe 's|Result1620 \[\.\.\.\]|Result1620 [ Stage1Lap10Sector1 ]|g' Dependencies.txt
echo 326 / 1866 --- Result1620 to Stage1Lap10Sector1
perl -i -pe 's|Result1621 \[\.\.\.\]|Result1621 [ Stage1Lap1Sector2 ]|g' Dependencies.txt
echo 327 / 1866 --- Result1621 to Stage1Lap1Sector2
perl -i -pe 's|Result1622 \[\.\.\.\]|Result1622 [ Stage1Lap2Sector2 ]|g' Dependencies.txt
echo 328 / 1866 --- Result1622 to Stage1Lap2Sector2
perl -i -pe 's|Result1623 \[\.\.\.\]|Result1623 [ Stage1Lap3Sector2 ]|g' Dependencies.txt
echo 329 / 1866 --- Result1623 to Stage1Lap3Sector2
perl -i -pe 's|Result1624 \[\.\.\.\]|Result1624 [ Stage1Lap4Sector2 ]|g' Dependencies.txt
echo 330 / 1866 --- Result1624 to Stage1Lap4Sector2
perl -i -pe 's|Result1625 \[\.\.\.\]|Result1625 [ Stage1Lap5Sector2 ]|g' Dependencies.txt
echo 331 / 1866 --- Result1625 to Stage1Lap5Sector2
perl -i -pe 's|Result1626 \[\.\.\.\]|Result1626 [ Stage1Lap6Sector2 ]|g' Dependencies.txt
echo 332 / 1866 --- Result1626 to Stage1Lap6Sector2
perl -i -pe 's|Result1627 \[\.\.\.\]|Result1627 [ Stage1Lap7Sector2 ]|g' Dependencies.txt
echo 333 / 1866 --- Result1627 to Stage1Lap7Sector2
perl -i -pe 's|Result1628 \[\.\.\.\]|Result1628 [ Stage1Lap8Sector2 ]|g' Dependencies.txt
echo 334 / 1866 --- Result1628 to Stage1Lap8Sector2
perl -i -pe 's|Result1629 \[\.\.\.\]|Result1629 [ Stage1Lap9Sector2 ]|g' Dependencies.txt
echo 335 / 1866 --- Result1629 to Stage1Lap9Sector2
perl -i -pe 's|Result1630 \[\.\.\.\]|Result1630 [ Stage1Lap10Sector2 ]|g' Dependencies.txt
echo 336 / 1866 --- Result1630 to Stage1Lap10Sector2
perl -i -pe 's|Result1631 \[\.\.\.\]|Result1631 [ Stage1Lap1Sector3 ]|g' Dependencies.txt
echo 337 / 1866 --- Result1631 to Stage1Lap1Sector3
perl -i -pe 's|Result1632 \[\.\.\.\]|Result1632 [ Stage1Lap2Sector3 ]|g' Dependencies.txt
echo 338 / 1866 --- Result1632 to Stage1Lap2Sector3
perl -i -pe 's|Result1633 \[\.\.\.\]|Result1633 [ Stage1Lap3Sector3 ]|g' Dependencies.txt
echo 339 / 1866 --- Result1633 to Stage1Lap3Sector3
perl -i -pe 's|Result1634 \[\.\.\.\]|Result1634 [ Stage1Lap4Sector3 ]|g' Dependencies.txt
echo 340 / 1866 --- Result1634 to Stage1Lap4Sector3
perl -i -pe 's|Result1635 \[\.\.\.\]|Result1635 [ Stage1Lap5Sector3 ]|g' Dependencies.txt
echo 341 / 1866 --- Result1635 to Stage1Lap5Sector3
perl -i -pe 's|Result1636 \[\.\.\.\]|Result1636 [ Stage1Lap6Sector3 ]|g' Dependencies.txt
echo 342 / 1866 --- Result1636 to Stage1Lap6Sector3
perl -i -pe 's|Result1637 \[\.\.\.\]|Result1637 [ Stage1Lap7Sector3 ]|g' Dependencies.txt
echo 343 / 1866 --- Result1637 to Stage1Lap7Sector3
perl -i -pe 's|Result1638 \[\.\.\.\]|Result1638 [ Stage1Lap8Sector3 ]|g' Dependencies.txt
echo 344 / 1866 --- Result1638 to Stage1Lap8Sector3
perl -i -pe 's|Result1639 \[\.\.\.\]|Result1639 [ Stage1Lap9Sector3 ]|g' Dependencies.txt
echo 345 / 1866 --- Result1639 to Stage1Lap9Sector3
perl -i -pe 's|Result1640 \[\.\.\.\]|Result1640 [ Stage1Lap10Sector3 ]|g' Dependencies.txt
echo 346 / 1866 --- Result1640 to Stage1Lap10Sector3
perl -i -pe 's|Result1641 \[\.\.\.\]|Result1641 [ Stage1Lap1Sector4 ]|g' Dependencies.txt
echo 347 / 1866 --- Result1641 to Stage1Lap1Sector4
perl -i -pe 's|Result1642 \[\.\.\.\]|Result1642 [ Stage1Lap2Sector4 ]|g' Dependencies.txt
echo 348 / 1866 --- Result1642 to Stage1Lap2Sector4
perl -i -pe 's|Result1643 \[\.\.\.\]|Result1643 [ Stage1Lap3Sector4 ]|g' Dependencies.txt
echo 349 / 1866 --- Result1643 to Stage1Lap3Sector4
perl -i -pe 's|Result1644 \[\.\.\.\]|Result1644 [ Stage1Lap4Sector4 ]|g' Dependencies.txt
echo 350 / 1866 --- Result1644 to Stage1Lap4Sector4
perl -i -pe 's|Result1645 \[\.\.\.\]|Result1645 [ Stage1Lap5Sector4 ]|g' Dependencies.txt
echo 351 / 1866 --- Result1645 to Stage1Lap5Sector4
perl -i -pe 's|Result1646 \[\.\.\.\]|Result1646 [ Stage1Lap6Sector4 ]|g' Dependencies.txt
echo 352 / 1866 --- Result1646 to Stage1Lap6Sector4
perl -i -pe 's|Result1647 \[\.\.\.\]|Result1647 [ Stage1Lap7Sector4 ]|g' Dependencies.txt
echo 353 / 1866 --- Result1647 to Stage1Lap7Sector4
perl -i -pe 's|Result1648 \[\.\.\.\]|Result1648 [ Stage1Lap8Sector4 ]|g' Dependencies.txt
echo 354 / 1866 --- Result1648 to Stage1Lap8Sector4
perl -i -pe 's|Result1649 \[\.\.\.\]|Result1649 [ Stage1Lap9Sector4 ]|g' Dependencies.txt
echo 355 / 1866 --- Result1649 to Stage1Lap9Sector4
perl -i -pe 's|Result1650 \[\.\.\.\]|Result1650 [ Stage1Lap10Sector4 ]|g' Dependencies.txt
echo 356 / 1866 --- Result1650 to Stage1Lap10Sector4
perl -i -pe 's|Result1651 \[\.\.\.\]|Result1651 [ Stage1Lap1UphillSector ]|g' Dependencies.txt
echo 357 / 1866 --- Result1651 to Stage1Lap1UphillSector
perl -i -pe 's|Result1652 \[\.\.\.\]|Result1652 [ Stage1Lap2UphillSector ]|g' Dependencies.txt
echo 358 / 1866 --- Result1652 to Stage1Lap2UphillSector
perl -i -pe 's|Result1653 \[\.\.\.\]|Result1653 [ Stage1Lap3UphillSector ]|g' Dependencies.txt
echo 359 / 1866 --- Result1653 to Stage1Lap3UphillSector
perl -i -pe 's|Result1654 \[\.\.\.\]|Result1654 [ Stage1Lap4UphillSector ]|g' Dependencies.txt
echo 360 / 1866 --- Result1654 to Stage1Lap4UphillSector
perl -i -pe 's|Result1655 \[\.\.\.\]|Result1655 [ Stage1Lap5UphillSector ]|g' Dependencies.txt
echo 361 / 1866 --- Result1655 to Stage1Lap5UphillSector
perl -i -pe 's|Result1656 \[\.\.\.\]|Result1656 [ Stage1Lap6UphillSector ]|g' Dependencies.txt
echo 362 / 1866 --- Result1656 to Stage1Lap6UphillSector
perl -i -pe 's|Result1657 \[\.\.\.\]|Result1657 [ Stage1Lap7UphillSector ]|g' Dependencies.txt
echo 363 / 1866 --- Result1657 to Stage1Lap7UphillSector
perl -i -pe 's|Result1658 \[\.\.\.\]|Result1658 [ Stage1Lap8UphillSector ]|g' Dependencies.txt
echo 364 / 1866 --- Result1658 to Stage1Lap8UphillSector
perl -i -pe 's|Result1659 \[\.\.\.\]|Result1659 [ Stage1Lap9UphillSector ]|g' Dependencies.txt
echo 365 / 1866 --- Result1659 to Stage1Lap9UphillSector
perl -i -pe 's|Result1660 \[\.\.\.\]|Result1660 [ Stage1Lap10UphillSector ]|g' Dependencies.txt
echo 366 / 1866 --- Result1660 to Stage1Lap10UphillSector
perl -i -pe 's|Result1680 \[\.\.\.\]|Result1680 [ Stage1FastestUphillSector ]|g' Dependencies.txt
echo 367 / 1866 --- Result1680 to Stage1FastestUphillSector
perl -i -pe 's|Result1681 \[\.\.\.\]|Result1681 [ Stage1FastestUphillSectorID ]|g' Dependencies.txt
echo 368 / 1866 --- Result1681 to Stage1FastestUphillSectorID
perl -i -pe 's|Result2000 \[\.\.\.\]|Result2000 [ Stage2StartTime ]|g' Dependencies.txt
echo 369 / 1866 --- Result2000 to Stage2StartTime
perl -i -pe 's|Result2001 \[\.\.\.\]|Result2001 [ Stage2FinishTimeLimit ]|g' Dependencies.txt
echo 370 / 1866 --- Result2001 to Stage2FinishTimeLimit
perl -i -pe 's|Result2100 \[\.\.\.\]|Result2100 [ Stage2Started ]|g' Dependencies.txt
echo 371 / 1866 --- Result2100 to Stage2Started
perl -i -pe 's|Result2101 \[\.\.\.\]|Result2101 [ Stage2AfterLap1Split1 ]|g' Dependencies.txt
echo 372 / 1866 --- Result2101 to Stage2AfterLap1Split1
perl -i -pe 's|Result2102 \[\.\.\.\]|Result2102 [ Stage2AfterLap1Split2 ]|g' Dependencies.txt
echo 373 / 1866 --- Result2102 to Stage2AfterLap1Split2
perl -i -pe 's|Result2103 \[\.\.\.\]|Result2103 [ Stage2AfterLap1Split3 ]|g' Dependencies.txt
echo 374 / 1866 --- Result2103 to Stage2AfterLap1Split3
perl -i -pe 's|Result2104 \[\.\.\.\]|Result2104 [ Stage2AfterLap1Spotter ]|g' Dependencies.txt
echo 375 / 1866 --- Result2104 to Stage2AfterLap1Spotter
perl -i -pe 's|Result2105 \[\.\.\.\]|Result2105 [ Stage2AfterLap1Finish ]|g' Dependencies.txt
echo 376 / 1866 --- Result2105 to Stage2AfterLap1Finish
perl -i -pe 's|Result2106 \[\.\.\.\]|Result2106 [ Stage2AfterLap2Split1 ]|g' Dependencies.txt
echo 377 / 1866 --- Result2106 to Stage2AfterLap2Split1
perl -i -pe 's|Result2107 \[\.\.\.\]|Result2107 [ Stage2AfterLap2Split2 ]|g' Dependencies.txt
echo 378 / 1866 --- Result2107 to Stage2AfterLap2Split2
perl -i -pe 's|Result2108 \[\.\.\.\]|Result2108 [ Stage2AfterLap2Split3 ]|g' Dependencies.txt
echo 379 / 1866 --- Result2108 to Stage2AfterLap2Split3
perl -i -pe 's|Result2109 \[\.\.\.\]|Result2109 [ Stage2AfterLap2Spotter ]|g' Dependencies.txt
echo 380 / 1866 --- Result2109 to Stage2AfterLap2Spotter
perl -i -pe 's|Result2110 \[\.\.\.\]|Result2110 [ Stage2AfterLap2Finish ]|g' Dependencies.txt
echo 381 / 1866 --- Result2110 to Stage2AfterLap2Finish
perl -i -pe 's|Result2111 \[\.\.\.\]|Result2111 [ Stage2AfterLap3Split1 ]|g' Dependencies.txt
echo 382 / 1866 --- Result2111 to Stage2AfterLap3Split1
perl -i -pe 's|Result2112 \[\.\.\.\]|Result2112 [ Stage2AfterLap3Split2 ]|g' Dependencies.txt
echo 383 / 1866 --- Result2112 to Stage2AfterLap3Split2
perl -i -pe 's|Result2113 \[\.\.\.\]|Result2113 [ Stage2AfterLap3Split3 ]|g' Dependencies.txt
echo 384 / 1866 --- Result2113 to Stage2AfterLap3Split3
perl -i -pe 's|Result2114 \[\.\.\.\]|Result2114 [ Stage2AfterLap3Spotter ]|g' Dependencies.txt
echo 385 / 1866 --- Result2114 to Stage2AfterLap3Spotter
perl -i -pe 's|Result2115 \[\.\.\.\]|Result2115 [ Stage2AfterLap3Finish ]|g' Dependencies.txt
echo 386 / 1866 --- Result2115 to Stage2AfterLap3Finish
perl -i -pe 's|Result2116 \[\.\.\.\]|Result2116 [ Stage2AfterLap4Split1 ]|g' Dependencies.txt
echo 387 / 1866 --- Result2116 to Stage2AfterLap4Split1
perl -i -pe 's|Result2117 \[\.\.\.\]|Result2117 [ Stage2AfterLap4Split2 ]|g' Dependencies.txt
echo 388 / 1866 --- Result2117 to Stage2AfterLap4Split2
perl -i -pe 's|Result2118 \[\.\.\.\]|Result2118 [ Stage2AfterLap4Split3 ]|g' Dependencies.txt
echo 389 / 1866 --- Result2118 to Stage2AfterLap4Split3
perl -i -pe 's|Result2119 \[\.\.\.\]|Result2119 [ Stage2AfterLap4Spotter ]|g' Dependencies.txt
echo 390 / 1866 --- Result2119 to Stage2AfterLap4Spotter
perl -i -pe 's|Result2120 \[\.\.\.\]|Result2120 [ Stage2AfterLap4Finish ]|g' Dependencies.txt
echo 391 / 1866 --- Result2120 to Stage2AfterLap4Finish
perl -i -pe 's|Result2121 \[\.\.\.\]|Result2121 [ Stage2AfterLap5Split1 ]|g' Dependencies.txt
echo 392 / 1866 --- Result2121 to Stage2AfterLap5Split1
perl -i -pe 's|Result2122 \[\.\.\.\]|Result2122 [ Stage2AfterLap5Split2 ]|g' Dependencies.txt
echo 393 / 1866 --- Result2122 to Stage2AfterLap5Split2
perl -i -pe 's|Result2123 \[\.\.\.\]|Result2123 [ Stage2AfterLap5Split3 ]|g' Dependencies.txt
echo 394 / 1866 --- Result2123 to Stage2AfterLap5Split3
perl -i -pe 's|Result2124 \[\.\.\.\]|Result2124 [ Stage2AfterLap5Spotter ]|g' Dependencies.txt
echo 395 / 1866 --- Result2124 to Stage2AfterLap5Spotter
perl -i -pe 's|Result2125 \[\.\.\.\]|Result2125 [ Stage2AfterLap5Finish ]|g' Dependencies.txt
echo 396 / 1866 --- Result2125 to Stage2AfterLap5Finish
perl -i -pe 's|Result2126 \[\.\.\.\]|Result2126 [ Stage2AfterLap6Split1 ]|g' Dependencies.txt
echo 397 / 1866 --- Result2126 to Stage2AfterLap6Split1
perl -i -pe 's|Result2127 \[\.\.\.\]|Result2127 [ Stage2AfterLap6Split2 ]|g' Dependencies.txt
echo 398 / 1866 --- Result2127 to Stage2AfterLap6Split2
perl -i -pe 's|Result2128 \[\.\.\.\]|Result2128 [ Stage2AfterLap6Split3 ]|g' Dependencies.txt
echo 399 / 1866 --- Result2128 to Stage2AfterLap6Split3
perl -i -pe 's|Result2129 \[\.\.\.\]|Result2129 [ Stage2AfterLap6Spotter ]|g' Dependencies.txt
echo 400 / 1866 --- Result2129 to Stage2AfterLap6Spotter
perl -i -pe 's|Result2130 \[\.\.\.\]|Result2130 [ Stage2AfterLap6Finish ]|g' Dependencies.txt
echo 401 / 1866 --- Result2130 to Stage2AfterLap6Finish
perl -i -pe 's|Result2131 \[\.\.\.\]|Result2131 [ Stage2AfterLap7Split1 ]|g' Dependencies.txt
echo 402 / 1866 --- Result2131 to Stage2AfterLap7Split1
perl -i -pe 's|Result2132 \[\.\.\.\]|Result2132 [ Stage2AfterLap7Split2 ]|g' Dependencies.txt
echo 403 / 1866 --- Result2132 to Stage2AfterLap7Split2
perl -i -pe 's|Result2133 \[\.\.\.\]|Result2133 [ Stage2AfterLap7Split3 ]|g' Dependencies.txt
echo 404 / 1866 --- Result2133 to Stage2AfterLap7Split3
perl -i -pe 's|Result2134 \[\.\.\.\]|Result2134 [ Stage2AfterLap7Spotter ]|g' Dependencies.txt
echo 405 / 1866 --- Result2134 to Stage2AfterLap7Spotter
perl -i -pe 's|Result2135 \[\.\.\.\]|Result2135 [ Stage2AfterLap7Finish ]|g' Dependencies.txt
echo 406 / 1866 --- Result2135 to Stage2AfterLap7Finish
perl -i -pe 's|Result2136 \[\.\.\.\]|Result2136 [ Stage2AfterLap8Split1 ]|g' Dependencies.txt
echo 407 / 1866 --- Result2136 to Stage2AfterLap8Split1
perl -i -pe 's|Result2137 \[\.\.\.\]|Result2137 [ Stage2AfterLap8Split2 ]|g' Dependencies.txt
echo 408 / 1866 --- Result2137 to Stage2AfterLap8Split2
perl -i -pe 's|Result2138 \[\.\.\.\]|Result2138 [ Stage2AfterLap8Split3 ]|g' Dependencies.txt
echo 409 / 1866 --- Result2138 to Stage2AfterLap8Split3
perl -i -pe 's|Result2139 \[\.\.\.\]|Result2139 [ Stage2AfterLap8Spotter ]|g' Dependencies.txt
echo 410 / 1866 --- Result2139 to Stage2AfterLap8Spotter
perl -i -pe 's|Result2140 \[\.\.\.\]|Result2140 [ Stage2AfterLap8Finish ]|g' Dependencies.txt
echo 411 / 1866 --- Result2140 to Stage2AfterLap8Finish
perl -i -pe 's|Result2141 \[\.\.\.\]|Result2141 [ Stage2AfterLap9Split1 ]|g' Dependencies.txt
echo 412 / 1866 --- Result2141 to Stage2AfterLap9Split1
perl -i -pe 's|Result2142 \[\.\.\.\]|Result2142 [ Stage2AfterLap9Split2 ]|g' Dependencies.txt
echo 413 / 1866 --- Result2142 to Stage2AfterLap9Split2
perl -i -pe 's|Result2143 \[\.\.\.\]|Result2143 [ Stage2AfterLap9Split3 ]|g' Dependencies.txt
echo 414 / 1866 --- Result2143 to Stage2AfterLap9Split3
perl -i -pe 's|Result2144 \[\.\.\.\]|Result2144 [ Stage2AfterLap9Spotter ]|g' Dependencies.txt
echo 415 / 1866 --- Result2144 to Stage2AfterLap9Spotter
perl -i -pe 's|Result2145 \[\.\.\.\]|Result2145 [ Stage2AfterLap9Finish ]|g' Dependencies.txt
echo 416 / 1866 --- Result2145 to Stage2AfterLap9Finish
perl -i -pe 's|Result2146 \[\.\.\.\]|Result2146 [ Stage2AfterLap10Split1 ]|g' Dependencies.txt
echo 417 / 1866 --- Result2146 to Stage2AfterLap10Split1
perl -i -pe 's|Result2147 \[\.\.\.\]|Result2147 [ Stage2AfterLap10Split2 ]|g' Dependencies.txt
echo 418 / 1866 --- Result2147 to Stage2AfterLap10Split2
perl -i -pe 's|Result2148 \[\.\.\.\]|Result2148 [ Stage2AfterLap10Split3 ]|g' Dependencies.txt
echo 419 / 1866 --- Result2148 to Stage2AfterLap10Split3
perl -i -pe 's|Result2149 \[\.\.\.\]|Result2149 [ Stage2AfterLap10Spotter ]|g' Dependencies.txt
echo 420 / 1866 --- Result2149 to Stage2AfterLap10Spotter
perl -i -pe 's|Result2150 \[\.\.\.\]|Result2150 [ Stage2AfterLap10Finish ]|g' Dependencies.txt
echo 421 / 1866 --- Result2150 to Stage2AfterLap10Finish
perl -i -pe 's|Result2190 \[\.\.\.\]|Result2190 [ Stage2AfterFinish ]|g' Dependencies.txt
echo 422 / 1866 --- Result2190 to Stage2AfterFinish
perl -i -pe 's|Result2191 \[\.\.\.\]|Result2191 [ Stage2LastSplitID ]|g' Dependencies.txt
echo 423 / 1866 --- Result2191 to Stage2LastSplitID
perl -i -pe 's|Result2192 \[\.\.\.\]|Result2192 [ Stage2LastSplit ]|g' Dependencies.txt
echo 424 / 1866 --- Result2192 to Stage2LastSplit
perl -i -pe 's|Result2193 \[\.\.\.\]|Result2193 [ Stage2LastFinishID ]|g' Dependencies.txt
echo 425 / 1866 --- Result2193 to Stage2LastFinishID
perl -i -pe 's|Result2194 \[\.\.\.\]|Result2194 [ Stage2LastFinish ]|g' Dependencies.txt
echo 426 / 1866 --- Result2194 to Stage2LastFinish
perl -i -pe 's|Result2195 \[\.\.\.\]|Result2195 [ Stage2LastSplitBunchTime ]|g' Dependencies.txt
echo 427 / 1866 --- Result2195 to Stage2LastSplitBunchTime
perl -i -pe 's|Result2196 \[\.\.\.\]|Result2196 [ Stage2PhotoBunchTime ]|g' Dependencies.txt
echo 428 / 1866 --- Result2196 to Stage2PhotoBunchTime
perl -i -pe 's|Result2200 \[\.\.\.\]|Result2200 [ Stage2Start ]|g' Dependencies.txt
echo 429 / 1866 --- Result2200 to Stage2Start
perl -i -pe 's|Result2201 \[\.\.\.\]|Result2201 [ Stage2Lap1Split1 ]|g' Dependencies.txt
echo 430 / 1866 --- Result2201 to Stage2Lap1Split1
perl -i -pe 's|Result2202 \[\.\.\.\]|Result2202 [ Stage2Lap1Split2 ]|g' Dependencies.txt
echo 431 / 1866 --- Result2202 to Stage2Lap1Split2
perl -i -pe 's|Result2203 \[\.\.\.\]|Result2203 [ Stage2Lap1Split3 ]|g' Dependencies.txt
echo 432 / 1866 --- Result2203 to Stage2Lap1Split3
perl -i -pe 's|Result2204 \[\.\.\.\]|Result2204 [ Stage2Lap1Spotter ]|g' Dependencies.txt
echo 433 / 1866 --- Result2204 to Stage2Lap1Spotter
perl -i -pe 's|Result2205 \[\.\.\.\]|Result2205 [ Stage2Lap1Finish ]|g' Dependencies.txt
echo 434 / 1866 --- Result2205 to Stage2Lap1Finish
perl -i -pe 's|Result2206 \[\.\.\.\]|Result2206 [ Stage2Lap2Split1 ]|g' Dependencies.txt
echo 435 / 1866 --- Result2206 to Stage2Lap2Split1
perl -i -pe 's|Result2207 \[\.\.\.\]|Result2207 [ Stage2Lap2Split2 ]|g' Dependencies.txt
echo 436 / 1866 --- Result2207 to Stage2Lap2Split2
perl -i -pe 's|Result2208 \[\.\.\.\]|Result2208 [ Stage2Lap2Split3 ]|g' Dependencies.txt
echo 437 / 1866 --- Result2208 to Stage2Lap2Split3
perl -i -pe 's|Result2209 \[\.\.\.\]|Result2209 [ Stage2Lap2Spotter ]|g' Dependencies.txt
echo 438 / 1866 --- Result2209 to Stage2Lap2Spotter
perl -i -pe 's|Result2210 \[\.\.\.\]|Result2210 [ Stage2Lap2Finish ]|g' Dependencies.txt
echo 439 / 1866 --- Result2210 to Stage2Lap2Finish
perl -i -pe 's|Result2211 \[\.\.\.\]|Result2211 [ Stage2Lap3Split1 ]|g' Dependencies.txt
echo 440 / 1866 --- Result2211 to Stage2Lap3Split1
perl -i -pe 's|Result2212 \[\.\.\.\]|Result2212 [ Stage2Lap3Split2 ]|g' Dependencies.txt
echo 441 / 1866 --- Result2212 to Stage2Lap3Split2
perl -i -pe 's|Result2213 \[\.\.\.\]|Result2213 [ Stage2Lap3Split3 ]|g' Dependencies.txt
echo 442 / 1866 --- Result2213 to Stage2Lap3Split3
perl -i -pe 's|Result2214 \[\.\.\.\]|Result2214 [ Stage2Lap3Spotter ]|g' Dependencies.txt
echo 443 / 1866 --- Result2214 to Stage2Lap3Spotter
perl -i -pe 's|Result2215 \[\.\.\.\]|Result2215 [ Stage2Lap3Finish ]|g' Dependencies.txt
echo 444 / 1866 --- Result2215 to Stage2Lap3Finish
perl -i -pe 's|Result2216 \[\.\.\.\]|Result2216 [ Stage2Lap4Split1 ]|g' Dependencies.txt
echo 445 / 1866 --- Result2216 to Stage2Lap4Split1
perl -i -pe 's|Result2217 \[\.\.\.\]|Result2217 [ Stage2Lap4Split2 ]|g' Dependencies.txt
echo 446 / 1866 --- Result2217 to Stage2Lap4Split2
perl -i -pe 's|Result2218 \[\.\.\.\]|Result2218 [ Stage2Lap4Split3 ]|g' Dependencies.txt
echo 447 / 1866 --- Result2218 to Stage2Lap4Split3
perl -i -pe 's|Result2219 \[\.\.\.\]|Result2219 [ Stage2Lap4Spotter ]|g' Dependencies.txt
echo 448 / 1866 --- Result2219 to Stage2Lap4Spotter
perl -i -pe 's|Result2220 \[\.\.\.\]|Result2220 [ Stage2Lap4Finish ]|g' Dependencies.txt
echo 449 / 1866 --- Result2220 to Stage2Lap4Finish
perl -i -pe 's|Result2221 \[\.\.\.\]|Result2221 [ Stage2Lap5Split1 ]|g' Dependencies.txt
echo 450 / 1866 --- Result2221 to Stage2Lap5Split1
perl -i -pe 's|Result2222 \[\.\.\.\]|Result2222 [ Stage2Lap5Split2 ]|g' Dependencies.txt
echo 451 / 1866 --- Result2222 to Stage2Lap5Split2
perl -i -pe 's|Result2223 \[\.\.\.\]|Result2223 [ Stage2Lap5Split3 ]|g' Dependencies.txt
echo 452 / 1866 --- Result2223 to Stage2Lap5Split3
perl -i -pe 's|Result2224 \[\.\.\.\]|Result2224 [ Stage2Lap5Spotter ]|g' Dependencies.txt
echo 453 / 1866 --- Result2224 to Stage2Lap5Spotter
perl -i -pe 's|Result2225 \[\.\.\.\]|Result2225 [ Stage2Lap5Finish ]|g' Dependencies.txt
echo 454 / 1866 --- Result2225 to Stage2Lap5Finish
perl -i -pe 's|Result2226 \[\.\.\.\]|Result2226 [ Stage2Lap6Split1 ]|g' Dependencies.txt
echo 455 / 1866 --- Result2226 to Stage2Lap6Split1
perl -i -pe 's|Result2227 \[\.\.\.\]|Result2227 [ Stage2Lap6Split2 ]|g' Dependencies.txt
echo 456 / 1866 --- Result2227 to Stage2Lap6Split2
perl -i -pe 's|Result2228 \[\.\.\.\]|Result2228 [ Stage2Lap6Split3 ]|g' Dependencies.txt
echo 457 / 1866 --- Result2228 to Stage2Lap6Split3
perl -i -pe 's|Result2229 \[\.\.\.\]|Result2229 [ Stage2Lap6Spotter ]|g' Dependencies.txt
echo 458 / 1866 --- Result2229 to Stage2Lap6Spotter
perl -i -pe 's|Result2230 \[\.\.\.\]|Result2230 [ Stage2Lap6Finish ]|g' Dependencies.txt
echo 459 / 1866 --- Result2230 to Stage2Lap6Finish
perl -i -pe 's|Result2231 \[\.\.\.\]|Result2231 [ Stage2Lap7Split1 ]|g' Dependencies.txt
echo 460 / 1866 --- Result2231 to Stage2Lap7Split1
perl -i -pe 's|Result2232 \[\.\.\.\]|Result2232 [ Stage2Lap7Split2 ]|g' Dependencies.txt
echo 461 / 1866 --- Result2232 to Stage2Lap7Split2
perl -i -pe 's|Result2233 \[\.\.\.\]|Result2233 [ Stage2Lap7Split3 ]|g' Dependencies.txt
echo 462 / 1866 --- Result2233 to Stage2Lap7Split3
perl -i -pe 's|Result2234 \[\.\.\.\]|Result2234 [ Stage2Lap7Spotter ]|g' Dependencies.txt
echo 463 / 1866 --- Result2234 to Stage2Lap7Spotter
perl -i -pe 's|Result2235 \[\.\.\.\]|Result2235 [ Stage2Lap7Finish ]|g' Dependencies.txt
echo 464 / 1866 --- Result2235 to Stage2Lap7Finish
perl -i -pe 's|Result2236 \[\.\.\.\]|Result2236 [ Stage2Lap8Split1 ]|g' Dependencies.txt
echo 465 / 1866 --- Result2236 to Stage2Lap8Split1
perl -i -pe 's|Result2237 \[\.\.\.\]|Result2237 [ Stage2Lap8Split2 ]|g' Dependencies.txt
echo 466 / 1866 --- Result2237 to Stage2Lap8Split2
perl -i -pe 's|Result2238 \[\.\.\.\]|Result2238 [ Stage2Lap8Split3 ]|g' Dependencies.txt
echo 467 / 1866 --- Result2238 to Stage2Lap8Split3
perl -i -pe 's|Result2239 \[\.\.\.\]|Result2239 [ Stage2Lap8Spotter ]|g' Dependencies.txt
echo 468 / 1866 --- Result2239 to Stage2Lap8Spotter
perl -i -pe 's|Result2240 \[\.\.\.\]|Result2240 [ Stage2Lap8Finish ]|g' Dependencies.txt
echo 469 / 1866 --- Result2240 to Stage2Lap8Finish
perl -i -pe 's|Result2241 \[\.\.\.\]|Result2241 [ Stage2Lap9Split1 ]|g' Dependencies.txt
echo 470 / 1866 --- Result2241 to Stage2Lap9Split1
perl -i -pe 's|Result2242 \[\.\.\.\]|Result2242 [ Stage2Lap9Split2 ]|g' Dependencies.txt
echo 471 / 1866 --- Result2242 to Stage2Lap9Split2
perl -i -pe 's|Result2243 \[\.\.\.\]|Result2243 [ Stage2Lap9Split3 ]|g' Dependencies.txt
echo 472 / 1866 --- Result2243 to Stage2Lap9Split3
perl -i -pe 's|Result2244 \[\.\.\.\]|Result2244 [ Stage2Lap9Spotter ]|g' Dependencies.txt
echo 473 / 1866 --- Result2244 to Stage2Lap9Spotter
perl -i -pe 's|Result2245 \[\.\.\.\]|Result2245 [ Stage2Lap9Finish ]|g' Dependencies.txt
echo 474 / 1866 --- Result2245 to Stage2Lap9Finish
perl -i -pe 's|Result2246 \[\.\.\.\]|Result2246 [ Stage2Lap10Split1 ]|g' Dependencies.txt
echo 475 / 1866 --- Result2246 to Stage2Lap10Split1
perl -i -pe 's|Result2247 \[\.\.\.\]|Result2247 [ Stage2Lap10Split2 ]|g' Dependencies.txt
echo 476 / 1866 --- Result2247 to Stage2Lap10Split2
perl -i -pe 's|Result2248 \[\.\.\.\]|Result2248 [ Stage2Lap10Split3 ]|g' Dependencies.txt
echo 477 / 1866 --- Result2248 to Stage2Lap10Split3
perl -i -pe 's|Result2249 \[\.\.\.\]|Result2249 [ Stage2Lap10Spotter ]|g' Dependencies.txt
echo 478 / 1866 --- Result2249 to Stage2Lap10Spotter
perl -i -pe 's|Result2250 \[\.\.\.\]|Result2250 [ Stage2Lap10Finish ]|g' Dependencies.txt
echo 479 / 1866 --- Result2250 to Stage2Lap10Finish
perl -i -pe 's|Result2301 \[\.\.\.\]|Result2301 [ Stage2Lap1 ]|g' Dependencies.txt
echo 480 / 1866 --- Result2301 to Stage2Lap1
perl -i -pe 's|Result2302 \[\.\.\.\]|Result2302 [ Stage2Lap2 ]|g' Dependencies.txt
echo 481 / 1866 --- Result2302 to Stage2Lap2
perl -i -pe 's|Result2303 \[\.\.\.\]|Result2303 [ Stage2Lap3 ]|g' Dependencies.txt
echo 482 / 1866 --- Result2303 to Stage2Lap3
perl -i -pe 's|Result2304 \[\.\.\.\]|Result2304 [ Stage2Lap4 ]|g' Dependencies.txt
echo 483 / 1866 --- Result2304 to Stage2Lap4
perl -i -pe 's|Result2305 \[\.\.\.\]|Result2305 [ Stage2Lap5 ]|g' Dependencies.txt
echo 484 / 1866 --- Result2305 to Stage2Lap5
perl -i -pe 's|Result2306 \[\.\.\.\]|Result2306 [ Stage2Lap6 ]|g' Dependencies.txt
echo 485 / 1866 --- Result2306 to Stage2Lap6
perl -i -pe 's|Result2307 \[\.\.\.\]|Result2307 [ Stage2Lap7 ]|g' Dependencies.txt
echo 486 / 1866 --- Result2307 to Stage2Lap7
perl -i -pe 's|Result2308 \[\.\.\.\]|Result2308 [ Stage2Lap8 ]|g' Dependencies.txt
echo 487 / 1866 --- Result2308 to Stage2Lap8
perl -i -pe 's|Result2309 \[\.\.\.\]|Result2309 [ Stage2Lap9 ]|g' Dependencies.txt
echo 488 / 1866 --- Result2309 to Stage2Lap9
perl -i -pe 's|Result2310 \[\.\.\.\]|Result2310 [ Stage2Lap10 ]|g' Dependencies.txt
echo 489 / 1866 --- Result2310 to Stage2Lap10
perl -i -pe 's|Result2320 \[\.\.\.\]|Result2320 [ Stage2LapCount ]|g' Dependencies.txt
echo 490 / 1866 --- Result2320 to Stage2LapCount
perl -i -pe 's|Result2321 \[\.\.\.\]|Result2321 [ Stage2FastestLap ]|g' Dependencies.txt
echo 491 / 1866 --- Result2321 to Stage2FastestLap
perl -i -pe 's|Result2322 \[\.\.\.\]|Result2322 [ Stage2SlowestLap ]|g' Dependencies.txt
echo 492 / 1866 --- Result2322 to Stage2SlowestLap
perl -i -pe 's|Result2323 \[\.\.\.\]|Result2323 [ Stage2AverageLap ]|g' Dependencies.txt
echo 493 / 1866 --- Result2323 to Stage2AverageLap
perl -i -pe 's|Result2324 \[\.\.\.\]|Result2324 [ Stage2LastLap ]|g' Dependencies.txt
echo 494 / 1866 --- Result2324 to Stage2LastLap
perl -i -pe 's|Result2401 \[\.\.\.\]|Result2401 [ Stage2ParcoursStation1Points ]|g' Dependencies.txt
echo 495 / 1866 --- Result2401 to Stage2ParcoursStation1Points
perl -i -pe 's|Result2402 \[\.\.\.\]|Result2402 [ Stage2ParcoursStation2Points ]|g' Dependencies.txt
echo 496 / 1866 --- Result2402 to Stage2ParcoursStation2Points
perl -i -pe 's|Result2403 \[\.\.\.\]|Result2403 [ Stage2ParcoursStation3Points ]|g' Dependencies.txt
echo 497 / 1866 --- Result2403 to Stage2ParcoursStation3Points
perl -i -pe 's|Result2404 \[\.\.\.\]|Result2404 [ Stage2ParcoursStation4Points ]|g' Dependencies.txt
echo 498 / 1866 --- Result2404 to Stage2ParcoursStation4Points
perl -i -pe 's|Result2405 \[\.\.\.\]|Result2405 [ Stage2ParcoursStation5Points ]|g' Dependencies.txt
echo 499 / 1866 --- Result2405 to Stage2ParcoursStation5Points
perl -i -pe 's|Result2406 \[\.\.\.\]|Result2406 [ Stage2ParcoursStation6Points ]|g' Dependencies.txt
echo 500 / 1866 --- Result2406 to Stage2ParcoursStation6Points
perl -i -pe 's|Result2407 \[\.\.\.\]|Result2407 [ Stage2ParcoursStation7Points ]|g' Dependencies.txt
echo 501 / 1866 --- Result2407 to Stage2ParcoursStation7Points
perl -i -pe 's|Result2408 \[\.\.\.\]|Result2408 [ Stage2ParcoursStation8Points ]|g' Dependencies.txt
echo 502 / 1866 --- Result2408 to Stage2ParcoursStation8Points
perl -i -pe 's|Result2409 \[\.\.\.\]|Result2409 [ Stage2ParcoursStation9Points ]|g' Dependencies.txt
echo 503 / 1866 --- Result2409 to Stage2ParcoursStation9Points
perl -i -pe 's|Result2410 \[\.\.\.\]|Result2410 [ Stage2ParcoursStation10Points ]|g' Dependencies.txt
echo 504 / 1866 --- Result2410 to Stage2ParcoursStation10Points
perl -i -pe 's|Result2411 \[\.\.\.\]|Result2411 [ Stage2ParcoursStation11Points ]|g' Dependencies.txt
echo 505 / 1866 --- Result2411 to Stage2ParcoursStation11Points
perl -i -pe 's|Result2412 \[\.\.\.\]|Result2412 [ Stage2ParcoursStation12Points ]|g' Dependencies.txt
echo 506 / 1866 --- Result2412 to Stage2ParcoursStation12Points
perl -i -pe 's|Result2413 \[\.\.\.\]|Result2413 [ Stage2ParcoursStation13Points ]|g' Dependencies.txt
echo 507 / 1866 --- Result2413 to Stage2ParcoursStation13Points
perl -i -pe 's|Result2414 \[\.\.\.\]|Result2414 [ Stage2ParcoursStation14Points ]|g' Dependencies.txt
echo 508 / 1866 --- Result2414 to Stage2ParcoursStation14Points
perl -i -pe 's|Result2415 \[\.\.\.\]|Result2415 [ Stage2ParcoursStation15Points ]|g' Dependencies.txt
echo 509 / 1866 --- Result2415 to Stage2ParcoursStation15Points
perl -i -pe 's|Result2430 \[\.\.\.\]|Result2430 [ Stage2ParcoursTotalPoints ]|g' Dependencies.txt
echo 510 / 1866 --- Result2430 to Stage2ParcoursTotalPoints
perl -i -pe 's|Result2441 \[\.\.\.\]|Result2441 [ Stage2ParcoursStart ]|g' Dependencies.txt
echo 511 / 1866 --- Result2441 to Stage2ParcoursStart
perl -i -pe 's|Result2442 \[\.\.\.\]|Result2442 [ Stage2ParcoursFinish ]|g' Dependencies.txt
echo 512 / 1866 --- Result2442 to Stage2ParcoursFinish
perl -i -pe 's|Result2450 \[\.\.\.\]|Result2450 [ Stage2ParcoursTime ]|g' Dependencies.txt
echo 513 / 1866 --- Result2450 to Stage2ParcoursTime
perl -i -pe 's|Result2501 \[\.\.\.\]|Result2501 [ Stage2ParcoursRankingPoints ]|g' Dependencies.txt
echo 514 / 1866 --- Result2501 to Stage2ParcoursRankingPoints
perl -i -pe 's|Result2502 \[\.\.\.\]|Result2502 [ Stage2CrossCountryRankingPoints ]|g' Dependencies.txt
echo 515 / 1866 --- Result2502 to Stage2CrossCountryRankingPoints
perl -i -pe 's|Result2503 \[\.\.\.\]|Result2503 [ Stage2TotalRankingPoints ]|g' Dependencies.txt
echo 516 / 1866 --- Result2503 to Stage2TotalRankingPoints
perl -i -pe 's|Result2611 \[\.\.\.\]|Result2611 [ Stage2Lap1Sector1 ]|g' Dependencies.txt
echo 517 / 1866 --- Result2611 to Stage2Lap1Sector1
perl -i -pe 's|Result2612 \[\.\.\.\]|Result2612 [ Stage2Lap2Sector1 ]|g' Dependencies.txt
echo 518 / 1866 --- Result2612 to Stage2Lap2Sector1
perl -i -pe 's|Result2613 \[\.\.\.\]|Result2613 [ Stage2Lap3Sector1 ]|g' Dependencies.txt
echo 519 / 1866 --- Result2613 to Stage2Lap3Sector1
perl -i -pe 's|Result2614 \[\.\.\.\]|Result2614 [ Stage2Lap4Sector1 ]|g' Dependencies.txt
echo 520 / 1866 --- Result2614 to Stage2Lap4Sector1
perl -i -pe 's|Result2615 \[\.\.\.\]|Result2615 [ Stage2Lap5Sector1 ]|g' Dependencies.txt
echo 521 / 1866 --- Result2615 to Stage2Lap5Sector1
perl -i -pe 's|Result2616 \[\.\.\.\]|Result2616 [ Stage2Lap6Sector1 ]|g' Dependencies.txt
echo 522 / 1866 --- Result2616 to Stage2Lap6Sector1
perl -i -pe 's|Result2617 \[\.\.\.\]|Result2617 [ Stage2Lap7Sector1 ]|g' Dependencies.txt
echo 523 / 1866 --- Result2617 to Stage2Lap7Sector1
perl -i -pe 's|Result2618 \[\.\.\.\]|Result2618 [ Stage2Lap8Sector1 ]|g' Dependencies.txt
echo 524 / 1866 --- Result2618 to Stage2Lap8Sector1
perl -i -pe 's|Result2619 \[\.\.\.\]|Result2619 [ Stage2Lap9Sector1 ]|g' Dependencies.txt
echo 525 / 1866 --- Result2619 to Stage2Lap9Sector1
perl -i -pe 's|Result2620 \[\.\.\.\]|Result2620 [ Stage2Lap10Sector1 ]|g' Dependencies.txt
echo 526 / 1866 --- Result2620 to Stage2Lap10Sector1
perl -i -pe 's|Result2621 \[\.\.\.\]|Result2621 [ Stage2Lap1Sector2 ]|g' Dependencies.txt
echo 527 / 1866 --- Result2621 to Stage2Lap1Sector2
perl -i -pe 's|Result2622 \[\.\.\.\]|Result2622 [ Stage2Lap2Sector2 ]|g' Dependencies.txt
echo 528 / 1866 --- Result2622 to Stage2Lap2Sector2
perl -i -pe 's|Result2623 \[\.\.\.\]|Result2623 [ Stage2Lap3Sector2 ]|g' Dependencies.txt
echo 529 / 1866 --- Result2623 to Stage2Lap3Sector2
perl -i -pe 's|Result2624 \[\.\.\.\]|Result2624 [ Stage2Lap4Sector2 ]|g' Dependencies.txt
echo 530 / 1866 --- Result2624 to Stage2Lap4Sector2
perl -i -pe 's|Result2625 \[\.\.\.\]|Result2625 [ Stage2Lap5Sector2 ]|g' Dependencies.txt
echo 531 / 1866 --- Result2625 to Stage2Lap5Sector2
perl -i -pe 's|Result2626 \[\.\.\.\]|Result2626 [ Stage2Lap6Sector2 ]|g' Dependencies.txt
echo 532 / 1866 --- Result2626 to Stage2Lap6Sector2
perl -i -pe 's|Result2627 \[\.\.\.\]|Result2627 [ Stage2Lap7Sector2 ]|g' Dependencies.txt
echo 533 / 1866 --- Result2627 to Stage2Lap7Sector2
perl -i -pe 's|Result2628 \[\.\.\.\]|Result2628 [ Stage2Lap8Sector2 ]|g' Dependencies.txt
echo 534 / 1866 --- Result2628 to Stage2Lap8Sector2
perl -i -pe 's|Result2629 \[\.\.\.\]|Result2629 [ Stage2Lap9Sector2 ]|g' Dependencies.txt
echo 535 / 1866 --- Result2629 to Stage2Lap9Sector2
perl -i -pe 's|Result2630 \[\.\.\.\]|Result2630 [ Stage2Lap10Sector2 ]|g' Dependencies.txt
echo 536 / 1866 --- Result2630 to Stage2Lap10Sector2
perl -i -pe 's|Result2631 \[\.\.\.\]|Result2631 [ Stage2Lap1Sector3 ]|g' Dependencies.txt
echo 537 / 1866 --- Result2631 to Stage2Lap1Sector3
perl -i -pe 's|Result2632 \[\.\.\.\]|Result2632 [ Stage2Lap2Sector3 ]|g' Dependencies.txt
echo 538 / 1866 --- Result2632 to Stage2Lap2Sector3
perl -i -pe 's|Result2633 \[\.\.\.\]|Result2633 [ Stage2Lap3Sector3 ]|g' Dependencies.txt
echo 539 / 1866 --- Result2633 to Stage2Lap3Sector3
perl -i -pe 's|Result2634 \[\.\.\.\]|Result2634 [ Stage2Lap4Sector3 ]|g' Dependencies.txt
echo 540 / 1866 --- Result2634 to Stage2Lap4Sector3
perl -i -pe 's|Result2635 \[\.\.\.\]|Result2635 [ Stage2Lap5Sector3 ]|g' Dependencies.txt
echo 541 / 1866 --- Result2635 to Stage2Lap5Sector3
perl -i -pe 's|Result2636 \[\.\.\.\]|Result2636 [ Stage2Lap6Sector3 ]|g' Dependencies.txt
echo 542 / 1866 --- Result2636 to Stage2Lap6Sector3
perl -i -pe 's|Result2637 \[\.\.\.\]|Result2637 [ Stage2Lap7Sector3 ]|g' Dependencies.txt
echo 543 / 1866 --- Result2637 to Stage2Lap7Sector3
perl -i -pe 's|Result2638 \[\.\.\.\]|Result2638 [ Stage2Lap8Sector3 ]|g' Dependencies.txt
echo 544 / 1866 --- Result2638 to Stage2Lap8Sector3
perl -i -pe 's|Result2639 \[\.\.\.\]|Result2639 [ Stage2Lap9Sector3 ]|g' Dependencies.txt
echo 545 / 1866 --- Result2639 to Stage2Lap9Sector3
perl -i -pe 's|Result2640 \[\.\.\.\]|Result2640 [ Stage2Lap10Sector3 ]|g' Dependencies.txt
echo 546 / 1866 --- Result2640 to Stage2Lap10Sector3
perl -i -pe 's|Result2641 \[\.\.\.\]|Result2641 [ Stage2Lap1Sector4 ]|g' Dependencies.txt
echo 547 / 1866 --- Result2641 to Stage2Lap1Sector4
perl -i -pe 's|Result2642 \[\.\.\.\]|Result2642 [ Stage2Lap2Sector4 ]|g' Dependencies.txt
echo 548 / 1866 --- Result2642 to Stage2Lap2Sector4
perl -i -pe 's|Result2643 \[\.\.\.\]|Result2643 [ Stage2Lap3Sector4 ]|g' Dependencies.txt
echo 549 / 1866 --- Result2643 to Stage2Lap3Sector4
perl -i -pe 's|Result2644 \[\.\.\.\]|Result2644 [ Stage2Lap4Sector4 ]|g' Dependencies.txt
echo 550 / 1866 --- Result2644 to Stage2Lap4Sector4
perl -i -pe 's|Result2645 \[\.\.\.\]|Result2645 [ Stage2Lap5Sector4 ]|g' Dependencies.txt
echo 551 / 1866 --- Result2645 to Stage2Lap5Sector4
perl -i -pe 's|Result2646 \[\.\.\.\]|Result2646 [ Stage2Lap6Sector4 ]|g' Dependencies.txt
echo 552 / 1866 --- Result2646 to Stage2Lap6Sector4
perl -i -pe 's|Result2647 \[\.\.\.\]|Result2647 [ Stage2Lap7Sector4 ]|g' Dependencies.txt
echo 553 / 1866 --- Result2647 to Stage2Lap7Sector4
perl -i -pe 's|Result2648 \[\.\.\.\]|Result2648 [ Stage2Lap8Sector4 ]|g' Dependencies.txt
echo 554 / 1866 --- Result2648 to Stage2Lap8Sector4
perl -i -pe 's|Result2649 \[\.\.\.\]|Result2649 [ Stage2Lap9Sector4 ]|g' Dependencies.txt
echo 555 / 1866 --- Result2649 to Stage2Lap9Sector4
perl -i -pe 's|Result2650 \[\.\.\.\]|Result2650 [ Stage2Lap10Sector4 ]|g' Dependencies.txt
echo 556 / 1866 --- Result2650 to Stage2Lap10Sector4
perl -i -pe 's|Result2651 \[\.\.\.\]|Result2651 [ Stage2Lap1UphillSector ]|g' Dependencies.txt
echo 557 / 1866 --- Result2651 to Stage2Lap1UphillSector
perl -i -pe 's|Result2652 \[\.\.\.\]|Result2652 [ Stage2Lap2UphillSector ]|g' Dependencies.txt
echo 558 / 1866 --- Result2652 to Stage2Lap2UphillSector
perl -i -pe 's|Result2653 \[\.\.\.\]|Result2653 [ Stage2Lap3UphillSector ]|g' Dependencies.txt
echo 559 / 1866 --- Result2653 to Stage2Lap3UphillSector
perl -i -pe 's|Result2654 \[\.\.\.\]|Result2654 [ Stage2Lap4UphillSector ]|g' Dependencies.txt
echo 560 / 1866 --- Result2654 to Stage2Lap4UphillSector
perl -i -pe 's|Result2655 \[\.\.\.\]|Result2655 [ Stage2Lap5UphillSector ]|g' Dependencies.txt
echo 561 / 1866 --- Result2655 to Stage2Lap5UphillSector
perl -i -pe 's|Result2656 \[\.\.\.\]|Result2656 [ Stage2Lap6UphillSector ]|g' Dependencies.txt
echo 562 / 1866 --- Result2656 to Stage2Lap6UphillSector
perl -i -pe 's|Result2657 \[\.\.\.\]|Result2657 [ Stage2Lap7UphillSector ]|g' Dependencies.txt
echo 563 / 1866 --- Result2657 to Stage2Lap7UphillSector
perl -i -pe 's|Result2658 \[\.\.\.\]|Result2658 [ Stage2Lap8UphillSector ]|g' Dependencies.txt
echo 564 / 1866 --- Result2658 to Stage2Lap8UphillSector
perl -i -pe 's|Result2659 \[\.\.\.\]|Result2659 [ Stage2Lap9UphillSector ]|g' Dependencies.txt
echo 565 / 1866 --- Result2659 to Stage2Lap9UphillSector
perl -i -pe 's|Result2660 \[\.\.\.\]|Result2660 [ Stage2Lap10UphillSector ]|g' Dependencies.txt
echo 566 / 1866 --- Result2660 to Stage2Lap10UphillSector
perl -i -pe 's|Result2680 \[\.\.\.\]|Result2680 [ Stage2FastestUphillSector ]|g' Dependencies.txt
echo 567 / 1866 --- Result2680 to Stage2FastestUphillSector
perl -i -pe 's|Result2681 \[\.\.\.\]|Result2681 [ Stage2FastestUphillSectorID ]|g' Dependencies.txt
echo 568 / 1866 --- Result2681 to Stage2FastestUphillSectorID
perl -i -pe 's|Result3000 \[\.\.\.\]|Result3000 [ Stage3StartTime ]|g' Dependencies.txt
echo 569 / 1866 --- Result3000 to Stage3StartTime
perl -i -pe 's|Result3001 \[\.\.\.\]|Result3001 [ Stage3FinishTimeLimit ]|g' Dependencies.txt
echo 570 / 1866 --- Result3001 to Stage3FinishTimeLimit
perl -i -pe 's|Result3100 \[\.\.\.\]|Result3100 [ Stage3Started ]|g' Dependencies.txt
echo 571 / 1866 --- Result3100 to Stage3Started
perl -i -pe 's|Result3101 \[\.\.\.\]|Result3101 [ Stage3AfterLap1Split1 ]|g' Dependencies.txt
echo 572 / 1866 --- Result3101 to Stage3AfterLap1Split1
perl -i -pe 's|Result3102 \[\.\.\.\]|Result3102 [ Stage3AfterLap1Split2 ]|g' Dependencies.txt
echo 573 / 1866 --- Result3102 to Stage3AfterLap1Split2
perl -i -pe 's|Result3103 \[\.\.\.\]|Result3103 [ Stage3AfterLap1Split3 ]|g' Dependencies.txt
echo 574 / 1866 --- Result3103 to Stage3AfterLap1Split3
perl -i -pe 's|Result3104 \[\.\.\.\]|Result3104 [ Stage3AfterLap1Spotter ]|g' Dependencies.txt
echo 575 / 1866 --- Result3104 to Stage3AfterLap1Spotter
perl -i -pe 's|Result3105 \[\.\.\.\]|Result3105 [ Stage3AfterLap1Finish ]|g' Dependencies.txt
echo 576 / 1866 --- Result3105 to Stage3AfterLap1Finish
perl -i -pe 's|Result3106 \[\.\.\.\]|Result3106 [ Stage3AfterLap2Split1 ]|g' Dependencies.txt
echo 577 / 1866 --- Result3106 to Stage3AfterLap2Split1
perl -i -pe 's|Result3107 \[\.\.\.\]|Result3107 [ Stage3AfterLap2Split2 ]|g' Dependencies.txt
echo 578 / 1866 --- Result3107 to Stage3AfterLap2Split2
perl -i -pe 's|Result3108 \[\.\.\.\]|Result3108 [ Stage3AfterLap2Split3 ]|g' Dependencies.txt
echo 579 / 1866 --- Result3108 to Stage3AfterLap2Split3
perl -i -pe 's|Result3109 \[\.\.\.\]|Result3109 [ Stage3AfterLap2Spotter ]|g' Dependencies.txt
echo 580 / 1866 --- Result3109 to Stage3AfterLap2Spotter
perl -i -pe 's|Result3110 \[\.\.\.\]|Result3110 [ Stage3AfterLap2Finish ]|g' Dependencies.txt
echo 581 / 1866 --- Result3110 to Stage3AfterLap2Finish
perl -i -pe 's|Result3111 \[\.\.\.\]|Result3111 [ Stage3AfterLap3Split1 ]|g' Dependencies.txt
echo 582 / 1866 --- Result3111 to Stage3AfterLap3Split1
perl -i -pe 's|Result3112 \[\.\.\.\]|Result3112 [ Stage3AfterLap3Split2 ]|g' Dependencies.txt
echo 583 / 1866 --- Result3112 to Stage3AfterLap3Split2
perl -i -pe 's|Result3113 \[\.\.\.\]|Result3113 [ Stage3AfterLap3Split3 ]|g' Dependencies.txt
echo 584 / 1866 --- Result3113 to Stage3AfterLap3Split3
perl -i -pe 's|Result3114 \[\.\.\.\]|Result3114 [ Stage3AfterLap3Spotter ]|g' Dependencies.txt
echo 585 / 1866 --- Result3114 to Stage3AfterLap3Spotter
perl -i -pe 's|Result3115 \[\.\.\.\]|Result3115 [ Stage3AfterLap3Finish ]|g' Dependencies.txt
echo 586 / 1866 --- Result3115 to Stage3AfterLap3Finish
perl -i -pe 's|Result3116 \[\.\.\.\]|Result3116 [ Stage3AfterLap4Split1 ]|g' Dependencies.txt
echo 587 / 1866 --- Result3116 to Stage3AfterLap4Split1
perl -i -pe 's|Result3117 \[\.\.\.\]|Result3117 [ Stage3AfterLap4Split2 ]|g' Dependencies.txt
echo 588 / 1866 --- Result3117 to Stage3AfterLap4Split2
perl -i -pe 's|Result3118 \[\.\.\.\]|Result3118 [ Stage3AfterLap4Split3 ]|g' Dependencies.txt
echo 589 / 1866 --- Result3118 to Stage3AfterLap4Split3
perl -i -pe 's|Result3119 \[\.\.\.\]|Result3119 [ Stage3AfterLap4Spotter ]|g' Dependencies.txt
echo 590 / 1866 --- Result3119 to Stage3AfterLap4Spotter
perl -i -pe 's|Result3120 \[\.\.\.\]|Result3120 [ Stage3AfterLap4Finish ]|g' Dependencies.txt
echo 591 / 1866 --- Result3120 to Stage3AfterLap4Finish
perl -i -pe 's|Result3121 \[\.\.\.\]|Result3121 [ Stage3AfterLap5Split1 ]|g' Dependencies.txt
echo 592 / 1866 --- Result3121 to Stage3AfterLap5Split1
perl -i -pe 's|Result3122 \[\.\.\.\]|Result3122 [ Stage3AfterLap5Split2 ]|g' Dependencies.txt
echo 593 / 1866 --- Result3122 to Stage3AfterLap5Split2
perl -i -pe 's|Result3123 \[\.\.\.\]|Result3123 [ Stage3AfterLap5Split3 ]|g' Dependencies.txt
echo 594 / 1866 --- Result3123 to Stage3AfterLap5Split3
perl -i -pe 's|Result3124 \[\.\.\.\]|Result3124 [ Stage3AfterLap5Spotter ]|g' Dependencies.txt
echo 595 / 1866 --- Result3124 to Stage3AfterLap5Spotter
perl -i -pe 's|Result3125 \[\.\.\.\]|Result3125 [ Stage3AfterLap5Finish ]|g' Dependencies.txt
echo 596 / 1866 --- Result3125 to Stage3AfterLap5Finish
perl -i -pe 's|Result3126 \[\.\.\.\]|Result3126 [ Stage3AfterLap6Split1 ]|g' Dependencies.txt
echo 597 / 1866 --- Result3126 to Stage3AfterLap6Split1
perl -i -pe 's|Result3127 \[\.\.\.\]|Result3127 [ Stage3AfterLap6Split2 ]|g' Dependencies.txt
echo 598 / 1866 --- Result3127 to Stage3AfterLap6Split2
perl -i -pe 's|Result3128 \[\.\.\.\]|Result3128 [ Stage3AfterLap6Split3 ]|g' Dependencies.txt
echo 599 / 1866 --- Result3128 to Stage3AfterLap6Split3
perl -i -pe 's|Result3129 \[\.\.\.\]|Result3129 [ Stage3AfterLap6Spotter ]|g' Dependencies.txt
echo 600 / 1866 --- Result3129 to Stage3AfterLap6Spotter
perl -i -pe 's|Result3130 \[\.\.\.\]|Result3130 [ Stage3AfterLap6Finish ]|g' Dependencies.txt
echo 601 / 1866 --- Result3130 to Stage3AfterLap6Finish
perl -i -pe 's|Result3131 \[\.\.\.\]|Result3131 [ Stage3AfterLap7Split1 ]|g' Dependencies.txt
echo 602 / 1866 --- Result3131 to Stage3AfterLap7Split1
perl -i -pe 's|Result3132 \[\.\.\.\]|Result3132 [ Stage3AfterLap7Split2 ]|g' Dependencies.txt
echo 603 / 1866 --- Result3132 to Stage3AfterLap7Split2
perl -i -pe 's|Result3133 \[\.\.\.\]|Result3133 [ Stage3AfterLap7Split3 ]|g' Dependencies.txt
echo 604 / 1866 --- Result3133 to Stage3AfterLap7Split3
perl -i -pe 's|Result3134 \[\.\.\.\]|Result3134 [ Stage3AfterLap7Spotter ]|g' Dependencies.txt
echo 605 / 1866 --- Result3134 to Stage3AfterLap7Spotter
perl -i -pe 's|Result3135 \[\.\.\.\]|Result3135 [ Stage3AfterLap7Finish ]|g' Dependencies.txt
echo 606 / 1866 --- Result3135 to Stage3AfterLap7Finish
perl -i -pe 's|Result3136 \[\.\.\.\]|Result3136 [ Stage3AfterLap8Split1 ]|g' Dependencies.txt
echo 607 / 1866 --- Result3136 to Stage3AfterLap8Split1
perl -i -pe 's|Result3137 \[\.\.\.\]|Result3137 [ Stage3AfterLap8Split2 ]|g' Dependencies.txt
echo 608 / 1866 --- Result3137 to Stage3AfterLap8Split2
perl -i -pe 's|Result3138 \[\.\.\.\]|Result3138 [ Stage3AfterLap8Split3 ]|g' Dependencies.txt
echo 609 / 1866 --- Result3138 to Stage3AfterLap8Split3
perl -i -pe 's|Result3139 \[\.\.\.\]|Result3139 [ Stage3AfterLap8Spotter ]|g' Dependencies.txt
echo 610 / 1866 --- Result3139 to Stage3AfterLap8Spotter
perl -i -pe 's|Result3140 \[\.\.\.\]|Result3140 [ Stage3AfterLap8Finish ]|g' Dependencies.txt
echo 611 / 1866 --- Result3140 to Stage3AfterLap8Finish
perl -i -pe 's|Result3141 \[\.\.\.\]|Result3141 [ Stage3AfterLap9Split1 ]|g' Dependencies.txt
echo 612 / 1866 --- Result3141 to Stage3AfterLap9Split1
perl -i -pe 's|Result3142 \[\.\.\.\]|Result3142 [ Stage3AfterLap9Split2 ]|g' Dependencies.txt
echo 613 / 1866 --- Result3142 to Stage3AfterLap9Split2
perl -i -pe 's|Result3143 \[\.\.\.\]|Result3143 [ Stage3AfterLap9Split3 ]|g' Dependencies.txt
echo 614 / 1866 --- Result3143 to Stage3AfterLap9Split3
perl -i -pe 's|Result3144 \[\.\.\.\]|Result3144 [ Stage3AfterLap9Spotter ]|g' Dependencies.txt
echo 615 / 1866 --- Result3144 to Stage3AfterLap9Spotter
perl -i -pe 's|Result3145 \[\.\.\.\]|Result3145 [ Stage3AfterLap9Finish ]|g' Dependencies.txt
echo 616 / 1866 --- Result3145 to Stage3AfterLap9Finish
perl -i -pe 's|Result3146 \[\.\.\.\]|Result3146 [ Stage3AfterLap10Split1 ]|g' Dependencies.txt
echo 617 / 1866 --- Result3146 to Stage3AfterLap10Split1
perl -i -pe 's|Result3147 \[\.\.\.\]|Result3147 [ Stage3AfterLap10Split2 ]|g' Dependencies.txt
echo 618 / 1866 --- Result3147 to Stage3AfterLap10Split2
perl -i -pe 's|Result3148 \[\.\.\.\]|Result3148 [ Stage3AfterLap10Split3 ]|g' Dependencies.txt
echo 619 / 1866 --- Result3148 to Stage3AfterLap10Split3
perl -i -pe 's|Result3149 \[\.\.\.\]|Result3149 [ Stage3AfterLap10Spotter ]|g' Dependencies.txt
echo 620 / 1866 --- Result3149 to Stage3AfterLap10Spotter
perl -i -pe 's|Result3150 \[\.\.\.\]|Result3150 [ Stage3AfterLap10Finish ]|g' Dependencies.txt
echo 621 / 1866 --- Result3150 to Stage3AfterLap10Finish
perl -i -pe 's|Result3190 \[\.\.\.\]|Result3190 [ Stage3AfterFinish ]|g' Dependencies.txt
echo 622 / 1866 --- Result3190 to Stage3AfterFinish
perl -i -pe 's|Result3191 \[\.\.\.\]|Result3191 [ Stage3LastSplitID ]|g' Dependencies.txt
echo 623 / 1866 --- Result3191 to Stage3LastSplitID
perl -i -pe 's|Result3192 \[\.\.\.\]|Result3192 [ Stage3LastSplit ]|g' Dependencies.txt
echo 624 / 1866 --- Result3192 to Stage3LastSplit
perl -i -pe 's|Result3193 \[\.\.\.\]|Result3193 [ Stage3LastFinishID ]|g' Dependencies.txt
echo 625 / 1866 --- Result3193 to Stage3LastFinishID
perl -i -pe 's|Result3194 \[\.\.\.\]|Result3194 [ Stage3LastFinish ]|g' Dependencies.txt
echo 626 / 1866 --- Result3194 to Stage3LastFinish
perl -i -pe 's|Result3195 \[\.\.\.\]|Result3195 [ Stage3LastSplitBunchTime ]|g' Dependencies.txt
echo 627 / 1866 --- Result3195 to Stage3LastSplitBunchTime
perl -i -pe 's|Result3196 \[\.\.\.\]|Result3196 [ Stage3PhotoBunchTime ]|g' Dependencies.txt
echo 628 / 1866 --- Result3196 to Stage3PhotoBunchTime
perl -i -pe 's|Result3200 \[\.\.\.\]|Result3200 [ Stage3Start ]|g' Dependencies.txt
echo 629 / 1866 --- Result3200 to Stage3Start
perl -i -pe 's|Result3201 \[\.\.\.\]|Result3201 [ Stage3Lap1Split1 ]|g' Dependencies.txt
echo 630 / 1866 --- Result3201 to Stage3Lap1Split1
perl -i -pe 's|Result3202 \[\.\.\.\]|Result3202 [ Stage3Lap1Split2 ]|g' Dependencies.txt
echo 631 / 1866 --- Result3202 to Stage3Lap1Split2
perl -i -pe 's|Result3203 \[\.\.\.\]|Result3203 [ Stage3Lap1Split3 ]|g' Dependencies.txt
echo 632 / 1866 --- Result3203 to Stage3Lap1Split3
perl -i -pe 's|Result3204 \[\.\.\.\]|Result3204 [ Stage3Lap1Spotter ]|g' Dependencies.txt
echo 633 / 1866 --- Result3204 to Stage3Lap1Spotter
perl -i -pe 's|Result3205 \[\.\.\.\]|Result3205 [ Stage3Lap1Finish ]|g' Dependencies.txt
echo 634 / 1866 --- Result3205 to Stage3Lap1Finish
perl -i -pe 's|Result3206 \[\.\.\.\]|Result3206 [ Stage3Lap2Split1 ]|g' Dependencies.txt
echo 635 / 1866 --- Result3206 to Stage3Lap2Split1
perl -i -pe 's|Result3207 \[\.\.\.\]|Result3207 [ Stage3Lap2Split2 ]|g' Dependencies.txt
echo 636 / 1866 --- Result3207 to Stage3Lap2Split2
perl -i -pe 's|Result3208 \[\.\.\.\]|Result3208 [ Stage3Lap2Split3 ]|g' Dependencies.txt
echo 637 / 1866 --- Result3208 to Stage3Lap2Split3
perl -i -pe 's|Result3209 \[\.\.\.\]|Result3209 [ Stage3Lap2Spotter ]|g' Dependencies.txt
echo 638 / 1866 --- Result3209 to Stage3Lap2Spotter
perl -i -pe 's|Result3210 \[\.\.\.\]|Result3210 [ Stage3Lap2Finish ]|g' Dependencies.txt
echo 639 / 1866 --- Result3210 to Stage3Lap2Finish
perl -i -pe 's|Result3211 \[\.\.\.\]|Result3211 [ Stage3Lap3Split1 ]|g' Dependencies.txt
echo 640 / 1866 --- Result3211 to Stage3Lap3Split1
perl -i -pe 's|Result3212 \[\.\.\.\]|Result3212 [ Stage3Lap3Split2 ]|g' Dependencies.txt
echo 641 / 1866 --- Result3212 to Stage3Lap3Split2
perl -i -pe 's|Result3213 \[\.\.\.\]|Result3213 [ Stage3Lap3Split3 ]|g' Dependencies.txt
echo 642 / 1866 --- Result3213 to Stage3Lap3Split3
perl -i -pe 's|Result3214 \[\.\.\.\]|Result3214 [ Stage3Lap3Spotter ]|g' Dependencies.txt
echo 643 / 1866 --- Result3214 to Stage3Lap3Spotter
perl -i -pe 's|Result3215 \[\.\.\.\]|Result3215 [ Stage3Lap3Finish ]|g' Dependencies.txt
echo 644 / 1866 --- Result3215 to Stage3Lap3Finish
perl -i -pe 's|Result3216 \[\.\.\.\]|Result3216 [ Stage3Lap4Split1 ]|g' Dependencies.txt
echo 645 / 1866 --- Result3216 to Stage3Lap4Split1
perl -i -pe 's|Result3217 \[\.\.\.\]|Result3217 [ Stage3Lap4Split2 ]|g' Dependencies.txt
echo 646 / 1866 --- Result3217 to Stage3Lap4Split2
perl -i -pe 's|Result3218 \[\.\.\.\]|Result3218 [ Stage3Lap4Split3 ]|g' Dependencies.txt
echo 647 / 1866 --- Result3218 to Stage3Lap4Split3
perl -i -pe 's|Result3219 \[\.\.\.\]|Result3219 [ Stage3Lap4Spotter ]|g' Dependencies.txt
echo 648 / 1866 --- Result3219 to Stage3Lap4Spotter
perl -i -pe 's|Result3220 \[\.\.\.\]|Result3220 [ Stage3Lap4Finish ]|g' Dependencies.txt
echo 649 / 1866 --- Result3220 to Stage3Lap4Finish
perl -i -pe 's|Result3221 \[\.\.\.\]|Result3221 [ Stage3Lap5Split1 ]|g' Dependencies.txt
echo 650 / 1866 --- Result3221 to Stage3Lap5Split1
perl -i -pe 's|Result3222 \[\.\.\.\]|Result3222 [ Stage3Lap5Split2 ]|g' Dependencies.txt
echo 651 / 1866 --- Result3222 to Stage3Lap5Split2
perl -i -pe 's|Result3223 \[\.\.\.\]|Result3223 [ Stage3Lap5Split3 ]|g' Dependencies.txt
echo 652 / 1866 --- Result3223 to Stage3Lap5Split3
perl -i -pe 's|Result3224 \[\.\.\.\]|Result3224 [ Stage3Lap5Spotter ]|g' Dependencies.txt
echo 653 / 1866 --- Result3224 to Stage3Lap5Spotter
perl -i -pe 's|Result3225 \[\.\.\.\]|Result3225 [ Stage3Lap5Finish ]|g' Dependencies.txt
echo 654 / 1866 --- Result3225 to Stage3Lap5Finish
perl -i -pe 's|Result3226 \[\.\.\.\]|Result3226 [ Stage3Lap6Split1 ]|g' Dependencies.txt
echo 655 / 1866 --- Result3226 to Stage3Lap6Split1
perl -i -pe 's|Result3227 \[\.\.\.\]|Result3227 [ Stage3Lap6Split2 ]|g' Dependencies.txt
echo 656 / 1866 --- Result3227 to Stage3Lap6Split2
perl -i -pe 's|Result3228 \[\.\.\.\]|Result3228 [ Stage3Lap6Split3 ]|g' Dependencies.txt
echo 657 / 1866 --- Result3228 to Stage3Lap6Split3
perl -i -pe 's|Result3229 \[\.\.\.\]|Result3229 [ Stage3Lap6Spotter ]|g' Dependencies.txt
echo 658 / 1866 --- Result3229 to Stage3Lap6Spotter
perl -i -pe 's|Result3230 \[\.\.\.\]|Result3230 [ Stage3Lap6Finish ]|g' Dependencies.txt
echo 659 / 1866 --- Result3230 to Stage3Lap6Finish
perl -i -pe 's|Result3231 \[\.\.\.\]|Result3231 [ Stage3Lap7Split1 ]|g' Dependencies.txt
echo 660 / 1866 --- Result3231 to Stage3Lap7Split1
perl -i -pe 's|Result3232 \[\.\.\.\]|Result3232 [ Stage3Lap7Split2 ]|g' Dependencies.txt
echo 661 / 1866 --- Result3232 to Stage3Lap7Split2
perl -i -pe 's|Result3233 \[\.\.\.\]|Result3233 [ Stage3Lap7Split3 ]|g' Dependencies.txt
echo 662 / 1866 --- Result3233 to Stage3Lap7Split3
perl -i -pe 's|Result3234 \[\.\.\.\]|Result3234 [ Stage3Lap7Spotter ]|g' Dependencies.txt
echo 663 / 1866 --- Result3234 to Stage3Lap7Spotter
perl -i -pe 's|Result3235 \[\.\.\.\]|Result3235 [ Stage3Lap7Finish ]|g' Dependencies.txt
echo 664 / 1866 --- Result3235 to Stage3Lap7Finish
perl -i -pe 's|Result3236 \[\.\.\.\]|Result3236 [ Stage3Lap8Split1 ]|g' Dependencies.txt
echo 665 / 1866 --- Result3236 to Stage3Lap8Split1
perl -i -pe 's|Result3237 \[\.\.\.\]|Result3237 [ Stage3Lap8Split2 ]|g' Dependencies.txt
echo 666 / 1866 --- Result3237 to Stage3Lap8Split2
perl -i -pe 's|Result3238 \[\.\.\.\]|Result3238 [ Stage3Lap8Split3 ]|g' Dependencies.txt
echo 667 / 1866 --- Result3238 to Stage3Lap8Split3
perl -i -pe 's|Result3239 \[\.\.\.\]|Result3239 [ Stage3Lap8Spotter ]|g' Dependencies.txt
echo 668 / 1866 --- Result3239 to Stage3Lap8Spotter
perl -i -pe 's|Result3240 \[\.\.\.\]|Result3240 [ Stage3Lap8Finish ]|g' Dependencies.txt
echo 669 / 1866 --- Result3240 to Stage3Lap8Finish
perl -i -pe 's|Result3241 \[\.\.\.\]|Result3241 [ Stage3Lap9Split1 ]|g' Dependencies.txt
echo 670 / 1866 --- Result3241 to Stage3Lap9Split1
perl -i -pe 's|Result3242 \[\.\.\.\]|Result3242 [ Stage3Lap9Split2 ]|g' Dependencies.txt
echo 671 / 1866 --- Result3242 to Stage3Lap9Split2
perl -i -pe 's|Result3243 \[\.\.\.\]|Result3243 [ Stage3Lap9Split3 ]|g' Dependencies.txt
echo 672 / 1866 --- Result3243 to Stage3Lap9Split3
perl -i -pe 's|Result3244 \[\.\.\.\]|Result3244 [ Stage3Lap9Spotter ]|g' Dependencies.txt
echo 673 / 1866 --- Result3244 to Stage3Lap9Spotter
perl -i -pe 's|Result3245 \[\.\.\.\]|Result3245 [ Stage3Lap9Finish ]|g' Dependencies.txt
echo 674 / 1866 --- Result3245 to Stage3Lap9Finish
perl -i -pe 's|Result3246 \[\.\.\.\]|Result3246 [ Stage3Lap10Split1 ]|g' Dependencies.txt
echo 675 / 1866 --- Result3246 to Stage3Lap10Split1
perl -i -pe 's|Result3247 \[\.\.\.\]|Result3247 [ Stage3Lap10Split2 ]|g' Dependencies.txt
echo 676 / 1866 --- Result3247 to Stage3Lap10Split2
perl -i -pe 's|Result3248 \[\.\.\.\]|Result3248 [ Stage3Lap10Split3 ]|g' Dependencies.txt
echo 677 / 1866 --- Result3248 to Stage3Lap10Split3
perl -i -pe 's|Result3249 \[\.\.\.\]|Result3249 [ Stage3Lap10Spotter ]|g' Dependencies.txt
echo 678 / 1866 --- Result3249 to Stage3Lap10Spotter
perl -i -pe 's|Result3250 \[\.\.\.\]|Result3250 [ Stage3Lap10Finish ]|g' Dependencies.txt
echo 679 / 1866 --- Result3250 to Stage3Lap10Finish
perl -i -pe 's|Result3301 \[\.\.\.\]|Result3301 [ Stage3Lap1 ]|g' Dependencies.txt
echo 680 / 1866 --- Result3301 to Stage3Lap1
perl -i -pe 's|Result3302 \[\.\.\.\]|Result3302 [ Stage3Lap2 ]|g' Dependencies.txt
echo 681 / 1866 --- Result3302 to Stage3Lap2
perl -i -pe 's|Result3303 \[\.\.\.\]|Result3303 [ Stage3Lap3 ]|g' Dependencies.txt
echo 682 / 1866 --- Result3303 to Stage3Lap3
perl -i -pe 's|Result3304 \[\.\.\.\]|Result3304 [ Stage3Lap4 ]|g' Dependencies.txt
echo 683 / 1866 --- Result3304 to Stage3Lap4
perl -i -pe 's|Result3305 \[\.\.\.\]|Result3305 [ Stage3Lap5 ]|g' Dependencies.txt
echo 684 / 1866 --- Result3305 to Stage3Lap5
perl -i -pe 's|Result3306 \[\.\.\.\]|Result3306 [ Stage3Lap6 ]|g' Dependencies.txt
echo 685 / 1866 --- Result3306 to Stage3Lap6
perl -i -pe 's|Result3307 \[\.\.\.\]|Result3307 [ Stage3Lap7 ]|g' Dependencies.txt
echo 686 / 1866 --- Result3307 to Stage3Lap7
perl -i -pe 's|Result3308 \[\.\.\.\]|Result3308 [ Stage3Lap8 ]|g' Dependencies.txt
echo 687 / 1866 --- Result3308 to Stage3Lap8
perl -i -pe 's|Result3309 \[\.\.\.\]|Result3309 [ Stage3Lap9 ]|g' Dependencies.txt
echo 688 / 1866 --- Result3309 to Stage3Lap9
perl -i -pe 's|Result3310 \[\.\.\.\]|Result3310 [ Stage3Lap10 ]|g' Dependencies.txt
echo 689 / 1866 --- Result3310 to Stage3Lap10
perl -i -pe 's|Result3320 \[\.\.\.\]|Result3320 [ Stage3LapCount ]|g' Dependencies.txt
echo 690 / 1866 --- Result3320 to Stage3LapCount
perl -i -pe 's|Result3321 \[\.\.\.\]|Result3321 [ Stage3FastestLap ]|g' Dependencies.txt
echo 691 / 1866 --- Result3321 to Stage3FastestLap
perl -i -pe 's|Result3322 \[\.\.\.\]|Result3322 [ Stage3SlowestLap ]|g' Dependencies.txt
echo 692 / 1866 --- Result3322 to Stage3SlowestLap
perl -i -pe 's|Result3323 \[\.\.\.\]|Result3323 [ Stage3AverageLap ]|g' Dependencies.txt
echo 693 / 1866 --- Result3323 to Stage3AverageLap
perl -i -pe 's|Result3401 \[\.\.\.\]|Result3401 [ Stage3ParcoursStation1Points ]|g' Dependencies.txt
echo 694 / 1866 --- Result3401 to Stage3ParcoursStation1Points
perl -i -pe 's|Result3402 \[\.\.\.\]|Result3402 [ Stage3ParcoursStation2Points ]|g' Dependencies.txt
echo 695 / 1866 --- Result3402 to Stage3ParcoursStation2Points
perl -i -pe 's|Result3403 \[\.\.\.\]|Result3403 [ Stage3ParcoursStation3Points ]|g' Dependencies.txt
echo 696 / 1866 --- Result3403 to Stage3ParcoursStation3Points
perl -i -pe 's|Result3404 \[\.\.\.\]|Result3404 [ Stage3ParcoursStation4Points ]|g' Dependencies.txt
echo 697 / 1866 --- Result3404 to Stage3ParcoursStation4Points
perl -i -pe 's|Result3405 \[\.\.\.\]|Result3405 [ Stage3ParcoursStation5Points ]|g' Dependencies.txt
echo 698 / 1866 --- Result3405 to Stage3ParcoursStation5Points
perl -i -pe 's|Result3406 \[\.\.\.\]|Result3406 [ Stage3ParcoursStation6Points ]|g' Dependencies.txt
echo 699 / 1866 --- Result3406 to Stage3ParcoursStation6Points
perl -i -pe 's|Result3407 \[\.\.\.\]|Result3407 [ Stage3ParcoursStation7Points ]|g' Dependencies.txt
echo 700 / 1866 --- Result3407 to Stage3ParcoursStation7Points
perl -i -pe 's|Result3408 \[\.\.\.\]|Result3408 [ Stage3ParcoursStation8Points ]|g' Dependencies.txt
echo 701 / 1866 --- Result3408 to Stage3ParcoursStation8Points
perl -i -pe 's|Result3409 \[\.\.\.\]|Result3409 [ Stage3ParcoursStation9Points ]|g' Dependencies.txt
echo 702 / 1866 --- Result3409 to Stage3ParcoursStation9Points
perl -i -pe 's|Result3410 \[\.\.\.\]|Result3410 [ Stage3ParcoursStation10Points ]|g' Dependencies.txt
echo 703 / 1866 --- Result3410 to Stage3ParcoursStation10Points
perl -i -pe 's|Result3411 \[\.\.\.\]|Result3411 [ Stage3ParcoursStation11Points ]|g' Dependencies.txt
echo 704 / 1866 --- Result3411 to Stage3ParcoursStation11Points
perl -i -pe 's|Result3412 \[\.\.\.\]|Result3412 [ Stage3ParcoursStation12Points ]|g' Dependencies.txt
echo 705 / 1866 --- Result3412 to Stage3ParcoursStation12Points
perl -i -pe 's|Result3413 \[\.\.\.\]|Result3413 [ Stage3ParcoursStation13Points ]|g' Dependencies.txt
echo 706 / 1866 --- Result3413 to Stage3ParcoursStation13Points
perl -i -pe 's|Result3414 \[\.\.\.\]|Result3414 [ Stage3ParcoursStation14Points ]|g' Dependencies.txt
echo 707 / 1866 --- Result3414 to Stage3ParcoursStation14Points
perl -i -pe 's|Result3415 \[\.\.\.\]|Result3415 [ Stage3ParcoursStation15Points ]|g' Dependencies.txt
echo 708 / 1866 --- Result3415 to Stage3ParcoursStation15Points
perl -i -pe 's|Result3430 \[\.\.\.\]|Result3430 [ Stage3ParcoursTotalPoints ]|g' Dependencies.txt
echo 709 / 1866 --- Result3430 to Stage3ParcoursTotalPoints
perl -i -pe 's|Result3441 \[\.\.\.\]|Result3441 [ Stage3ParcoursStart ]|g' Dependencies.txt
echo 710 / 1866 --- Result3441 to Stage3ParcoursStart
perl -i -pe 's|Result3442 \[\.\.\.\]|Result3442 [ Stage3ParcoursFinish ]|g' Dependencies.txt
echo 711 / 1866 --- Result3442 to Stage3ParcoursFinish
perl -i -pe 's|Result3450 \[\.\.\.\]|Result3450 [ Stage3ParcoursTime ]|g' Dependencies.txt
echo 712 / 1866 --- Result3450 to Stage3ParcoursTime
perl -i -pe 's|Result3501 \[\.\.\.\]|Result3501 [ Stage3ParcoursRankingPoints ]|g' Dependencies.txt
echo 713 / 1866 --- Result3501 to Stage3ParcoursRankingPoints
perl -i -pe 's|Result3502 \[\.\.\.\]|Result3502 [ Stage3CrossCountryRankingPoints ]|g' Dependencies.txt
echo 714 / 1866 --- Result3502 to Stage3CrossCountryRankingPoints
perl -i -pe 's|Result3503 \[\.\.\.\]|Result3503 [ Stage3TotalRankingPoints ]|g' Dependencies.txt
echo 715 / 1866 --- Result3503 to Stage3TotalRankingPoints
perl -i -pe 's|Result3611 \[\.\.\.\]|Result3611 [ Stage3Lap1Sector1 ]|g' Dependencies.txt
echo 716 / 1866 --- Result3611 to Stage3Lap1Sector1
perl -i -pe 's|Result3612 \[\.\.\.\]|Result3612 [ Stage3Lap2Sector1 ]|g' Dependencies.txt
echo 717 / 1866 --- Result3612 to Stage3Lap2Sector1
perl -i -pe 's|Result3613 \[\.\.\.\]|Result3613 [ Stage3Lap3Sector1 ]|g' Dependencies.txt
echo 718 / 1866 --- Result3613 to Stage3Lap3Sector1
perl -i -pe 's|Result3614 \[\.\.\.\]|Result3614 [ Stage3Lap4Sector1 ]|g' Dependencies.txt
echo 719 / 1866 --- Result3614 to Stage3Lap4Sector1
perl -i -pe 's|Result3615 \[\.\.\.\]|Result3615 [ Stage3Lap5Sector1 ]|g' Dependencies.txt
echo 720 / 1866 --- Result3615 to Stage3Lap5Sector1
perl -i -pe 's|Result3616 \[\.\.\.\]|Result3616 [ Stage3Lap6Sector1 ]|g' Dependencies.txt
echo 721 / 1866 --- Result3616 to Stage3Lap6Sector1
perl -i -pe 's|Result3617 \[\.\.\.\]|Result3617 [ Stage3Lap7Sector1 ]|g' Dependencies.txt
echo 722 / 1866 --- Result3617 to Stage3Lap7Sector1
perl -i -pe 's|Result3618 \[\.\.\.\]|Result3618 [ Stage3Lap8Sector1 ]|g' Dependencies.txt
echo 723 / 1866 --- Result3618 to Stage3Lap8Sector1
perl -i -pe 's|Result3619 \[\.\.\.\]|Result3619 [ Stage3Lap9Sector1 ]|g' Dependencies.txt
echo 724 / 1866 --- Result3619 to Stage3Lap9Sector1
perl -i -pe 's|Result3620 \[\.\.\.\]|Result3620 [ Stage3Lap10Sector1 ]|g' Dependencies.txt
echo 725 / 1866 --- Result3620 to Stage3Lap10Sector1
perl -i -pe 's|Result3621 \[\.\.\.\]|Result3621 [ Stage3Lap1Sector2 ]|g' Dependencies.txt
echo 726 / 1866 --- Result3621 to Stage3Lap1Sector2
perl -i -pe 's|Result3622 \[\.\.\.\]|Result3622 [ Stage3Lap2Sector2 ]|g' Dependencies.txt
echo 727 / 1866 --- Result3622 to Stage3Lap2Sector2
perl -i -pe 's|Result3623 \[\.\.\.\]|Result3623 [ Stage3Lap3Sector2 ]|g' Dependencies.txt
echo 728 / 1866 --- Result3623 to Stage3Lap3Sector2
perl -i -pe 's|Result3624 \[\.\.\.\]|Result3624 [ Stage3Lap4Sector2 ]|g' Dependencies.txt
echo 729 / 1866 --- Result3624 to Stage3Lap4Sector2
perl -i -pe 's|Result3625 \[\.\.\.\]|Result3625 [ Stage3Lap5Sector2 ]|g' Dependencies.txt
echo 730 / 1866 --- Result3625 to Stage3Lap5Sector2
perl -i -pe 's|Result3626 \[\.\.\.\]|Result3626 [ Stage3Lap6Sector2 ]|g' Dependencies.txt
echo 731 / 1866 --- Result3626 to Stage3Lap6Sector2
perl -i -pe 's|Result3627 \[\.\.\.\]|Result3627 [ Stage3Lap7Sector2 ]|g' Dependencies.txt
echo 732 / 1866 --- Result3627 to Stage3Lap7Sector2
perl -i -pe 's|Result3628 \[\.\.\.\]|Result3628 [ Stage3Lap8Sector2 ]|g' Dependencies.txt
echo 733 / 1866 --- Result3628 to Stage3Lap8Sector2
perl -i -pe 's|Result3629 \[\.\.\.\]|Result3629 [ Stage3Lap9Sector2 ]|g' Dependencies.txt
echo 734 / 1866 --- Result3629 to Stage3Lap9Sector2
perl -i -pe 's|Result3630 \[\.\.\.\]|Result3630 [ Stage3Lap10Sector2 ]|g' Dependencies.txt
echo 735 / 1866 --- Result3630 to Stage3Lap10Sector2
perl -i -pe 's|Result3631 \[\.\.\.\]|Result3631 [ Stage3Lap1Sector3 ]|g' Dependencies.txt
echo 736 / 1866 --- Result3631 to Stage3Lap1Sector3
perl -i -pe 's|Result3632 \[\.\.\.\]|Result3632 [ Stage3Lap2Sector3 ]|g' Dependencies.txt
echo 737 / 1866 --- Result3632 to Stage3Lap2Sector3
perl -i -pe 's|Result3633 \[\.\.\.\]|Result3633 [ Stage3Lap3Sector3 ]|g' Dependencies.txt
echo 738 / 1866 --- Result3633 to Stage3Lap3Sector3
perl -i -pe 's|Result3634 \[\.\.\.\]|Result3634 [ Stage3Lap4Sector3 ]|g' Dependencies.txt
echo 739 / 1866 --- Result3634 to Stage3Lap4Sector3
perl -i -pe 's|Result3635 \[\.\.\.\]|Result3635 [ Stage3Lap5Sector3 ]|g' Dependencies.txt
echo 740 / 1866 --- Result3635 to Stage3Lap5Sector3
perl -i -pe 's|Result3636 \[\.\.\.\]|Result3636 [ Stage3Lap6Sector3 ]|g' Dependencies.txt
echo 741 / 1866 --- Result3636 to Stage3Lap6Sector3
perl -i -pe 's|Result3637 \[\.\.\.\]|Result3637 [ Stage3Lap7Sector3 ]|g' Dependencies.txt
echo 742 / 1866 --- Result3637 to Stage3Lap7Sector3
perl -i -pe 's|Result3638 \[\.\.\.\]|Result3638 [ Stage3Lap8Sector3 ]|g' Dependencies.txt
echo 743 / 1866 --- Result3638 to Stage3Lap8Sector3
perl -i -pe 's|Result3639 \[\.\.\.\]|Result3639 [ Stage3Lap9Sector3 ]|g' Dependencies.txt
echo 744 / 1866 --- Result3639 to Stage3Lap9Sector3
perl -i -pe 's|Result3640 \[\.\.\.\]|Result3640 [ Stage3Lap10Sector3 ]|g' Dependencies.txt
echo 745 / 1866 --- Result3640 to Stage3Lap10Sector3
perl -i -pe 's|Result3641 \[\.\.\.\]|Result3641 [ Stage3Lap1Sector4 ]|g' Dependencies.txt
echo 746 / 1866 --- Result3641 to Stage3Lap1Sector4
perl -i -pe 's|Result3642 \[\.\.\.\]|Result3642 [ Stage3Lap2Sector4 ]|g' Dependencies.txt
echo 747 / 1866 --- Result3642 to Stage3Lap2Sector4
perl -i -pe 's|Result3643 \[\.\.\.\]|Result3643 [ Stage3Lap3Sector4 ]|g' Dependencies.txt
echo 748 / 1866 --- Result3643 to Stage3Lap3Sector4
perl -i -pe 's|Result3644 \[\.\.\.\]|Result3644 [ Stage3Lap4Sector4 ]|g' Dependencies.txt
echo 749 / 1866 --- Result3644 to Stage3Lap4Sector4
perl -i -pe 's|Result3645 \[\.\.\.\]|Result3645 [ Stage3Lap5Sector4 ]|g' Dependencies.txt
echo 750 / 1866 --- Result3645 to Stage3Lap5Sector4
perl -i -pe 's|Result3646 \[\.\.\.\]|Result3646 [ Stage3Lap6Sector4 ]|g' Dependencies.txt
echo 751 / 1866 --- Result3646 to Stage3Lap6Sector4
perl -i -pe 's|Result3647 \[\.\.\.\]|Result3647 [ Stage3Lap7Sector4 ]|g' Dependencies.txt
echo 752 / 1866 --- Result3647 to Stage3Lap7Sector4
perl -i -pe 's|Result3648 \[\.\.\.\]|Result3648 [ Stage3Lap8Sector4 ]|g' Dependencies.txt
echo 753 / 1866 --- Result3648 to Stage3Lap8Sector4
perl -i -pe 's|Result3649 \[\.\.\.\]|Result3649 [ Stage3Lap9Sector4 ]|g' Dependencies.txt
echo 754 / 1866 --- Result3649 to Stage3Lap9Sector4
perl -i -pe 's|Result3650 \[\.\.\.\]|Result3650 [ Stage3Lap10Sector4 ]|g' Dependencies.txt
echo 755 / 1866 --- Result3650 to Stage3Lap10Sector4
perl -i -pe 's|Result3651 \[\.\.\.\]|Result3651 [ Stage3Lap1UphillSector ]|g' Dependencies.txt
echo 756 / 1866 --- Result3651 to Stage3Lap1UphillSector
perl -i -pe 's|Result3652 \[\.\.\.\]|Result3652 [ Stage3Lap2UphillSector ]|g' Dependencies.txt
echo 757 / 1866 --- Result3652 to Stage3Lap2UphillSector
perl -i -pe 's|Result3653 \[\.\.\.\]|Result3653 [ Stage3Lap3UphillSector ]|g' Dependencies.txt
echo 758 / 1866 --- Result3653 to Stage3Lap3UphillSector
perl -i -pe 's|Result3654 \[\.\.\.\]|Result3654 [ Stage3Lap4UphillSector ]|g' Dependencies.txt
echo 759 / 1866 --- Result3654 to Stage3Lap4UphillSector
perl -i -pe 's|Result3655 \[\.\.\.\]|Result3655 [ Stage3Lap5UphillSector ]|g' Dependencies.txt
echo 760 / 1866 --- Result3655 to Stage3Lap5UphillSector
perl -i -pe 's|Result3656 \[\.\.\.\]|Result3656 [ Stage3Lap6UphillSector ]|g' Dependencies.txt
echo 761 / 1866 --- Result3656 to Stage3Lap6UphillSector
perl -i -pe 's|Result3657 \[\.\.\.\]|Result3657 [ Stage3Lap7UphillSector ]|g' Dependencies.txt
echo 762 / 1866 --- Result3657 to Stage3Lap7UphillSector
perl -i -pe 's|Result3658 \[\.\.\.\]|Result3658 [ Stage3Lap8UphillSector ]|g' Dependencies.txt
echo 763 / 1866 --- Result3658 to Stage3Lap8UphillSector
perl -i -pe 's|Result3659 \[\.\.\.\]|Result3659 [ Stage3Lap9UphillSector ]|g' Dependencies.txt
echo 764 / 1866 --- Result3659 to Stage3Lap9UphillSector
perl -i -pe 's|Result3660 \[\.\.\.\]|Result3660 [ Stage3Lap10UphillSector ]|g' Dependencies.txt
echo 765 / 1866 --- Result3660 to Stage3Lap10UphillSector
perl -i -pe 's|Result3680 \[\.\.\.\]|Result3680 [ Stage3FastestUphillSector ]|g' Dependencies.txt
echo 766 / 1866 --- Result3680 to Stage3FastestUphillSector
perl -i -pe 's|Result3681 \[\.\.\.\]|Result3681 [ Stage3FastestUphillSectorID ]|g' Dependencies.txt
echo 767 / 1866 --- Result3681 to Stage3FastestUphillSectorID
perl -i -pe 's|Result4000 \[\.\.\.\]|Result4000 [ Stage4StartTime ]|g' Dependencies.txt
echo 768 / 1866 --- Result4000 to Stage4StartTime
perl -i -pe 's|Result4001 \[\.\.\.\]|Result4001 [ Stage4FinishTimeLimit ]|g' Dependencies.txt
echo 769 / 1866 --- Result4001 to Stage4FinishTimeLimit
perl -i -pe 's|Result4100 \[\.\.\.\]|Result4100 [ Stage4Started ]|g' Dependencies.txt
echo 770 / 1866 --- Result4100 to Stage4Started
perl -i -pe 's|Result4101 \[\.\.\.\]|Result4101 [ Stage4AfterLap1Split1 ]|g' Dependencies.txt
echo 771 / 1866 --- Result4101 to Stage4AfterLap1Split1
perl -i -pe 's|Result4102 \[\.\.\.\]|Result4102 [ Stage4AfterLap1Split2 ]|g' Dependencies.txt
echo 772 / 1866 --- Result4102 to Stage4AfterLap1Split2
perl -i -pe 's|Result4103 \[\.\.\.\]|Result4103 [ Stage4AfterLap1Split3 ]|g' Dependencies.txt
echo 773 / 1866 --- Result4103 to Stage4AfterLap1Split3
perl -i -pe 's|Result4104 \[\.\.\.\]|Result4104 [ Stage4AfterLap1Spotter ]|g' Dependencies.txt
echo 774 / 1866 --- Result4104 to Stage4AfterLap1Spotter
perl -i -pe 's|Result4105 \[\.\.\.\]|Result4105 [ Stage4AfterLap1Finish ]|g' Dependencies.txt
echo 775 / 1866 --- Result4105 to Stage4AfterLap1Finish
perl -i -pe 's|Result4106 \[\.\.\.\]|Result4106 [ Stage4AfterLap2Split1 ]|g' Dependencies.txt
echo 776 / 1866 --- Result4106 to Stage4AfterLap2Split1
perl -i -pe 's|Result4107 \[\.\.\.\]|Result4107 [ Stage4AfterLap2Split2 ]|g' Dependencies.txt
echo 777 / 1866 --- Result4107 to Stage4AfterLap2Split2
perl -i -pe 's|Result4108 \[\.\.\.\]|Result4108 [ Stage4AfterLap2Split3 ]|g' Dependencies.txt
echo 778 / 1866 --- Result4108 to Stage4AfterLap2Split3
perl -i -pe 's|Result4109 \[\.\.\.\]|Result4109 [ Stage4AfterLap2Spotter ]|g' Dependencies.txt
echo 779 / 1866 --- Result4109 to Stage4AfterLap2Spotter
perl -i -pe 's|Result4110 \[\.\.\.\]|Result4110 [ Stage4AfterLap2Finish ]|g' Dependencies.txt
echo 780 / 1866 --- Result4110 to Stage4AfterLap2Finish
perl -i -pe 's|Result4111 \[\.\.\.\]|Result4111 [ Stage4AfterLap3Split1 ]|g' Dependencies.txt
echo 781 / 1866 --- Result4111 to Stage4AfterLap3Split1
perl -i -pe 's|Result4112 \[\.\.\.\]|Result4112 [ Stage4AfterLap3Split2 ]|g' Dependencies.txt
echo 782 / 1866 --- Result4112 to Stage4AfterLap3Split2
perl -i -pe 's|Result4113 \[\.\.\.\]|Result4113 [ Stage4AfterLap3Split3 ]|g' Dependencies.txt
echo 783 / 1866 --- Result4113 to Stage4AfterLap3Split3
perl -i -pe 's|Result4114 \[\.\.\.\]|Result4114 [ Stage4AfterLap3Spotter ]|g' Dependencies.txt
echo 784 / 1866 --- Result4114 to Stage4AfterLap3Spotter
perl -i -pe 's|Result4115 \[\.\.\.\]|Result4115 [ Stage4AfterLap3Finish ]|g' Dependencies.txt
echo 785 / 1866 --- Result4115 to Stage4AfterLap3Finish
perl -i -pe 's|Result4116 \[\.\.\.\]|Result4116 [ Stage4AfterLap4Split1 ]|g' Dependencies.txt
echo 786 / 1866 --- Result4116 to Stage4AfterLap4Split1
perl -i -pe 's|Result4117 \[\.\.\.\]|Result4117 [ Stage4AfterLap4Split2 ]|g' Dependencies.txt
echo 787 / 1866 --- Result4117 to Stage4AfterLap4Split2
perl -i -pe 's|Result4118 \[\.\.\.\]|Result4118 [ Stage4AfterLap4Split3 ]|g' Dependencies.txt
echo 788 / 1866 --- Result4118 to Stage4AfterLap4Split3
perl -i -pe 's|Result4119 \[\.\.\.\]|Result4119 [ Stage4AfterLap4Spotter ]|g' Dependencies.txt
echo 789 / 1866 --- Result4119 to Stage4AfterLap4Spotter
perl -i -pe 's|Result4120 \[\.\.\.\]|Result4120 [ Stage4AfterLap4Finish ]|g' Dependencies.txt
echo 790 / 1866 --- Result4120 to Stage4AfterLap4Finish
perl -i -pe 's|Result4121 \[\.\.\.\]|Result4121 [ Stage4AfterLap5Split1 ]|g' Dependencies.txt
echo 791 / 1866 --- Result4121 to Stage4AfterLap5Split1
perl -i -pe 's|Result4122 \[\.\.\.\]|Result4122 [ Stage4AfterLap5Split2 ]|g' Dependencies.txt
echo 792 / 1866 --- Result4122 to Stage4AfterLap5Split2
perl -i -pe 's|Result4123 \[\.\.\.\]|Result4123 [ Stage4AfterLap5Split3 ]|g' Dependencies.txt
echo 793 / 1866 --- Result4123 to Stage4AfterLap5Split3
perl -i -pe 's|Result4124 \[\.\.\.\]|Result4124 [ Stage4AfterLap5Spotter ]|g' Dependencies.txt
echo 794 / 1866 --- Result4124 to Stage4AfterLap5Spotter
perl -i -pe 's|Result4125 \[\.\.\.\]|Result4125 [ Stage4AfterLap5Finish ]|g' Dependencies.txt
echo 795 / 1866 --- Result4125 to Stage4AfterLap5Finish
perl -i -pe 's|Result4126 \[\.\.\.\]|Result4126 [ Stage4AfterLap6Split1 ]|g' Dependencies.txt
echo 796 / 1866 --- Result4126 to Stage4AfterLap6Split1
perl -i -pe 's|Result4127 \[\.\.\.\]|Result4127 [ Stage4AfterLap6Split2 ]|g' Dependencies.txt
echo 797 / 1866 --- Result4127 to Stage4AfterLap6Split2
perl -i -pe 's|Result4128 \[\.\.\.\]|Result4128 [ Stage4AfterLap6Split3 ]|g' Dependencies.txt
echo 798 / 1866 --- Result4128 to Stage4AfterLap6Split3
perl -i -pe 's|Result4129 \[\.\.\.\]|Result4129 [ Stage4AfterLap6Spotter ]|g' Dependencies.txt
echo 799 / 1866 --- Result4129 to Stage4AfterLap6Spotter
perl -i -pe 's|Result4130 \[\.\.\.\]|Result4130 [ Stage4AfterLap6Finish ]|g' Dependencies.txt
echo 800 / 1866 --- Result4130 to Stage4AfterLap6Finish
perl -i -pe 's|Result4131 \[\.\.\.\]|Result4131 [ Stage4AfterLap7Split1 ]|g' Dependencies.txt
echo 801 / 1866 --- Result4131 to Stage4AfterLap7Split1
perl -i -pe 's|Result4132 \[\.\.\.\]|Result4132 [ Stage4AfterLap7Split2 ]|g' Dependencies.txt
echo 802 / 1866 --- Result4132 to Stage4AfterLap7Split2
perl -i -pe 's|Result4133 \[\.\.\.\]|Result4133 [ Stage4AfterLap7Split3 ]|g' Dependencies.txt
echo 803 / 1866 --- Result4133 to Stage4AfterLap7Split3
perl -i -pe 's|Result4134 \[\.\.\.\]|Result4134 [ Stage4AfterLap7Spotter ]|g' Dependencies.txt
echo 804 / 1866 --- Result4134 to Stage4AfterLap7Spotter
perl -i -pe 's|Result4135 \[\.\.\.\]|Result4135 [ Stage4AfterLap7Finish ]|g' Dependencies.txt
echo 805 / 1866 --- Result4135 to Stage4AfterLap7Finish
perl -i -pe 's|Result4136 \[\.\.\.\]|Result4136 [ Stage4AfterLap8Split1 ]|g' Dependencies.txt
echo 806 / 1866 --- Result4136 to Stage4AfterLap8Split1
perl -i -pe 's|Result4137 \[\.\.\.\]|Result4137 [ Stage4AfterLap8Split2 ]|g' Dependencies.txt
echo 807 / 1866 --- Result4137 to Stage4AfterLap8Split2
perl -i -pe 's|Result4138 \[\.\.\.\]|Result4138 [ Stage4AfterLap8Split3 ]|g' Dependencies.txt
echo 808 / 1866 --- Result4138 to Stage4AfterLap8Split3
perl -i -pe 's|Result4139 \[\.\.\.\]|Result4139 [ Stage4AfterLap8Spotter ]|g' Dependencies.txt
echo 809 / 1866 --- Result4139 to Stage4AfterLap8Spotter
perl -i -pe 's|Result4140 \[\.\.\.\]|Result4140 [ Stage4AfterLap8Finish ]|g' Dependencies.txt
echo 810 / 1866 --- Result4140 to Stage4AfterLap8Finish
perl -i -pe 's|Result4141 \[\.\.\.\]|Result4141 [ Stage4AfterLap9Split1 ]|g' Dependencies.txt
echo 811 / 1866 --- Result4141 to Stage4AfterLap9Split1
perl -i -pe 's|Result4142 \[\.\.\.\]|Result4142 [ Stage4AfterLap9Split2 ]|g' Dependencies.txt
echo 812 / 1866 --- Result4142 to Stage4AfterLap9Split2
perl -i -pe 's|Result4143 \[\.\.\.\]|Result4143 [ Stage4AfterLap9Split3 ]|g' Dependencies.txt
echo 813 / 1866 --- Result4143 to Stage4AfterLap9Split3
perl -i -pe 's|Result4144 \[\.\.\.\]|Result4144 [ Stage4AfterLap9Spotter ]|g' Dependencies.txt
echo 814 / 1866 --- Result4144 to Stage4AfterLap9Spotter
perl -i -pe 's|Result4145 \[\.\.\.\]|Result4145 [ Stage4AfterLap9Finish ]|g' Dependencies.txt
echo 815 / 1866 --- Result4145 to Stage4AfterLap9Finish
perl -i -pe 's|Result4146 \[\.\.\.\]|Result4146 [ Stage4AfterLap10Split1 ]|g' Dependencies.txt
echo 816 / 1866 --- Result4146 to Stage4AfterLap10Split1
perl -i -pe 's|Result4147 \[\.\.\.\]|Result4147 [ Stage4AfterLap10Split2 ]|g' Dependencies.txt
echo 817 / 1866 --- Result4147 to Stage4AfterLap10Split2
perl -i -pe 's|Result4148 \[\.\.\.\]|Result4148 [ Stage4AfterLap10Split3 ]|g' Dependencies.txt
echo 818 / 1866 --- Result4148 to Stage4AfterLap10Split3
perl -i -pe 's|Result4149 \[\.\.\.\]|Result4149 [ Stage4AfterLap10Spotter ]|g' Dependencies.txt
echo 819 / 1866 --- Result4149 to Stage4AfterLap10Spotter
perl -i -pe 's|Result4150 \[\.\.\.\]|Result4150 [ Stage4AfterLap10Finish ]|g' Dependencies.txt
echo 820 / 1866 --- Result4150 to Stage4AfterLap10Finish
perl -i -pe 's|Result4190 \[\.\.\.\]|Result4190 [ Stage4AfterFinish ]|g' Dependencies.txt
echo 821 / 1866 --- Result4190 to Stage4AfterFinish
perl -i -pe 's|Result4191 \[\.\.\.\]|Result4191 [ Stage4LastSplitID ]|g' Dependencies.txt
echo 822 / 1866 --- Result4191 to Stage4LastSplitID
perl -i -pe 's|Result4192 \[\.\.\.\]|Result4192 [ Stage4LastSplit ]|g' Dependencies.txt
echo 823 / 1866 --- Result4192 to Stage4LastSplit
perl -i -pe 's|Result4193 \[\.\.\.\]|Result4193 [ Stage4LastFinishID ]|g' Dependencies.txt
echo 824 / 1866 --- Result4193 to Stage4LastFinishID
perl -i -pe 's|Result4194 \[\.\.\.\]|Result4194 [ Stage4LastFinish ]|g' Dependencies.txt
echo 825 / 1866 --- Result4194 to Stage4LastFinish
perl -i -pe 's|Result4195 \[\.\.\.\]|Result4195 [ Stage4LastSplitBunchTime ]|g' Dependencies.txt
echo 826 / 1866 --- Result4195 to Stage4LastSplitBunchTime
perl -i -pe 's|Result4196 \[\.\.\.\]|Result4196 [ Stage4PhotoBunchTime ]|g' Dependencies.txt
echo 827 / 1866 --- Result4196 to Stage4PhotoBunchTime
perl -i -pe 's|Result4200 \[\.\.\.\]|Result4200 [ Stage4Start ]|g' Dependencies.txt
echo 828 / 1866 --- Result4200 to Stage4Start
perl -i -pe 's|Result4201 \[\.\.\.\]|Result4201 [ Stage4Lap1Split1 ]|g' Dependencies.txt
echo 829 / 1866 --- Result4201 to Stage4Lap1Split1
perl -i -pe 's|Result4202 \[\.\.\.\]|Result4202 [ Stage4Lap1Split2 ]|g' Dependencies.txt
echo 830 / 1866 --- Result4202 to Stage4Lap1Split2
perl -i -pe 's|Result4203 \[\.\.\.\]|Result4203 [ Stage4Lap1Split3 ]|g' Dependencies.txt
echo 831 / 1866 --- Result4203 to Stage4Lap1Split3
perl -i -pe 's|Result4204 \[\.\.\.\]|Result4204 [ Stage4Lap1Spotter ]|g' Dependencies.txt
echo 832 / 1866 --- Result4204 to Stage4Lap1Spotter
perl -i -pe 's|Result4205 \[\.\.\.\]|Result4205 [ Stage4Lap1Finish ]|g' Dependencies.txt
echo 833 / 1866 --- Result4205 to Stage4Lap1Finish
perl -i -pe 's|Result4206 \[\.\.\.\]|Result4206 [ Stage4Lap2Split1 ]|g' Dependencies.txt
echo 834 / 1866 --- Result4206 to Stage4Lap2Split1
perl -i -pe 's|Result4207 \[\.\.\.\]|Result4207 [ Stage4Lap2Split2 ]|g' Dependencies.txt
echo 835 / 1866 --- Result4207 to Stage4Lap2Split2
perl -i -pe 's|Result4208 \[\.\.\.\]|Result4208 [ Stage4Lap2Split3 ]|g' Dependencies.txt
echo 836 / 1866 --- Result4208 to Stage4Lap2Split3
perl -i -pe 's|Result4209 \[\.\.\.\]|Result4209 [ Stage4Lap2Spotter ]|g' Dependencies.txt
echo 837 / 1866 --- Result4209 to Stage4Lap2Spotter
perl -i -pe 's|Result4210 \[\.\.\.\]|Result4210 [ Stage4Lap2Finish ]|g' Dependencies.txt
echo 838 / 1866 --- Result4210 to Stage4Lap2Finish
perl -i -pe 's|Result4211 \[\.\.\.\]|Result4211 [ Stage4Lap3Split1 ]|g' Dependencies.txt
echo 839 / 1866 --- Result4211 to Stage4Lap3Split1
perl -i -pe 's|Result4212 \[\.\.\.\]|Result4212 [ Stage4Lap3Split2 ]|g' Dependencies.txt
echo 840 / 1866 --- Result4212 to Stage4Lap3Split2
perl -i -pe 's|Result4213 \[\.\.\.\]|Result4213 [ Stage4Lap3Split3 ]|g' Dependencies.txt
echo 841 / 1866 --- Result4213 to Stage4Lap3Split3
perl -i -pe 's|Result4214 \[\.\.\.\]|Result4214 [ Stage4Lap3Spotter ]|g' Dependencies.txt
echo 842 / 1866 --- Result4214 to Stage4Lap3Spotter
perl -i -pe 's|Result4215 \[\.\.\.\]|Result4215 [ Stage4Lap3Finish ]|g' Dependencies.txt
echo 843 / 1866 --- Result4215 to Stage4Lap3Finish
perl -i -pe 's|Result4216 \[\.\.\.\]|Result4216 [ Stage4Lap4Split1 ]|g' Dependencies.txt
echo 844 / 1866 --- Result4216 to Stage4Lap4Split1
perl -i -pe 's|Result4217 \[\.\.\.\]|Result4217 [ Stage4Lap4Split2 ]|g' Dependencies.txt
echo 845 / 1866 --- Result4217 to Stage4Lap4Split2
perl -i -pe 's|Result4218 \[\.\.\.\]|Result4218 [ Stage4Lap4Split3 ]|g' Dependencies.txt
echo 846 / 1866 --- Result4218 to Stage4Lap4Split3
perl -i -pe 's|Result4219 \[\.\.\.\]|Result4219 [ Stage4Lap4Spotter ]|g' Dependencies.txt
echo 847 / 1866 --- Result4219 to Stage4Lap4Spotter
perl -i -pe 's|Result4220 \[\.\.\.\]|Result4220 [ Stage4Lap4Finish ]|g' Dependencies.txt
echo 848 / 1866 --- Result4220 to Stage4Lap4Finish
perl -i -pe 's|Result4221 \[\.\.\.\]|Result4221 [ Stage4Lap5Split1 ]|g' Dependencies.txt
echo 849 / 1866 --- Result4221 to Stage4Lap5Split1
perl -i -pe 's|Result4222 \[\.\.\.\]|Result4222 [ Stage4Lap5Split2 ]|g' Dependencies.txt
echo 850 / 1866 --- Result4222 to Stage4Lap5Split2
perl -i -pe 's|Result4223 \[\.\.\.\]|Result4223 [ Stage4Lap5Split3 ]|g' Dependencies.txt
echo 851 / 1866 --- Result4223 to Stage4Lap5Split3
perl -i -pe 's|Result4224 \[\.\.\.\]|Result4224 [ Stage4Lap5Spotter ]|g' Dependencies.txt
echo 852 / 1866 --- Result4224 to Stage4Lap5Spotter
perl -i -pe 's|Result4225 \[\.\.\.\]|Result4225 [ Stage4Lap5Finish ]|g' Dependencies.txt
echo 853 / 1866 --- Result4225 to Stage4Lap5Finish
perl -i -pe 's|Result4226 \[\.\.\.\]|Result4226 [ Stage4Lap6Split1 ]|g' Dependencies.txt
echo 854 / 1866 --- Result4226 to Stage4Lap6Split1
perl -i -pe 's|Result4227 \[\.\.\.\]|Result4227 [ Stage4Lap6Split2 ]|g' Dependencies.txt
echo 855 / 1866 --- Result4227 to Stage4Lap6Split2
perl -i -pe 's|Result4228 \[\.\.\.\]|Result4228 [ Stage4Lap6Split3 ]|g' Dependencies.txt
echo 856 / 1866 --- Result4228 to Stage4Lap6Split3
perl -i -pe 's|Result4229 \[\.\.\.\]|Result4229 [ Stage4Lap6Spotter ]|g' Dependencies.txt
echo 857 / 1866 --- Result4229 to Stage4Lap6Spotter
perl -i -pe 's|Result4230 \[\.\.\.\]|Result4230 [ Stage4Lap6Finish ]|g' Dependencies.txt
echo 858 / 1866 --- Result4230 to Stage4Lap6Finish
perl -i -pe 's|Result4231 \[\.\.\.\]|Result4231 [ Stage4Lap7Split1 ]|g' Dependencies.txt
echo 859 / 1866 --- Result4231 to Stage4Lap7Split1
perl -i -pe 's|Result4232 \[\.\.\.\]|Result4232 [ Stage4Lap7Split2 ]|g' Dependencies.txt
echo 860 / 1866 --- Result4232 to Stage4Lap7Split2
perl -i -pe 's|Result4233 \[\.\.\.\]|Result4233 [ Stage4Lap7Split3 ]|g' Dependencies.txt
echo 861 / 1866 --- Result4233 to Stage4Lap7Split3
perl -i -pe 's|Result4234 \[\.\.\.\]|Result4234 [ Stage4Lap7Spotter ]|g' Dependencies.txt
echo 862 / 1866 --- Result4234 to Stage4Lap7Spotter
perl -i -pe 's|Result4235 \[\.\.\.\]|Result4235 [ Stage4Lap7Finish ]|g' Dependencies.txt
echo 863 / 1866 --- Result4235 to Stage4Lap7Finish
perl -i -pe 's|Result4236 \[\.\.\.\]|Result4236 [ Stage4Lap8Split1 ]|g' Dependencies.txt
echo 864 / 1866 --- Result4236 to Stage4Lap8Split1
perl -i -pe 's|Result4237 \[\.\.\.\]|Result4237 [ Stage4Lap8Split2 ]|g' Dependencies.txt
echo 865 / 1866 --- Result4237 to Stage4Lap8Split2
perl -i -pe 's|Result4238 \[\.\.\.\]|Result4238 [ Stage4Lap8Split3 ]|g' Dependencies.txt
echo 866 / 1866 --- Result4238 to Stage4Lap8Split3
perl -i -pe 's|Result4239 \[\.\.\.\]|Result4239 [ Stage4Lap8Spotter ]|g' Dependencies.txt
echo 867 / 1866 --- Result4239 to Stage4Lap8Spotter
perl -i -pe 's|Result4240 \[\.\.\.\]|Result4240 [ Stage4Lap8Finish ]|g' Dependencies.txt
echo 868 / 1866 --- Result4240 to Stage4Lap8Finish
perl -i -pe 's|Result4241 \[\.\.\.\]|Result4241 [ Stage4Lap9Split1 ]|g' Dependencies.txt
echo 869 / 1866 --- Result4241 to Stage4Lap9Split1
perl -i -pe 's|Result4242 \[\.\.\.\]|Result4242 [ Stage4Lap9Split2 ]|g' Dependencies.txt
echo 870 / 1866 --- Result4242 to Stage4Lap9Split2
perl -i -pe 's|Result4243 \[\.\.\.\]|Result4243 [ Stage4Lap9Split3 ]|g' Dependencies.txt
echo 871 / 1866 --- Result4243 to Stage4Lap9Split3
perl -i -pe 's|Result4244 \[\.\.\.\]|Result4244 [ Stage4Lap9Spotter ]|g' Dependencies.txt
echo 872 / 1866 --- Result4244 to Stage4Lap9Spotter
perl -i -pe 's|Result4245 \[\.\.\.\]|Result4245 [ Stage4Lap9Finish ]|g' Dependencies.txt
echo 873 / 1866 --- Result4245 to Stage4Lap9Finish
perl -i -pe 's|Result4246 \[\.\.\.\]|Result4246 [ Stage4Lap10Split1 ]|g' Dependencies.txt
echo 874 / 1866 --- Result4246 to Stage4Lap10Split1
perl -i -pe 's|Result4247 \[\.\.\.\]|Result4247 [ Stage4Lap10Split2 ]|g' Dependencies.txt
echo 875 / 1866 --- Result4247 to Stage4Lap10Split2
perl -i -pe 's|Result4248 \[\.\.\.\]|Result4248 [ Stage4Lap10Split3 ]|g' Dependencies.txt
echo 876 / 1866 --- Result4248 to Stage4Lap10Split3
perl -i -pe 's|Result4249 \[\.\.\.\]|Result4249 [ Stage4Lap10Spotter ]|g' Dependencies.txt
echo 877 / 1866 --- Result4249 to Stage4Lap10Spotter
perl -i -pe 's|Result4250 \[\.\.\.\]|Result4250 [ Stage4Lap10Finish ]|g' Dependencies.txt
echo 878 / 1866 --- Result4250 to Stage4Lap10Finish
perl -i -pe 's|Result4301 \[\.\.\.\]|Result4301 [ Stage4Lap1 ]|g' Dependencies.txt
echo 879 / 1866 --- Result4301 to Stage4Lap1
perl -i -pe 's|Result4302 \[\.\.\.\]|Result4302 [ Stage4Lap2 ]|g' Dependencies.txt
echo 880 / 1866 --- Result4302 to Stage4Lap2
perl -i -pe 's|Result4303 \[\.\.\.\]|Result4303 [ Stage4Lap3 ]|g' Dependencies.txt
echo 881 / 1866 --- Result4303 to Stage4Lap3
perl -i -pe 's|Result4304 \[\.\.\.\]|Result4304 [ Stage4Lap4 ]|g' Dependencies.txt
echo 882 / 1866 --- Result4304 to Stage4Lap4
perl -i -pe 's|Result4305 \[\.\.\.\]|Result4305 [ Stage4Lap5 ]|g' Dependencies.txt
echo 883 / 1866 --- Result4305 to Stage4Lap5
perl -i -pe 's|Result4306 \[\.\.\.\]|Result4306 [ Stage4Lap6 ]|g' Dependencies.txt
echo 884 / 1866 --- Result4306 to Stage4Lap6
perl -i -pe 's|Result4307 \[\.\.\.\]|Result4307 [ Stage4Lap7 ]|g' Dependencies.txt
echo 885 / 1866 --- Result4307 to Stage4Lap7
perl -i -pe 's|Result4308 \[\.\.\.\]|Result4308 [ Stage4Lap8 ]|g' Dependencies.txt
echo 886 / 1866 --- Result4308 to Stage4Lap8
perl -i -pe 's|Result4309 \[\.\.\.\]|Result4309 [ Stage4Lap9 ]|g' Dependencies.txt
echo 887 / 1866 --- Result4309 to Stage4Lap9
perl -i -pe 's|Result4310 \[\.\.\.\]|Result4310 [ Stage4Lap10 ]|g' Dependencies.txt
echo 888 / 1866 --- Result4310 to Stage4Lap10
perl -i -pe 's|Result4320 \[\.\.\.\]|Result4320 [ Stage4LapCount ]|g' Dependencies.txt
echo 889 / 1866 --- Result4320 to Stage4LapCount
perl -i -pe 's|Result4321 \[\.\.\.\]|Result4321 [ Stage4FastestLap ]|g' Dependencies.txt
echo 890 / 1866 --- Result4321 to Stage4FastestLap
perl -i -pe 's|Result4322 \[\.\.\.\]|Result4322 [ Stage4SlowestLap ]|g' Dependencies.txt
echo 891 / 1866 --- Result4322 to Stage4SlowestLap
perl -i -pe 's|Result4323 \[\.\.\.\]|Result4323 [ Stage4AverageLap ]|g' Dependencies.txt
echo 892 / 1866 --- Result4323 to Stage4AverageLap
perl -i -pe 's|Result4401 \[\.\.\.\]|Result4401 [ Stage4ParcoursStation1Points ]|g' Dependencies.txt
echo 893 / 1866 --- Result4401 to Stage4ParcoursStation1Points
perl -i -pe 's|Result4402 \[\.\.\.\]|Result4402 [ Stage4ParcoursStation2Points ]|g' Dependencies.txt
echo 894 / 1866 --- Result4402 to Stage4ParcoursStation2Points
perl -i -pe 's|Result4403 \[\.\.\.\]|Result4403 [ Stage4ParcoursStation3Points ]|g' Dependencies.txt
echo 895 / 1866 --- Result4403 to Stage4ParcoursStation3Points
perl -i -pe 's|Result4404 \[\.\.\.\]|Result4404 [ Stage4ParcoursStation4Points ]|g' Dependencies.txt
echo 896 / 1866 --- Result4404 to Stage4ParcoursStation4Points
perl -i -pe 's|Result4405 \[\.\.\.\]|Result4405 [ Stage4ParcoursStation5Points ]|g' Dependencies.txt
echo 897 / 1866 --- Result4405 to Stage4ParcoursStation5Points
perl -i -pe 's|Result4406 \[\.\.\.\]|Result4406 [ Stage4ParcoursStation6Points ]|g' Dependencies.txt
echo 898 / 1866 --- Result4406 to Stage4ParcoursStation6Points
perl -i -pe 's|Result4407 \[\.\.\.\]|Result4407 [ Stage4ParcoursStation7Points ]|g' Dependencies.txt
echo 899 / 1866 --- Result4407 to Stage4ParcoursStation7Points
perl -i -pe 's|Result4408 \[\.\.\.\]|Result4408 [ Stage4ParcoursStation8Points ]|g' Dependencies.txt
echo 900 / 1866 --- Result4408 to Stage4ParcoursStation8Points
perl -i -pe 's|Result4409 \[\.\.\.\]|Result4409 [ Stage4ParcoursStation9Points ]|g' Dependencies.txt
echo 901 / 1866 --- Result4409 to Stage4ParcoursStation9Points
perl -i -pe 's|Result4410 \[\.\.\.\]|Result4410 [ Stage4ParcoursStation10Points ]|g' Dependencies.txt
echo 902 / 1866 --- Result4410 to Stage4ParcoursStation10Points
perl -i -pe 's|Result4411 \[\.\.\.\]|Result4411 [ Stage4ParcoursStation11Points ]|g' Dependencies.txt
echo 903 / 1866 --- Result4411 to Stage4ParcoursStation11Points
perl -i -pe 's|Result4412 \[\.\.\.\]|Result4412 [ Stage4ParcoursStation12Points ]|g' Dependencies.txt
echo 904 / 1866 --- Result4412 to Stage4ParcoursStation12Points
perl -i -pe 's|Result4413 \[\.\.\.\]|Result4413 [ Stage4ParcoursStation13Points ]|g' Dependencies.txt
echo 905 / 1866 --- Result4413 to Stage4ParcoursStation13Points
perl -i -pe 's|Result4414 \[\.\.\.\]|Result4414 [ Stage4ParcoursStation14Points ]|g' Dependencies.txt
echo 906 / 1866 --- Result4414 to Stage4ParcoursStation14Points
perl -i -pe 's|Result4415 \[\.\.\.\]|Result4415 [ Stage4ParcoursStation15Points ]|g' Dependencies.txt
echo 907 / 1866 --- Result4415 to Stage4ParcoursStation15Points
perl -i -pe 's|Result4430 \[\.\.\.\]|Result4430 [ Stage4ParcoursTotalPoints ]|g' Dependencies.txt
echo 908 / 1866 --- Result4430 to Stage4ParcoursTotalPoints
perl -i -pe 's|Result4441 \[\.\.\.\]|Result4441 [ Stage4ParcoursStart ]|g' Dependencies.txt
echo 909 / 1866 --- Result4441 to Stage4ParcoursStart
perl -i -pe 's|Result4442 \[\.\.\.\]|Result4442 [ Stage4ParcoursFinish ]|g' Dependencies.txt
echo 910 / 1866 --- Result4442 to Stage4ParcoursFinish
perl -i -pe 's|Result4450 \[\.\.\.\]|Result4450 [ Stage4ParcoursTime ]|g' Dependencies.txt
echo 911 / 1866 --- Result4450 to Stage4ParcoursTime
perl -i -pe 's|Result4501 \[\.\.\.\]|Result4501 [ Stage4ParcoursRankingPoints ]|g' Dependencies.txt
echo 912 / 1866 --- Result4501 to Stage4ParcoursRankingPoints
perl -i -pe 's|Result4502 \[\.\.\.\]|Result4502 [ Stage4CrossCountryRankingPoints ]|g' Dependencies.txt
echo 913 / 1866 --- Result4502 to Stage4CrossCountryRankingPoints
perl -i -pe 's|Result4503 \[\.\.\.\]|Result4503 [ Stage4TotalRankingPoints ]|g' Dependencies.txt
echo 914 / 1866 --- Result4503 to Stage4TotalRankingPoints
perl -i -pe 's|Result4611 \[\.\.\.\]|Result4611 [ Stage4Lap1Sector1 ]|g' Dependencies.txt
echo 915 / 1866 --- Result4611 to Stage4Lap1Sector1
perl -i -pe 's|Result4612 \[\.\.\.\]|Result4612 [ Stage4Lap2Sector1 ]|g' Dependencies.txt
echo 916 / 1866 --- Result4612 to Stage4Lap2Sector1
perl -i -pe 's|Result4613 \[\.\.\.\]|Result4613 [ Stage4Lap3Sector1 ]|g' Dependencies.txt
echo 917 / 1866 --- Result4613 to Stage4Lap3Sector1
perl -i -pe 's|Result4614 \[\.\.\.\]|Result4614 [ Stage4Lap4Sector1 ]|g' Dependencies.txt
echo 918 / 1866 --- Result4614 to Stage4Lap4Sector1
perl -i -pe 's|Result4615 \[\.\.\.\]|Result4615 [ Stage4Lap5Sector1 ]|g' Dependencies.txt
echo 919 / 1866 --- Result4615 to Stage4Lap5Sector1
perl -i -pe 's|Result4616 \[\.\.\.\]|Result4616 [ Stage4Lap6Sector1 ]|g' Dependencies.txt
echo 920 / 1866 --- Result4616 to Stage4Lap6Sector1
perl -i -pe 's|Result4617 \[\.\.\.\]|Result4617 [ Stage4Lap7Sector1 ]|g' Dependencies.txt
echo 921 / 1866 --- Result4617 to Stage4Lap7Sector1
perl -i -pe 's|Result4618 \[\.\.\.\]|Result4618 [ Stage4Lap8Sector1 ]|g' Dependencies.txt
echo 922 / 1866 --- Result4618 to Stage4Lap8Sector1
perl -i -pe 's|Result4619 \[\.\.\.\]|Result4619 [ Stage4Lap9Sector1 ]|g' Dependencies.txt
echo 923 / 1866 --- Result4619 to Stage4Lap9Sector1
perl -i -pe 's|Result4620 \[\.\.\.\]|Result4620 [ Stage4Lap10Sector1 ]|g' Dependencies.txt
echo 924 / 1866 --- Result4620 to Stage4Lap10Sector1
perl -i -pe 's|Result4621 \[\.\.\.\]|Result4621 [ Stage4Lap1Sector2 ]|g' Dependencies.txt
echo 925 / 1866 --- Result4621 to Stage4Lap1Sector2
perl -i -pe 's|Result4622 \[\.\.\.\]|Result4622 [ Stage4Lap2Sector2 ]|g' Dependencies.txt
echo 926 / 1866 --- Result4622 to Stage4Lap2Sector2
perl -i -pe 's|Result4623 \[\.\.\.\]|Result4623 [ Stage4Lap3Sector2 ]|g' Dependencies.txt
echo 927 / 1866 --- Result4623 to Stage4Lap3Sector2
perl -i -pe 's|Result4624 \[\.\.\.\]|Result4624 [ Stage4Lap4Sector2 ]|g' Dependencies.txt
echo 928 / 1866 --- Result4624 to Stage4Lap4Sector2
perl -i -pe 's|Result4625 \[\.\.\.\]|Result4625 [ Stage4Lap5Sector2 ]|g' Dependencies.txt
echo 929 / 1866 --- Result4625 to Stage4Lap5Sector2
perl -i -pe 's|Result4626 \[\.\.\.\]|Result4626 [ Stage4Lap6Sector2 ]|g' Dependencies.txt
echo 930 / 1866 --- Result4626 to Stage4Lap6Sector2
perl -i -pe 's|Result4627 \[\.\.\.\]|Result4627 [ Stage4Lap7Sector2 ]|g' Dependencies.txt
echo 931 / 1866 --- Result4627 to Stage4Lap7Sector2
perl -i -pe 's|Result4628 \[\.\.\.\]|Result4628 [ Stage4Lap8Sector2 ]|g' Dependencies.txt
echo 932 / 1866 --- Result4628 to Stage4Lap8Sector2
perl -i -pe 's|Result4629 \[\.\.\.\]|Result4629 [ Stage4Lap9Sector2 ]|g' Dependencies.txt
echo 933 / 1866 --- Result4629 to Stage4Lap9Sector2
perl -i -pe 's|Result4630 \[\.\.\.\]|Result4630 [ Stage4Lap10Sector2 ]|g' Dependencies.txt
echo 934 / 1866 --- Result4630 to Stage4Lap10Sector2
perl -i -pe 's|Result4631 \[\.\.\.\]|Result4631 [ Stage4Lap1Sector3 ]|g' Dependencies.txt
echo 935 / 1866 --- Result4631 to Stage4Lap1Sector3
perl -i -pe 's|Result4632 \[\.\.\.\]|Result4632 [ Stage4Lap2Sector3 ]|g' Dependencies.txt
echo 936 / 1866 --- Result4632 to Stage4Lap2Sector3
perl -i -pe 's|Result4633 \[\.\.\.\]|Result4633 [ Stage4Lap3Sector3 ]|g' Dependencies.txt
echo 937 / 1866 --- Result4633 to Stage4Lap3Sector3
perl -i -pe 's|Result4634 \[\.\.\.\]|Result4634 [ Stage4Lap4Sector3 ]|g' Dependencies.txt
echo 938 / 1866 --- Result4634 to Stage4Lap4Sector3
perl -i -pe 's|Result4635 \[\.\.\.\]|Result4635 [ Stage4Lap5Sector3 ]|g' Dependencies.txt
echo 939 / 1866 --- Result4635 to Stage4Lap5Sector3
perl -i -pe 's|Result4636 \[\.\.\.\]|Result4636 [ Stage4Lap6Sector3 ]|g' Dependencies.txt
echo 940 / 1866 --- Result4636 to Stage4Lap6Sector3
perl -i -pe 's|Result4637 \[\.\.\.\]|Result4637 [ Stage4Lap7Sector3 ]|g' Dependencies.txt
echo 941 / 1866 --- Result4637 to Stage4Lap7Sector3
perl -i -pe 's|Result4638 \[\.\.\.\]|Result4638 [ Stage4Lap8Sector3 ]|g' Dependencies.txt
echo 942 / 1866 --- Result4638 to Stage4Lap8Sector3
perl -i -pe 's|Result4639 \[\.\.\.\]|Result4639 [ Stage4Lap9Sector3 ]|g' Dependencies.txt
echo 943 / 1866 --- Result4639 to Stage4Lap9Sector3
perl -i -pe 's|Result4640 \[\.\.\.\]|Result4640 [ Stage4Lap10Sector3 ]|g' Dependencies.txt
echo 944 / 1866 --- Result4640 to Stage4Lap10Sector3
perl -i -pe 's|Result4641 \[\.\.\.\]|Result4641 [ Stage4Lap1Sector4 ]|g' Dependencies.txt
echo 945 / 1866 --- Result4641 to Stage4Lap1Sector4
perl -i -pe 's|Result4642 \[\.\.\.\]|Result4642 [ Stage4Lap2Sector4 ]|g' Dependencies.txt
echo 946 / 1866 --- Result4642 to Stage4Lap2Sector4
perl -i -pe 's|Result4643 \[\.\.\.\]|Result4643 [ Stage4Lap3Sector4 ]|g' Dependencies.txt
echo 947 / 1866 --- Result4643 to Stage4Lap3Sector4
perl -i -pe 's|Result4644 \[\.\.\.\]|Result4644 [ Stage4Lap4Sector4 ]|g' Dependencies.txt
echo 948 / 1866 --- Result4644 to Stage4Lap4Sector4
perl -i -pe 's|Result4645 \[\.\.\.\]|Result4645 [ Stage4Lap5Sector4 ]|g' Dependencies.txt
echo 949 / 1866 --- Result4645 to Stage4Lap5Sector4
perl -i -pe 's|Result4646 \[\.\.\.\]|Result4646 [ Stage4Lap6Sector4 ]|g' Dependencies.txt
echo 950 / 1866 --- Result4646 to Stage4Lap6Sector4
perl -i -pe 's|Result4647 \[\.\.\.\]|Result4647 [ Stage4Lap7Sector4 ]|g' Dependencies.txt
echo 951 / 1866 --- Result4647 to Stage4Lap7Sector4
perl -i -pe 's|Result4648 \[\.\.\.\]|Result4648 [ Stage4Lap8Sector4 ]|g' Dependencies.txt
echo 952 / 1866 --- Result4648 to Stage4Lap8Sector4
perl -i -pe 's|Result4649 \[\.\.\.\]|Result4649 [ Stage4Lap9Sector4 ]|g' Dependencies.txt
echo 953 / 1866 --- Result4649 to Stage4Lap9Sector4
perl -i -pe 's|Result4650 \[\.\.\.\]|Result4650 [ Stage4Lap10Sector4 ]|g' Dependencies.txt
echo 954 / 1866 --- Result4650 to Stage4Lap10Sector4
perl -i -pe 's|Result4651 \[\.\.\.\]|Result4651 [ Stage4Lap1UphillSector ]|g' Dependencies.txt
echo 955 / 1866 --- Result4651 to Stage4Lap1UphillSector
perl -i -pe 's|Result4652 \[\.\.\.\]|Result4652 [ Stage4Lap2UphillSector ]|g' Dependencies.txt
echo 956 / 1866 --- Result4652 to Stage4Lap2UphillSector
perl -i -pe 's|Result4653 \[\.\.\.\]|Result4653 [ Stage4Lap3UphillSector ]|g' Dependencies.txt
echo 957 / 1866 --- Result4653 to Stage4Lap3UphillSector
perl -i -pe 's|Result4654 \[\.\.\.\]|Result4654 [ Stage4Lap4UphillSector ]|g' Dependencies.txt
echo 958 / 1866 --- Result4654 to Stage4Lap4UphillSector
perl -i -pe 's|Result4655 \[\.\.\.\]|Result4655 [ Stage4Lap5UphillSector ]|g' Dependencies.txt
echo 959 / 1866 --- Result4655 to Stage4Lap5UphillSector
perl -i -pe 's|Result4656 \[\.\.\.\]|Result4656 [ Stage4Lap6UphillSector ]|g' Dependencies.txt
echo 960 / 1866 --- Result4656 to Stage4Lap6UphillSector
perl -i -pe 's|Result4657 \[\.\.\.\]|Result4657 [ Stage4Lap7UphillSector ]|g' Dependencies.txt
echo 961 / 1866 --- Result4657 to Stage4Lap7UphillSector
perl -i -pe 's|Result4658 \[\.\.\.\]|Result4658 [ Stage4Lap8UphillSector ]|g' Dependencies.txt
echo 962 / 1866 --- Result4658 to Stage4Lap8UphillSector
perl -i -pe 's|Result4659 \[\.\.\.\]|Result4659 [ Stage4Lap9UphillSector ]|g' Dependencies.txt
echo 963 / 1866 --- Result4659 to Stage4Lap9UphillSector
perl -i -pe 's|Result4660 \[\.\.\.\]|Result4660 [ Stage4Lap10UphillSector ]|g' Dependencies.txt
echo 964 / 1866 --- Result4660 to Stage4Lap10UphillSector
perl -i -pe 's|Result4680 \[\.\.\.\]|Result4680 [ Stage4FastestUphillSector ]|g' Dependencies.txt
echo 965 / 1866 --- Result4680 to Stage4FastestUphillSector
perl -i -pe 's|Result4681 \[\.\.\.\]|Result4681 [ Stage4FastestUphillSectorID ]|g' Dependencies.txt
echo 966 / 1866 --- Result4681 to Stage4FastestUphillSectorID
perl -i -pe 's|Result5000 \[\.\.\.\]|Result5000 [ Stage5StartTime ]|g' Dependencies.txt
echo 967 / 1866 --- Result5000 to Stage5StartTime
perl -i -pe 's|Result5001 \[\.\.\.\]|Result5001 [ Stage5FinishTimeLimit ]|g' Dependencies.txt
echo 968 / 1866 --- Result5001 to Stage5FinishTimeLimit
perl -i -pe 's|Result5100 \[\.\.\.\]|Result5100 [ Stage5Started ]|g' Dependencies.txt
echo 969 / 1866 --- Result5100 to Stage5Started
perl -i -pe 's|Result5101 \[\.\.\.\]|Result5101 [ Stage5AfterLap1Split1 ]|g' Dependencies.txt
echo 970 / 1866 --- Result5101 to Stage5AfterLap1Split1
perl -i -pe 's|Result5102 \[\.\.\.\]|Result5102 [ Stage5AfterLap1Split2 ]|g' Dependencies.txt
echo 971 / 1866 --- Result5102 to Stage5AfterLap1Split2
perl -i -pe 's|Result5103 \[\.\.\.\]|Result5103 [ Stage5AfterLap1Split3 ]|g' Dependencies.txt
echo 972 / 1866 --- Result5103 to Stage5AfterLap1Split3
perl -i -pe 's|Result5104 \[\.\.\.\]|Result5104 [ Stage5AfterLap1Spotter ]|g' Dependencies.txt
echo 973 / 1866 --- Result5104 to Stage5AfterLap1Spotter
perl -i -pe 's|Result5105 \[\.\.\.\]|Result5105 [ Stage5AfterLap1Finish ]|g' Dependencies.txt
echo 974 / 1866 --- Result5105 to Stage5AfterLap1Finish
perl -i -pe 's|Result5106 \[\.\.\.\]|Result5106 [ Stage5AfterLap2Split1 ]|g' Dependencies.txt
echo 975 / 1866 --- Result5106 to Stage5AfterLap2Split1
perl -i -pe 's|Result5107 \[\.\.\.\]|Result5107 [ Stage5AfterLap2Split2 ]|g' Dependencies.txt
echo 976 / 1866 --- Result5107 to Stage5AfterLap2Split2
perl -i -pe 's|Result5108 \[\.\.\.\]|Result5108 [ Stage5AfterLap2Split3 ]|g' Dependencies.txt
echo 977 / 1866 --- Result5108 to Stage5AfterLap2Split3
perl -i -pe 's|Result5109 \[\.\.\.\]|Result5109 [ Stage5AfterLap2Spotter ]|g' Dependencies.txt
echo 978 / 1866 --- Result5109 to Stage5AfterLap2Spotter
perl -i -pe 's|Result5110 \[\.\.\.\]|Result5110 [ Stage5AfterLap2Finish ]|g' Dependencies.txt
echo 979 / 1866 --- Result5110 to Stage5AfterLap2Finish
perl -i -pe 's|Result5111 \[\.\.\.\]|Result5111 [ Stage5AfterLap3Split1 ]|g' Dependencies.txt
echo 980 / 1866 --- Result5111 to Stage5AfterLap3Split1
perl -i -pe 's|Result5112 \[\.\.\.\]|Result5112 [ Stage5AfterLap3Split2 ]|g' Dependencies.txt
echo 981 / 1866 --- Result5112 to Stage5AfterLap3Split2
perl -i -pe 's|Result5113 \[\.\.\.\]|Result5113 [ Stage5AfterLap3Split3 ]|g' Dependencies.txt
echo 982 / 1866 --- Result5113 to Stage5AfterLap3Split3
perl -i -pe 's|Result5114 \[\.\.\.\]|Result5114 [ Stage5AfterLap3Spotter ]|g' Dependencies.txt
echo 983 / 1866 --- Result5114 to Stage5AfterLap3Spotter
perl -i -pe 's|Result5115 \[\.\.\.\]|Result5115 [ Stage5AfterLap3Finish ]|g' Dependencies.txt
echo 984 / 1866 --- Result5115 to Stage5AfterLap3Finish
perl -i -pe 's|Result5116 \[\.\.\.\]|Result5116 [ Stage5AfterLap4Split1 ]|g' Dependencies.txt
echo 985 / 1866 --- Result5116 to Stage5AfterLap4Split1
perl -i -pe 's|Result5117 \[\.\.\.\]|Result5117 [ Stage5AfterLap4Split2 ]|g' Dependencies.txt
echo 986 / 1866 --- Result5117 to Stage5AfterLap4Split2
perl -i -pe 's|Result5118 \[\.\.\.\]|Result5118 [ Stage5AfterLap4Split3 ]|g' Dependencies.txt
echo 987 / 1866 --- Result5118 to Stage5AfterLap4Split3
perl -i -pe 's|Result5119 \[\.\.\.\]|Result5119 [ Stage5AfterLap4Spotter ]|g' Dependencies.txt
echo 988 / 1866 --- Result5119 to Stage5AfterLap4Spotter
perl -i -pe 's|Result5120 \[\.\.\.\]|Result5120 [ Stage5AfterLap4Finish ]|g' Dependencies.txt
echo 989 / 1866 --- Result5120 to Stage5AfterLap4Finish
perl -i -pe 's|Result5121 \[\.\.\.\]|Result5121 [ Stage5AfterLap5Split1 ]|g' Dependencies.txt
echo 990 / 1866 --- Result5121 to Stage5AfterLap5Split1
perl -i -pe 's|Result5122 \[\.\.\.\]|Result5122 [ Stage5AfterLap5Split2 ]|g' Dependencies.txt
echo 991 / 1866 --- Result5122 to Stage5AfterLap5Split2
perl -i -pe 's|Result5123 \[\.\.\.\]|Result5123 [ Stage5AfterLap5Split3 ]|g' Dependencies.txt
echo 992 / 1866 --- Result5123 to Stage5AfterLap5Split3
perl -i -pe 's|Result5124 \[\.\.\.\]|Result5124 [ Stage5AfterLap5Spotter ]|g' Dependencies.txt
echo 993 / 1866 --- Result5124 to Stage5AfterLap5Spotter
perl -i -pe 's|Result5125 \[\.\.\.\]|Result5125 [ Stage5AfterLap5Finish ]|g' Dependencies.txt
echo 994 / 1866 --- Result5125 to Stage5AfterLap5Finish
perl -i -pe 's|Result5126 \[\.\.\.\]|Result5126 [ Stage5AfterLap6Split1 ]|g' Dependencies.txt
echo 995 / 1866 --- Result5126 to Stage5AfterLap6Split1
perl -i -pe 's|Result5127 \[\.\.\.\]|Result5127 [ Stage5AfterLap6Split2 ]|g' Dependencies.txt
echo 996 / 1866 --- Result5127 to Stage5AfterLap6Split2
perl -i -pe 's|Result5128 \[\.\.\.\]|Result5128 [ Stage5AfterLap6Split3 ]|g' Dependencies.txt
echo 997 / 1866 --- Result5128 to Stage5AfterLap6Split3
perl -i -pe 's|Result5129 \[\.\.\.\]|Result5129 [ Stage5AfterLap6Spotter ]|g' Dependencies.txt
echo 998 / 1866 --- Result5129 to Stage5AfterLap6Spotter
perl -i -pe 's|Result5130 \[\.\.\.\]|Result5130 [ Stage5AfterLap6Finish ]|g' Dependencies.txt
echo 999 / 1866 --- Result5130 to Stage5AfterLap6Finish
perl -i -pe 's|Result5131 \[\.\.\.\]|Result5131 [ Stage5AfterLap7Split1 ]|g' Dependencies.txt
echo 1000 / 1866 --- Result5131 to Stage5AfterLap7Split1
perl -i -pe 's|Result5132 \[\.\.\.\]|Result5132 [ Stage5AfterLap7Split2 ]|g' Dependencies.txt
echo 1001 / 1866 --- Result5132 to Stage5AfterLap7Split2
perl -i -pe 's|Result5133 \[\.\.\.\]|Result5133 [ Stage5AfterLap7Split3 ]|g' Dependencies.txt
echo 1002 / 1866 --- Result5133 to Stage5AfterLap7Split3
perl -i -pe 's|Result5134 \[\.\.\.\]|Result5134 [ Stage5AfterLap7Spotter ]|g' Dependencies.txt
echo 1003 / 1866 --- Result5134 to Stage5AfterLap7Spotter
perl -i -pe 's|Result5135 \[\.\.\.\]|Result5135 [ Stage5AfterLap7Finish ]|g' Dependencies.txt
echo 1004 / 1866 --- Result5135 to Stage5AfterLap7Finish
perl -i -pe 's|Result5136 \[\.\.\.\]|Result5136 [ Stage5AfterLap8Split1 ]|g' Dependencies.txt
echo 1005 / 1866 --- Result5136 to Stage5AfterLap8Split1
perl -i -pe 's|Result5137 \[\.\.\.\]|Result5137 [ Stage5AfterLap8Split2 ]|g' Dependencies.txt
echo 1006 / 1866 --- Result5137 to Stage5AfterLap8Split2
perl -i -pe 's|Result5138 \[\.\.\.\]|Result5138 [ Stage5AfterLap8Split3 ]|g' Dependencies.txt
echo 1007 / 1866 --- Result5138 to Stage5AfterLap8Split3
perl -i -pe 's|Result5139 \[\.\.\.\]|Result5139 [ Stage5AfterLap8Spotter ]|g' Dependencies.txt
echo 1008 / 1866 --- Result5139 to Stage5AfterLap8Spotter
perl -i -pe 's|Result5140 \[\.\.\.\]|Result5140 [ Stage5AfterLap8Finish ]|g' Dependencies.txt
echo 1009 / 1866 --- Result5140 to Stage5AfterLap8Finish
perl -i -pe 's|Result5141 \[\.\.\.\]|Result5141 [ Stage5AfterLap9Split1 ]|g' Dependencies.txt
echo 1010 / 1866 --- Result5141 to Stage5AfterLap9Split1
perl -i -pe 's|Result5142 \[\.\.\.\]|Result5142 [ Stage5AfterLap9Split2 ]|g' Dependencies.txt
echo 1011 / 1866 --- Result5142 to Stage5AfterLap9Split2
perl -i -pe 's|Result5143 \[\.\.\.\]|Result5143 [ Stage5AfterLap9Split3 ]|g' Dependencies.txt
echo 1012 / 1866 --- Result5143 to Stage5AfterLap9Split3
perl -i -pe 's|Result5144 \[\.\.\.\]|Result5144 [ Stage5AfterLap9Spotter ]|g' Dependencies.txt
echo 1013 / 1866 --- Result5144 to Stage5AfterLap9Spotter
perl -i -pe 's|Result5145 \[\.\.\.\]|Result5145 [ Stage5AfterLap9Finish ]|g' Dependencies.txt
echo 1014 / 1866 --- Result5145 to Stage5AfterLap9Finish
perl -i -pe 's|Result5146 \[\.\.\.\]|Result5146 [ Stage5AfterLap10Split1 ]|g' Dependencies.txt
echo 1015 / 1866 --- Result5146 to Stage5AfterLap10Split1
perl -i -pe 's|Result5147 \[\.\.\.\]|Result5147 [ Stage5AfterLap10Split2 ]|g' Dependencies.txt
echo 1016 / 1866 --- Result5147 to Stage5AfterLap10Split2
perl -i -pe 's|Result5148 \[\.\.\.\]|Result5148 [ Stage5AfterLap10Split3 ]|g' Dependencies.txt
echo 1017 / 1866 --- Result5148 to Stage5AfterLap10Split3
perl -i -pe 's|Result5149 \[\.\.\.\]|Result5149 [ Stage5AfterLap10Spotter ]|g' Dependencies.txt
echo 1018 / 1866 --- Result5149 to Stage5AfterLap10Spotter
perl -i -pe 's|Result5150 \[\.\.\.\]|Result5150 [ Stage5AfterLap10Finish ]|g' Dependencies.txt
echo 1019 / 1866 --- Result5150 to Stage5AfterLap10Finish
perl -i -pe 's|Result5190 \[\.\.\.\]|Result5190 [ Stage5AfterFinish ]|g' Dependencies.txt
echo 1020 / 1866 --- Result5190 to Stage5AfterFinish
perl -i -pe 's|Result5191 \[\.\.\.\]|Result5191 [ Stage5LastSplitID ]|g' Dependencies.txt
echo 1021 / 1866 --- Result5191 to Stage5LastSplitID
perl -i -pe 's|Result5192 \[\.\.\.\]|Result5192 [ Stage5LastSplit ]|g' Dependencies.txt
echo 1022 / 1866 --- Result5192 to Stage5LastSplit
perl -i -pe 's|Result5193 \[\.\.\.\]|Result5193 [ Stage5LastFinishID ]|g' Dependencies.txt
echo 1023 / 1866 --- Result5193 to Stage5LastFinishID
perl -i -pe 's|Result5194 \[\.\.\.\]|Result5194 [ Stage5LastFinish ]|g' Dependencies.txt
echo 1024 / 1866 --- Result5194 to Stage5LastFinish
perl -i -pe 's|Result5195 \[\.\.\.\]|Result5195 [ Stage5LastSplitBunchTime ]|g' Dependencies.txt
echo 1025 / 1866 --- Result5195 to Stage5LastSplitBunchTime
perl -i -pe 's|Result5196 \[\.\.\.\]|Result5196 [ Stage5PhotoBunchTime ]|g' Dependencies.txt
echo 1026 / 1866 --- Result5196 to Stage5PhotoBunchTime
perl -i -pe 's|Result5200 \[\.\.\.\]|Result5200 [ Stage5Start ]|g' Dependencies.txt
echo 1027 / 1866 --- Result5200 to Stage5Start
perl -i -pe 's|Result5201 \[\.\.\.\]|Result5201 [ Stage5Lap1Split1 ]|g' Dependencies.txt
echo 1028 / 1866 --- Result5201 to Stage5Lap1Split1
perl -i -pe 's|Result5202 \[\.\.\.\]|Result5202 [ Stage5Lap1Split2 ]|g' Dependencies.txt
echo 1029 / 1866 --- Result5202 to Stage5Lap1Split2
perl -i -pe 's|Result5203 \[\.\.\.\]|Result5203 [ Stage5Lap1Split3 ]|g' Dependencies.txt
echo 1030 / 1866 --- Result5203 to Stage5Lap1Split3
perl -i -pe 's|Result5204 \[\.\.\.\]|Result5204 [ Stage5Lap1Spotter ]|g' Dependencies.txt
echo 1031 / 1866 --- Result5204 to Stage5Lap1Spotter
perl -i -pe 's|Result5205 \[\.\.\.\]|Result5205 [ Stage5Lap1Finish ]|g' Dependencies.txt
echo 1032 / 1866 --- Result5205 to Stage5Lap1Finish
perl -i -pe 's|Result5206 \[\.\.\.\]|Result5206 [ Stage5Lap2Split1 ]|g' Dependencies.txt
echo 1033 / 1866 --- Result5206 to Stage5Lap2Split1
perl -i -pe 's|Result5207 \[\.\.\.\]|Result5207 [ Stage5Lap2Split2 ]|g' Dependencies.txt
echo 1034 / 1866 --- Result5207 to Stage5Lap2Split2
perl -i -pe 's|Result5208 \[\.\.\.\]|Result5208 [ Stage5Lap2Split3 ]|g' Dependencies.txt
echo 1035 / 1866 --- Result5208 to Stage5Lap2Split3
perl -i -pe 's|Result5209 \[\.\.\.\]|Result5209 [ Stage5Lap2Spotter ]|g' Dependencies.txt
echo 1036 / 1866 --- Result5209 to Stage5Lap2Spotter
perl -i -pe 's|Result5210 \[\.\.\.\]|Result5210 [ Stage5Lap2Finish ]|g' Dependencies.txt
echo 1037 / 1866 --- Result5210 to Stage5Lap2Finish
perl -i -pe 's|Result5211 \[\.\.\.\]|Result5211 [ Stage5Lap3Split1 ]|g' Dependencies.txt
echo 1038 / 1866 --- Result5211 to Stage5Lap3Split1
perl -i -pe 's|Result5212 \[\.\.\.\]|Result5212 [ Stage5Lap3Split2 ]|g' Dependencies.txt
echo 1039 / 1866 --- Result5212 to Stage5Lap3Split2
perl -i -pe 's|Result5213 \[\.\.\.\]|Result5213 [ Stage5Lap3Split3 ]|g' Dependencies.txt
echo 1040 / 1866 --- Result5213 to Stage5Lap3Split3
perl -i -pe 's|Result5214 \[\.\.\.\]|Result5214 [ Stage5Lap3Spotter ]|g' Dependencies.txt
echo 1041 / 1866 --- Result5214 to Stage5Lap3Spotter
perl -i -pe 's|Result5215 \[\.\.\.\]|Result5215 [ Stage5Lap3Finish ]|g' Dependencies.txt
echo 1042 / 1866 --- Result5215 to Stage5Lap3Finish
perl -i -pe 's|Result5216 \[\.\.\.\]|Result5216 [ Stage5Lap4Split1 ]|g' Dependencies.txt
echo 1043 / 1866 --- Result5216 to Stage5Lap4Split1
perl -i -pe 's|Result5217 \[\.\.\.\]|Result5217 [ Stage5Lap4Split2 ]|g' Dependencies.txt
echo 1044 / 1866 --- Result5217 to Stage5Lap4Split2
perl -i -pe 's|Result5218 \[\.\.\.\]|Result5218 [ Stage5Lap4Split3 ]|g' Dependencies.txt
echo 1045 / 1866 --- Result5218 to Stage5Lap4Split3
perl -i -pe 's|Result5219 \[\.\.\.\]|Result5219 [ Stage5Lap4Spotter ]|g' Dependencies.txt
echo 1046 / 1866 --- Result5219 to Stage5Lap4Spotter
perl -i -pe 's|Result5220 \[\.\.\.\]|Result5220 [ Stage5Lap4Finish ]|g' Dependencies.txt
echo 1047 / 1866 --- Result5220 to Stage5Lap4Finish
perl -i -pe 's|Result5221 \[\.\.\.\]|Result5221 [ Stage5Lap5Split1 ]|g' Dependencies.txt
echo 1048 / 1866 --- Result5221 to Stage5Lap5Split1
perl -i -pe 's|Result5222 \[\.\.\.\]|Result5222 [ Stage5Lap5Split2 ]|g' Dependencies.txt
echo 1049 / 1866 --- Result5222 to Stage5Lap5Split2
perl -i -pe 's|Result5223 \[\.\.\.\]|Result5223 [ Stage5Lap5Split3 ]|g' Dependencies.txt
echo 1050 / 1866 --- Result5223 to Stage5Lap5Split3
perl -i -pe 's|Result5224 \[\.\.\.\]|Result5224 [ Stage5Lap5Spotter ]|g' Dependencies.txt
echo 1051 / 1866 --- Result5224 to Stage5Lap5Spotter
perl -i -pe 's|Result5225 \[\.\.\.\]|Result5225 [ Stage5Lap5Finish ]|g' Dependencies.txt
echo 1052 / 1866 --- Result5225 to Stage5Lap5Finish
perl -i -pe 's|Result5226 \[\.\.\.\]|Result5226 [ Stage5Lap6Split1 ]|g' Dependencies.txt
echo 1053 / 1866 --- Result5226 to Stage5Lap6Split1
perl -i -pe 's|Result5227 \[\.\.\.\]|Result5227 [ Stage5Lap6Split2 ]|g' Dependencies.txt
echo 1054 / 1866 --- Result5227 to Stage5Lap6Split2
perl -i -pe 's|Result5228 \[\.\.\.\]|Result5228 [ Stage5Lap6Split3 ]|g' Dependencies.txt
echo 1055 / 1866 --- Result5228 to Stage5Lap6Split3
perl -i -pe 's|Result5229 \[\.\.\.\]|Result5229 [ Stage5Lap6Spotter ]|g' Dependencies.txt
echo 1056 / 1866 --- Result5229 to Stage5Lap6Spotter
perl -i -pe 's|Result5230 \[\.\.\.\]|Result5230 [ Stage5Lap6Finish ]|g' Dependencies.txt
echo 1057 / 1866 --- Result5230 to Stage5Lap6Finish
perl -i -pe 's|Result5231 \[\.\.\.\]|Result5231 [ Stage5Lap7Split1 ]|g' Dependencies.txt
echo 1058 / 1866 --- Result5231 to Stage5Lap7Split1
perl -i -pe 's|Result5232 \[\.\.\.\]|Result5232 [ Stage5Lap7Split2 ]|g' Dependencies.txt
echo 1059 / 1866 --- Result5232 to Stage5Lap7Split2
perl -i -pe 's|Result5233 \[\.\.\.\]|Result5233 [ Stage5Lap7Split3 ]|g' Dependencies.txt
echo 1060 / 1866 --- Result5233 to Stage5Lap7Split3
perl -i -pe 's|Result5234 \[\.\.\.\]|Result5234 [ Stage5Lap7Spotter ]|g' Dependencies.txt
echo 1061 / 1866 --- Result5234 to Stage5Lap7Spotter
perl -i -pe 's|Result5235 \[\.\.\.\]|Result5235 [ Stage5Lap7Finish ]|g' Dependencies.txt
echo 1062 / 1866 --- Result5235 to Stage5Lap7Finish
perl -i -pe 's|Result5236 \[\.\.\.\]|Result5236 [ Stage5Lap8Split1 ]|g' Dependencies.txt
echo 1063 / 1866 --- Result5236 to Stage5Lap8Split1
perl -i -pe 's|Result5237 \[\.\.\.\]|Result5237 [ Stage5Lap8Split2 ]|g' Dependencies.txt
echo 1064 / 1866 --- Result5237 to Stage5Lap8Split2
perl -i -pe 's|Result5238 \[\.\.\.\]|Result5238 [ Stage5Lap8Split3 ]|g' Dependencies.txt
echo 1065 / 1866 --- Result5238 to Stage5Lap8Split3
perl -i -pe 's|Result5239 \[\.\.\.\]|Result5239 [ Stage5Lap8Spotter ]|g' Dependencies.txt
echo 1066 / 1866 --- Result5239 to Stage5Lap8Spotter
perl -i -pe 's|Result5240 \[\.\.\.\]|Result5240 [ Stage5Lap8Finish ]|g' Dependencies.txt
echo 1067 / 1866 --- Result5240 to Stage5Lap8Finish
perl -i -pe 's|Result5241 \[\.\.\.\]|Result5241 [ Stage5Lap9Split1 ]|g' Dependencies.txt
echo 1068 / 1866 --- Result5241 to Stage5Lap9Split1
perl -i -pe 's|Result5242 \[\.\.\.\]|Result5242 [ Stage5Lap9Split2 ]|g' Dependencies.txt
echo 1069 / 1866 --- Result5242 to Stage5Lap9Split2
perl -i -pe 's|Result5243 \[\.\.\.\]|Result5243 [ Stage5Lap9Split3 ]|g' Dependencies.txt
echo 1070 / 1866 --- Result5243 to Stage5Lap9Split3
perl -i -pe 's|Result5244 \[\.\.\.\]|Result5244 [ Stage5Lap9Spotter ]|g' Dependencies.txt
echo 1071 / 1866 --- Result5244 to Stage5Lap9Spotter
perl -i -pe 's|Result5245 \[\.\.\.\]|Result5245 [ Stage5Lap9Finish ]|g' Dependencies.txt
echo 1072 / 1866 --- Result5245 to Stage5Lap9Finish
perl -i -pe 's|Result5246 \[\.\.\.\]|Result5246 [ Stage5Lap10Split1 ]|g' Dependencies.txt
echo 1073 / 1866 --- Result5246 to Stage5Lap10Split1
perl -i -pe 's|Result5247 \[\.\.\.\]|Result5247 [ Stage5Lap10Split2 ]|g' Dependencies.txt
echo 1074 / 1866 --- Result5247 to Stage5Lap10Split2
perl -i -pe 's|Result5248 \[\.\.\.\]|Result5248 [ Stage5Lap10Split3 ]|g' Dependencies.txt
echo 1075 / 1866 --- Result5248 to Stage5Lap10Split3
perl -i -pe 's|Result5249 \[\.\.\.\]|Result5249 [ Stage5Lap10Spotter ]|g' Dependencies.txt
echo 1076 / 1866 --- Result5249 to Stage5Lap10Spotter
perl -i -pe 's|Result5250 \[\.\.\.\]|Result5250 [ Stage5Lap10Finish ]|g' Dependencies.txt
echo 1077 / 1866 --- Result5250 to Stage5Lap10Finish
perl -i -pe 's|Result5301 \[\.\.\.\]|Result5301 [ Stage5Lap1 ]|g' Dependencies.txt
echo 1078 / 1866 --- Result5301 to Stage5Lap1
perl -i -pe 's|Result5302 \[\.\.\.\]|Result5302 [ Stage5Lap2 ]|g' Dependencies.txt
echo 1079 / 1866 --- Result5302 to Stage5Lap2
perl -i -pe 's|Result5303 \[\.\.\.\]|Result5303 [ Stage5Lap3 ]|g' Dependencies.txt
echo 1080 / 1866 --- Result5303 to Stage5Lap3
perl -i -pe 's|Result5304 \[\.\.\.\]|Result5304 [ Stage5Lap4 ]|g' Dependencies.txt
echo 1081 / 1866 --- Result5304 to Stage5Lap4
perl -i -pe 's|Result5305 \[\.\.\.\]|Result5305 [ Stage5Lap5 ]|g' Dependencies.txt
echo 1082 / 1866 --- Result5305 to Stage5Lap5
perl -i -pe 's|Result5306 \[\.\.\.\]|Result5306 [ Stage5Lap6 ]|g' Dependencies.txt
echo 1083 / 1866 --- Result5306 to Stage5Lap6
perl -i -pe 's|Result5307 \[\.\.\.\]|Result5307 [ Stage5Lap7 ]|g' Dependencies.txt
echo 1084 / 1866 --- Result5307 to Stage5Lap7
perl -i -pe 's|Result5308 \[\.\.\.\]|Result5308 [ Stage5Lap8 ]|g' Dependencies.txt
echo 1085 / 1866 --- Result5308 to Stage5Lap8
perl -i -pe 's|Result5309 \[\.\.\.\]|Result5309 [ Stage5Lap9 ]|g' Dependencies.txt
echo 1086 / 1866 --- Result5309 to Stage5Lap9
perl -i -pe 's|Result5310 \[\.\.\.\]|Result5310 [ Stage5Lap10 ]|g' Dependencies.txt
echo 1087 / 1866 --- Result5310 to Stage5Lap10
perl -i -pe 's|Result5320 \[\.\.\.\]|Result5320 [ Stage5LapCount ]|g' Dependencies.txt
echo 1088 / 1866 --- Result5320 to Stage5LapCount
perl -i -pe 's|Result5321 \[\.\.\.\]|Result5321 [ Stage5FastestLap ]|g' Dependencies.txt
echo 1089 / 1866 --- Result5321 to Stage5FastestLap
perl -i -pe 's|Result5322 \[\.\.\.\]|Result5322 [ Stage5SlowestLap ]|g' Dependencies.txt
echo 1090 / 1866 --- Result5322 to Stage5SlowestLap
perl -i -pe 's|Result5323 \[\.\.\.\]|Result5323 [ Stage5AverageLap ]|g' Dependencies.txt
echo 1091 / 1866 --- Result5323 to Stage5AverageLap
perl -i -pe 's|Result5401 \[\.\.\.\]|Result5401 [ Stage5ParcoursStation1Points ]|g' Dependencies.txt
echo 1092 / 1866 --- Result5401 to Stage5ParcoursStation1Points
perl -i -pe 's|Result5402 \[\.\.\.\]|Result5402 [ Stage5ParcoursStation2Points ]|g' Dependencies.txt
echo 1093 / 1866 --- Result5402 to Stage5ParcoursStation2Points
perl -i -pe 's|Result5403 \[\.\.\.\]|Result5403 [ Stage5ParcoursStation3Points ]|g' Dependencies.txt
echo 1094 / 1866 --- Result5403 to Stage5ParcoursStation3Points
perl -i -pe 's|Result5404 \[\.\.\.\]|Result5404 [ Stage5ParcoursStation4Points ]|g' Dependencies.txt
echo 1095 / 1866 --- Result5404 to Stage5ParcoursStation4Points
perl -i -pe 's|Result5405 \[\.\.\.\]|Result5405 [ Stage5ParcoursStation5Points ]|g' Dependencies.txt
echo 1096 / 1866 --- Result5405 to Stage5ParcoursStation5Points
perl -i -pe 's|Result5406 \[\.\.\.\]|Result5406 [ Stage5ParcoursStation6Points ]|g' Dependencies.txt
echo 1097 / 1866 --- Result5406 to Stage5ParcoursStation6Points
perl -i -pe 's|Result5407 \[\.\.\.\]|Result5407 [ Stage5ParcoursStation7Points ]|g' Dependencies.txt
echo 1098 / 1866 --- Result5407 to Stage5ParcoursStation7Points
perl -i -pe 's|Result5408 \[\.\.\.\]|Result5408 [ Stage5ParcoursStation8Points ]|g' Dependencies.txt
echo 1099 / 1866 --- Result5408 to Stage5ParcoursStation8Points
perl -i -pe 's|Result5409 \[\.\.\.\]|Result5409 [ Stage5ParcoursStation9Points ]|g' Dependencies.txt
echo 1100 / 1866 --- Result5409 to Stage5ParcoursStation9Points
perl -i -pe 's|Result5410 \[\.\.\.\]|Result5410 [ Stage5ParcoursStation10Points ]|g' Dependencies.txt
echo 1101 / 1866 --- Result5410 to Stage5ParcoursStation10Points
perl -i -pe 's|Result5411 \[\.\.\.\]|Result5411 [ Stage5ParcoursStation11Points ]|g' Dependencies.txt
echo 1102 / 1866 --- Result5411 to Stage5ParcoursStation11Points
perl -i -pe 's|Result5412 \[\.\.\.\]|Result5412 [ Stage5ParcoursStation12Points ]|g' Dependencies.txt
echo 1103 / 1866 --- Result5412 to Stage5ParcoursStation12Points
perl -i -pe 's|Result5413 \[\.\.\.\]|Result5413 [ Stage5ParcoursStation13Points ]|g' Dependencies.txt
echo 1104 / 1866 --- Result5413 to Stage5ParcoursStation13Points
perl -i -pe 's|Result5414 \[\.\.\.\]|Result5414 [ Stage5ParcoursStation14Points ]|g' Dependencies.txt
echo 1105 / 1866 --- Result5414 to Stage5ParcoursStation14Points
perl -i -pe 's|Result5415 \[\.\.\.\]|Result5415 [ Stage5ParcoursStation15Points ]|g' Dependencies.txt
echo 1106 / 1866 --- Result5415 to Stage5ParcoursStation15Points
perl -i -pe 's|Result5430 \[\.\.\.\]|Result5430 [ Stage5ParcoursTotalPoints ]|g' Dependencies.txt
echo 1107 / 1866 --- Result5430 to Stage5ParcoursTotalPoints
perl -i -pe 's|Result5441 \[\.\.\.\]|Result5441 [ Stage5ParcoursStart ]|g' Dependencies.txt
echo 1108 / 1866 --- Result5441 to Stage5ParcoursStart
perl -i -pe 's|Result5442 \[\.\.\.\]|Result5442 [ Stage5ParcoursFinish ]|g' Dependencies.txt
echo 1109 / 1866 --- Result5442 to Stage5ParcoursFinish
perl -i -pe 's|Result5450 \[\.\.\.\]|Result5450 [ Stage5ParcoursTime ]|g' Dependencies.txt
echo 1110 / 1866 --- Result5450 to Stage5ParcoursTime
perl -i -pe 's|Result5501 \[\.\.\.\]|Result5501 [ Stage5ParcoursRankingPoints ]|g' Dependencies.txt
echo 1111 / 1866 --- Result5501 to Stage5ParcoursRankingPoints
perl -i -pe 's|Result5502 \[\.\.\.\]|Result5502 [ Stage5CrossCountryRankingPoints ]|g' Dependencies.txt
echo 1112 / 1866 --- Result5502 to Stage5CrossCountryRankingPoints
perl -i -pe 's|Result5503 \[\.\.\.\]|Result5503 [ Stage5TotalRankingPoints ]|g' Dependencies.txt
echo 1113 / 1866 --- Result5503 to Stage5TotalRankingPoints
perl -i -pe 's|Result5611 \[\.\.\.\]|Result5611 [ Stage5Lap1Sector1 ]|g' Dependencies.txt
echo 1114 / 1866 --- Result5611 to Stage5Lap1Sector1
perl -i -pe 's|Result5612 \[\.\.\.\]|Result5612 [ Stage5Lap2Sector1 ]|g' Dependencies.txt
echo 1115 / 1866 --- Result5612 to Stage5Lap2Sector1
perl -i -pe 's|Result5613 \[\.\.\.\]|Result5613 [ Stage5Lap3Sector1 ]|g' Dependencies.txt
echo 1116 / 1866 --- Result5613 to Stage5Lap3Sector1
perl -i -pe 's|Result5614 \[\.\.\.\]|Result5614 [ Stage5Lap4Sector1 ]|g' Dependencies.txt
echo 1117 / 1866 --- Result5614 to Stage5Lap4Sector1
perl -i -pe 's|Result5615 \[\.\.\.\]|Result5615 [ Stage5Lap5Sector1 ]|g' Dependencies.txt
echo 1118 / 1866 --- Result5615 to Stage5Lap5Sector1
perl -i -pe 's|Result5616 \[\.\.\.\]|Result5616 [ Stage5Lap6Sector1 ]|g' Dependencies.txt
echo 1119 / 1866 --- Result5616 to Stage5Lap6Sector1
perl -i -pe 's|Result5617 \[\.\.\.\]|Result5617 [ Stage5Lap7Sector1 ]|g' Dependencies.txt
echo 1120 / 1866 --- Result5617 to Stage5Lap7Sector1
perl -i -pe 's|Result5618 \[\.\.\.\]|Result5618 [ Stage5Lap8Sector1 ]|g' Dependencies.txt
echo 1121 / 1866 --- Result5618 to Stage5Lap8Sector1
perl -i -pe 's|Result5619 \[\.\.\.\]|Result5619 [ Stage5Lap9Sector1 ]|g' Dependencies.txt
echo 1122 / 1866 --- Result5619 to Stage5Lap9Sector1
perl -i -pe 's|Result5620 \[\.\.\.\]|Result5620 [ Stage5Lap10Sector1 ]|g' Dependencies.txt
echo 1123 / 1866 --- Result5620 to Stage5Lap10Sector1
perl -i -pe 's|Result5621 \[\.\.\.\]|Result5621 [ Stage5Lap1Sector2 ]|g' Dependencies.txt
echo 1124 / 1866 --- Result5621 to Stage5Lap1Sector2
perl -i -pe 's|Result5622 \[\.\.\.\]|Result5622 [ Stage5Lap2Sector2 ]|g' Dependencies.txt
echo 1125 / 1866 --- Result5622 to Stage5Lap2Sector2
perl -i -pe 's|Result5623 \[\.\.\.\]|Result5623 [ Stage5Lap3Sector2 ]|g' Dependencies.txt
echo 1126 / 1866 --- Result5623 to Stage5Lap3Sector2
perl -i -pe 's|Result5624 \[\.\.\.\]|Result5624 [ Stage5Lap4Sector2 ]|g' Dependencies.txt
echo 1127 / 1866 --- Result5624 to Stage5Lap4Sector2
perl -i -pe 's|Result5625 \[\.\.\.\]|Result5625 [ Stage5Lap5Sector2 ]|g' Dependencies.txt
echo 1128 / 1866 --- Result5625 to Stage5Lap5Sector2
perl -i -pe 's|Result5626 \[\.\.\.\]|Result5626 [ Stage5Lap6Sector2 ]|g' Dependencies.txt
echo 1129 / 1866 --- Result5626 to Stage5Lap6Sector2
perl -i -pe 's|Result5627 \[\.\.\.\]|Result5627 [ Stage5Lap7Sector2 ]|g' Dependencies.txt
echo 1130 / 1866 --- Result5627 to Stage5Lap7Sector2
perl -i -pe 's|Result5628 \[\.\.\.\]|Result5628 [ Stage5Lap8Sector2 ]|g' Dependencies.txt
echo 1131 / 1866 --- Result5628 to Stage5Lap8Sector2
perl -i -pe 's|Result5629 \[\.\.\.\]|Result5629 [ Stage5Lap9Sector2 ]|g' Dependencies.txt
echo 1132 / 1866 --- Result5629 to Stage5Lap9Sector2
perl -i -pe 's|Result5630 \[\.\.\.\]|Result5630 [ Stage5Lap10Sector2 ]|g' Dependencies.txt
echo 1133 / 1866 --- Result5630 to Stage5Lap10Sector2
perl -i -pe 's|Result5631 \[\.\.\.\]|Result5631 [ Stage5Lap1Sector3 ]|g' Dependencies.txt
echo 1134 / 1866 --- Result5631 to Stage5Lap1Sector3
perl -i -pe 's|Result5632 \[\.\.\.\]|Result5632 [ Stage5Lap2Sector3 ]|g' Dependencies.txt
echo 1135 / 1866 --- Result5632 to Stage5Lap2Sector3
perl -i -pe 's|Result5633 \[\.\.\.\]|Result5633 [ Stage5Lap3Sector3 ]|g' Dependencies.txt
echo 1136 / 1866 --- Result5633 to Stage5Lap3Sector3
perl -i -pe 's|Result5634 \[\.\.\.\]|Result5634 [ Stage5Lap4Sector3 ]|g' Dependencies.txt
echo 1137 / 1866 --- Result5634 to Stage5Lap4Sector3
perl -i -pe 's|Result5635 \[\.\.\.\]|Result5635 [ Stage5Lap5Sector3 ]|g' Dependencies.txt
echo 1138 / 1866 --- Result5635 to Stage5Lap5Sector3
perl -i -pe 's|Result5636 \[\.\.\.\]|Result5636 [ Stage5Lap6Sector3 ]|g' Dependencies.txt
echo 1139 / 1866 --- Result5636 to Stage5Lap6Sector3
perl -i -pe 's|Result5637 \[\.\.\.\]|Result5637 [ Stage5Lap7Sector3 ]|g' Dependencies.txt
echo 1140 / 1866 --- Result5637 to Stage5Lap7Sector3
perl -i -pe 's|Result5638 \[\.\.\.\]|Result5638 [ Stage5Lap8Sector3 ]|g' Dependencies.txt
echo 1141 / 1866 --- Result5638 to Stage5Lap8Sector3
perl -i -pe 's|Result5639 \[\.\.\.\]|Result5639 [ Stage5Lap9Sector3 ]|g' Dependencies.txt
echo 1142 / 1866 --- Result5639 to Stage5Lap9Sector3
perl -i -pe 's|Result5640 \[\.\.\.\]|Result5640 [ Stage5Lap10Sector3 ]|g' Dependencies.txt
echo 1143 / 1866 --- Result5640 to Stage5Lap10Sector3
perl -i -pe 's|Result5641 \[\.\.\.\]|Result5641 [ Stage5Lap1Sector4 ]|g' Dependencies.txt
echo 1144 / 1866 --- Result5641 to Stage5Lap1Sector4
perl -i -pe 's|Result5642 \[\.\.\.\]|Result5642 [ Stage5Lap2Sector4 ]|g' Dependencies.txt
echo 1145 / 1866 --- Result5642 to Stage5Lap2Sector4
perl -i -pe 's|Result5643 \[\.\.\.\]|Result5643 [ Stage5Lap3Sector4 ]|g' Dependencies.txt
echo 1146 / 1866 --- Result5643 to Stage5Lap3Sector4
perl -i -pe 's|Result5644 \[\.\.\.\]|Result5644 [ Stage5Lap4Sector4 ]|g' Dependencies.txt
echo 1147 / 1866 --- Result5644 to Stage5Lap4Sector4
perl -i -pe 's|Result5645 \[\.\.\.\]|Result5645 [ Stage5Lap5Sector4 ]|g' Dependencies.txt
echo 1148 / 1866 --- Result5645 to Stage5Lap5Sector4
perl -i -pe 's|Result5646 \[\.\.\.\]|Result5646 [ Stage5Lap6Sector4 ]|g' Dependencies.txt
echo 1149 / 1866 --- Result5646 to Stage5Lap6Sector4
perl -i -pe 's|Result5647 \[\.\.\.\]|Result5647 [ Stage5Lap7Sector4 ]|g' Dependencies.txt
echo 1150 / 1866 --- Result5647 to Stage5Lap7Sector4
perl -i -pe 's|Result5648 \[\.\.\.\]|Result5648 [ Stage5Lap8Sector4 ]|g' Dependencies.txt
echo 1151 / 1866 --- Result5648 to Stage5Lap8Sector4
perl -i -pe 's|Result5649 \[\.\.\.\]|Result5649 [ Stage5Lap9Sector4 ]|g' Dependencies.txt
echo 1152 / 1866 --- Result5649 to Stage5Lap9Sector4
perl -i -pe 's|Result5650 \[\.\.\.\]|Result5650 [ Stage5Lap10Sector4 ]|g' Dependencies.txt
echo 1153 / 1866 --- Result5650 to Stage5Lap10Sector4
perl -i -pe 's|Result5651 \[\.\.\.\]|Result5651 [ Stage5Lap1UphillSector ]|g' Dependencies.txt
echo 1154 / 1866 --- Result5651 to Stage5Lap1UphillSector
perl -i -pe 's|Result5652 \[\.\.\.\]|Result5652 [ Stage5Lap2UphillSector ]|g' Dependencies.txt
echo 1155 / 1866 --- Result5652 to Stage5Lap2UphillSector
perl -i -pe 's|Result5653 \[\.\.\.\]|Result5653 [ Stage5Lap3UphillSector ]|g' Dependencies.txt
echo 1156 / 1866 --- Result5653 to Stage5Lap3UphillSector
perl -i -pe 's|Result5654 \[\.\.\.\]|Result5654 [ Stage5Lap4UphillSector ]|g' Dependencies.txt
echo 1157 / 1866 --- Result5654 to Stage5Lap4UphillSector
perl -i -pe 's|Result5655 \[\.\.\.\]|Result5655 [ Stage5Lap5UphillSector ]|g' Dependencies.txt
echo 1158 / 1866 --- Result5655 to Stage5Lap5UphillSector
perl -i -pe 's|Result5656 \[\.\.\.\]|Result5656 [ Stage5Lap6UphillSector ]|g' Dependencies.txt
echo 1159 / 1866 --- Result5656 to Stage5Lap6UphillSector
perl -i -pe 's|Result5657 \[\.\.\.\]|Result5657 [ Stage5Lap7UphillSector ]|g' Dependencies.txt
echo 1160 / 1866 --- Result5657 to Stage5Lap7UphillSector
perl -i -pe 's|Result5658 \[\.\.\.\]|Result5658 [ Stage5Lap8UphillSector ]|g' Dependencies.txt
echo 1161 / 1866 --- Result5658 to Stage5Lap8UphillSector
perl -i -pe 's|Result5659 \[\.\.\.\]|Result5659 [ Stage5Lap9UphillSector ]|g' Dependencies.txt
echo 1162 / 1866 --- Result5659 to Stage5Lap9UphillSector
perl -i -pe 's|Result5660 \[\.\.\.\]|Result5660 [ Stage5Lap10UphillSector ]|g' Dependencies.txt
echo 1163 / 1866 --- Result5660 to Stage5Lap10UphillSector
perl -i -pe 's|Result5680 \[\.\.\.\]|Result5680 [ Stage5FastestUphillSector ]|g' Dependencies.txt
echo 1164 / 1866 --- Result5680 to Stage5FastestUphillSector
perl -i -pe 's|Result5681 \[\.\.\.\]|Result5681 [ Stage5FastestUphillSectorID ]|g' Dependencies.txt
echo 1165 / 1866 --- Result5681 to Stage5FastestUphillSectorID
perl -i -pe 's|Result6000 \[\.\.\.\]|Result6000 [ Stage6StartTime ]|g' Dependencies.txt
echo 1166 / 1866 --- Result6000 to Stage6StartTime
perl -i -pe 's|Result6001 \[\.\.\.\]|Result6001 [ Stage6FinishTimeLimit ]|g' Dependencies.txt
echo 1167 / 1866 --- Result6001 to Stage6FinishTimeLimit
perl -i -pe 's|Result6100 \[\.\.\.\]|Result6100 [ Stage6Started ]|g' Dependencies.txt
echo 1168 / 1866 --- Result6100 to Stage6Started
perl -i -pe 's|Result6101 \[\.\.\.\]|Result6101 [ Stage6AfterLap1Split1 ]|g' Dependencies.txt
echo 1169 / 1866 --- Result6101 to Stage6AfterLap1Split1
perl -i -pe 's|Result6102 \[\.\.\.\]|Result6102 [ Stage6AfterLap1Split2 ]|g' Dependencies.txt
echo 1170 / 1866 --- Result6102 to Stage6AfterLap1Split2
perl -i -pe 's|Result6103 \[\.\.\.\]|Result6103 [ Stage6AfterLap1Split3 ]|g' Dependencies.txt
echo 1171 / 1866 --- Result6103 to Stage6AfterLap1Split3
perl -i -pe 's|Result6104 \[\.\.\.\]|Result6104 [ Stage6AfterLap1Spotter ]|g' Dependencies.txt
echo 1172 / 1866 --- Result6104 to Stage6AfterLap1Spotter
perl -i -pe 's|Result6105 \[\.\.\.\]|Result6105 [ Stage6AfterLap1Finish ]|g' Dependencies.txt
echo 1173 / 1866 --- Result6105 to Stage6AfterLap1Finish
perl -i -pe 's|Result6106 \[\.\.\.\]|Result6106 [ Stage6AfterLap2Split1 ]|g' Dependencies.txt
echo 1174 / 1866 --- Result6106 to Stage6AfterLap2Split1
perl -i -pe 's|Result6107 \[\.\.\.\]|Result6107 [ Stage6AfterLap2Split2 ]|g' Dependencies.txt
echo 1175 / 1866 --- Result6107 to Stage6AfterLap2Split2
perl -i -pe 's|Result6108 \[\.\.\.\]|Result6108 [ Stage6AfterLap2Split3 ]|g' Dependencies.txt
echo 1176 / 1866 --- Result6108 to Stage6AfterLap2Split3
perl -i -pe 's|Result6109 \[\.\.\.\]|Result6109 [ Stage6AfterLap2Spotter ]|g' Dependencies.txt
echo 1177 / 1866 --- Result6109 to Stage6AfterLap2Spotter
perl -i -pe 's|Result6110 \[\.\.\.\]|Result6110 [ Stage6AfterLap2Finish ]|g' Dependencies.txt
echo 1178 / 1866 --- Result6110 to Stage6AfterLap2Finish
perl -i -pe 's|Result6111 \[\.\.\.\]|Result6111 [ Stage6AfterLap3Split1 ]|g' Dependencies.txt
echo 1179 / 1866 --- Result6111 to Stage6AfterLap3Split1
perl -i -pe 's|Result6112 \[\.\.\.\]|Result6112 [ Stage6AfterLap3Split2 ]|g' Dependencies.txt
echo 1180 / 1866 --- Result6112 to Stage6AfterLap3Split2
perl -i -pe 's|Result6113 \[\.\.\.\]|Result6113 [ Stage6AfterLap3Split3 ]|g' Dependencies.txt
echo 1181 / 1866 --- Result6113 to Stage6AfterLap3Split3
perl -i -pe 's|Result6114 \[\.\.\.\]|Result6114 [ Stage6AfterLap3Spotter ]|g' Dependencies.txt
echo 1182 / 1866 --- Result6114 to Stage6AfterLap3Spotter
perl -i -pe 's|Result6115 \[\.\.\.\]|Result6115 [ Stage6AfterLap3Finish ]|g' Dependencies.txt
echo 1183 / 1866 --- Result6115 to Stage6AfterLap3Finish
perl -i -pe 's|Result6116 \[\.\.\.\]|Result6116 [ Stage6AfterLap4Split1 ]|g' Dependencies.txt
echo 1184 / 1866 --- Result6116 to Stage6AfterLap4Split1
perl -i -pe 's|Result6117 \[\.\.\.\]|Result6117 [ Stage6AfterLap4Split2 ]|g' Dependencies.txt
echo 1185 / 1866 --- Result6117 to Stage6AfterLap4Split2
perl -i -pe 's|Result6118 \[\.\.\.\]|Result6118 [ Stage6AfterLap4Split3 ]|g' Dependencies.txt
echo 1186 / 1866 --- Result6118 to Stage6AfterLap4Split3
perl -i -pe 's|Result6119 \[\.\.\.\]|Result6119 [ Stage6AfterLap4Spotter ]|g' Dependencies.txt
echo 1187 / 1866 --- Result6119 to Stage6AfterLap4Spotter
perl -i -pe 's|Result6120 \[\.\.\.\]|Result6120 [ Stage6AfterLap4Finish ]|g' Dependencies.txt
echo 1188 / 1866 --- Result6120 to Stage6AfterLap4Finish
perl -i -pe 's|Result6121 \[\.\.\.\]|Result6121 [ Stage6AfterLap5Split1 ]|g' Dependencies.txt
echo 1189 / 1866 --- Result6121 to Stage6AfterLap5Split1
perl -i -pe 's|Result6122 \[\.\.\.\]|Result6122 [ Stage6AfterLap5Split2 ]|g' Dependencies.txt
echo 1190 / 1866 --- Result6122 to Stage6AfterLap5Split2
perl -i -pe 's|Result6123 \[\.\.\.\]|Result6123 [ Stage6AfterLap5Split3 ]|g' Dependencies.txt
echo 1191 / 1866 --- Result6123 to Stage6AfterLap5Split3
perl -i -pe 's|Result6124 \[\.\.\.\]|Result6124 [ Stage6AfterLap5Spotter ]|g' Dependencies.txt
echo 1192 / 1866 --- Result6124 to Stage6AfterLap5Spotter
perl -i -pe 's|Result6125 \[\.\.\.\]|Result6125 [ Stage6AfterLap5Finish ]|g' Dependencies.txt
echo 1193 / 1866 --- Result6125 to Stage6AfterLap5Finish
perl -i -pe 's|Result6126 \[\.\.\.\]|Result6126 [ Stage6AfterLap6Split1 ]|g' Dependencies.txt
echo 1194 / 1866 --- Result6126 to Stage6AfterLap6Split1
perl -i -pe 's|Result6127 \[\.\.\.\]|Result6127 [ Stage6AfterLap6Split2 ]|g' Dependencies.txt
echo 1195 / 1866 --- Result6127 to Stage6AfterLap6Split2
perl -i -pe 's|Result6128 \[\.\.\.\]|Result6128 [ Stage6AfterLap6Split3 ]|g' Dependencies.txt
echo 1196 / 1866 --- Result6128 to Stage6AfterLap6Split3
perl -i -pe 's|Result6129 \[\.\.\.\]|Result6129 [ Stage6AfterLap6Spotter ]|g' Dependencies.txt
echo 1197 / 1866 --- Result6129 to Stage6AfterLap6Spotter
perl -i -pe 's|Result6130 \[\.\.\.\]|Result6130 [ Stage6AfterLap6Finish ]|g' Dependencies.txt
echo 1198 / 1866 --- Result6130 to Stage6AfterLap6Finish
perl -i -pe 's|Result6131 \[\.\.\.\]|Result6131 [ Stage6AfterLap7Split1 ]|g' Dependencies.txt
echo 1199 / 1866 --- Result6131 to Stage6AfterLap7Split1
perl -i -pe 's|Result6132 \[\.\.\.\]|Result6132 [ Stage6AfterLap7Split2 ]|g' Dependencies.txt
echo 1200 / 1866 --- Result6132 to Stage6AfterLap7Split2
perl -i -pe 's|Result6133 \[\.\.\.\]|Result6133 [ Stage6AfterLap7Split3 ]|g' Dependencies.txt
echo 1201 / 1866 --- Result6133 to Stage6AfterLap7Split3
perl -i -pe 's|Result6134 \[\.\.\.\]|Result6134 [ Stage6AfterLap7Spotter ]|g' Dependencies.txt
echo 1202 / 1866 --- Result6134 to Stage6AfterLap7Spotter
perl -i -pe 's|Result6135 \[\.\.\.\]|Result6135 [ Stage6AfterLap7Finish ]|g' Dependencies.txt
echo 1203 / 1866 --- Result6135 to Stage6AfterLap7Finish
perl -i -pe 's|Result6136 \[\.\.\.\]|Result6136 [ Stage6AfterLap8Split1 ]|g' Dependencies.txt
echo 1204 / 1866 --- Result6136 to Stage6AfterLap8Split1
perl -i -pe 's|Result6137 \[\.\.\.\]|Result6137 [ Stage6AfterLap8Split2 ]|g' Dependencies.txt
echo 1205 / 1866 --- Result6137 to Stage6AfterLap8Split2
perl -i -pe 's|Result6138 \[\.\.\.\]|Result6138 [ Stage6AfterLap8Split3 ]|g' Dependencies.txt
echo 1206 / 1866 --- Result6138 to Stage6AfterLap8Split3
perl -i -pe 's|Result6139 \[\.\.\.\]|Result6139 [ Stage6AfterLap8Spotter ]|g' Dependencies.txt
echo 1207 / 1866 --- Result6139 to Stage6AfterLap8Spotter
perl -i -pe 's|Result6140 \[\.\.\.\]|Result6140 [ Stage6AfterLap8Finish ]|g' Dependencies.txt
echo 1208 / 1866 --- Result6140 to Stage6AfterLap8Finish
perl -i -pe 's|Result6141 \[\.\.\.\]|Result6141 [ Stage6AfterLap9Split1 ]|g' Dependencies.txt
echo 1209 / 1866 --- Result6141 to Stage6AfterLap9Split1
perl -i -pe 's|Result6142 \[\.\.\.\]|Result6142 [ Stage6AfterLap9Split2 ]|g' Dependencies.txt
echo 1210 / 1866 --- Result6142 to Stage6AfterLap9Split2
perl -i -pe 's|Result6143 \[\.\.\.\]|Result6143 [ Stage6AfterLap9Split3 ]|g' Dependencies.txt
echo 1211 / 1866 --- Result6143 to Stage6AfterLap9Split3
perl -i -pe 's|Result6144 \[\.\.\.\]|Result6144 [ Stage6AfterLap9Spotter ]|g' Dependencies.txt
echo 1212 / 1866 --- Result6144 to Stage6AfterLap9Spotter
perl -i -pe 's|Result6145 \[\.\.\.\]|Result6145 [ Stage6AfterLap9Finish ]|g' Dependencies.txt
echo 1213 / 1866 --- Result6145 to Stage6AfterLap9Finish
perl -i -pe 's|Result6146 \[\.\.\.\]|Result6146 [ Stage6AfterLap10Split1 ]|g' Dependencies.txt
echo 1214 / 1866 --- Result6146 to Stage6AfterLap10Split1
perl -i -pe 's|Result6147 \[\.\.\.\]|Result6147 [ Stage6AfterLap10Split2 ]|g' Dependencies.txt
echo 1215 / 1866 --- Result6147 to Stage6AfterLap10Split2
perl -i -pe 's|Result6148 \[\.\.\.\]|Result6148 [ Stage6AfterLap10Split3 ]|g' Dependencies.txt
echo 1216 / 1866 --- Result6148 to Stage6AfterLap10Split3
perl -i -pe 's|Result6149 \[\.\.\.\]|Result6149 [ Stage6AfterLap10Spotter ]|g' Dependencies.txt
echo 1217 / 1866 --- Result6149 to Stage6AfterLap10Spotter
perl -i -pe 's|Result6150 \[\.\.\.\]|Result6150 [ Stage6AfterLap10Finish ]|g' Dependencies.txt
echo 1218 / 1866 --- Result6150 to Stage6AfterLap10Finish
perl -i -pe 's|Result6190 \[\.\.\.\]|Result6190 [ Stage6AfterFinish ]|g' Dependencies.txt
echo 1219 / 1866 --- Result6190 to Stage6AfterFinish
perl -i -pe 's|Result6191 \[\.\.\.\]|Result6191 [ Stage6LastSplitID ]|g' Dependencies.txt
echo 1220 / 1866 --- Result6191 to Stage6LastSplitID
perl -i -pe 's|Result6192 \[\.\.\.\]|Result6192 [ Stage6LastSplit ]|g' Dependencies.txt
echo 1221 / 1866 --- Result6192 to Stage6LastSplit
perl -i -pe 's|Result6193 \[\.\.\.\]|Result6193 [ Stage6LastFinishID ]|g' Dependencies.txt
echo 1222 / 1866 --- Result6193 to Stage6LastFinishID
perl -i -pe 's|Result6194 \[\.\.\.\]|Result6194 [ Stage6LastFinish ]|g' Dependencies.txt
echo 1223 / 1866 --- Result6194 to Stage6LastFinish
perl -i -pe 's|Result6195 \[\.\.\.\]|Result6195 [ Stage6LastSplitBunchTime ]|g' Dependencies.txt
echo 1224 / 1866 --- Result6195 to Stage6LastSplitBunchTime
perl -i -pe 's|Result6196 \[\.\.\.\]|Result6196 [ Stage6PhotoBunchTime ]|g' Dependencies.txt
echo 1225 / 1866 --- Result6196 to Stage6PhotoBunchTime
perl -i -pe 's|Result6200 \[\.\.\.\]|Result6200 [ Stage6Start ]|g' Dependencies.txt
echo 1226 / 1866 --- Result6200 to Stage6Start
perl -i -pe 's|Result6201 \[\.\.\.\]|Result6201 [ Stage6Lap1Split1 ]|g' Dependencies.txt
echo 1227 / 1866 --- Result6201 to Stage6Lap1Split1
perl -i -pe 's|Result6202 \[\.\.\.\]|Result6202 [ Stage6Lap1Split2 ]|g' Dependencies.txt
echo 1228 / 1866 --- Result6202 to Stage6Lap1Split2
perl -i -pe 's|Result6203 \[\.\.\.\]|Result6203 [ Stage6Lap1Split3 ]|g' Dependencies.txt
echo 1229 / 1866 --- Result6203 to Stage6Lap1Split3
perl -i -pe 's|Result6204 \[\.\.\.\]|Result6204 [ Stage6Lap1Spotter ]|g' Dependencies.txt
echo 1230 / 1866 --- Result6204 to Stage6Lap1Spotter
perl -i -pe 's|Result6205 \[\.\.\.\]|Result6205 [ Stage6Lap1Finish ]|g' Dependencies.txt
echo 1231 / 1866 --- Result6205 to Stage6Lap1Finish
perl -i -pe 's|Result6206 \[\.\.\.\]|Result6206 [ Stage6Lap2Split1 ]|g' Dependencies.txt
echo 1232 / 1866 --- Result6206 to Stage6Lap2Split1
perl -i -pe 's|Result6207 \[\.\.\.\]|Result6207 [ Stage6Lap2Split2 ]|g' Dependencies.txt
echo 1233 / 1866 --- Result6207 to Stage6Lap2Split2
perl -i -pe 's|Result6208 \[\.\.\.\]|Result6208 [ Stage6Lap2Split3 ]|g' Dependencies.txt
echo 1234 / 1866 --- Result6208 to Stage6Lap2Split3
perl -i -pe 's|Result6209 \[\.\.\.\]|Result6209 [ Stage6Lap2Spotter ]|g' Dependencies.txt
echo 1235 / 1866 --- Result6209 to Stage6Lap2Spotter
perl -i -pe 's|Result6210 \[\.\.\.\]|Result6210 [ Stage6Lap2Finish ]|g' Dependencies.txt
echo 1236 / 1866 --- Result6210 to Stage6Lap2Finish
perl -i -pe 's|Result6211 \[\.\.\.\]|Result6211 [ Stage6Lap3Split1 ]|g' Dependencies.txt
echo 1237 / 1866 --- Result6211 to Stage6Lap3Split1
perl -i -pe 's|Result6212 \[\.\.\.\]|Result6212 [ Stage6Lap3Split2 ]|g' Dependencies.txt
echo 1238 / 1866 --- Result6212 to Stage6Lap3Split2
perl -i -pe 's|Result6213 \[\.\.\.\]|Result6213 [ Stage6Lap3Split3 ]|g' Dependencies.txt
echo 1239 / 1866 --- Result6213 to Stage6Lap3Split3
perl -i -pe 's|Result6214 \[\.\.\.\]|Result6214 [ Stage6Lap3Spotter ]|g' Dependencies.txt
echo 1240 / 1866 --- Result6214 to Stage6Lap3Spotter
perl -i -pe 's|Result6215 \[\.\.\.\]|Result6215 [ Stage6Lap3Finish ]|g' Dependencies.txt
echo 1241 / 1866 --- Result6215 to Stage6Lap3Finish
perl -i -pe 's|Result6216 \[\.\.\.\]|Result6216 [ Stage6Lap4Split1 ]|g' Dependencies.txt
echo 1242 / 1866 --- Result6216 to Stage6Lap4Split1
perl -i -pe 's|Result6217 \[\.\.\.\]|Result6217 [ Stage6Lap4Split2 ]|g' Dependencies.txt
echo 1243 / 1866 --- Result6217 to Stage6Lap4Split2
perl -i -pe 's|Result6218 \[\.\.\.\]|Result6218 [ Stage6Lap4Split3 ]|g' Dependencies.txt
echo 1244 / 1866 --- Result6218 to Stage6Lap4Split3
perl -i -pe 's|Result6219 \[\.\.\.\]|Result6219 [ Stage6Lap4Spotter ]|g' Dependencies.txt
echo 1245 / 1866 --- Result6219 to Stage6Lap4Spotter
perl -i -pe 's|Result6220 \[\.\.\.\]|Result6220 [ Stage6Lap4Finish ]|g' Dependencies.txt
echo 1246 / 1866 --- Result6220 to Stage6Lap4Finish
perl -i -pe 's|Result6221 \[\.\.\.\]|Result6221 [ Stage6Lap5Split1 ]|g' Dependencies.txt
echo 1247 / 1866 --- Result6221 to Stage6Lap5Split1
perl -i -pe 's|Result6222 \[\.\.\.\]|Result6222 [ Stage6Lap5Split2 ]|g' Dependencies.txt
echo 1248 / 1866 --- Result6222 to Stage6Lap5Split2
perl -i -pe 's|Result6223 \[\.\.\.\]|Result6223 [ Stage6Lap5Split3 ]|g' Dependencies.txt
echo 1249 / 1866 --- Result6223 to Stage6Lap5Split3
perl -i -pe 's|Result6224 \[\.\.\.\]|Result6224 [ Stage6Lap5Spotter ]|g' Dependencies.txt
echo 1250 / 1866 --- Result6224 to Stage6Lap5Spotter
perl -i -pe 's|Result6225 \[\.\.\.\]|Result6225 [ Stage6Lap5Finish ]|g' Dependencies.txt
echo 1251 / 1866 --- Result6225 to Stage6Lap5Finish
perl -i -pe 's|Result6226 \[\.\.\.\]|Result6226 [ Stage6Lap6Split1 ]|g' Dependencies.txt
echo 1252 / 1866 --- Result6226 to Stage6Lap6Split1
perl -i -pe 's|Result6227 \[\.\.\.\]|Result6227 [ Stage6Lap6Split2 ]|g' Dependencies.txt
echo 1253 / 1866 --- Result6227 to Stage6Lap6Split2
perl -i -pe 's|Result6228 \[\.\.\.\]|Result6228 [ Stage6Lap6Split3 ]|g' Dependencies.txt
echo 1254 / 1866 --- Result6228 to Stage6Lap6Split3
perl -i -pe 's|Result6229 \[\.\.\.\]|Result6229 [ Stage6Lap6Spotter ]|g' Dependencies.txt
echo 1255 / 1866 --- Result6229 to Stage6Lap6Spotter
perl -i -pe 's|Result6230 \[\.\.\.\]|Result6230 [ Stage6Lap6Finish ]|g' Dependencies.txt
echo 1256 / 1866 --- Result6230 to Stage6Lap6Finish
perl -i -pe 's|Result6231 \[\.\.\.\]|Result6231 [ Stage6Lap7Split1 ]|g' Dependencies.txt
echo 1257 / 1866 --- Result6231 to Stage6Lap7Split1
perl -i -pe 's|Result6232 \[\.\.\.\]|Result6232 [ Stage6Lap7Split2 ]|g' Dependencies.txt
echo 1258 / 1866 --- Result6232 to Stage6Lap7Split2
perl -i -pe 's|Result6233 \[\.\.\.\]|Result6233 [ Stage6Lap7Split3 ]|g' Dependencies.txt
echo 1259 / 1866 --- Result6233 to Stage6Lap7Split3
perl -i -pe 's|Result6234 \[\.\.\.\]|Result6234 [ Stage6Lap7Spotter ]|g' Dependencies.txt
echo 1260 / 1866 --- Result6234 to Stage6Lap7Spotter
perl -i -pe 's|Result6235 \[\.\.\.\]|Result6235 [ Stage6Lap7Finish ]|g' Dependencies.txt
echo 1261 / 1866 --- Result6235 to Stage6Lap7Finish
perl -i -pe 's|Result6236 \[\.\.\.\]|Result6236 [ Stage6Lap8Split1 ]|g' Dependencies.txt
echo 1262 / 1866 --- Result6236 to Stage6Lap8Split1
perl -i -pe 's|Result6237 \[\.\.\.\]|Result6237 [ Stage6Lap8Split2 ]|g' Dependencies.txt
echo 1263 / 1866 --- Result6237 to Stage6Lap8Split2
perl -i -pe 's|Result6238 \[\.\.\.\]|Result6238 [ Stage6Lap8Split3 ]|g' Dependencies.txt
echo 1264 / 1866 --- Result6238 to Stage6Lap8Split3
perl -i -pe 's|Result6239 \[\.\.\.\]|Result6239 [ Stage6Lap8Spotter ]|g' Dependencies.txt
echo 1265 / 1866 --- Result6239 to Stage6Lap8Spotter
perl -i -pe 's|Result6240 \[\.\.\.\]|Result6240 [ Stage6Lap8Finish ]|g' Dependencies.txt
echo 1266 / 1866 --- Result6240 to Stage6Lap8Finish
perl -i -pe 's|Result6241 \[\.\.\.\]|Result6241 [ Stage6Lap9Split1 ]|g' Dependencies.txt
echo 1267 / 1866 --- Result6241 to Stage6Lap9Split1
perl -i -pe 's|Result6242 \[\.\.\.\]|Result6242 [ Stage6Lap9Split2 ]|g' Dependencies.txt
echo 1268 / 1866 --- Result6242 to Stage6Lap9Split2
perl -i -pe 's|Result6243 \[\.\.\.\]|Result6243 [ Stage6Lap9Split3 ]|g' Dependencies.txt
echo 1269 / 1866 --- Result6243 to Stage6Lap9Split3
perl -i -pe 's|Result6244 \[\.\.\.\]|Result6244 [ Stage6Lap9Spotter ]|g' Dependencies.txt
echo 1270 / 1866 --- Result6244 to Stage6Lap9Spotter
perl -i -pe 's|Result6245 \[\.\.\.\]|Result6245 [ Stage6Lap9Finish ]|g' Dependencies.txt
echo 1271 / 1866 --- Result6245 to Stage6Lap9Finish
perl -i -pe 's|Result6246 \[\.\.\.\]|Result6246 [ Stage6Lap10Split1 ]|g' Dependencies.txt
echo 1272 / 1866 --- Result6246 to Stage6Lap10Split1
perl -i -pe 's|Result6247 \[\.\.\.\]|Result6247 [ Stage6Lap10Split2 ]|g' Dependencies.txt
echo 1273 / 1866 --- Result6247 to Stage6Lap10Split2
perl -i -pe 's|Result6248 \[\.\.\.\]|Result6248 [ Stage6Lap10Split3 ]|g' Dependencies.txt
echo 1274 / 1866 --- Result6248 to Stage6Lap10Split3
perl -i -pe 's|Result6249 \[\.\.\.\]|Result6249 [ Stage6Lap10Spotter ]|g' Dependencies.txt
echo 1275 / 1866 --- Result6249 to Stage6Lap10Spotter
perl -i -pe 's|Result6250 \[\.\.\.\]|Result6250 [ Stage6Lap10Finish ]|g' Dependencies.txt
echo 1276 / 1866 --- Result6250 to Stage6Lap10Finish
perl -i -pe 's|Result6301 \[\.\.\.\]|Result6301 [ Stage6Lap1 ]|g' Dependencies.txt
echo 1277 / 1866 --- Result6301 to Stage6Lap1
perl -i -pe 's|Result6302 \[\.\.\.\]|Result6302 [ Stage6Lap2 ]|g' Dependencies.txt
echo 1278 / 1866 --- Result6302 to Stage6Lap2
perl -i -pe 's|Result6303 \[\.\.\.\]|Result6303 [ Stage6Lap3 ]|g' Dependencies.txt
echo 1279 / 1866 --- Result6303 to Stage6Lap3
perl -i -pe 's|Result6304 \[\.\.\.\]|Result6304 [ Stage6Lap4 ]|g' Dependencies.txt
echo 1280 / 1866 --- Result6304 to Stage6Lap4
perl -i -pe 's|Result6305 \[\.\.\.\]|Result6305 [ Stage6Lap5 ]|g' Dependencies.txt
echo 1281 / 1866 --- Result6305 to Stage6Lap5
perl -i -pe 's|Result6306 \[\.\.\.\]|Result6306 [ Stage6Lap6 ]|g' Dependencies.txt
echo 1282 / 1866 --- Result6306 to Stage6Lap6
perl -i -pe 's|Result6307 \[\.\.\.\]|Result6307 [ Stage6Lap7 ]|g' Dependencies.txt
echo 1283 / 1866 --- Result6307 to Stage6Lap7
perl -i -pe 's|Result6308 \[\.\.\.\]|Result6308 [ Stage6Lap8 ]|g' Dependencies.txt
echo 1284 / 1866 --- Result6308 to Stage6Lap8
perl -i -pe 's|Result6309 \[\.\.\.\]|Result6309 [ Stage6Lap9 ]|g' Dependencies.txt
echo 1285 / 1866 --- Result6309 to Stage6Lap9
perl -i -pe 's|Result6310 \[\.\.\.\]|Result6310 [ Stage6Lap10 ]|g' Dependencies.txt
echo 1286 / 1866 --- Result6310 to Stage6Lap10
perl -i -pe 's|Result6320 \[\.\.\.\]|Result6320 [ Stage6LapCount ]|g' Dependencies.txt
echo 1287 / 1866 --- Result6320 to Stage6LapCount
perl -i -pe 's|Result6321 \[\.\.\.\]|Result6321 [ Stage6FastestLap ]|g' Dependencies.txt
echo 1288 / 1866 --- Result6321 to Stage6FastestLap
perl -i -pe 's|Result6322 \[\.\.\.\]|Result6322 [ Stage6SlowestLap ]|g' Dependencies.txt
echo 1289 / 1866 --- Result6322 to Stage6SlowestLap
perl -i -pe 's|Result6323 \[\.\.\.\]|Result6323 [ Stage6AverageLap ]|g' Dependencies.txt
echo 1290 / 1866 --- Result6323 to Stage6AverageLap
perl -i -pe 's|Result6401 \[\.\.\.\]|Result6401 [ Stage6ParcoursStation1Points ]|g' Dependencies.txt
echo 1291 / 1866 --- Result6401 to Stage6ParcoursStation1Points
perl -i -pe 's|Result6402 \[\.\.\.\]|Result6402 [ Stage6ParcoursStation2Points ]|g' Dependencies.txt
echo 1292 / 1866 --- Result6402 to Stage6ParcoursStation2Points
perl -i -pe 's|Result6403 \[\.\.\.\]|Result6403 [ Stage6ParcoursStation3Points ]|g' Dependencies.txt
echo 1293 / 1866 --- Result6403 to Stage6ParcoursStation3Points
perl -i -pe 's|Result6404 \[\.\.\.\]|Result6404 [ Stage6ParcoursStation4Points ]|g' Dependencies.txt
echo 1294 / 1866 --- Result6404 to Stage6ParcoursStation4Points
perl -i -pe 's|Result6405 \[\.\.\.\]|Result6405 [ Stage6ParcoursStation5Points ]|g' Dependencies.txt
echo 1295 / 1866 --- Result6405 to Stage6ParcoursStation5Points
perl -i -pe 's|Result6406 \[\.\.\.\]|Result6406 [ Stage6ParcoursStation6Points ]|g' Dependencies.txt
echo 1296 / 1866 --- Result6406 to Stage6ParcoursStation6Points
perl -i -pe 's|Result6407 \[\.\.\.\]|Result6407 [ Stage6ParcoursStation7Points ]|g' Dependencies.txt
echo 1297 / 1866 --- Result6407 to Stage6ParcoursStation7Points
perl -i -pe 's|Result6408 \[\.\.\.\]|Result6408 [ Stage6ParcoursStation8Points ]|g' Dependencies.txt
echo 1298 / 1866 --- Result6408 to Stage6ParcoursStation8Points
perl -i -pe 's|Result6409 \[\.\.\.\]|Result6409 [ Stage6ParcoursStation9Points ]|g' Dependencies.txt
echo 1299 / 1866 --- Result6409 to Stage6ParcoursStation9Points
perl -i -pe 's|Result6410 \[\.\.\.\]|Result6410 [ Stage6ParcoursStation10Points ]|g' Dependencies.txt
echo 1300 / 1866 --- Result6410 to Stage6ParcoursStation10Points
perl -i -pe 's|Result6411 \[\.\.\.\]|Result6411 [ Stage6ParcoursStation11Points ]|g' Dependencies.txt
echo 1301 / 1866 --- Result6411 to Stage6ParcoursStation11Points
perl -i -pe 's|Result6412 \[\.\.\.\]|Result6412 [ Stage6ParcoursStation12Points ]|g' Dependencies.txt
echo 1302 / 1866 --- Result6412 to Stage6ParcoursStation12Points
perl -i -pe 's|Result6413 \[\.\.\.\]|Result6413 [ Stage6ParcoursStation13Points ]|g' Dependencies.txt
echo 1303 / 1866 --- Result6413 to Stage6ParcoursStation13Points
perl -i -pe 's|Result6414 \[\.\.\.\]|Result6414 [ Stage6ParcoursStation14Points ]|g' Dependencies.txt
echo 1304 / 1866 --- Result6414 to Stage6ParcoursStation14Points
perl -i -pe 's|Result6415 \[\.\.\.\]|Result6415 [ Stage6ParcoursStation15Points ]|g' Dependencies.txt
echo 1305 / 1866 --- Result6415 to Stage6ParcoursStation15Points
perl -i -pe 's|Result6430 \[\.\.\.\]|Result6430 [ Stage6ParcoursTotalPoints ]|g' Dependencies.txt
echo 1306 / 1866 --- Result6430 to Stage6ParcoursTotalPoints
perl -i -pe 's|Result6441 \[\.\.\.\]|Result6441 [ Stage6ParcoursStart ]|g' Dependencies.txt
echo 1307 / 1866 --- Result6441 to Stage6ParcoursStart
perl -i -pe 's|Result6442 \[\.\.\.\]|Result6442 [ Stage6ParcoursFinish ]|g' Dependencies.txt
echo 1308 / 1866 --- Result6442 to Stage6ParcoursFinish
perl -i -pe 's|Result6450 \[\.\.\.\]|Result6450 [ Stage6ParcoursTime ]|g' Dependencies.txt
echo 1309 / 1866 --- Result6450 to Stage6ParcoursTime
perl -i -pe 's|Result6501 \[\.\.\.\]|Result6501 [ Stage6ParcoursRankingPoints ]|g' Dependencies.txt
echo 1310 / 1866 --- Result6501 to Stage6ParcoursRankingPoints
perl -i -pe 's|Result6502 \[\.\.\.\]|Result6502 [ Stage6CrossCountryRankingPoints ]|g' Dependencies.txt
echo 1311 / 1866 --- Result6502 to Stage6CrossCountryRankingPoints
perl -i -pe 's|Result6503 \[\.\.\.\]|Result6503 [ Stage6TotalRankingPoints ]|g' Dependencies.txt
echo 1312 / 1866 --- Result6503 to Stage6TotalRankingPoints
perl -i -pe 's|Result6611 \[\.\.\.\]|Result6611 [ Stage6Lap1Sector1 ]|g' Dependencies.txt
echo 1313 / 1866 --- Result6611 to Stage6Lap1Sector1
perl -i -pe 's|Result6612 \[\.\.\.\]|Result6612 [ Stage6Lap2Sector1 ]|g' Dependencies.txt
echo 1314 / 1866 --- Result6612 to Stage6Lap2Sector1
perl -i -pe 's|Result6613 \[\.\.\.\]|Result6613 [ Stage6Lap3Sector1 ]|g' Dependencies.txt
echo 1315 / 1866 --- Result6613 to Stage6Lap3Sector1
perl -i -pe 's|Result6614 \[\.\.\.\]|Result6614 [ Stage6Lap4Sector1 ]|g' Dependencies.txt
echo 1316 / 1866 --- Result6614 to Stage6Lap4Sector1
perl -i -pe 's|Result6615 \[\.\.\.\]|Result6615 [ Stage6Lap5Sector1 ]|g' Dependencies.txt
echo 1317 / 1866 --- Result6615 to Stage6Lap5Sector1
perl -i -pe 's|Result6616 \[\.\.\.\]|Result6616 [ Stage6Lap6Sector1 ]|g' Dependencies.txt
echo 1318 / 1866 --- Result6616 to Stage6Lap6Sector1
perl -i -pe 's|Result6617 \[\.\.\.\]|Result6617 [ Stage6Lap7Sector1 ]|g' Dependencies.txt
echo 1319 / 1866 --- Result6617 to Stage6Lap7Sector1
perl -i -pe 's|Result6618 \[\.\.\.\]|Result6618 [ Stage6Lap8Sector1 ]|g' Dependencies.txt
echo 1320 / 1866 --- Result6618 to Stage6Lap8Sector1
perl -i -pe 's|Result6619 \[\.\.\.\]|Result6619 [ Stage6Lap9Sector1 ]|g' Dependencies.txt
echo 1321 / 1866 --- Result6619 to Stage6Lap9Sector1
perl -i -pe 's|Result6620 \[\.\.\.\]|Result6620 [ Stage6Lap10Sector1 ]|g' Dependencies.txt
echo 1322 / 1866 --- Result6620 to Stage6Lap10Sector1
perl -i -pe 's|Result6621 \[\.\.\.\]|Result6621 [ Stage6Lap1Sector2 ]|g' Dependencies.txt
echo 1323 / 1866 --- Result6621 to Stage6Lap1Sector2
perl -i -pe 's|Result6622 \[\.\.\.\]|Result6622 [ Stage6Lap2Sector2 ]|g' Dependencies.txt
echo 1324 / 1866 --- Result6622 to Stage6Lap2Sector2
perl -i -pe 's|Result6623 \[\.\.\.\]|Result6623 [ Stage6Lap3Sector2 ]|g' Dependencies.txt
echo 1325 / 1866 --- Result6623 to Stage6Lap3Sector2
perl -i -pe 's|Result6624 \[\.\.\.\]|Result6624 [ Stage6Lap4Sector2 ]|g' Dependencies.txt
echo 1326 / 1866 --- Result6624 to Stage6Lap4Sector2
perl -i -pe 's|Result6625 \[\.\.\.\]|Result6625 [ Stage6Lap5Sector2 ]|g' Dependencies.txt
echo 1327 / 1866 --- Result6625 to Stage6Lap5Sector2
perl -i -pe 's|Result6626 \[\.\.\.\]|Result6626 [ Stage6Lap6Sector2 ]|g' Dependencies.txt
echo 1328 / 1866 --- Result6626 to Stage6Lap6Sector2
perl -i -pe 's|Result6627 \[\.\.\.\]|Result6627 [ Stage6Lap7Sector2 ]|g' Dependencies.txt
echo 1329 / 1866 --- Result6627 to Stage6Lap7Sector2
perl -i -pe 's|Result6628 \[\.\.\.\]|Result6628 [ Stage6Lap8Sector2 ]|g' Dependencies.txt
echo 1330 / 1866 --- Result6628 to Stage6Lap8Sector2
perl -i -pe 's|Result6629 \[\.\.\.\]|Result6629 [ Stage6Lap9Sector2 ]|g' Dependencies.txt
echo 1331 / 1866 --- Result6629 to Stage6Lap9Sector2
perl -i -pe 's|Result6630 \[\.\.\.\]|Result6630 [ Stage6Lap10Sector2 ]|g' Dependencies.txt
echo 1332 / 1866 --- Result6630 to Stage6Lap10Sector2
perl -i -pe 's|Result6631 \[\.\.\.\]|Result6631 [ Stage6Lap1Sector3 ]|g' Dependencies.txt
echo 1333 / 1866 --- Result6631 to Stage6Lap1Sector3
perl -i -pe 's|Result6632 \[\.\.\.\]|Result6632 [ Stage6Lap2Sector3 ]|g' Dependencies.txt
echo 1334 / 1866 --- Result6632 to Stage6Lap2Sector3
perl -i -pe 's|Result6633 \[\.\.\.\]|Result6633 [ Stage6Lap3Sector3 ]|g' Dependencies.txt
echo 1335 / 1866 --- Result6633 to Stage6Lap3Sector3
perl -i -pe 's|Result6634 \[\.\.\.\]|Result6634 [ Stage6Lap4Sector3 ]|g' Dependencies.txt
echo 1336 / 1866 --- Result6634 to Stage6Lap4Sector3
perl -i -pe 's|Result6635 \[\.\.\.\]|Result6635 [ Stage6Lap5Sector3 ]|g' Dependencies.txt
echo 1337 / 1866 --- Result6635 to Stage6Lap5Sector3
perl -i -pe 's|Result6636 \[\.\.\.\]|Result6636 [ Stage6Lap6Sector3 ]|g' Dependencies.txt
echo 1338 / 1866 --- Result6636 to Stage6Lap6Sector3
perl -i -pe 's|Result6637 \[\.\.\.\]|Result6637 [ Stage6Lap7Sector3 ]|g' Dependencies.txt
echo 1339 / 1866 --- Result6637 to Stage6Lap7Sector3
perl -i -pe 's|Result6638 \[\.\.\.\]|Result6638 [ Stage6Lap8Sector3 ]|g' Dependencies.txt
echo 1340 / 1866 --- Result6638 to Stage6Lap8Sector3
perl -i -pe 's|Result6639 \[\.\.\.\]|Result6639 [ Stage6Lap9Sector3 ]|g' Dependencies.txt
echo 1341 / 1866 --- Result6639 to Stage6Lap9Sector3
perl -i -pe 's|Result6640 \[\.\.\.\]|Result6640 [ Stage6Lap10Sector3 ]|g' Dependencies.txt
echo 1342 / 1866 --- Result6640 to Stage6Lap10Sector3
perl -i -pe 's|Result6641 \[\.\.\.\]|Result6641 [ Stage6Lap1Sector4 ]|g' Dependencies.txt
echo 1343 / 1866 --- Result6641 to Stage6Lap1Sector4
perl -i -pe 's|Result6642 \[\.\.\.\]|Result6642 [ Stage6Lap2Sector4 ]|g' Dependencies.txt
echo 1344 / 1866 --- Result6642 to Stage6Lap2Sector4
perl -i -pe 's|Result6643 \[\.\.\.\]|Result6643 [ Stage6Lap3Sector4 ]|g' Dependencies.txt
echo 1345 / 1866 --- Result6643 to Stage6Lap3Sector4
perl -i -pe 's|Result6644 \[\.\.\.\]|Result6644 [ Stage6Lap4Sector4 ]|g' Dependencies.txt
echo 1346 / 1866 --- Result6644 to Stage6Lap4Sector4
perl -i -pe 's|Result6645 \[\.\.\.\]|Result6645 [ Stage6Lap5Sector4 ]|g' Dependencies.txt
echo 1347 / 1866 --- Result6645 to Stage6Lap5Sector4
perl -i -pe 's|Result6646 \[\.\.\.\]|Result6646 [ Stage6Lap6Sector4 ]|g' Dependencies.txt
echo 1348 / 1866 --- Result6646 to Stage6Lap6Sector4
perl -i -pe 's|Result6647 \[\.\.\.\]|Result6647 [ Stage6Lap7Sector4 ]|g' Dependencies.txt
echo 1349 / 1866 --- Result6647 to Stage6Lap7Sector4
perl -i -pe 's|Result6648 \[\.\.\.\]|Result6648 [ Stage6Lap8Sector4 ]|g' Dependencies.txt
echo 1350 / 1866 --- Result6648 to Stage6Lap8Sector4
perl -i -pe 's|Result6649 \[\.\.\.\]|Result6649 [ Stage6Lap9Sector4 ]|g' Dependencies.txt
echo 1351 / 1866 --- Result6649 to Stage6Lap9Sector4
perl -i -pe 's|Result6650 \[\.\.\.\]|Result6650 [ Stage6Lap10Sector4 ]|g' Dependencies.txt
echo 1352 / 1866 --- Result6650 to Stage6Lap10Sector4
perl -i -pe 's|Result6651 \[\.\.\.\]|Result6651 [ Stage6Lap1UphillSector ]|g' Dependencies.txt
echo 1353 / 1866 --- Result6651 to Stage6Lap1UphillSector
perl -i -pe 's|Result6652 \[\.\.\.\]|Result6652 [ Stage6Lap2UphillSector ]|g' Dependencies.txt
echo 1354 / 1866 --- Result6652 to Stage6Lap2UphillSector
perl -i -pe 's|Result6653 \[\.\.\.\]|Result6653 [ Stage6Lap3UphillSector ]|g' Dependencies.txt
echo 1355 / 1866 --- Result6653 to Stage6Lap3UphillSector
perl -i -pe 's|Result6654 \[\.\.\.\]|Result6654 [ Stage6Lap4UphillSector ]|g' Dependencies.txt
echo 1356 / 1866 --- Result6654 to Stage6Lap4UphillSector
perl -i -pe 's|Result6655 \[\.\.\.\]|Result6655 [ Stage6Lap5UphillSector ]|g' Dependencies.txt
echo 1357 / 1866 --- Result6655 to Stage6Lap5UphillSector
perl -i -pe 's|Result6656 \[\.\.\.\]|Result6656 [ Stage6Lap6UphillSector ]|g' Dependencies.txt
echo 1358 / 1866 --- Result6656 to Stage6Lap6UphillSector
perl -i -pe 's|Result6657 \[\.\.\.\]|Result6657 [ Stage6Lap7UphillSector ]|g' Dependencies.txt
echo 1359 / 1866 --- Result6657 to Stage6Lap7UphillSector
perl -i -pe 's|Result6658 \[\.\.\.\]|Result6658 [ Stage6Lap8UphillSector ]|g' Dependencies.txt
echo 1360 / 1866 --- Result6658 to Stage6Lap8UphillSector
perl -i -pe 's|Result6659 \[\.\.\.\]|Result6659 [ Stage6Lap9UphillSector ]|g' Dependencies.txt
echo 1361 / 1866 --- Result6659 to Stage6Lap9UphillSector
perl -i -pe 's|Result6660 \[\.\.\.\]|Result6660 [ Stage6Lap10UphillSector ]|g' Dependencies.txt
echo 1362 / 1866 --- Result6660 to Stage6Lap10UphillSector
perl -i -pe 's|Result6680 \[\.\.\.\]|Result6680 [ Stage6FastestUphillSector ]|g' Dependencies.txt
echo 1363 / 1866 --- Result6680 to Stage6FastestUphillSector
perl -i -pe 's|Result6681 \[\.\.\.\]|Result6681 [ Stage6FastestUphillSectorID ]|g' Dependencies.txt
echo 1364 / 1866 --- Result6681 to Stage6FastestUphillSectorID
perl -i -pe 's|Result7000 \[\.\.\.\]|Result7000 [ Stage7StartTime ]|g' Dependencies.txt
echo 1365 / 1866 --- Result7000 to Stage7StartTime
perl -i -pe 's|Result7001 \[\.\.\.\]|Result7001 [ Stage7FinishTimeLimit ]|g' Dependencies.txt
echo 1366 / 1866 --- Result7001 to Stage7FinishTimeLimit
perl -i -pe 's|Result7100 \[\.\.\.\]|Result7100 [ Stage7Started ]|g' Dependencies.txt
echo 1367 / 1866 --- Result7100 to Stage7Started
perl -i -pe 's|Result7101 \[\.\.\.\]|Result7101 [ Stage7AfterLap1Split1 ]|g' Dependencies.txt
echo 1368 / 1866 --- Result7101 to Stage7AfterLap1Split1
perl -i -pe 's|Result7102 \[\.\.\.\]|Result7102 [ Stage7AfterLap1Split2 ]|g' Dependencies.txt
echo 1369 / 1866 --- Result7102 to Stage7AfterLap1Split2
perl -i -pe 's|Result7103 \[\.\.\.\]|Result7103 [ Stage7AfterLap1Split3 ]|g' Dependencies.txt
echo 1370 / 1866 --- Result7103 to Stage7AfterLap1Split3
perl -i -pe 's|Result7104 \[\.\.\.\]|Result7104 [ Stage7AfterLap1Spotter ]|g' Dependencies.txt
echo 1371 / 1866 --- Result7104 to Stage7AfterLap1Spotter
perl -i -pe 's|Result7105 \[\.\.\.\]|Result7105 [ Stage7AfterLap1Finish ]|g' Dependencies.txt
echo 1372 / 1866 --- Result7105 to Stage7AfterLap1Finish
perl -i -pe 's|Result7106 \[\.\.\.\]|Result7106 [ Stage7AfterLap2Split1 ]|g' Dependencies.txt
echo 1373 / 1866 --- Result7106 to Stage7AfterLap2Split1
perl -i -pe 's|Result7107 \[\.\.\.\]|Result7107 [ Stage7AfterLap2Split2 ]|g' Dependencies.txt
echo 1374 / 1866 --- Result7107 to Stage7AfterLap2Split2
perl -i -pe 's|Result7108 \[\.\.\.\]|Result7108 [ Stage7AfterLap2Split3 ]|g' Dependencies.txt
echo 1375 / 1866 --- Result7108 to Stage7AfterLap2Split3
perl -i -pe 's|Result7109 \[\.\.\.\]|Result7109 [ Stage7AfterLap2Spotter ]|g' Dependencies.txt
echo 1376 / 1866 --- Result7109 to Stage7AfterLap2Spotter
perl -i -pe 's|Result7110 \[\.\.\.\]|Result7110 [ Stage7AfterLap2Finish ]|g' Dependencies.txt
echo 1377 / 1866 --- Result7110 to Stage7AfterLap2Finish
perl -i -pe 's|Result7111 \[\.\.\.\]|Result7111 [ Stage7AfterLap3Split1 ]|g' Dependencies.txt
echo 1378 / 1866 --- Result7111 to Stage7AfterLap3Split1
perl -i -pe 's|Result7112 \[\.\.\.\]|Result7112 [ Stage7AfterLap3Split2 ]|g' Dependencies.txt
echo 1379 / 1866 --- Result7112 to Stage7AfterLap3Split2
perl -i -pe 's|Result7113 \[\.\.\.\]|Result7113 [ Stage7AfterLap3Split3 ]|g' Dependencies.txt
echo 1380 / 1866 --- Result7113 to Stage7AfterLap3Split3
perl -i -pe 's|Result7114 \[\.\.\.\]|Result7114 [ Stage7AfterLap3Spotter ]|g' Dependencies.txt
echo 1381 / 1866 --- Result7114 to Stage7AfterLap3Spotter
perl -i -pe 's|Result7115 \[\.\.\.\]|Result7115 [ Stage7AfterLap3Finish ]|g' Dependencies.txt
echo 1382 / 1866 --- Result7115 to Stage7AfterLap3Finish
perl -i -pe 's|Result7116 \[\.\.\.\]|Result7116 [ Stage7AfterLap4Split1 ]|g' Dependencies.txt
echo 1383 / 1866 --- Result7116 to Stage7AfterLap4Split1
perl -i -pe 's|Result7117 \[\.\.\.\]|Result7117 [ Stage7AfterLap4Split2 ]|g' Dependencies.txt
echo 1384 / 1866 --- Result7117 to Stage7AfterLap4Split2
perl -i -pe 's|Result7118 \[\.\.\.\]|Result7118 [ Stage7AfterLap4Split3 ]|g' Dependencies.txt
echo 1385 / 1866 --- Result7118 to Stage7AfterLap4Split3
perl -i -pe 's|Result7119 \[\.\.\.\]|Result7119 [ Stage7AfterLap4Spotter ]|g' Dependencies.txt
echo 1386 / 1866 --- Result7119 to Stage7AfterLap4Spotter
perl -i -pe 's|Result7120 \[\.\.\.\]|Result7120 [ Stage7AfterLap4Finish ]|g' Dependencies.txt
echo 1387 / 1866 --- Result7120 to Stage7AfterLap4Finish
perl -i -pe 's|Result7121 \[\.\.\.\]|Result7121 [ Stage7AfterLap5Split1 ]|g' Dependencies.txt
echo 1388 / 1866 --- Result7121 to Stage7AfterLap5Split1
perl -i -pe 's|Result7122 \[\.\.\.\]|Result7122 [ Stage7AfterLap5Split2 ]|g' Dependencies.txt
echo 1389 / 1866 --- Result7122 to Stage7AfterLap5Split2
perl -i -pe 's|Result7123 \[\.\.\.\]|Result7123 [ Stage7AfterLap5Split3 ]|g' Dependencies.txt
echo 1390 / 1866 --- Result7123 to Stage7AfterLap5Split3
perl -i -pe 's|Result7124 \[\.\.\.\]|Result7124 [ Stage7AfterLap5Spotter ]|g' Dependencies.txt
echo 1391 / 1866 --- Result7124 to Stage7AfterLap5Spotter
perl -i -pe 's|Result7125 \[\.\.\.\]|Result7125 [ Stage7AfterLap5Finish ]|g' Dependencies.txt
echo 1392 / 1866 --- Result7125 to Stage7AfterLap5Finish
perl -i -pe 's|Result7126 \[\.\.\.\]|Result7126 [ Stage7AfterLap6Split1 ]|g' Dependencies.txt
echo 1393 / 1866 --- Result7126 to Stage7AfterLap6Split1
perl -i -pe 's|Result7127 \[\.\.\.\]|Result7127 [ Stage7AfterLap6Split2 ]|g' Dependencies.txt
echo 1394 / 1866 --- Result7127 to Stage7AfterLap6Split2
perl -i -pe 's|Result7128 \[\.\.\.\]|Result7128 [ Stage7AfterLap6Split3 ]|g' Dependencies.txt
echo 1395 / 1866 --- Result7128 to Stage7AfterLap6Split3
perl -i -pe 's|Result7129 \[\.\.\.\]|Result7129 [ Stage7AfterLap6Spotter ]|g' Dependencies.txt
echo 1396 / 1866 --- Result7129 to Stage7AfterLap6Spotter
perl -i -pe 's|Result7130 \[\.\.\.\]|Result7130 [ Stage7AfterLap6Finish ]|g' Dependencies.txt
echo 1397 / 1866 --- Result7130 to Stage7AfterLap6Finish
perl -i -pe 's|Result7131 \[\.\.\.\]|Result7131 [ Stage7AfterLap7Split1 ]|g' Dependencies.txt
echo 1398 / 1866 --- Result7131 to Stage7AfterLap7Split1
perl -i -pe 's|Result7132 \[\.\.\.\]|Result7132 [ Stage7AfterLap7Split2 ]|g' Dependencies.txt
echo 1399 / 1866 --- Result7132 to Stage7AfterLap7Split2
perl -i -pe 's|Result7133 \[\.\.\.\]|Result7133 [ Stage7AfterLap7Split3 ]|g' Dependencies.txt
echo 1400 / 1866 --- Result7133 to Stage7AfterLap7Split3
perl -i -pe 's|Result7134 \[\.\.\.\]|Result7134 [ Stage7AfterLap7Spotter ]|g' Dependencies.txt
echo 1401 / 1866 --- Result7134 to Stage7AfterLap7Spotter
perl -i -pe 's|Result7135 \[\.\.\.\]|Result7135 [ Stage7AfterLap7Finish ]|g' Dependencies.txt
echo 1402 / 1866 --- Result7135 to Stage7AfterLap7Finish
perl -i -pe 's|Result7136 \[\.\.\.\]|Result7136 [ Stage7AfterLap8Split1 ]|g' Dependencies.txt
echo 1403 / 1866 --- Result7136 to Stage7AfterLap8Split1
perl -i -pe 's|Result7137 \[\.\.\.\]|Result7137 [ Stage7AfterLap8Split2 ]|g' Dependencies.txt
echo 1404 / 1866 --- Result7137 to Stage7AfterLap8Split2
perl -i -pe 's|Result7138 \[\.\.\.\]|Result7138 [ Stage7AfterLap8Split3 ]|g' Dependencies.txt
echo 1405 / 1866 --- Result7138 to Stage7AfterLap8Split3
perl -i -pe 's|Result7139 \[\.\.\.\]|Result7139 [ Stage7AfterLap8Spotter ]|g' Dependencies.txt
echo 1406 / 1866 --- Result7139 to Stage7AfterLap8Spotter
perl -i -pe 's|Result7140 \[\.\.\.\]|Result7140 [ Stage7AfterLap8Finish ]|g' Dependencies.txt
echo 1407 / 1866 --- Result7140 to Stage7AfterLap8Finish
perl -i -pe 's|Result7141 \[\.\.\.\]|Result7141 [ Stage7AfterLap9Split1 ]|g' Dependencies.txt
echo 1408 / 1866 --- Result7141 to Stage7AfterLap9Split1
perl -i -pe 's|Result7142 \[\.\.\.\]|Result7142 [ Stage7AfterLap9Split2 ]|g' Dependencies.txt
echo 1409 / 1866 --- Result7142 to Stage7AfterLap9Split2
perl -i -pe 's|Result7143 \[\.\.\.\]|Result7143 [ Stage7AfterLap9Split3 ]|g' Dependencies.txt
echo 1410 / 1866 --- Result7143 to Stage7AfterLap9Split3
perl -i -pe 's|Result7144 \[\.\.\.\]|Result7144 [ Stage7AfterLap9Spotter ]|g' Dependencies.txt
echo 1411 / 1866 --- Result7144 to Stage7AfterLap9Spotter
perl -i -pe 's|Result7145 \[\.\.\.\]|Result7145 [ Stage7AfterLap9Finish ]|g' Dependencies.txt
echo 1412 / 1866 --- Result7145 to Stage7AfterLap9Finish
perl -i -pe 's|Result7146 \[\.\.\.\]|Result7146 [ Stage7AfterLap10Split1 ]|g' Dependencies.txt
echo 1413 / 1866 --- Result7146 to Stage7AfterLap10Split1
perl -i -pe 's|Result7147 \[\.\.\.\]|Result7147 [ Stage7AfterLap10Split2 ]|g' Dependencies.txt
echo 1414 / 1866 --- Result7147 to Stage7AfterLap10Split2
perl -i -pe 's|Result7148 \[\.\.\.\]|Result7148 [ Stage7AfterLap10Split3 ]|g' Dependencies.txt
echo 1415 / 1866 --- Result7148 to Stage7AfterLap10Split3
perl -i -pe 's|Result7149 \[\.\.\.\]|Result7149 [ Stage7AfterLap10Spotter ]|g' Dependencies.txt
echo 1416 / 1866 --- Result7149 to Stage7AfterLap10Spotter
perl -i -pe 's|Result7150 \[\.\.\.\]|Result7150 [ Stage7AfterLap10Finish ]|g' Dependencies.txt
echo 1417 / 1866 --- Result7150 to Stage7AfterLap10Finish
perl -i -pe 's|Result7190 \[\.\.\.\]|Result7190 [ Stage7AfterFinish ]|g' Dependencies.txt
echo 1418 / 1866 --- Result7190 to Stage7AfterFinish
perl -i -pe 's|Result7191 \[\.\.\.\]|Result7191 [ Stage7LastSplitID ]|g' Dependencies.txt
echo 1419 / 1866 --- Result7191 to Stage7LastSplitID
perl -i -pe 's|Result7192 \[\.\.\.\]|Result7192 [ Stage7LastSplit ]|g' Dependencies.txt
echo 1420 / 1866 --- Result7192 to Stage7LastSplit
perl -i -pe 's|Result7193 \[\.\.\.\]|Result7193 [ Stage7LastFinishID ]|g' Dependencies.txt
echo 1421 / 1866 --- Result7193 to Stage7LastFinishID
perl -i -pe 's|Result7194 \[\.\.\.\]|Result7194 [ Stage7LastFinish ]|g' Dependencies.txt
echo 1422 / 1866 --- Result7194 to Stage7LastFinish
perl -i -pe 's|Result7195 \[\.\.\.\]|Result7195 [ Stage7LastSplitBunchTime ]|g' Dependencies.txt
echo 1423 / 1866 --- Result7195 to Stage7LastSplitBunchTime
perl -i -pe 's|Result7196 \[\.\.\.\]|Result7196 [ Stage7PhotoBunchTime ]|g' Dependencies.txt
echo 1424 / 1866 --- Result7196 to Stage7PhotoBunchTime
perl -i -pe 's|Result7200 \[\.\.\.\]|Result7200 [ Stage7Start ]|g' Dependencies.txt
echo 1425 / 1866 --- Result7200 to Stage7Start
perl -i -pe 's|Result7201 \[\.\.\.\]|Result7201 [ Stage7Lap1Split1 ]|g' Dependencies.txt
echo 1426 / 1866 --- Result7201 to Stage7Lap1Split1
perl -i -pe 's|Result7202 \[\.\.\.\]|Result7202 [ Stage7Lap1Split2 ]|g' Dependencies.txt
echo 1427 / 1866 --- Result7202 to Stage7Lap1Split2
perl -i -pe 's|Result7203 \[\.\.\.\]|Result7203 [ Stage7Lap1Split3 ]|g' Dependencies.txt
echo 1428 / 1866 --- Result7203 to Stage7Lap1Split3
perl -i -pe 's|Result7204 \[\.\.\.\]|Result7204 [ Stage7Lap1Spotter ]|g' Dependencies.txt
echo 1429 / 1866 --- Result7204 to Stage7Lap1Spotter
perl -i -pe 's|Result7205 \[\.\.\.\]|Result7205 [ Stage7Lap1Finish ]|g' Dependencies.txt
echo 1430 / 1866 --- Result7205 to Stage7Lap1Finish
perl -i -pe 's|Result7206 \[\.\.\.\]|Result7206 [ Stage7Lap2Split1 ]|g' Dependencies.txt
echo 1431 / 1866 --- Result7206 to Stage7Lap2Split1
perl -i -pe 's|Result7207 \[\.\.\.\]|Result7207 [ Stage7Lap2Split2 ]|g' Dependencies.txt
echo 1432 / 1866 --- Result7207 to Stage7Lap2Split2
perl -i -pe 's|Result7208 \[\.\.\.\]|Result7208 [ Stage7Lap2Split3 ]|g' Dependencies.txt
echo 1433 / 1866 --- Result7208 to Stage7Lap2Split3
perl -i -pe 's|Result7209 \[\.\.\.\]|Result7209 [ Stage7Lap2Spotter ]|g' Dependencies.txt
echo 1434 / 1866 --- Result7209 to Stage7Lap2Spotter
perl -i -pe 's|Result7210 \[\.\.\.\]|Result7210 [ Stage7Lap2Finish ]|g' Dependencies.txt
echo 1435 / 1866 --- Result7210 to Stage7Lap2Finish
perl -i -pe 's|Result7211 \[\.\.\.\]|Result7211 [ Stage7Lap3Split1 ]|g' Dependencies.txt
echo 1436 / 1866 --- Result7211 to Stage7Lap3Split1
perl -i -pe 's|Result7212 \[\.\.\.\]|Result7212 [ Stage7Lap3Split2 ]|g' Dependencies.txt
echo 1437 / 1866 --- Result7212 to Stage7Lap3Split2
perl -i -pe 's|Result7213 \[\.\.\.\]|Result7213 [ Stage7Lap3Split3 ]|g' Dependencies.txt
echo 1438 / 1866 --- Result7213 to Stage7Lap3Split3
perl -i -pe 's|Result7214 \[\.\.\.\]|Result7214 [ Stage7Lap3Spotter ]|g' Dependencies.txt
echo 1439 / 1866 --- Result7214 to Stage7Lap3Spotter
perl -i -pe 's|Result7215 \[\.\.\.\]|Result7215 [ Stage7Lap3Finish ]|g' Dependencies.txt
echo 1440 / 1866 --- Result7215 to Stage7Lap3Finish
perl -i -pe 's|Result7216 \[\.\.\.\]|Result7216 [ Stage7Lap4Split1 ]|g' Dependencies.txt
echo 1441 / 1866 --- Result7216 to Stage7Lap4Split1
perl -i -pe 's|Result7217 \[\.\.\.\]|Result7217 [ Stage7Lap4Split2 ]|g' Dependencies.txt
echo 1442 / 1866 --- Result7217 to Stage7Lap4Split2
perl -i -pe 's|Result7218 \[\.\.\.\]|Result7218 [ Stage7Lap4Split3 ]|g' Dependencies.txt
echo 1443 / 1866 --- Result7218 to Stage7Lap4Split3
perl -i -pe 's|Result7219 \[\.\.\.\]|Result7219 [ Stage7Lap4Spotter ]|g' Dependencies.txt
echo 1444 / 1866 --- Result7219 to Stage7Lap4Spotter
perl -i -pe 's|Result7220 \[\.\.\.\]|Result7220 [ Stage7Lap4Finish ]|g' Dependencies.txt
echo 1445 / 1866 --- Result7220 to Stage7Lap4Finish
perl -i -pe 's|Result7221 \[\.\.\.\]|Result7221 [ Stage7Lap5Split1 ]|g' Dependencies.txt
echo 1446 / 1866 --- Result7221 to Stage7Lap5Split1
perl -i -pe 's|Result7222 \[\.\.\.\]|Result7222 [ Stage7Lap5Split2 ]|g' Dependencies.txt
echo 1447 / 1866 --- Result7222 to Stage7Lap5Split2
perl -i -pe 's|Result7223 \[\.\.\.\]|Result7223 [ Stage7Lap5Split3 ]|g' Dependencies.txt
echo 1448 / 1866 --- Result7223 to Stage7Lap5Split3
perl -i -pe 's|Result7224 \[\.\.\.\]|Result7224 [ Stage7Lap5Spotter ]|g' Dependencies.txt
echo 1449 / 1866 --- Result7224 to Stage7Lap5Spotter
perl -i -pe 's|Result7225 \[\.\.\.\]|Result7225 [ Stage7Lap5Finish ]|g' Dependencies.txt
echo 1450 / 1866 --- Result7225 to Stage7Lap5Finish
perl -i -pe 's|Result7226 \[\.\.\.\]|Result7226 [ Stage7Lap6Split1 ]|g' Dependencies.txt
echo 1451 / 1866 --- Result7226 to Stage7Lap6Split1
perl -i -pe 's|Result7227 \[\.\.\.\]|Result7227 [ Stage7Lap6Split2 ]|g' Dependencies.txt
echo 1452 / 1866 --- Result7227 to Stage7Lap6Split2
perl -i -pe 's|Result7228 \[\.\.\.\]|Result7228 [ Stage7Lap6Split3 ]|g' Dependencies.txt
echo 1453 / 1866 --- Result7228 to Stage7Lap6Split3
perl -i -pe 's|Result7229 \[\.\.\.\]|Result7229 [ Stage7Lap6Spotter ]|g' Dependencies.txt
echo 1454 / 1866 --- Result7229 to Stage7Lap6Spotter
perl -i -pe 's|Result7230 \[\.\.\.\]|Result7230 [ Stage7Lap6Finish ]|g' Dependencies.txt
echo 1455 / 1866 --- Result7230 to Stage7Lap6Finish
perl -i -pe 's|Result7231 \[\.\.\.\]|Result7231 [ Stage7Lap7Split1 ]|g' Dependencies.txt
echo 1456 / 1866 --- Result7231 to Stage7Lap7Split1
perl -i -pe 's|Result7232 \[\.\.\.\]|Result7232 [ Stage7Lap7Split2 ]|g' Dependencies.txt
echo 1457 / 1866 --- Result7232 to Stage7Lap7Split2
perl -i -pe 's|Result7233 \[\.\.\.\]|Result7233 [ Stage7Lap7Split3 ]|g' Dependencies.txt
echo 1458 / 1866 --- Result7233 to Stage7Lap7Split3
perl -i -pe 's|Result7234 \[\.\.\.\]|Result7234 [ Stage7Lap7Spotter ]|g' Dependencies.txt
echo 1459 / 1866 --- Result7234 to Stage7Lap7Spotter
perl -i -pe 's|Result7235 \[\.\.\.\]|Result7235 [ Stage7Lap7Finish ]|g' Dependencies.txt
echo 1460 / 1866 --- Result7235 to Stage7Lap7Finish
perl -i -pe 's|Result7236 \[\.\.\.\]|Result7236 [ Stage7Lap8Split1 ]|g' Dependencies.txt
echo 1461 / 1866 --- Result7236 to Stage7Lap8Split1
perl -i -pe 's|Result7237 \[\.\.\.\]|Result7237 [ Stage7Lap8Split2 ]|g' Dependencies.txt
echo 1462 / 1866 --- Result7237 to Stage7Lap8Split2
perl -i -pe 's|Result7238 \[\.\.\.\]|Result7238 [ Stage7Lap8Split3 ]|g' Dependencies.txt
echo 1463 / 1866 --- Result7238 to Stage7Lap8Split3
perl -i -pe 's|Result7239 \[\.\.\.\]|Result7239 [ Stage7Lap8Spotter ]|g' Dependencies.txt
echo 1464 / 1866 --- Result7239 to Stage7Lap8Spotter
perl -i -pe 's|Result7240 \[\.\.\.\]|Result7240 [ Stage7Lap8Finish ]|g' Dependencies.txt
echo 1465 / 1866 --- Result7240 to Stage7Lap8Finish
perl -i -pe 's|Result7241 \[\.\.\.\]|Result7241 [ Stage7Lap9Split1 ]|g' Dependencies.txt
echo 1466 / 1866 --- Result7241 to Stage7Lap9Split1
perl -i -pe 's|Result7242 \[\.\.\.\]|Result7242 [ Stage7Lap9Split2 ]|g' Dependencies.txt
echo 1467 / 1866 --- Result7242 to Stage7Lap9Split2
perl -i -pe 's|Result7243 \[\.\.\.\]|Result7243 [ Stage7Lap9Split3 ]|g' Dependencies.txt
echo 1468 / 1866 --- Result7243 to Stage7Lap9Split3
perl -i -pe 's|Result7244 \[\.\.\.\]|Result7244 [ Stage7Lap9Spotter ]|g' Dependencies.txt
echo 1469 / 1866 --- Result7244 to Stage7Lap9Spotter
perl -i -pe 's|Result7245 \[\.\.\.\]|Result7245 [ Stage7Lap9Finish ]|g' Dependencies.txt
echo 1470 / 1866 --- Result7245 to Stage7Lap9Finish
perl -i -pe 's|Result7246 \[\.\.\.\]|Result7246 [ Stage7Lap10Split1 ]|g' Dependencies.txt
echo 1471 / 1866 --- Result7246 to Stage7Lap10Split1
perl -i -pe 's|Result7247 \[\.\.\.\]|Result7247 [ Stage7Lap10Split2 ]|g' Dependencies.txt
echo 1472 / 1866 --- Result7247 to Stage7Lap10Split2
perl -i -pe 's|Result7248 \[\.\.\.\]|Result7248 [ Stage7Lap10Split3 ]|g' Dependencies.txt
echo 1473 / 1866 --- Result7248 to Stage7Lap10Split3
perl -i -pe 's|Result7249 \[\.\.\.\]|Result7249 [ Stage7Lap10Spotter ]|g' Dependencies.txt
echo 1474 / 1866 --- Result7249 to Stage7Lap10Spotter
perl -i -pe 's|Result7250 \[\.\.\.\]|Result7250 [ Stage7Lap10Finish ]|g' Dependencies.txt
echo 1475 / 1866 --- Result7250 to Stage7Lap10Finish
perl -i -pe 's|Result7301 \[\.\.\.\]|Result7301 [ Stage7Lap1 ]|g' Dependencies.txt
echo 1476 / 1866 --- Result7301 to Stage7Lap1
perl -i -pe 's|Result7302 \[\.\.\.\]|Result7302 [ Stage7Lap2 ]|g' Dependencies.txt
echo 1477 / 1866 --- Result7302 to Stage7Lap2
perl -i -pe 's|Result7303 \[\.\.\.\]|Result7303 [ Stage7Lap3 ]|g' Dependencies.txt
echo 1478 / 1866 --- Result7303 to Stage7Lap3
perl -i -pe 's|Result7304 \[\.\.\.\]|Result7304 [ Stage7Lap4 ]|g' Dependencies.txt
echo 1479 / 1866 --- Result7304 to Stage7Lap4
perl -i -pe 's|Result7305 \[\.\.\.\]|Result7305 [ Stage7Lap5 ]|g' Dependencies.txt
echo 1480 / 1866 --- Result7305 to Stage7Lap5
perl -i -pe 's|Result7306 \[\.\.\.\]|Result7306 [ Stage7Lap6 ]|g' Dependencies.txt
echo 1481 / 1866 --- Result7306 to Stage7Lap6
perl -i -pe 's|Result7307 \[\.\.\.\]|Result7307 [ Stage7Lap7 ]|g' Dependencies.txt
echo 1482 / 1866 --- Result7307 to Stage7Lap7
perl -i -pe 's|Result7308 \[\.\.\.\]|Result7308 [ Stage7Lap8 ]|g' Dependencies.txt
echo 1483 / 1866 --- Result7308 to Stage7Lap8
perl -i -pe 's|Result7309 \[\.\.\.\]|Result7309 [ Stage7Lap9 ]|g' Dependencies.txt
echo 1484 / 1866 --- Result7309 to Stage7Lap9
perl -i -pe 's|Result7310 \[\.\.\.\]|Result7310 [ Stage7Lap10 ]|g' Dependencies.txt
echo 1485 / 1866 --- Result7310 to Stage7Lap10
perl -i -pe 's|Result7320 \[\.\.\.\]|Result7320 [ Stage7LapCount ]|g' Dependencies.txt
echo 1486 / 1866 --- Result7320 to Stage7LapCount
perl -i -pe 's|Result7321 \[\.\.\.\]|Result7321 [ Stage7FastestLap ]|g' Dependencies.txt
echo 1487 / 1866 --- Result7321 to Stage7FastestLap
perl -i -pe 's|Result7322 \[\.\.\.\]|Result7322 [ Stage7SlowestLap ]|g' Dependencies.txt
echo 1488 / 1866 --- Result7322 to Stage7SlowestLap
perl -i -pe 's|Result7323 \[\.\.\.\]|Result7323 [ Stage7AverageLap ]|g' Dependencies.txt
echo 1489 / 1866 --- Result7323 to Stage7AverageLap
perl -i -pe 's|Result7401 \[\.\.\.\]|Result7401 [ Stage7ParcoursStation1Points ]|g' Dependencies.txt
echo 1490 / 1866 --- Result7401 to Stage7ParcoursStation1Points
perl -i -pe 's|Result7402 \[\.\.\.\]|Result7402 [ Stage7ParcoursStation2Points ]|g' Dependencies.txt
echo 1491 / 1866 --- Result7402 to Stage7ParcoursStation2Points
perl -i -pe 's|Result7403 \[\.\.\.\]|Result7403 [ Stage7ParcoursStation3Points ]|g' Dependencies.txt
echo 1492 / 1866 --- Result7403 to Stage7ParcoursStation3Points
perl -i -pe 's|Result7404 \[\.\.\.\]|Result7404 [ Stage7ParcoursStation4Points ]|g' Dependencies.txt
echo 1493 / 1866 --- Result7404 to Stage7ParcoursStation4Points
perl -i -pe 's|Result7405 \[\.\.\.\]|Result7405 [ Stage7ParcoursStation5Points ]|g' Dependencies.txt
echo 1494 / 1866 --- Result7405 to Stage7ParcoursStation5Points
perl -i -pe 's|Result7406 \[\.\.\.\]|Result7406 [ Stage7ParcoursStation6Points ]|g' Dependencies.txt
echo 1495 / 1866 --- Result7406 to Stage7ParcoursStation6Points
perl -i -pe 's|Result7407 \[\.\.\.\]|Result7407 [ Stage7ParcoursStation7Points ]|g' Dependencies.txt
echo 1496 / 1866 --- Result7407 to Stage7ParcoursStation7Points
perl -i -pe 's|Result7408 \[\.\.\.\]|Result7408 [ Stage7ParcoursStation8Points ]|g' Dependencies.txt
echo 1497 / 1866 --- Result7408 to Stage7ParcoursStation8Points
perl -i -pe 's|Result7409 \[\.\.\.\]|Result7409 [ Stage7ParcoursStation9Points ]|g' Dependencies.txt
echo 1498 / 1866 --- Result7409 to Stage7ParcoursStation9Points
perl -i -pe 's|Result7410 \[\.\.\.\]|Result7410 [ Stage7ParcoursStation10Points ]|g' Dependencies.txt
echo 1499 / 1866 --- Result7410 to Stage7ParcoursStation10Points
perl -i -pe 's|Result7411 \[\.\.\.\]|Result7411 [ Stage7ParcoursStation11Points ]|g' Dependencies.txt
echo 1500 / 1866 --- Result7411 to Stage7ParcoursStation11Points
perl -i -pe 's|Result7412 \[\.\.\.\]|Result7412 [ Stage7ParcoursStation12Points ]|g' Dependencies.txt
echo 1501 / 1866 --- Result7412 to Stage7ParcoursStation12Points
perl -i -pe 's|Result7413 \[\.\.\.\]|Result7413 [ Stage7ParcoursStation13Points ]|g' Dependencies.txt
echo 1502 / 1866 --- Result7413 to Stage7ParcoursStation13Points
perl -i -pe 's|Result7414 \[\.\.\.\]|Result7414 [ Stage7ParcoursStation14Points ]|g' Dependencies.txt
echo 1503 / 1866 --- Result7414 to Stage7ParcoursStation14Points
perl -i -pe 's|Result7415 \[\.\.\.\]|Result7415 [ Stage7ParcoursStation15Points ]|g' Dependencies.txt
echo 1504 / 1866 --- Result7415 to Stage7ParcoursStation15Points
perl -i -pe 's|Result7430 \[\.\.\.\]|Result7430 [ Stage7ParcoursTotalPoints ]|g' Dependencies.txt
echo 1505 / 1866 --- Result7430 to Stage7ParcoursTotalPoints
perl -i -pe 's|Result7441 \[\.\.\.\]|Result7441 [ Stage7ParcoursStart ]|g' Dependencies.txt
echo 1506 / 1866 --- Result7441 to Stage7ParcoursStart
perl -i -pe 's|Result7442 \[\.\.\.\]|Result7442 [ Stage7ParcoursFinish ]|g' Dependencies.txt
echo 1507 / 1866 --- Result7442 to Stage7ParcoursFinish
perl -i -pe 's|Result7450 \[\.\.\.\]|Result7450 [ Stage7ParcoursTime ]|g' Dependencies.txt
echo 1508 / 1866 --- Result7450 to Stage7ParcoursTime
perl -i -pe 's|Result7501 \[\.\.\.\]|Result7501 [ Stage7ParcoursRankingPoints ]|g' Dependencies.txt
echo 1509 / 1866 --- Result7501 to Stage7ParcoursRankingPoints
perl -i -pe 's|Result7502 \[\.\.\.\]|Result7502 [ Stage7CrossCountryRankingPoints ]|g' Dependencies.txt
echo 1510 / 1866 --- Result7502 to Stage7CrossCountryRankingPoints
perl -i -pe 's|Result7503 \[\.\.\.\]|Result7503 [ Stage7TotalRankingPoints ]|g' Dependencies.txt
echo 1511 / 1866 --- Result7503 to Stage7TotalRankingPoints
perl -i -pe 's|Result7611 \[\.\.\.\]|Result7611 [ Stage7Lap1Sector1 ]|g' Dependencies.txt
echo 1512 / 1866 --- Result7611 to Stage7Lap1Sector1
perl -i -pe 's|Result7612 \[\.\.\.\]|Result7612 [ Stage7Lap2Sector1 ]|g' Dependencies.txt
echo 1513 / 1866 --- Result7612 to Stage7Lap2Sector1
perl -i -pe 's|Result7613 \[\.\.\.\]|Result7613 [ Stage7Lap3Sector1 ]|g' Dependencies.txt
echo 1514 / 1866 --- Result7613 to Stage7Lap3Sector1
perl -i -pe 's|Result7614 \[\.\.\.\]|Result7614 [ Stage7Lap4Sector1 ]|g' Dependencies.txt
echo 1515 / 1866 --- Result7614 to Stage7Lap4Sector1
perl -i -pe 's|Result7615 \[\.\.\.\]|Result7615 [ Stage7Lap5Sector1 ]|g' Dependencies.txt
echo 1516 / 1866 --- Result7615 to Stage7Lap5Sector1
perl -i -pe 's|Result7616 \[\.\.\.\]|Result7616 [ Stage7Lap6Sector1 ]|g' Dependencies.txt
echo 1517 / 1866 --- Result7616 to Stage7Lap6Sector1
perl -i -pe 's|Result7617 \[\.\.\.\]|Result7617 [ Stage7Lap7Sector1 ]|g' Dependencies.txt
echo 1518 / 1866 --- Result7617 to Stage7Lap7Sector1
perl -i -pe 's|Result7618 \[\.\.\.\]|Result7618 [ Stage7Lap8Sector1 ]|g' Dependencies.txt
echo 1519 / 1866 --- Result7618 to Stage7Lap8Sector1
perl -i -pe 's|Result7619 \[\.\.\.\]|Result7619 [ Stage7Lap9Sector1 ]|g' Dependencies.txt
echo 1520 / 1866 --- Result7619 to Stage7Lap9Sector1
perl -i -pe 's|Result7620 \[\.\.\.\]|Result7620 [ Stage7Lap10Sector1 ]|g' Dependencies.txt
echo 1521 / 1866 --- Result7620 to Stage7Lap10Sector1
perl -i -pe 's|Result7621 \[\.\.\.\]|Result7621 [ Stage7Lap1Sector2 ]|g' Dependencies.txt
echo 1522 / 1866 --- Result7621 to Stage7Lap1Sector2
perl -i -pe 's|Result7622 \[\.\.\.\]|Result7622 [ Stage7Lap2Sector2 ]|g' Dependencies.txt
echo 1523 / 1866 --- Result7622 to Stage7Lap2Sector2
perl -i -pe 's|Result7623 \[\.\.\.\]|Result7623 [ Stage7Lap3Sector2 ]|g' Dependencies.txt
echo 1524 / 1866 --- Result7623 to Stage7Lap3Sector2
perl -i -pe 's|Result7624 \[\.\.\.\]|Result7624 [ Stage7Lap4Sector2 ]|g' Dependencies.txt
echo 1525 / 1866 --- Result7624 to Stage7Lap4Sector2
perl -i -pe 's|Result7625 \[\.\.\.\]|Result7625 [ Stage7Lap5Sector2 ]|g' Dependencies.txt
echo 1526 / 1866 --- Result7625 to Stage7Lap5Sector2
perl -i -pe 's|Result7626 \[\.\.\.\]|Result7626 [ Stage7Lap6Sector2 ]|g' Dependencies.txt
echo 1527 / 1866 --- Result7626 to Stage7Lap6Sector2
perl -i -pe 's|Result7627 \[\.\.\.\]|Result7627 [ Stage7Lap7Sector2 ]|g' Dependencies.txt
echo 1528 / 1866 --- Result7627 to Stage7Lap7Sector2
perl -i -pe 's|Result7628 \[\.\.\.\]|Result7628 [ Stage7Lap8Sector2 ]|g' Dependencies.txt
echo 1529 / 1866 --- Result7628 to Stage7Lap8Sector2
perl -i -pe 's|Result7629 \[\.\.\.\]|Result7629 [ Stage7Lap9Sector2 ]|g' Dependencies.txt
echo 1530 / 1866 --- Result7629 to Stage7Lap9Sector2
perl -i -pe 's|Result7630 \[\.\.\.\]|Result7630 [ Stage7Lap10Sector2 ]|g' Dependencies.txt
echo 1531 / 1866 --- Result7630 to Stage7Lap10Sector2
perl -i -pe 's|Result7631 \[\.\.\.\]|Result7631 [ Stage7Lap1Sector3 ]|g' Dependencies.txt
echo 1532 / 1866 --- Result7631 to Stage7Lap1Sector3
perl -i -pe 's|Result7632 \[\.\.\.\]|Result7632 [ Stage7Lap2Sector3 ]|g' Dependencies.txt
echo 1533 / 1866 --- Result7632 to Stage7Lap2Sector3
perl -i -pe 's|Result7633 \[\.\.\.\]|Result7633 [ Stage7Lap3Sector3 ]|g' Dependencies.txt
echo 1534 / 1866 --- Result7633 to Stage7Lap3Sector3
perl -i -pe 's|Result7634 \[\.\.\.\]|Result7634 [ Stage7Lap4Sector3 ]|g' Dependencies.txt
echo 1535 / 1866 --- Result7634 to Stage7Lap4Sector3
perl -i -pe 's|Result7635 \[\.\.\.\]|Result7635 [ Stage7Lap5Sector3 ]|g' Dependencies.txt
echo 1536 / 1866 --- Result7635 to Stage7Lap5Sector3
perl -i -pe 's|Result7636 \[\.\.\.\]|Result7636 [ Stage7Lap6Sector3 ]|g' Dependencies.txt
echo 1537 / 1866 --- Result7636 to Stage7Lap6Sector3
perl -i -pe 's|Result7637 \[\.\.\.\]|Result7637 [ Stage7Lap7Sector3 ]|g' Dependencies.txt
echo 1538 / 1866 --- Result7637 to Stage7Lap7Sector3
perl -i -pe 's|Result7638 \[\.\.\.\]|Result7638 [ Stage7Lap8Sector3 ]|g' Dependencies.txt
echo 1539 / 1866 --- Result7638 to Stage7Lap8Sector3
perl -i -pe 's|Result7639 \[\.\.\.\]|Result7639 [ Stage7Lap9Sector3 ]|g' Dependencies.txt
echo 1540 / 1866 --- Result7639 to Stage7Lap9Sector3
perl -i -pe 's|Result7640 \[\.\.\.\]|Result7640 [ Stage7Lap10Sector3 ]|g' Dependencies.txt
echo 1541 / 1866 --- Result7640 to Stage7Lap10Sector3
perl -i -pe 's|Result7641 \[\.\.\.\]|Result7641 [ Stage7Lap1Sector4 ]|g' Dependencies.txt
echo 1542 / 1866 --- Result7641 to Stage7Lap1Sector4
perl -i -pe 's|Result7642 \[\.\.\.\]|Result7642 [ Stage7Lap2Sector4 ]|g' Dependencies.txt
echo 1543 / 1866 --- Result7642 to Stage7Lap2Sector4
perl -i -pe 's|Result7643 \[\.\.\.\]|Result7643 [ Stage7Lap3Sector4 ]|g' Dependencies.txt
echo 1544 / 1866 --- Result7643 to Stage7Lap3Sector4
perl -i -pe 's|Result7644 \[\.\.\.\]|Result7644 [ Stage7Lap4Sector4 ]|g' Dependencies.txt
echo 1545 / 1866 --- Result7644 to Stage7Lap4Sector4
perl -i -pe 's|Result7645 \[\.\.\.\]|Result7645 [ Stage7Lap5Sector4 ]|g' Dependencies.txt
echo 1546 / 1866 --- Result7645 to Stage7Lap5Sector4
perl -i -pe 's|Result7646 \[\.\.\.\]|Result7646 [ Stage7Lap6Sector4 ]|g' Dependencies.txt
echo 1547 / 1866 --- Result7646 to Stage7Lap6Sector4
perl -i -pe 's|Result7647 \[\.\.\.\]|Result7647 [ Stage7Lap7Sector4 ]|g' Dependencies.txt
echo 1548 / 1866 --- Result7647 to Stage7Lap7Sector4
perl -i -pe 's|Result7648 \[\.\.\.\]|Result7648 [ Stage7Lap8Sector4 ]|g' Dependencies.txt
echo 1549 / 1866 --- Result7648 to Stage7Lap8Sector4
perl -i -pe 's|Result7649 \[\.\.\.\]|Result7649 [ Stage7Lap9Sector4 ]|g' Dependencies.txt
echo 1550 / 1866 --- Result7649 to Stage7Lap9Sector4
perl -i -pe 's|Result7650 \[\.\.\.\]|Result7650 [ Stage7Lap10Sector4 ]|g' Dependencies.txt
echo 1551 / 1866 --- Result7650 to Stage7Lap10Sector4
perl -i -pe 's|Result7651 \[\.\.\.\]|Result7651 [ Stage7Lap1UphillSector ]|g' Dependencies.txt
echo 1552 / 1866 --- Result7651 to Stage7Lap1UphillSector
perl -i -pe 's|Result7652 \[\.\.\.\]|Result7652 [ Stage7Lap2UphillSector ]|g' Dependencies.txt
echo 1553 / 1866 --- Result7652 to Stage7Lap2UphillSector
perl -i -pe 's|Result7653 \[\.\.\.\]|Result7653 [ Stage7Lap3UphillSector ]|g' Dependencies.txt
echo 1554 / 1866 --- Result7653 to Stage7Lap3UphillSector
perl -i -pe 's|Result7654 \[\.\.\.\]|Result7654 [ Stage7Lap4UphillSector ]|g' Dependencies.txt
echo 1555 / 1866 --- Result7654 to Stage7Lap4UphillSector
perl -i -pe 's|Result7655 \[\.\.\.\]|Result7655 [ Stage7Lap5UphillSector ]|g' Dependencies.txt
echo 1556 / 1866 --- Result7655 to Stage7Lap5UphillSector
perl -i -pe 's|Result7656 \[\.\.\.\]|Result7656 [ Stage7Lap6UphillSector ]|g' Dependencies.txt
echo 1557 / 1866 --- Result7656 to Stage7Lap6UphillSector
perl -i -pe 's|Result7657 \[\.\.\.\]|Result7657 [ Stage7Lap7UphillSector ]|g' Dependencies.txt
echo 1558 / 1866 --- Result7657 to Stage7Lap7UphillSector
perl -i -pe 's|Result7658 \[\.\.\.\]|Result7658 [ Stage7Lap8UphillSector ]|g' Dependencies.txt
echo 1559 / 1866 --- Result7658 to Stage7Lap8UphillSector
perl -i -pe 's|Result7659 \[\.\.\.\]|Result7659 [ Stage7Lap9UphillSector ]|g' Dependencies.txt
echo 1560 / 1866 --- Result7659 to Stage7Lap9UphillSector
perl -i -pe 's|Result7660 \[\.\.\.\]|Result7660 [ Stage7Lap10UphillSector ]|g' Dependencies.txt
echo 1561 / 1866 --- Result7660 to Stage7Lap10UphillSector
perl -i -pe 's|Result7680 \[\.\.\.\]|Result7680 [ Stage7FastestUphillSector ]|g' Dependencies.txt
echo 1562 / 1866 --- Result7680 to Stage7FastestUphillSector
perl -i -pe 's|Result7681 \[\.\.\.\]|Result7681 [ Stage7FastestUphillSectorID ]|g' Dependencies.txt
echo 1563 / 1866 --- Result7681 to Stage7FastestUphillSectorID
perl -i -pe 's|Result8000 \[\.\.\.\]|Result8000 [ Stage8StartTime ]|g' Dependencies.txt
echo 1564 / 1866 --- Result8000 to Stage8StartTime
perl -i -pe 's|Result8001 \[\.\.\.\]|Result8001 [ Stage8FinishTimeLimit ]|g' Dependencies.txt
echo 1565 / 1866 --- Result8001 to Stage8FinishTimeLimit
perl -i -pe 's|Result8100 \[\.\.\.\]|Result8100 [ Stage8Started ]|g' Dependencies.txt
echo 1566 / 1866 --- Result8100 to Stage8Started
perl -i -pe 's|Result8101 \[\.\.\.\]|Result8101 [ Stage8AfterLap1Split1 ]|g' Dependencies.txt
echo 1567 / 1866 --- Result8101 to Stage8AfterLap1Split1
perl -i -pe 's|Result8102 \[\.\.\.\]|Result8102 [ Stage8AfterLap1Split2 ]|g' Dependencies.txt
echo 1568 / 1866 --- Result8102 to Stage8AfterLap1Split2
perl -i -pe 's|Result8103 \[\.\.\.\]|Result8103 [ Stage8AfterLap1Split3 ]|g' Dependencies.txt
echo 1569 / 1866 --- Result8103 to Stage8AfterLap1Split3
perl -i -pe 's|Result8104 \[\.\.\.\]|Result8104 [ Stage8AfterLap1Spotter ]|g' Dependencies.txt
echo 1570 / 1866 --- Result8104 to Stage8AfterLap1Spotter
perl -i -pe 's|Result8105 \[\.\.\.\]|Result8105 [ Stage8AfterLap1Finish ]|g' Dependencies.txt
echo 1571 / 1866 --- Result8105 to Stage8AfterLap1Finish
perl -i -pe 's|Result8106 \[\.\.\.\]|Result8106 [ Stage8AfterLap2Split1 ]|g' Dependencies.txt
echo 1572 / 1866 --- Result8106 to Stage8AfterLap2Split1
perl -i -pe 's|Result8107 \[\.\.\.\]|Result8107 [ Stage8AfterLap2Split2 ]|g' Dependencies.txt
echo 1573 / 1866 --- Result8107 to Stage8AfterLap2Split2
perl -i -pe 's|Result8108 \[\.\.\.\]|Result8108 [ Stage8AfterLap2Split3 ]|g' Dependencies.txt
echo 1574 / 1866 --- Result8108 to Stage8AfterLap2Split3
perl -i -pe 's|Result8109 \[\.\.\.\]|Result8109 [ Stage8AfterLap2Spotter ]|g' Dependencies.txt
echo 1575 / 1866 --- Result8109 to Stage8AfterLap2Spotter
perl -i -pe 's|Result8110 \[\.\.\.\]|Result8110 [ Stage8AfterLap2Finish ]|g' Dependencies.txt
echo 1576 / 1866 --- Result8110 to Stage8AfterLap2Finish
perl -i -pe 's|Result8111 \[\.\.\.\]|Result8111 [ Stage8AfterLap3Split1 ]|g' Dependencies.txt
echo 1577 / 1866 --- Result8111 to Stage8AfterLap3Split1
perl -i -pe 's|Result8112 \[\.\.\.\]|Result8112 [ Stage8AfterLap3Split2 ]|g' Dependencies.txt
echo 1578 / 1866 --- Result8112 to Stage8AfterLap3Split2
perl -i -pe 's|Result8113 \[\.\.\.\]|Result8113 [ Stage8AfterLap3Split3 ]|g' Dependencies.txt
echo 1579 / 1866 --- Result8113 to Stage8AfterLap3Split3
perl -i -pe 's|Result8114 \[\.\.\.\]|Result8114 [ Stage8AfterLap3Spotter ]|g' Dependencies.txt
echo 1580 / 1866 --- Result8114 to Stage8AfterLap3Spotter
perl -i -pe 's|Result8115 \[\.\.\.\]|Result8115 [ Stage8AfterLap3Finish ]|g' Dependencies.txt
echo 1581 / 1866 --- Result8115 to Stage8AfterLap3Finish
perl -i -pe 's|Result8116 \[\.\.\.\]|Result8116 [ Stage8AfterLap4Split1 ]|g' Dependencies.txt
echo 1582 / 1866 --- Result8116 to Stage8AfterLap4Split1
perl -i -pe 's|Result8117 \[\.\.\.\]|Result8117 [ Stage8AfterLap4Split2 ]|g' Dependencies.txt
echo 1583 / 1866 --- Result8117 to Stage8AfterLap4Split2
perl -i -pe 's|Result8118 \[\.\.\.\]|Result8118 [ Stage8AfterLap4Split3 ]|g' Dependencies.txt
echo 1584 / 1866 --- Result8118 to Stage8AfterLap4Split3
perl -i -pe 's|Result8119 \[\.\.\.\]|Result8119 [ Stage8AfterLap4Spotter ]|g' Dependencies.txt
echo 1585 / 1866 --- Result8119 to Stage8AfterLap4Spotter
perl -i -pe 's|Result8120 \[\.\.\.\]|Result8120 [ Stage8AfterLap4Finish ]|g' Dependencies.txt
echo 1586 / 1866 --- Result8120 to Stage8AfterLap4Finish
perl -i -pe 's|Result8121 \[\.\.\.\]|Result8121 [ Stage8AfterLap5Split1 ]|g' Dependencies.txt
echo 1587 / 1866 --- Result8121 to Stage8AfterLap5Split1
perl -i -pe 's|Result8122 \[\.\.\.\]|Result8122 [ Stage8AfterLap5Split2 ]|g' Dependencies.txt
echo 1588 / 1866 --- Result8122 to Stage8AfterLap5Split2
perl -i -pe 's|Result8123 \[\.\.\.\]|Result8123 [ Stage8AfterLap5Split3 ]|g' Dependencies.txt
echo 1589 / 1866 --- Result8123 to Stage8AfterLap5Split3
perl -i -pe 's|Result8124 \[\.\.\.\]|Result8124 [ Stage8AfterLap5Spotter ]|g' Dependencies.txt
echo 1590 / 1866 --- Result8124 to Stage8AfterLap5Spotter
perl -i -pe 's|Result8125 \[\.\.\.\]|Result8125 [ Stage8AfterLap5Finish ]|g' Dependencies.txt
echo 1591 / 1866 --- Result8125 to Stage8AfterLap5Finish
perl -i -pe 's|Result8126 \[\.\.\.\]|Result8126 [ Stage8AfterLap6Split1 ]|g' Dependencies.txt
echo 1592 / 1866 --- Result8126 to Stage8AfterLap6Split1
perl -i -pe 's|Result8127 \[\.\.\.\]|Result8127 [ Stage8AfterLap6Split2 ]|g' Dependencies.txt
echo 1593 / 1866 --- Result8127 to Stage8AfterLap6Split2
perl -i -pe 's|Result8128 \[\.\.\.\]|Result8128 [ Stage8AfterLap6Split3 ]|g' Dependencies.txt
echo 1594 / 1866 --- Result8128 to Stage8AfterLap6Split3
perl -i -pe 's|Result8129 \[\.\.\.\]|Result8129 [ Stage8AfterLap6Spotter ]|g' Dependencies.txt
echo 1595 / 1866 --- Result8129 to Stage8AfterLap6Spotter
perl -i -pe 's|Result8130 \[\.\.\.\]|Result8130 [ Stage8AfterLap6Finish ]|g' Dependencies.txt
echo 1596 / 1866 --- Result8130 to Stage8AfterLap6Finish
perl -i -pe 's|Result8131 \[\.\.\.\]|Result8131 [ Stage8AfterLap7Split1 ]|g' Dependencies.txt
echo 1597 / 1866 --- Result8131 to Stage8AfterLap7Split1
perl -i -pe 's|Result8132 \[\.\.\.\]|Result8132 [ Stage8AfterLap7Split2 ]|g' Dependencies.txt
echo 1598 / 1866 --- Result8132 to Stage8AfterLap7Split2
perl -i -pe 's|Result8133 \[\.\.\.\]|Result8133 [ Stage8AfterLap7Split3 ]|g' Dependencies.txt
echo 1599 / 1866 --- Result8133 to Stage8AfterLap7Split3
perl -i -pe 's|Result8134 \[\.\.\.\]|Result8134 [ Stage8AfterLap7Spotter ]|g' Dependencies.txt
echo 1600 / 1866 --- Result8134 to Stage8AfterLap7Spotter
perl -i -pe 's|Result8135 \[\.\.\.\]|Result8135 [ Stage8AfterLap7Finish ]|g' Dependencies.txt
echo 1601 / 1866 --- Result8135 to Stage8AfterLap7Finish
perl -i -pe 's|Result8136 \[\.\.\.\]|Result8136 [ Stage8AfterLap8Split1 ]|g' Dependencies.txt
echo 1602 / 1866 --- Result8136 to Stage8AfterLap8Split1
perl -i -pe 's|Result8137 \[\.\.\.\]|Result8137 [ Stage8AfterLap8Split2 ]|g' Dependencies.txt
echo 1603 / 1866 --- Result8137 to Stage8AfterLap8Split2
perl -i -pe 's|Result8138 \[\.\.\.\]|Result8138 [ Stage8AfterLap8Split3 ]|g' Dependencies.txt
echo 1604 / 1866 --- Result8138 to Stage8AfterLap8Split3
perl -i -pe 's|Result8139 \[\.\.\.\]|Result8139 [ Stage8AfterLap8Spotter ]|g' Dependencies.txt
echo 1605 / 1866 --- Result8139 to Stage8AfterLap8Spotter
perl -i -pe 's|Result8140 \[\.\.\.\]|Result8140 [ Stage8AfterLap8Finish ]|g' Dependencies.txt
echo 1606 / 1866 --- Result8140 to Stage8AfterLap8Finish
perl -i -pe 's|Result8141 \[\.\.\.\]|Result8141 [ Stage8AfterLap9Split1 ]|g' Dependencies.txt
echo 1607 / 1866 --- Result8141 to Stage8AfterLap9Split1
perl -i -pe 's|Result8142 \[\.\.\.\]|Result8142 [ Stage8AfterLap9Split2 ]|g' Dependencies.txt
echo 1608 / 1866 --- Result8142 to Stage8AfterLap9Split2
perl -i -pe 's|Result8143 \[\.\.\.\]|Result8143 [ Stage8AfterLap9Split3 ]|g' Dependencies.txt
echo 1609 / 1866 --- Result8143 to Stage8AfterLap9Split3
perl -i -pe 's|Result8144 \[\.\.\.\]|Result8144 [ Stage8AfterLap9Spotter ]|g' Dependencies.txt
echo 1610 / 1866 --- Result8144 to Stage8AfterLap9Spotter
perl -i -pe 's|Result8145 \[\.\.\.\]|Result8145 [ Stage8AfterLap9Finish ]|g' Dependencies.txt
echo 1611 / 1866 --- Result8145 to Stage8AfterLap9Finish
perl -i -pe 's|Result8146 \[\.\.\.\]|Result8146 [ Stage8AfterLap10Split1 ]|g' Dependencies.txt
echo 1612 / 1866 --- Result8146 to Stage8AfterLap10Split1
perl -i -pe 's|Result8147 \[\.\.\.\]|Result8147 [ Stage8AfterLap10Split2 ]|g' Dependencies.txt
echo 1613 / 1866 --- Result8147 to Stage8AfterLap10Split2
perl -i -pe 's|Result8148 \[\.\.\.\]|Result8148 [ Stage8AfterLap10Split3 ]|g' Dependencies.txt
echo 1614 / 1866 --- Result8148 to Stage8AfterLap10Split3
perl -i -pe 's|Result8149 \[\.\.\.\]|Result8149 [ Stage8AfterLap10Spotter ]|g' Dependencies.txt
echo 1615 / 1866 --- Result8149 to Stage8AfterLap10Spotter
perl -i -pe 's|Result8150 \[\.\.\.\]|Result8150 [ Stage8AfterLap10Finish ]|g' Dependencies.txt
echo 1616 / 1866 --- Result8150 to Stage8AfterLap10Finish
perl -i -pe 's|Result8190 \[\.\.\.\]|Result8190 [ Stage8AfterFinish ]|g' Dependencies.txt
echo 1617 / 1866 --- Result8190 to Stage8AfterFinish
perl -i -pe 's|Result8191 \[\.\.\.\]|Result8191 [ Stage8LastSplitID ]|g' Dependencies.txt
echo 1618 / 1866 --- Result8191 to Stage8LastSplitID
perl -i -pe 's|Result8192 \[\.\.\.\]|Result8192 [ Stage8LastSplit ]|g' Dependencies.txt
echo 1619 / 1866 --- Result8192 to Stage8LastSplit
perl -i -pe 's|Result8193 \[\.\.\.\]|Result8193 [ Stage8LastFinishID ]|g' Dependencies.txt
echo 1620 / 1866 --- Result8193 to Stage8LastFinishID
perl -i -pe 's|Result8194 \[\.\.\.\]|Result8194 [ Stage8LastFinish ]|g' Dependencies.txt
echo 1621 / 1866 --- Result8194 to Stage8LastFinish
perl -i -pe 's|Result8195 \[\.\.\.\]|Result8195 [ Stage8LastSplitBunchTime ]|g' Dependencies.txt
echo 1622 / 1866 --- Result8195 to Stage8LastSplitBunchTime
perl -i -pe 's|Result8196 \[\.\.\.\]|Result8196 [ Stage8PhotoBunchTime ]|g' Dependencies.txt
echo 1623 / 1866 --- Result8196 to Stage8PhotoBunchTime
perl -i -pe 's|Result8200 \[\.\.\.\]|Result8200 [ Stage8Start ]|g' Dependencies.txt
echo 1624 / 1866 --- Result8200 to Stage8Start
perl -i -pe 's|Result8201 \[\.\.\.\]|Result8201 [ Stage8Lap1Split1 ]|g' Dependencies.txt
echo 1625 / 1866 --- Result8201 to Stage8Lap1Split1
perl -i -pe 's|Result8202 \[\.\.\.\]|Result8202 [ Stage8Lap1Split2 ]|g' Dependencies.txt
echo 1626 / 1866 --- Result8202 to Stage8Lap1Split2
perl -i -pe 's|Result8203 \[\.\.\.\]|Result8203 [ Stage8Lap1Split3 ]|g' Dependencies.txt
echo 1627 / 1866 --- Result8203 to Stage8Lap1Split3
perl -i -pe 's|Result8204 \[\.\.\.\]|Result8204 [ Stage8Lap1Spotter ]|g' Dependencies.txt
echo 1628 / 1866 --- Result8204 to Stage8Lap1Spotter
perl -i -pe 's|Result8205 \[\.\.\.\]|Result8205 [ Stage8Lap1Finish ]|g' Dependencies.txt
echo 1629 / 1866 --- Result8205 to Stage8Lap1Finish
perl -i -pe 's|Result8206 \[\.\.\.\]|Result8206 [ Stage8Lap2Split1 ]|g' Dependencies.txt
echo 1630 / 1866 --- Result8206 to Stage8Lap2Split1
perl -i -pe 's|Result8207 \[\.\.\.\]|Result8207 [ Stage8Lap2Split2 ]|g' Dependencies.txt
echo 1631 / 1866 --- Result8207 to Stage8Lap2Split2
perl -i -pe 's|Result8208 \[\.\.\.\]|Result8208 [ Stage8Lap2Split3 ]|g' Dependencies.txt
echo 1632 / 1866 --- Result8208 to Stage8Lap2Split3
perl -i -pe 's|Result8209 \[\.\.\.\]|Result8209 [ Stage8Lap2Spotter ]|g' Dependencies.txt
echo 1633 / 1866 --- Result8209 to Stage8Lap2Spotter
perl -i -pe 's|Result8210 \[\.\.\.\]|Result8210 [ Stage8Lap2Finish ]|g' Dependencies.txt
echo 1634 / 1866 --- Result8210 to Stage8Lap2Finish
perl -i -pe 's|Result8211 \[\.\.\.\]|Result8211 [ Stage8Lap3Split1 ]|g' Dependencies.txt
echo 1635 / 1866 --- Result8211 to Stage8Lap3Split1
perl -i -pe 's|Result8212 \[\.\.\.\]|Result8212 [ Stage8Lap3Split2 ]|g' Dependencies.txt
echo 1636 / 1866 --- Result8212 to Stage8Lap3Split2
perl -i -pe 's|Result8213 \[\.\.\.\]|Result8213 [ Stage8Lap3Split3 ]|g' Dependencies.txt
echo 1637 / 1866 --- Result8213 to Stage8Lap3Split3
perl -i -pe 's|Result8214 \[\.\.\.\]|Result8214 [ Stage8Lap3Spotter ]|g' Dependencies.txt
echo 1638 / 1866 --- Result8214 to Stage8Lap3Spotter
perl -i -pe 's|Result8215 \[\.\.\.\]|Result8215 [ Stage8Lap3Finish ]|g' Dependencies.txt
echo 1639 / 1866 --- Result8215 to Stage8Lap3Finish
perl -i -pe 's|Result8216 \[\.\.\.\]|Result8216 [ Stage8Lap4Split1 ]|g' Dependencies.txt
echo 1640 / 1866 --- Result8216 to Stage8Lap4Split1
perl -i -pe 's|Result8217 \[\.\.\.\]|Result8217 [ Stage8Lap4Split2 ]|g' Dependencies.txt
echo 1641 / 1866 --- Result8217 to Stage8Lap4Split2
perl -i -pe 's|Result8218 \[\.\.\.\]|Result8218 [ Stage8Lap4Split3 ]|g' Dependencies.txt
echo 1642 / 1866 --- Result8218 to Stage8Lap4Split3
perl -i -pe 's|Result8219 \[\.\.\.\]|Result8219 [ Stage8Lap4Spotter ]|g' Dependencies.txt
echo 1643 / 1866 --- Result8219 to Stage8Lap4Spotter
perl -i -pe 's|Result8220 \[\.\.\.\]|Result8220 [ Stage8Lap4Finish ]|g' Dependencies.txt
echo 1644 / 1866 --- Result8220 to Stage8Lap4Finish
perl -i -pe 's|Result8221 \[\.\.\.\]|Result8221 [ Stage8Lap5Split1 ]|g' Dependencies.txt
echo 1645 / 1866 --- Result8221 to Stage8Lap5Split1
perl -i -pe 's|Result8222 \[\.\.\.\]|Result8222 [ Stage8Lap5Split2 ]|g' Dependencies.txt
echo 1646 / 1866 --- Result8222 to Stage8Lap5Split2
perl -i -pe 's|Result8223 \[\.\.\.\]|Result8223 [ Stage8Lap5Split3 ]|g' Dependencies.txt
echo 1647 / 1866 --- Result8223 to Stage8Lap5Split3
perl -i -pe 's|Result8224 \[\.\.\.\]|Result8224 [ Stage8Lap5Spotter ]|g' Dependencies.txt
echo 1648 / 1866 --- Result8224 to Stage8Lap5Spotter
perl -i -pe 's|Result8225 \[\.\.\.\]|Result8225 [ Stage8Lap5Finish ]|g' Dependencies.txt
echo 1649 / 1866 --- Result8225 to Stage8Lap5Finish
perl -i -pe 's|Result8226 \[\.\.\.\]|Result8226 [ Stage8Lap6Split1 ]|g' Dependencies.txt
echo 1650 / 1866 --- Result8226 to Stage8Lap6Split1
perl -i -pe 's|Result8227 \[\.\.\.\]|Result8227 [ Stage8Lap6Split2 ]|g' Dependencies.txt
echo 1651 / 1866 --- Result8227 to Stage8Lap6Split2
perl -i -pe 's|Result8228 \[\.\.\.\]|Result8228 [ Stage8Lap6Split3 ]|g' Dependencies.txt
echo 1652 / 1866 --- Result8228 to Stage8Lap6Split3
perl -i -pe 's|Result8229 \[\.\.\.\]|Result8229 [ Stage8Lap6Spotter ]|g' Dependencies.txt
echo 1653 / 1866 --- Result8229 to Stage8Lap6Spotter
perl -i -pe 's|Result8230 \[\.\.\.\]|Result8230 [ Stage8Lap6Finish ]|g' Dependencies.txt
echo 1654 / 1866 --- Result8230 to Stage8Lap6Finish
perl -i -pe 's|Result8231 \[\.\.\.\]|Result8231 [ Stage8Lap7Split1 ]|g' Dependencies.txt
echo 1655 / 1866 --- Result8231 to Stage8Lap7Split1
perl -i -pe 's|Result8232 \[\.\.\.\]|Result8232 [ Stage8Lap7Split2 ]|g' Dependencies.txt
echo 1656 / 1866 --- Result8232 to Stage8Lap7Split2
perl -i -pe 's|Result8233 \[\.\.\.\]|Result8233 [ Stage8Lap7Split3 ]|g' Dependencies.txt
echo 1657 / 1866 --- Result8233 to Stage8Lap7Split3
perl -i -pe 's|Result8234 \[\.\.\.\]|Result8234 [ Stage8Lap7Spotter ]|g' Dependencies.txt
echo 1658 / 1866 --- Result8234 to Stage8Lap7Spotter
perl -i -pe 's|Result8235 \[\.\.\.\]|Result8235 [ Stage8Lap7Finish ]|g' Dependencies.txt
echo 1659 / 1866 --- Result8235 to Stage8Lap7Finish
perl -i -pe 's|Result8236 \[\.\.\.\]|Result8236 [ Stage8Lap8Split1 ]|g' Dependencies.txt
echo 1660 / 1866 --- Result8236 to Stage8Lap8Split1
perl -i -pe 's|Result8237 \[\.\.\.\]|Result8237 [ Stage8Lap8Split2 ]|g' Dependencies.txt
echo 1661 / 1866 --- Result8237 to Stage8Lap8Split2
perl -i -pe 's|Result8238 \[\.\.\.\]|Result8238 [ Stage8Lap8Split3 ]|g' Dependencies.txt
echo 1662 / 1866 --- Result8238 to Stage8Lap8Split3
perl -i -pe 's|Result8239 \[\.\.\.\]|Result8239 [ Stage8Lap8Spotter ]|g' Dependencies.txt
echo 1663 / 1866 --- Result8239 to Stage8Lap8Spotter
perl -i -pe 's|Result8240 \[\.\.\.\]|Result8240 [ Stage8Lap8Finish ]|g' Dependencies.txt
echo 1664 / 1866 --- Result8240 to Stage8Lap8Finish
perl -i -pe 's|Result8241 \[\.\.\.\]|Result8241 [ Stage8Lap9Split1 ]|g' Dependencies.txt
echo 1665 / 1866 --- Result8241 to Stage8Lap9Split1
perl -i -pe 's|Result8242 \[\.\.\.\]|Result8242 [ Stage8Lap9Split2 ]|g' Dependencies.txt
echo 1666 / 1866 --- Result8242 to Stage8Lap9Split2
perl -i -pe 's|Result8243 \[\.\.\.\]|Result8243 [ Stage8Lap9Split3 ]|g' Dependencies.txt
echo 1667 / 1866 --- Result8243 to Stage8Lap9Split3
perl -i -pe 's|Result8244 \[\.\.\.\]|Result8244 [ Stage8Lap9Spotter ]|g' Dependencies.txt
echo 1668 / 1866 --- Result8244 to Stage8Lap9Spotter
perl -i -pe 's|Result8245 \[\.\.\.\]|Result8245 [ Stage8Lap9Finish ]|g' Dependencies.txt
echo 1669 / 1866 --- Result8245 to Stage8Lap9Finish
perl -i -pe 's|Result8246 \[\.\.\.\]|Result8246 [ Stage8Lap10Split1 ]|g' Dependencies.txt
echo 1670 / 1866 --- Result8246 to Stage8Lap10Split1
perl -i -pe 's|Result8247 \[\.\.\.\]|Result8247 [ Stage8Lap10Split2 ]|g' Dependencies.txt
echo 1671 / 1866 --- Result8247 to Stage8Lap10Split2
perl -i -pe 's|Result8248 \[\.\.\.\]|Result8248 [ Stage8Lap10Split3 ]|g' Dependencies.txt
echo 1672 / 1866 --- Result8248 to Stage8Lap10Split3
perl -i -pe 's|Result8249 \[\.\.\.\]|Result8249 [ Stage8Lap10Spotter ]|g' Dependencies.txt
echo 1673 / 1866 --- Result8249 to Stage8Lap10Spotter
perl -i -pe 's|Result8250 \[\.\.\.\]|Result8250 [ Stage8Lap10Finish ]|g' Dependencies.txt
echo 1674 / 1866 --- Result8250 to Stage8Lap10Finish
perl -i -pe 's|Result8301 \[\.\.\.\]|Result8301 [ Stage8Lap1 ]|g' Dependencies.txt
echo 1675 / 1866 --- Result8301 to Stage8Lap1
perl -i -pe 's|Result8302 \[\.\.\.\]|Result8302 [ Stage8Lap2 ]|g' Dependencies.txt
echo 1676 / 1866 --- Result8302 to Stage8Lap2
perl -i -pe 's|Result8303 \[\.\.\.\]|Result8303 [ Stage8Lap3 ]|g' Dependencies.txt
echo 1677 / 1866 --- Result8303 to Stage8Lap3
perl -i -pe 's|Result8304 \[\.\.\.\]|Result8304 [ Stage8Lap4 ]|g' Dependencies.txt
echo 1678 / 1866 --- Result8304 to Stage8Lap4
perl -i -pe 's|Result8305 \[\.\.\.\]|Result8305 [ Stage8Lap5 ]|g' Dependencies.txt
echo 1679 / 1866 --- Result8305 to Stage8Lap5
perl -i -pe 's|Result8306 \[\.\.\.\]|Result8306 [ Stage8Lap6 ]|g' Dependencies.txt
echo 1680 / 1866 --- Result8306 to Stage8Lap6
perl -i -pe 's|Result8307 \[\.\.\.\]|Result8307 [ Stage8Lap7 ]|g' Dependencies.txt
echo 1681 / 1866 --- Result8307 to Stage8Lap7
perl -i -pe 's|Result8308 \[\.\.\.\]|Result8308 [ Stage8Lap8 ]|g' Dependencies.txt
echo 1682 / 1866 --- Result8308 to Stage8Lap8
perl -i -pe 's|Result8309 \[\.\.\.\]|Result8309 [ Stage8Lap9 ]|g' Dependencies.txt
echo 1683 / 1866 --- Result8309 to Stage8Lap9
perl -i -pe 's|Result8310 \[\.\.\.\]|Result8310 [ Stage8Lap10 ]|g' Dependencies.txt
echo 1684 / 1866 --- Result8310 to Stage8Lap10
perl -i -pe 's|Result8320 \[\.\.\.\]|Result8320 [ Stage8LapCount ]|g' Dependencies.txt
echo 1685 / 1866 --- Result8320 to Stage8LapCount
perl -i -pe 's|Result8321 \[\.\.\.\]|Result8321 [ Stage8FastestLap ]|g' Dependencies.txt
echo 1686 / 1866 --- Result8321 to Stage8FastestLap
perl -i -pe 's|Result8322 \[\.\.\.\]|Result8322 [ Stage8SlowestLap ]|g' Dependencies.txt
echo 1687 / 1866 --- Result8322 to Stage8SlowestLap
perl -i -pe 's|Result8323 \[\.\.\.\]|Result8323 [ Stage8AverageLap ]|g' Dependencies.txt
echo 1688 / 1866 --- Result8323 to Stage8AverageLap
perl -i -pe 's|Result8401 \[\.\.\.\]|Result8401 [ Stage8ParcoursStation1Points ]|g' Dependencies.txt
echo 1689 / 1866 --- Result8401 to Stage8ParcoursStation1Points
perl -i -pe 's|Result8402 \[\.\.\.\]|Result8402 [ Stage8ParcoursStation2Points ]|g' Dependencies.txt
echo 1690 / 1866 --- Result8402 to Stage8ParcoursStation2Points
perl -i -pe 's|Result8403 \[\.\.\.\]|Result8403 [ Stage8ParcoursStation3Points ]|g' Dependencies.txt
echo 1691 / 1866 --- Result8403 to Stage8ParcoursStation3Points
perl -i -pe 's|Result8404 \[\.\.\.\]|Result8404 [ Stage8ParcoursStation4Points ]|g' Dependencies.txt
echo 1692 / 1866 --- Result8404 to Stage8ParcoursStation4Points
perl -i -pe 's|Result8405 \[\.\.\.\]|Result8405 [ Stage8ParcoursStation5Points ]|g' Dependencies.txt
echo 1693 / 1866 --- Result8405 to Stage8ParcoursStation5Points
perl -i -pe 's|Result8406 \[\.\.\.\]|Result8406 [ Stage8ParcoursStation6Points ]|g' Dependencies.txt
echo 1694 / 1866 --- Result8406 to Stage8ParcoursStation6Points
perl -i -pe 's|Result8407 \[\.\.\.\]|Result8407 [ Stage8ParcoursStation7Points ]|g' Dependencies.txt
echo 1695 / 1866 --- Result8407 to Stage8ParcoursStation7Points
perl -i -pe 's|Result8408 \[\.\.\.\]|Result8408 [ Stage8ParcoursStation8Points ]|g' Dependencies.txt
echo 1696 / 1866 --- Result8408 to Stage8ParcoursStation8Points
perl -i -pe 's|Result8409 \[\.\.\.\]|Result8409 [ Stage8ParcoursStation9Points ]|g' Dependencies.txt
echo 1697 / 1866 --- Result8409 to Stage8ParcoursStation9Points
perl -i -pe 's|Result8410 \[\.\.\.\]|Result8410 [ Stage8ParcoursStation10Points ]|g' Dependencies.txt
echo 1698 / 1866 --- Result8410 to Stage8ParcoursStation10Points
perl -i -pe 's|Result8411 \[\.\.\.\]|Result8411 [ Stage8ParcoursStation11Points ]|g' Dependencies.txt
echo 1699 / 1866 --- Result8411 to Stage8ParcoursStation11Points
perl -i -pe 's|Result8412 \[\.\.\.\]|Result8412 [ Stage8ParcoursStation12Points ]|g' Dependencies.txt
echo 1700 / 1866 --- Result8412 to Stage8ParcoursStation12Points
perl -i -pe 's|Result8413 \[\.\.\.\]|Result8413 [ Stage8ParcoursStation13Points ]|g' Dependencies.txt
echo 1701 / 1866 --- Result8413 to Stage8ParcoursStation13Points
perl -i -pe 's|Result8414 \[\.\.\.\]|Result8414 [ Stage8ParcoursStation14Points ]|g' Dependencies.txt
echo 1702 / 1866 --- Result8414 to Stage8ParcoursStation14Points
perl -i -pe 's|Result8415 \[\.\.\.\]|Result8415 [ Stage8ParcoursStation15Points ]|g' Dependencies.txt
echo 1703 / 1866 --- Result8415 to Stage8ParcoursStation15Points
perl -i -pe 's|Result8430 \[\.\.\.\]|Result8430 [ Stage8ParcoursTotalPoints ]|g' Dependencies.txt
echo 1704 / 1866 --- Result8430 to Stage8ParcoursTotalPoints
perl -i -pe 's|Result8441 \[\.\.\.\]|Result8441 [ Stage8ParcoursStart ]|g' Dependencies.txt
echo 1705 / 1866 --- Result8441 to Stage8ParcoursStart
perl -i -pe 's|Result8442 \[\.\.\.\]|Result8442 [ Stage8ParcoursFinish ]|g' Dependencies.txt
echo 1706 / 1866 --- Result8442 to Stage8ParcoursFinish
perl -i -pe 's|Result8450 \[\.\.\.\]|Result8450 [ Stage8ParcoursTime ]|g' Dependencies.txt
echo 1707 / 1866 --- Result8450 to Stage8ParcoursTime
perl -i -pe 's|Result8501 \[\.\.\.\]|Result8501 [ Stage8ParcoursRankingPoints ]|g' Dependencies.txt
echo 1708 / 1866 --- Result8501 to Stage8ParcoursRankingPoints
perl -i -pe 's|Result8502 \[\.\.\.\]|Result8502 [ Stage8CrossCountryRankingPoints ]|g' Dependencies.txt
echo 1709 / 1866 --- Result8502 to Stage8CrossCountryRankingPoints
perl -i -pe 's|Result8503 \[\.\.\.\]|Result8503 [ Stage8TotalRankingPoints ]|g' Dependencies.txt
echo 1710 / 1866 --- Result8503 to Stage8TotalRankingPoints
perl -i -pe 's|Result8611 \[\.\.\.\]|Result8611 [ Stage8Lap1Sector1 ]|g' Dependencies.txt
echo 1711 / 1866 --- Result8611 to Stage8Lap1Sector1
perl -i -pe 's|Result8612 \[\.\.\.\]|Result8612 [ Stage8Lap2Sector1 ]|g' Dependencies.txt
echo 1712 / 1866 --- Result8612 to Stage8Lap2Sector1
perl -i -pe 's|Result8613 \[\.\.\.\]|Result8613 [ Stage8Lap3Sector1 ]|g' Dependencies.txt
echo 1713 / 1866 --- Result8613 to Stage8Lap3Sector1
perl -i -pe 's|Result8614 \[\.\.\.\]|Result8614 [ Stage8Lap4Sector1 ]|g' Dependencies.txt
echo 1714 / 1866 --- Result8614 to Stage8Lap4Sector1
perl -i -pe 's|Result8615 \[\.\.\.\]|Result8615 [ Stage8Lap5Sector1 ]|g' Dependencies.txt
echo 1715 / 1866 --- Result8615 to Stage8Lap5Sector1
perl -i -pe 's|Result8616 \[\.\.\.\]|Result8616 [ Stage8Lap6Sector1 ]|g' Dependencies.txt
echo 1716 / 1866 --- Result8616 to Stage8Lap6Sector1
perl -i -pe 's|Result8617 \[\.\.\.\]|Result8617 [ Stage8Lap7Sector1 ]|g' Dependencies.txt
echo 1717 / 1866 --- Result8617 to Stage8Lap7Sector1
perl -i -pe 's|Result8618 \[\.\.\.\]|Result8618 [ Stage8Lap8Sector1 ]|g' Dependencies.txt
echo 1718 / 1866 --- Result8618 to Stage8Lap8Sector1
perl -i -pe 's|Result8619 \[\.\.\.\]|Result8619 [ Stage8Lap9Sector1 ]|g' Dependencies.txt
echo 1719 / 1866 --- Result8619 to Stage8Lap9Sector1
perl -i -pe 's|Result8620 \[\.\.\.\]|Result8620 [ Stage8Lap10Sector1 ]|g' Dependencies.txt
echo 1720 / 1866 --- Result8620 to Stage8Lap10Sector1
perl -i -pe 's|Result8621 \[\.\.\.\]|Result8621 [ Stage8Lap1Sector2 ]|g' Dependencies.txt
echo 1721 / 1866 --- Result8621 to Stage8Lap1Sector2
perl -i -pe 's|Result8622 \[\.\.\.\]|Result8622 [ Stage8Lap2Sector2 ]|g' Dependencies.txt
echo 1722 / 1866 --- Result8622 to Stage8Lap2Sector2
perl -i -pe 's|Result8623 \[\.\.\.\]|Result8623 [ Stage8Lap3Sector2 ]|g' Dependencies.txt
echo 1723 / 1866 --- Result8623 to Stage8Lap3Sector2
perl -i -pe 's|Result8624 \[\.\.\.\]|Result8624 [ Stage8Lap4Sector2 ]|g' Dependencies.txt
echo 1724 / 1866 --- Result8624 to Stage8Lap4Sector2
perl -i -pe 's|Result8625 \[\.\.\.\]|Result8625 [ Stage8Lap5Sector2 ]|g' Dependencies.txt
echo 1725 / 1866 --- Result8625 to Stage8Lap5Sector2
perl -i -pe 's|Result8626 \[\.\.\.\]|Result8626 [ Stage8Lap6Sector2 ]|g' Dependencies.txt
echo 1726 / 1866 --- Result8626 to Stage8Lap6Sector2
perl -i -pe 's|Result8627 \[\.\.\.\]|Result8627 [ Stage8Lap7Sector2 ]|g' Dependencies.txt
echo 1727 / 1866 --- Result8627 to Stage8Lap7Sector2
perl -i -pe 's|Result8628 \[\.\.\.\]|Result8628 [ Stage8Lap8Sector2 ]|g' Dependencies.txt
echo 1728 / 1866 --- Result8628 to Stage8Lap8Sector2
perl -i -pe 's|Result8629 \[\.\.\.\]|Result8629 [ Stage8Lap9Sector2 ]|g' Dependencies.txt
echo 1729 / 1866 --- Result8629 to Stage8Lap9Sector2
perl -i -pe 's|Result8630 \[\.\.\.\]|Result8630 [ Stage8Lap10Sector2 ]|g' Dependencies.txt
echo 1730 / 1866 --- Result8630 to Stage8Lap10Sector2
perl -i -pe 's|Result8631 \[\.\.\.\]|Result8631 [ Stage8Lap1Sector3 ]|g' Dependencies.txt
echo 1731 / 1866 --- Result8631 to Stage8Lap1Sector3
perl -i -pe 's|Result8632 \[\.\.\.\]|Result8632 [ Stage8Lap2Sector3 ]|g' Dependencies.txt
echo 1732 / 1866 --- Result8632 to Stage8Lap2Sector3
perl -i -pe 's|Result8633 \[\.\.\.\]|Result8633 [ Stage8Lap3Sector3 ]|g' Dependencies.txt
echo 1733 / 1866 --- Result8633 to Stage8Lap3Sector3
perl -i -pe 's|Result8634 \[\.\.\.\]|Result8634 [ Stage8Lap4Sector3 ]|g' Dependencies.txt
echo 1734 / 1866 --- Result8634 to Stage8Lap4Sector3
perl -i -pe 's|Result8635 \[\.\.\.\]|Result8635 [ Stage8Lap5Sector3 ]|g' Dependencies.txt
echo 1735 / 1866 --- Result8635 to Stage8Lap5Sector3
perl -i -pe 's|Result8636 \[\.\.\.\]|Result8636 [ Stage8Lap6Sector3 ]|g' Dependencies.txt
echo 1736 / 1866 --- Result8636 to Stage8Lap6Sector3
perl -i -pe 's|Result8637 \[\.\.\.\]|Result8637 [ Stage8Lap7Sector3 ]|g' Dependencies.txt
echo 1737 / 1866 --- Result8637 to Stage8Lap7Sector3
perl -i -pe 's|Result8638 \[\.\.\.\]|Result8638 [ Stage8Lap8Sector3 ]|g' Dependencies.txt
echo 1738 / 1866 --- Result8638 to Stage8Lap8Sector3
perl -i -pe 's|Result8639 \[\.\.\.\]|Result8639 [ Stage8Lap9Sector3 ]|g' Dependencies.txt
echo 1739 / 1866 --- Result8639 to Stage8Lap9Sector3
perl -i -pe 's|Result8640 \[\.\.\.\]|Result8640 [ Stage8Lap10Sector3 ]|g' Dependencies.txt
echo 1740 / 1866 --- Result8640 to Stage8Lap10Sector3
perl -i -pe 's|Result8641 \[\.\.\.\]|Result8641 [ Stage8Lap1Sector4 ]|g' Dependencies.txt
echo 1741 / 1866 --- Result8641 to Stage8Lap1Sector4
perl -i -pe 's|Result8642 \[\.\.\.\]|Result8642 [ Stage8Lap2Sector4 ]|g' Dependencies.txt
echo 1742 / 1866 --- Result8642 to Stage8Lap2Sector4
perl -i -pe 's|Result8643 \[\.\.\.\]|Result8643 [ Stage8Lap3Sector4 ]|g' Dependencies.txt
echo 1743 / 1866 --- Result8643 to Stage8Lap3Sector4
perl -i -pe 's|Result8644 \[\.\.\.\]|Result8644 [ Stage8Lap4Sector4 ]|g' Dependencies.txt
echo 1744 / 1866 --- Result8644 to Stage8Lap4Sector4
perl -i -pe 's|Result8645 \[\.\.\.\]|Result8645 [ Stage8Lap5Sector4 ]|g' Dependencies.txt
echo 1745 / 1866 --- Result8645 to Stage8Lap5Sector4
perl -i -pe 's|Result8646 \[\.\.\.\]|Result8646 [ Stage8Lap6Sector4 ]|g' Dependencies.txt
echo 1746 / 1866 --- Result8646 to Stage8Lap6Sector4
perl -i -pe 's|Result8647 \[\.\.\.\]|Result8647 [ Stage8Lap7Sector4 ]|g' Dependencies.txt
echo 1747 / 1866 --- Result8647 to Stage8Lap7Sector4
perl -i -pe 's|Result8648 \[\.\.\.\]|Result8648 [ Stage8Lap8Sector4 ]|g' Dependencies.txt
echo 1748 / 1866 --- Result8648 to Stage8Lap8Sector4
perl -i -pe 's|Result8649 \[\.\.\.\]|Result8649 [ Stage8Lap9Sector4 ]|g' Dependencies.txt
echo 1749 / 1866 --- Result8649 to Stage8Lap9Sector4
perl -i -pe 's|Result8650 \[\.\.\.\]|Result8650 [ Stage8Lap10Sector4 ]|g' Dependencies.txt
echo 1750 / 1866 --- Result8650 to Stage8Lap10Sector4
perl -i -pe 's|Result8651 \[\.\.\.\]|Result8651 [ Stage8Lap1UphillSector ]|g' Dependencies.txt
echo 1751 / 1866 --- Result8651 to Stage8Lap1UphillSector
perl -i -pe 's|Result8652 \[\.\.\.\]|Result8652 [ Stage8Lap2UphillSector ]|g' Dependencies.txt
echo 1752 / 1866 --- Result8652 to Stage8Lap2UphillSector
perl -i -pe 's|Result8653 \[\.\.\.\]|Result8653 [ Stage8Lap3UphillSector ]|g' Dependencies.txt
echo 1753 / 1866 --- Result8653 to Stage8Lap3UphillSector
perl -i -pe 's|Result8654 \[\.\.\.\]|Result8654 [ Stage8Lap4UphillSector ]|g' Dependencies.txt
echo 1754 / 1866 --- Result8654 to Stage8Lap4UphillSector
perl -i -pe 's|Result8655 \[\.\.\.\]|Result8655 [ Stage8Lap5UphillSector ]|g' Dependencies.txt
echo 1755 / 1866 --- Result8655 to Stage8Lap5UphillSector
perl -i -pe 's|Result8656 \[\.\.\.\]|Result8656 [ Stage8Lap6UphillSector ]|g' Dependencies.txt
echo 1756 / 1866 --- Result8656 to Stage8Lap6UphillSector
perl -i -pe 's|Result8657 \[\.\.\.\]|Result8657 [ Stage8Lap7UphillSector ]|g' Dependencies.txt
echo 1757 / 1866 --- Result8657 to Stage8Lap7UphillSector
perl -i -pe 's|Result8658 \[\.\.\.\]|Result8658 [ Stage8Lap8UphillSector ]|g' Dependencies.txt
echo 1758 / 1866 --- Result8658 to Stage8Lap8UphillSector
perl -i -pe 's|Result8659 \[\.\.\.\]|Result8659 [ Stage8Lap9UphillSector ]|g' Dependencies.txt
echo 1759 / 1866 --- Result8659 to Stage8Lap9UphillSector
perl -i -pe 's|Result8660 \[\.\.\.\]|Result8660 [ Stage8Lap10UphillSector ]|g' Dependencies.txt
echo 1760 / 1866 --- Result8660 to Stage8Lap10UphillSector
perl -i -pe 's|Result8680 \[\.\.\.\]|Result8680 [ Stage8FastestUphillSector ]|g' Dependencies.txt
echo 1761 / 1866 --- Result8680 to Stage8FastestUphillSector
perl -i -pe 's|Result8681 \[\.\.\.\]|Result8681 [ Stage8FastestUphillSectorID ]|g' Dependencies.txt
echo 1762 / 1866 --- Result8681 to Stage8FastestUphillSectorID
perl -i -pe 's|Rank51 \[\.\.\.\]|Rank51 [ Stage1CombinedRank ]|g' Dependencies.txt
echo 1763 / 1866 --- Rank51 to Stage1CombinedRank
perl -i -pe 's|Rank52 \[\.\.\.\]|Rank52 [ Stage2CombinedRank ]|g' Dependencies.txt
echo 1764 / 1866 --- Rank52 to Stage2CombinedRank
perl -i -pe 's|Rank53 \[\.\.\.\]|Rank53 [ Stage3CombinedRank ]|g' Dependencies.txt
echo 1765 / 1866 --- Rank53 to Stage3CombinedRank
perl -i -pe 's|Rank54 \[\.\.\.\]|Rank54 [ Stage4CombinedRank ]|g' Dependencies.txt
echo 1766 / 1866 --- Rank54 to Stage4CombinedRank
perl -i -pe 's|Rank55 \[\.\.\.\]|Rank55 [ Stage5CombinedRank ]|g' Dependencies.txt
echo 1767 / 1866 --- Rank55 to Stage5CombinedRank
perl -i -pe 's|Rank56 \[\.\.\.\]|Rank56 [ Stage6CombinedRank ]|g' Dependencies.txt
echo 1768 / 1866 --- Rank56 to Stage6CombinedRank
perl -i -pe 's|Rank57 \[\.\.\.\]|Rank57 [ Stage7CombinedRank ]|g' Dependencies.txt
echo 1769 / 1866 --- Rank57 to Stage7CombinedRank
perl -i -pe 's|Rank58 \[\.\.\.\]|Rank58 [ Stage8CombinedRank ]|g' Dependencies.txt
echo 1770 / 1866 --- Rank58 to Stage8CombinedRank
perl -i -pe 's|Rank1 \[\.\.\.\]|Rank1 [ Stage1OverallRank ]|g' Dependencies.txt
echo 1771 / 1866 --- Rank1 to Stage1OverallRank
perl -i -pe 's|Rank2 \[\.\.\.\]|Rank2 [ Stage2OverallRank ]|g' Dependencies.txt
echo 1772 / 1866 --- Rank2 to Stage2OverallRank
perl -i -pe 's|Rank3 \[\.\.\.\]|Rank3 [ Stage3OverallRank ]|g' Dependencies.txt
echo 1773 / 1866 --- Rank3 to Stage3OverallRank
perl -i -pe 's|Rank4 \[\.\.\.\]|Rank4 [ Stage4OverallRank ]|g' Dependencies.txt
echo 1774 / 1866 --- Rank4 to Stage4OverallRank
perl -i -pe 's|Rank5 \[\.\.\.\]|Rank5 [ Stage5OverallRank ]|g' Dependencies.txt
echo 1775 / 1866 --- Rank5 to Stage5OverallRank
perl -i -pe 's|Rank6 \[\.\.\.\]|Rank6 [ Stage6OverallRank ]|g' Dependencies.txt
echo 1776 / 1866 --- Rank6 to Stage6OverallRank
perl -i -pe 's|Rank7 \[\.\.\.\]|Rank7 [ Stage7OverallRank ]|g' Dependencies.txt
echo 1777 / 1866 --- Rank7 to Stage7OverallRank
perl -i -pe 's|Rank8 \[\.\.\.\]|Rank8 [ Stage8OverallRank ]|g' Dependencies.txt
echo 1778 / 1866 --- Rank8 to Stage8OverallRank
perl -i -pe 's|Rank11 \[\.\.\.\]|Rank11 [ Stage1GenderRank ]|g' Dependencies.txt
echo 1779 / 1866 --- Rank11 to Stage1GenderRank
perl -i -pe 's|Rank12 \[\.\.\.\]|Rank12 [ Stage2GenderRank ]|g' Dependencies.txt
echo 1780 / 1866 --- Rank12 to Stage2GenderRank
perl -i -pe 's|Rank13 \[\.\.\.\]|Rank13 [ Stage3GenderRank ]|g' Dependencies.txt
echo 1781 / 1866 --- Rank13 to Stage3GenderRank
perl -i -pe 's|Rank14 \[\.\.\.\]|Rank14 [ Stage4GenderRank ]|g' Dependencies.txt
echo 1782 / 1866 --- Rank14 to Stage4GenderRank
perl -i -pe 's|Rank15 \[\.\.\.\]|Rank15 [ Stage5GenderRank ]|g' Dependencies.txt
echo 1783 / 1866 --- Rank15 to Stage5GenderRank
perl -i -pe 's|Rank16 \[\.\.\.\]|Rank16 [ Stage6GenderRank ]|g' Dependencies.txt
echo 1784 / 1866 --- Rank16 to Stage6GenderRank
perl -i -pe 's|Rank17 \[\.\.\.\]|Rank17 [ Stage7GenderRank ]|g' Dependencies.txt
echo 1785 / 1866 --- Rank17 to Stage7GenderRank
perl -i -pe 's|Rank18 \[\.\.\.\]|Rank18 [ Stage8GenderRank ]|g' Dependencies.txt
echo 1786 / 1866 --- Rank18 to Stage8GenderRank
perl -i -pe 's|Rank21 \[\.\.\.\]|Rank21 [ Stage1AgeGroupRank ]|g' Dependencies.txt
echo 1787 / 1866 --- Rank21 to Stage1AgeGroupRank
perl -i -pe 's|Rank22 \[\.\.\.\]|Rank22 [ Stage2AgeGroupRank ]|g' Dependencies.txt
echo 1788 / 1866 --- Rank22 to Stage2AgeGroupRank
perl -i -pe 's|Rank23 \[\.\.\.\]|Rank23 [ Stage3AgeGroupRank ]|g' Dependencies.txt
echo 1789 / 1866 --- Rank23 to Stage3AgeGroupRank
perl -i -pe 's|Rank24 \[\.\.\.\]|Rank24 [ Stage4AgeGroupRank ]|g' Dependencies.txt
echo 1790 / 1866 --- Rank24 to Stage4AgeGroupRank
perl -i -pe 's|Rank25 \[\.\.\.\]|Rank25 [ Stage5AgeGroupRank ]|g' Dependencies.txt
echo 1791 / 1866 --- Rank25 to Stage5AgeGroupRank
perl -i -pe 's|Rank26 \[\.\.\.\]|Rank26 [ Stage6AgeGroupRank ]|g' Dependencies.txt
echo 1792 / 1866 --- Rank26 to Stage6AgeGroupRank
perl -i -pe 's|Rank27 \[\.\.\.\]|Rank27 [ Stage7AgeGroupRank ]|g' Dependencies.txt
echo 1793 / 1866 --- Rank27 to Stage7AgeGroupRank
perl -i -pe 's|Rank28 \[\.\.\.\]|Rank28 [ Stage8AgeGroupRank ]|g' Dependencies.txt
echo 1794 / 1866 --- Rank28 to Stage8AgeGroupRank
perl -i -pe 's|TeamScore51 \[\.\.\.\]|TeamScore51 [ Stage1TeamClassificationTS ]|g' Dependencies.txt
echo 1795 / 1866 --- TeamScore51 to Stage1TeamClassificationTS
perl -i -pe 's|TeamScore52 \[\.\.\.\]|TeamScore52 [ Stage2TeamClassificationTS ]|g' Dependencies.txt
echo 1796 / 1866 --- TeamScore52 to Stage2TeamClassificationTS
perl -i -pe 's|TeamScore53 \[\.\.\.\]|TeamScore53 [ Stage3TeamClassificationTS ]|g' Dependencies.txt
echo 1797 / 1866 --- TeamScore53 to Stage3TeamClassificationTS
perl -i -pe 's|TeamScore54 \[\.\.\.\]|TeamScore54 [ Stage4TeamClassificationTS ]|g' Dependencies.txt
echo 1798 / 1866 --- TeamScore54 to Stage4TeamClassificationTS
perl -i -pe 's|TeamScore55 \[\.\.\.\]|TeamScore55 [ Stage5TeamClassificationTS ]|g' Dependencies.txt
echo 1799 / 1866 --- TeamScore55 to Stage5TeamClassificationTS
perl -i -pe 's|TeamScore56 \[\.\.\.\]|TeamScore56 [ Stage6TeamClassificationTS ]|g' Dependencies.txt
echo 1800 / 1866 --- TeamScore56 to Stage6TeamClassificationTS
perl -i -pe 's|TeamScore57 \[\.\.\.\]|TeamScore57 [ Stage7TeamClassificationTS ]|g' Dependencies.txt
echo 1801 / 1866 --- TeamScore57 to Stage7TeamClassificationTS
perl -i -pe 's|TeamScore58 \[\.\.\.\]|TeamScore58 [ Stage8TeamClassificationTS ]|g' Dependencies.txt
echo 1802 / 1866 --- TeamScore58 to Stage8TeamClassificationTS
perl -i -pe 's|TeamScore61 \[\.\.\.\]|TeamScore61 [ Stage1TeamClassificationAllRidersTS ]|g' Dependencies.txt
echo 1803 / 1866 --- TeamScore61 to Stage1TeamClassificationAllRidersTS
perl -i -pe 's|TeamScore62 \[\.\.\.\]|TeamScore62 [ Stage2TeamClassificationAllRidersTS ]|g' Dependencies.txt
echo 1804 / 1866 --- TeamScore62 to Stage2TeamClassificationAllRidersTS
perl -i -pe 's|TeamScore63 \[\.\.\.\]|TeamScore63 [ Stage3TeamClassificationAllRidersTS ]|g' Dependencies.txt
echo 1805 / 1866 --- TeamScore63 to Stage3TeamClassificationAllRidersTS
perl -i -pe 's|TeamScore64 \[\.\.\.\]|TeamScore64 [ Stage4TeamClassificationAllRidersTS ]|g' Dependencies.txt
echo 1806 / 1866 --- TeamScore64 to Stage4TeamClassificationAllRidersTS
perl -i -pe 's|TeamScore65 \[\.\.\.\]|TeamScore65 [ Stage5TeamClassificationAllRidersTS ]|g' Dependencies.txt
echo 1807 / 1866 --- TeamScore65 to Stage5TeamClassificationAllRidersTS
perl -i -pe 's|TeamScore66 \[\.\.\.\]|TeamScore66 [ Stage6TeamClassificationAllRidersTS ]|g' Dependencies.txt
echo 1808 / 1866 --- TeamScore66 to Stage6TeamClassificationAllRidersTS
perl -i -pe 's|TeamScore67 \[\.\.\.\]|TeamScore67 [ Stage7TeamClassificationAllRidersTS ]|g' Dependencies.txt
echo 1809 / 1866 --- TeamScore67 to Stage7TeamClassificationAllRidersTS
perl -i -pe 's|TeamScore68 \[\.\.\.\]|TeamScore68 [ Stage8TeamClassificationAllRidersTS ]|g' Dependencies.txt
echo 1810 / 1866 --- TeamScore68 to Stage8TeamClassificationAllRidersTS
perl -i -pe 's|TeamScore81 \[\.\.\.\]|TeamScore81 [ Stage1_U23_PointsTS ]|g' Dependencies.txt
echo 1811 / 1866 --- TeamScore81 to Stage1_U23_PointsTS
perl -i -pe 's|TeamScore82 \[\.\.\.\]|TeamScore82 [ Stage2_U23_PointsTS ]|g' Dependencies.txt
echo 1812 / 1866 --- TeamScore82 to Stage2_U23_PointsTS
perl -i -pe 's|TeamScore83 \[\.\.\.\]|TeamScore83 [ Stage3_U23_PointsTS ]|g' Dependencies.txt
echo 1813 / 1866 --- TeamScore83 to Stage3_U23_PointsTS
perl -i -pe 's|TeamScore84 \[\.\.\.\]|TeamScore84 [ Stage4_U23_PointsTS ]|g' Dependencies.txt
echo 1814 / 1866 --- TeamScore84 to Stage4_U23_PointsTS
perl -i -pe 's|TeamScore85 \[\.\.\.\]|TeamScore85 [ Stage5_U23_PointsTS ]|g' Dependencies.txt
echo 1815 / 1866 --- TeamScore85 to Stage5_U23_PointsTS
perl -i -pe 's|TeamScore86 \[\.\.\.\]|TeamScore86 [ Stage6_U23_PointsTS ]|g' Dependencies.txt
echo 1816 / 1866 --- TeamScore86 to Stage6_U23_PointsTS
perl -i -pe 's|TeamScore87 \[\.\.\.\]|TeamScore87 [ Stage7_U23_PointsTS ]|g' Dependencies.txt
echo 1817 / 1866 --- TeamScore87 to Stage7_U23_PointsTS
perl -i -pe 's|TeamScore88 \[\.\.\.\]|TeamScore88 [ Stage8_U23_PointsTS ]|g' Dependencies.txt
echo 1818 / 1866 --- TeamScore88 to Stage8_U23_PointsTS
perl -i -pe 's|TeamScore21 \[\.\.\.\]|TeamScore21 [ Stage1ClubPointsCalculationTS ]|g' Dependencies.txt
echo 1819 / 1866 --- TeamScore21 to Stage1ClubPointsCalculationTS
perl -i -pe 's|TeamScore22 \[\.\.\.\]|TeamScore22 [ Stage2ClubPointsCalculationTS ]|g' Dependencies.txt
echo 1820 / 1866 --- TeamScore22 to Stage2ClubPointsCalculationTS
perl -i -pe 's|TeamScore23 \[\.\.\.\]|TeamScore23 [ Stage3ClubPointsCalculationTS ]|g' Dependencies.txt
echo 1821 / 1866 --- TeamScore23 to Stage3ClubPointsCalculationTS
perl -i -pe 's|TeamScore24 \[\.\.\.\]|TeamScore24 [ Stage4ClubPointsCalculationTS ]|g' Dependencies.txt
echo 1822 / 1866 --- TeamScore24 to Stage4ClubPointsCalculationTS
perl -i -pe 's|TeamScore25 \[\.\.\.\]|TeamScore25 [ Stage5ClubPointsCalculationTS ]|g' Dependencies.txt
echo 1823 / 1866 --- TeamScore25 to Stage5ClubPointsCalculationTS
perl -i -pe 's|TeamScore26 \[\.\.\.\]|TeamScore26 [ Stage6ClubPointsCalculationTS ]|g' Dependencies.txt
echo 1824 / 1866 --- TeamScore26 to Stage6ClubPointsCalculationTS
perl -i -pe 's|TeamScore27 \[\.\.\.\]|TeamScore27 [ Stage7ClubPointsCalculationTS ]|g' Dependencies.txt
echo 1825 / 1866 --- TeamScore27 to Stage7ClubPointsCalculationTS
perl -i -pe 's|TeamScore28 \[\.\.\.\]|TeamScore28 [ Stage8ClubPointsCalculationTS ]|g' Dependencies.txt
echo 1826 / 1866 --- TeamScore28 to Stage8ClubPointsCalculationTS
perl -i -pe 's|TeamScore31 \[\.\.\.\]|TeamScore31 [ Stage1ClubClassificationTS ]|g' Dependencies.txt
echo 1827 / 1866 --- TeamScore31 to Stage1ClubClassificationTS
perl -i -pe 's|TeamScore32 \[\.\.\.\]|TeamScore32 [ Stage2ClubClassificationTS ]|g' Dependencies.txt
echo 1828 / 1866 --- TeamScore32 to Stage2ClubClassificationTS
perl -i -pe 's|TeamScore33 \[\.\.\.\]|TeamScore33 [ Stage3ClubClassificationTS ]|g' Dependencies.txt
echo 1829 / 1866 --- TeamScore33 to Stage3ClubClassificationTS
perl -i -pe 's|TeamScore34 \[\.\.\.\]|TeamScore34 [ Stage4ClubClassificationTS ]|g' Dependencies.txt
echo 1830 / 1866 --- TeamScore34 to Stage4ClubClassificationTS
perl -i -pe 's|TeamScore35 \[\.\.\.\]|TeamScore35 [ Stage5ClubClassificationTS ]|g' Dependencies.txt
echo 1831 / 1866 --- TeamScore35 to Stage5ClubClassificationTS
perl -i -pe 's|TeamScore36 \[\.\.\.\]|TeamScore36 [ Stage6ClubClassificationTS ]|g' Dependencies.txt
echo 1832 / 1866 --- TeamScore36 to Stage6ClubClassificationTS
perl -i -pe 's|TeamScore37 \[\.\.\.\]|TeamScore37 [ Stage7ClubClassificationTS ]|g' Dependencies.txt
echo 1833 / 1866 --- TeamScore37 to Stage7ClubClassificationTS
perl -i -pe 's|TeamScore38 \[\.\.\.\]|TeamScore38 [ Stage8ClubClassificationTS ]|g' Dependencies.txt
echo 1834 / 1866 --- TeamScore38 to Stage8ClubClassificationTS
perl -i -pe 's|Rank161 \[\.\.\.\]|Rank161 [ Stage1ClubClassificationTieBreakerRank ]|g' Dependencies.txt
echo 1835 / 1866 --- Rank161 to Stage1ClubClassificationTieBreakerRank
perl -i -pe 's|Rank162 \[\.\.\.\]|Rank162 [ Stage2ClubClassificationTieBreakerRank ]|g' Dependencies.txt
echo 1836 / 1866 --- Rank162 to Stage2ClubClassificationTieBreakerRank
perl -i -pe 's|Rank163 \[\.\.\.\]|Rank163 [ Stage3ClubClassificationTieBreakerRank ]|g' Dependencies.txt
echo 1837 / 1866 --- Rank163 to Stage3ClubClassificationTieBreakerRank
perl -i -pe 's|Rank164 \[\.\.\.\]|Rank164 [ Stage4ClubClassificationTieBreakerRank ]|g' Dependencies.txt
echo 1838 / 1866 --- Rank164 to Stage4ClubClassificationTieBreakerRank
perl -i -pe 's|Rank165 \[\.\.\.\]|Rank165 [ Stage5ClubClassificationTieBreakerRank ]|g' Dependencies.txt
echo 1839 / 1866 --- Rank165 to Stage5ClubClassificationTieBreakerRank
perl -i -pe 's|Rank166 \[\.\.\.\]|Rank166 [ Stage6ClubClassificationTieBreakerRank ]|g' Dependencies.txt
echo 1840 / 1866 --- Rank166 to Stage6ClubClassificationTieBreakerRank
perl -i -pe 's|Rank167 \[\.\.\.\]|Rank167 [ Stage7ClubClassificationTieBreakerRank ]|g' Dependencies.txt
echo 1841 / 1866 --- Rank167 to Stage7ClubClassificationTieBreakerRank
perl -i -pe 's|Rank168 \[\.\.\.\]|Rank168 [ Stage8ClubClassificationTieBreakerRank ]|g' Dependencies.txt
echo 1842 / 1866 --- Rank168 to Stage8ClubClassificationTieBreakerRank
perl -i -pe 's|Rank31 \[\.\.\.\]|Rank31 [ Stage1LiveRank ]|g' Dependencies.txt
echo 1843 / 1866 --- Rank31 to Stage1LiveRank
perl -i -pe 's|Rank41 \[\.\.\.\]|Rank41 [ Stage1ParcoursRank ]|g' Dependencies.txt
echo 1844 / 1866 --- Rank41 to Stage1ParcoursRank
perl -i -pe 's|Rank32 \[\.\.\.\]|Rank32 [ Stage2LiveRank ]|g' Dependencies.txt
echo 1845 / 1866 --- Rank32 to Stage2LiveRank
perl -i -pe 's|Rank42 \[\.\.\.\]|Rank42 [ Stage2ParcoursRank ]|g' Dependencies.txt
echo 1846 / 1866 --- Rank42 to Stage2ParcoursRank
perl -i -pe 's|Rank33 \[\.\.\.\]|Rank33 [ Stage3LiveRank ]|g' Dependencies.txt
echo 1847 / 1866 --- Rank33 to Stage3LiveRank
perl -i -pe 's|Rank43 \[\.\.\.\]|Rank43 [ Stage3ParcoursRank ]|g' Dependencies.txt
echo 1848 / 1866 --- Rank43 to Stage3ParcoursRank
perl -i -pe 's|Rank34 \[\.\.\.\]|Rank34 [ Stage4LiveRank ]|g' Dependencies.txt
echo 1849 / 1866 --- Rank34 to Stage4LiveRank
perl -i -pe 's|Rank44 \[\.\.\.\]|Rank44 [ Stage4ParcoursRank ]|g' Dependencies.txt
echo 1850 / 1866 --- Rank44 to Stage4ParcoursRank
perl -i -pe 's|Rank35 \[\.\.\.\]|Rank35 [ Stage5LiveRank ]|g' Dependencies.txt
echo 1851 / 1866 --- Rank35 to Stage5LiveRank
perl -i -pe 's|Rank45 \[\.\.\.\]|Rank45 [ Stage5ParcoursRank ]|g' Dependencies.txt
echo 1852 / 1866 --- Rank45 to Stage5ParcoursRank
perl -i -pe 's|Rank36 \[\.\.\.\]|Rank36 [ Stage6LiveRank ]|g' Dependencies.txt
echo 1853 / 1866 --- Rank36 to Stage6LiveRank
perl -i -pe 's|Rank46 \[\.\.\.\]|Rank46 [ Stage6ParcoursRank ]|g' Dependencies.txt
echo 1854 / 1866 --- Rank46 to Stage6ParcoursRank
perl -i -pe 's|Rank37 \[\.\.\.\]|Rank37 [ Stage7LiveRank ]|g' Dependencies.txt
echo 1855 / 1866 --- Rank37 to Stage7LiveRank
perl -i -pe 's|Rank47 \[\.\.\.\]|Rank47 [ Stage7ParcoursRank ]|g' Dependencies.txt
echo 1856 / 1866 --- Rank47 to Stage7ParcoursRank
perl -i -pe 's|Rank38 \[\.\.\.\]|Rank38 [ Stage8LiveRank ]|g' Dependencies.txt
echo 1857 / 1866 --- Rank38 to Stage8LiveRank
perl -i -pe 's|Rank48 \[\.\.\.\]|Rank48 [ Stage8ParcoursRank ]|g' Dependencies.txt
echo 1858 / 1866 --- Rank48 to Stage8ParcoursRank
perl -i -pe 's|Rank151 \[\.\.\.\]|Rank151 [ Stage1ClubClassificationSortingRank ]|g' Dependencies.txt
echo 1859 / 1866 --- Rank151 to Stage1ClubClassificationSortingRank
perl -i -pe 's|Rank152 \[\.\.\.\]|Rank152 [ Stage2ClubClassificationSortingRank ]|g' Dependencies.txt
echo 1860 / 1866 --- Rank152 to Stage2ClubClassificationSortingRank
perl -i -pe 's|Rank153 \[\.\.\.\]|Rank153 [ Stage3ClubClassificationSortingRank ]|g' Dependencies.txt
echo 1861 / 1866 --- Rank153 to Stage3ClubClassificationSortingRank
perl -i -pe 's|Rank154 \[\.\.\.\]|Rank154 [ Stage4ClubClassificationSortingRank ]|g' Dependencies.txt
echo 1862 / 1866 --- Rank154 to Stage4ClubClassificationSortingRank
perl -i -pe 's|Rank155 \[\.\.\.\]|Rank155 [ Stage5ClubClassificationSortingRank ]|g' Dependencies.txt
echo 1863 / 1866 --- Rank155 to Stage5ClubClassificationSortingRank
perl -i -pe 's|Rank156 \[\.\.\.\]|Rank156 [ Stage6ClubClassificationSortingRank ]|g' Dependencies.txt
echo 1864 / 1866 --- Rank156 to Stage6ClubClassificationSortingRank
perl -i -pe 's|Rank157 \[\.\.\.\]|Rank157 [ Stage7ClubClassificationSortingRank ]|g' Dependencies.txt
echo 1865 / 1866 --- Rank157 to Stage7ClubClassificationSortingRank
perl -i -pe 's|Rank158 \[\.\.\.\]|Rank158 [ Stage8ClubClassificationSortingRank ]|g' Dependencies.txt
echo 1866 / 1866 --- Rank158 to Stage8ClubClassificationSortingRank
