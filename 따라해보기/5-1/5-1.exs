# 다음과 같이 동작하는 함수 IEx에서 만들어 실행해보자.
# 1. list_concat.([:a, :b], [:c, :d]) 
# => [:a, :b, :c, :d]

list_concat = fn (list1, list2) -> list1 ++ list2 end
result = list_concat.([:a, :b], [:c, :d])
IO.inspect(result)

# 2. sum.(1, 2, 3)
# => 6
sum = fn (a, b, c) -> a + b + c end
result = sum.(1, 2, 3)
IO.inspect(result)

# 3. pair_tuple_to_list.( { 1234, 5678 })
# => [1234, 5678]
pair_tuple_to_list = fn (tuple) -> Tuple.to_list(tuple) end # 아직 배우지 않은 방법
                                                            # Tuple.to_list는 튜플을 리스트로 변환하는 함수이다.
result = pair_tuple_to_list.({1234, 5678})
IO.inspect(result)
pair_tuple_to_list = fn ( { a, b }) -> [a, b] end
result = pair_tuple_to_list.({1234, 5678})
IO.inspect(result)