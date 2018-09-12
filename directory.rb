@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def add_students(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def input_students
  puts "Please enter the name of a student"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp

  puts "And what was their cohort?"
  puts "To finish, just hit return twice"
  cohort = STDIN.gets.chomp.to_sym

  while !name.empty? do
    add_students(name, cohort)
    puts "Now we have #{@students.count} students."
    puts "Please enter the name of a student"
    name = STDIN.gets.chomp
    puts "And what was their cohort?"
    cohort = STDIN.gets.chomp
  end
end

def save_students(filename)
  file = File.open(filename, "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    add_students(name, cohort)
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def print_header
  puts "The students of Villains Academy".center(80)
  puts "-------------".center(80)
end

def print_students_list
  @students.each_with_index do |student, index|
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)".center(80)
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(80)
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    puts "please enter the filename"
    save_students(gets.chomp)
  when "4"
    puts "please enter the filename"
    load_students(gets.chomp)
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
    puts "\n\nThere you go! Is there anything else I can do?\n\n"
  end
end


try_load_students
interactive_menu
