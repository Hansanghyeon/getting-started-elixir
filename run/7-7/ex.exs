# 리스트 연결
IO.inspect [1,2,3] ++ [4,5,6]
# [1,2,3,4,5,6]

# 평탄화
IO.inspect List.flatten([[[1], 2], [[[3]]]])
# [1,2,3]

# 폴딩 (reduce와 비슷하지만 방향을 정할 수 있다)
IO.inspect List.foldl([1,2,3], "", fn value, acc -> "#{value}(#{acc})" end)
# "3(2(1()))"
IO.inspect List.foldr([1,2,3], "", fn value, acc -> "#{value}(#{acc}))" end)
# "1(2(3()))"

# 리스트 중간을 수정(가벼운 연산은 아니다)
IO.inspect List.replace_at([1,2,3], 2, "buckle my shoe")
# [1,2, "buckle my shoe"]

# 리스트 안의 튜플에 접근하기
kw = [{:name, "Dave"}, {:likes, "Programing"}, {:where, "Dallas", "TX"}]
IO.inspect List.keyfind(kw, "Dallas", 1)
IO.inspect List.keyfind(kw, "TX", 2)
IO.inspect List.keyfind(kw, "TX", 1)
IO.inspect List.keyfind(kw, "TW", 1, "No city called TX")
IO.inspect List.keydelete(kw, "TX", 2)
IO.inspect List.keyreplace(kw, :name, 0, {:first_name, "Dave"})
