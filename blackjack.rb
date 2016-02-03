def convert_card_value (input)
  if input == "A"
    return 11
  elsif input == "J" || input =="Q" || input == "K"
    return 10
  else
    return input.to_i
  end
end

def build_hard_options_hash 
  hit_opt = "Hit"
  dh_opt = "Double Hit, if possible"
  std_opt = "Stand"

  hard_hash = Hash.new(hit_opt)

  5..21.times do |hand_tot|
    hard_hash[hand_tot+5] = Hash.new(hit_opt)
  end
  hard_hash[8][5] = dh_opt
  hard_hash[8][6] = dh_opt
  hard_hash[9][2] = dh_opt
  hard_hash[9][3] = dh_opt
  hard_hash[9][4] = dh_opt
  hard_hash[9][5] = dh_opt
  hard_hash[9][6] = dh_opt
  hard_hash[10] = Hash.new (dh_opt)
  hard_hash[10][10] = hit_opt
  hard_hash[10][11] = hit_opt
  hard_hash[11] = Hash.new (dh_opt)

  return hard_hash

  # p hard_options
  # p hard_options[5][2]
  # 11=> {2=>dh_opt,  3=>dh_opt,  4=>dh_opt,  5=>dh_opt,  6=>dh_opt, 7=>dh_opt, 8=>dh_opt},
  # 12=> {2=>hit_opt,  3=>hit_opt,  4=>std_opt,  5=>std_opt,  6=>std_opt, 7=>hit_opt, 8=>hit_opt},
  # 13=> {2=>std_opt,  3=>std_opt,  4=>std_opt,  5=>std_opt,  6=>std_opt, 7=>hit_opt, 8=>hit_opt},
  # 14=> {2=>std_opt,  3=>std_opt,  4=>std_opt,  5=>std_opt,  6=>std_opt, 7=>hit_opt, 8=>hit_opt},
  # 15=> {2=>std_opt,  3=>std_opt,  4=>std_opt,  5=>std_opt,  6=>std_opt, 7=>hit_opt, 8=>hit_opt},
  # 16=> {2=>std_opt,  3=>std_opt,  4=>std_opt,  5=>std_opt,  6=>std_opt, 7=>hit_opt, 8=>hit_opt}
  #  }
end


hard_options = build_hard_options_hash

# p hard_options
# p hard_options[5][2]
# 11=> {2=>dh_opt,  3=>dh_opt,  4=>dh_opt,  5=>dh_opt,  6=>dh_opt, 7=>dh_opt, 8=>dh_opt},
# 12=> {2=>hit_opt,  3=>hit_opt,  4=>std_opt,  5=>std_opt,  6=>std_opt, 7=>hit_opt, 8=>hit_opt},
# 13=> {2=>std_opt,  3=>std_opt,  4=>std_opt,  5=>std_opt,  6=>std_opt, 7=>hit_opt, 8=>hit_opt},
# 14=> {2=>std_opt,  3=>std_opt,  4=>std_opt,  5=>std_opt,  6=>std_opt, 7=>hit_opt, 8=>hit_opt},
# 15=> {2=>std_opt,  3=>std_opt,  4=>std_opt,  5=>std_opt,  6=>std_opt, 7=>hit_opt, 8=>hit_opt},
# 16=> {2=>std_opt,  3=>std_opt,  4=>std_opt,  5=>std_opt,  6=>std_opt, 7=>hit_opt, 8=>hit_opt}
#  }

puts "hard options hash: "
puts hard_options
puts

puts "Enter your first card: "
first_card = gets.chomp
puts "Enter your second card: "
second_card = gets.chomp
puts "Enter the dealer top hand: "
dealer_top = gets.chomp

if first_card == "" || second_card == ""|| dealer_top == ""
  puts "You didn't follow instructions. Bye."
else
  choices_for_total = hard_options[convert_card_value(first_card) + convert_card_value(second_card)]
  puts choices_for_total

  your_ideal_option = choices_for_total[convert_card_value(dealer_top)]
  puts your_ideal_option
end
