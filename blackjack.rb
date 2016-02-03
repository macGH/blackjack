def convert_card_value (input)
  if input == "A"
    return 11
  elsif input == "J" || input =="Q" || input == "K"
    return 10
  else
    return input.to_i
  end
  puts "leaving convert_card_value"
end

def build_hard_options_hash
  hit_opt = "Hit"
  dh_opt = "Double Hit, if possible"
  std_opt = "Stand"

  hard_hash = {}

  (5..16).each do |hand_tot|
    puts hand_tot
    hard_hash[hand_tot] = Hash.new(hit_opt)
  end
  puts hard_hash
  puts
  puts

  (17..21).each do |hand_tot|
    hard_hash[hand_tot] = Hash.new(std_opt)
  end

  #now update exceptions
  hard_hash[8][5] = dh_opt
  hard_hash[8][6] = dh_opt
  (2..6).each do |x|
    hard_hash[9][x] = dh_opt
  end
  hard_hash[10] = Hash.new (dh_opt)
  hard_hash[10][10] = hit_opt
  hard_hash[10][11] = hit_opt
  hard_hash[11] = Hash.new (dh_opt)
  (4..6).each do |x|
    hard_hash[12][x] = std_opt
  end
  (13..16).each do |x|
    (2..6).each do |y|
      hard_hash[x][y] = std_opt
    end
  end

  puts "hard: \n#{hard_hash}"
  return hard_hash

end

def build_soft_options_hash
  hit_opt = "Hit"
  dh_opt = "Double Hit, if possible"
  std_opt = "Stand"

  soft_hash = {}

  (13..17).each do |x|
    soft_hash[x] = Hash.new(hit_opt)
  end

  (18..21).each do |x|
    soft_hash[x] = Hash.new(std_opt)
  end

  #now set exceptions
  (13..18).each do |x|
    (4..6).each do |y|
      soft_hash[x][y] = dh_opt
    end
  end

  soft_hash[17][2] = dh_opt
  soft_hash[17][2] = dh_opt
  soft_hash[18][3] = dh_opt
  soft_hash[18][9] = soft_hash[18][10] = hit_opt

  # puts
  # puts
  puts "soft: \n#{soft_hash}"

  return soft_hash

end

def build_pair_options
  hit_opt = "Hit"
  dh_opt = "Double Hit, if possible"
  std_opt = "Stand"
  spl_opt = "Split"

  pairs_hash = {}

  (2..13).each do |card|
    pairs_hash[card] = Hash.new(spl_opt)
  end

  #now set exceptions
  (2..4).each do |x|
    (9..11).each do |y|
      pairs_hash[x][y] = hit_opt
    end
  end

  pairs_hash[2][8] = hit_opt
  pairs_hash[4][2] = pairs_hash[4][3] = pairs_hash[4][7] = pairs_hash[4][8] = hit_opt

  (2..9).each do |x|
    pairs_hash[5][x] = dh_opt
  end

  pairs_hash[5][10] = pairs_hash[5][11] = hit_opt


  return pairs_hash
end

hard_options = build_hard_options_hash
soft_optionsj = build_soft_options_hash

puts "Enter your first card: "
first_card = gets.chomp
puts "Enter your second card: "
second_card = gets.chomp
puts "Enter the dealer top hand: "
dealer_top = gets.chomp

if first_card == "" || second_card == ""|| dealer_top == ""
  puts "You didn't follow instructions. Bye."
else
  correct_options = {}

puts

  if first_card == second_card
    correct_options = build_pair_options
  elsif first_card == "A" || second_card == "A"
    correct_options = build_soft_options_hash
  else
    correct_options = build_hard_options_hash
  end

  puts "tot_val = #{convert_card_value(first_card)+convert_card_value(second_card)}"
  choices_for_total = correct_options[convert_card_value(first_card) + convert_card_value(second_card)]
  puts choices_for_total

  your_ideal_option = choices_for_total[convert_card_value(dealer_top)]
  puts your_ideal_option
end
