f = File.open("sowpods.txt")

words = f.read.split("\r\n")

$scores = {"A"=> 1, "C"=>  3, "B"=>  3, "E"=>  1, "D"=>  2, "G"=>  2,
         "F"=>  4, "I"=>  1, "H"=>  4, "K"=>  5, "J"=>  8, "M"=>  3,
         "L"=> 1, "O"=>  1, "N"=>  1, "Q"=>  10, "P"=>  3, "S"=>  1,
         "R"=>  1, "U"=>  1, "T"=>  1, "W"=>  4, "V"=>  4, "Y"=>  4,
         "X"=>  8, "Z"=>  10}

#scores a given word

def points(str)
  i=0
  score = Array.new
  str.each_char {|x|
    score[i] = $scores[x]
    i += 1}
  total = score.inject{|sum,x| sum + x }
  return total
end




# function that cycles through letters of tiles
def cycle(tiles, curr)
  i=0
  comb = Array.new      #creates new array
  tiles2 = tiles
  curr.each_char {|y|       #cycles throught each character in current word
    tiles2 = tiles2.split(y).join("") }       #creates a string with removed letters from curr
    tiles2.each_char {|x|         #cycles throught remaining letters
      word = curr + x
      comb[i]= word           #stores remaining letters.

      i +=1
  }
  return comb
end

#function to iterate through all possible combinations of tiles
def combination(tiles)
  len = 0
  store = Array.new
  store[0] = Array.new
  pos=1
  j = 0
  store[0][0] = ""
  while len < 7
    loc = 0
    current = store[len][loc]
    store[len].each{|x|
      current = store[len][loc]
      comb = cycle(tiles,current)
      if store[pos] == nil
        store[pos] = comb
      else
        store[pos] = store[pos].push(*comb)
      end
      j += comb.length
      loc += 1
    }
    len +=1
    pos +=1
  end
  combi = store.flatten         #flattens multi-D array
  return combi
end


#creates list of best words
def list(combi,words)
  gw = combi & words
  gw_score = Hash.new

  gw.each {|x|
    scr = points(x)
    gw_score[x] = scr}
  gw_score = gw_score.sort_by{|_key, value| value}.reverse


  gw_score.each do |key, value|
      puts "#{key}  :  #{value}"
  end
end

puts "Welcome to the scrabble aid 3000"
puts "Insert your 7 scrabble tiles:"
tiles = gets.chomp.upcase

combi = combination(tiles)
list(combi,words)
