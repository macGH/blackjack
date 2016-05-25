def convert_card_value (input)
  if input.upcase == "A"
    return 11
  elsif input.upcase == "J" || input.upcase =="Q" || input.upcase == "K"
    return 10
  elsif input.to_i.to_s == input
    num = input.to_i
    if (2..10).to_a.include?(num)
      return num
    end
  end

  return 0  #invalid input
end

def build_hard_options
  hit_opt = "Hit"
  dh_opt = "Double Hit, if possible; otherwise Hit"
  std_opt = "Stand"

  hard_hash = {}

  (5..16).each do |hand_tot|
    hard_hash[hand_tot] = Hash.new(hit_opt)
  end

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

  return hard_hash
end

def build_soft_options
  hit_opt = "Hit"
  dh_opt = "Double Hit, if possible; otherwise Hit"
  ds_opt = "Double Hit, if possible; otherwise Stand"
  std_opt = "Stand"

  soft_hash = {}

  (13..17).each do |x|
    soft_hash[x] = Hash.new(hit_opt)
  end

  (18..21).each do |x|
    soft_hash[x] = Hash.new(std_opt)
  end

  #now set exceptions
  (13..17).each do |x|
    (4..6).each do |y|
      soft_hash[x][y] = dh_opt
    end
  end

  soft_hash[17][2] = soft_hash[17][3] = dh_opt
  soft_hash[18][3] = ds_opt
  soft_hash[18][3] = soft_hash[18][4] = soft_hash[18][5] = soft_hash[18][6] = ds_opt
  soft_hash[18][9] = soft_hash[18][10] = hit_opt
  soft_hash[19][6] = ds_opt

  return soft_hash
end

def build_pair_options
  hit_opt = "Hit"
  dh_opt = "Double Hit, if possible; otherwise Hit"
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

  (8..11).each do |x|
    pairs_hash[6][x] = hit_opt
  end

  pairs_hash[7][9] = pairs_hash[7][11] = hit_opt
  pairs_hash[7][10] = std_opt

  pairs_hash[9][7] = pairs_hash[9][10] = pairs_hash[9][11] = std_opt

  pairs_hash[10] = Hash.new(std_opt)

  return pairs_hash
end

# Gather user input
puts "Enter your first card: "
first_card = gets.chomp
puts "Enter your second card: "
second_card = gets.chomp
puts "Enter the dealer top hand: "
dealer_top = gets.chomp

if first_card == "" || second_card == ""|| dealer_top == ""
  puts "Oops! You skipped some cards. Bye."
elsif convert_card_value(first_card) == 0 || convert_card_value(second_card) == 0|| convert_card_value(dealer_top) == 0
  puts "Not sure what kind of deck you have, but we don't have it"
else
  correct_options = {}
  choices_for_total = {}
  running_total = convert_card_value(first_card) + convert_card_value(second_card)

  if first_card == second_card
    correct_options = build_pair_options
    choices_for_total = correct_options[convert_card_value(second_card)]
  elsif first_card == "A" || second_card == "A"
    correct_options = build_soft_options
    choices_for_total = correct_options[running_total]
  else
    correct_options = build_hard_options
    choices_for_total = correct_options[running_total]
  end

  your_ideal_option = choices_for_total[convert_card_value(dealer_top)]

  puts "You should #{your_ideal_option}."
  puts "In fact... Blackjack! You win!!" if running_total == 21
end
