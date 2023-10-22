map = %{ name: "Dave", likes: "Programming", where: "Dallas" }

IO.inspect Map.keys map
IO.inspect Map.values map
IO.inspect map[:name]
IO.inspect(map.name)

map1 = Map.drop map, [:where, :likes]
IO.inspect map1

map2 = Map.put map, :also_likes, "Ruby"
IO.inspect(map2)
IO.inspect(Map.keys map2)

IO.inspect Map.has_key? map1, :where

# { value, updated_map } = Map.pop map2, :also_likes
# 패턴매칭하고 바로 IO.inspect 하는방법이있을까?
{value, updated_map} = Map.pop map2, :also_likes
IO.inspect {value, updated_map}

IO.inspect Map.equal? map, updated_map


# ==================== 패턴매칭, 맵수정 ====================
IO.puts("==================== 패턴매칭, 맵수정 ====================")
person = %{ name: "Dave", height: 1.88 }

# 맵에: name이라는 키가 있는가?
case Map.has_key? person, :name do
  true -> IO.puts "Name is #{person.name}"
  false -> IO.puts "No name found"
end

## 패턴매칭으로 해결하기
%{ name: a_name } = person
IO.inspect a_name

# 맵에 `:name`과 `:height`키가 모두 있는가?
IO.inspect %{ name: _, height: _ } = person

# `:name`키의 값이 "Dave"인가?
IO.inspect %{ name: "Dave" } = person
## 실패유도
IO.inspect %{ name: _, weight: _ } = person
