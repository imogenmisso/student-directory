require 'csv'

@students = []
def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load the list"
  puts "9. Exit"
end

def show_students
  print_header
  print_by_cohort
  print_footer
end

def process(selection)
  case selection
    when "1"
      puts "You chose 1"
      input_students
    when "2"
      puts "You chose 2"
      show_students
    when "9"
      puts "You chose 9"
      exit
    when "3"
      puts "You chose 3"
      save_students
    when "4"
      puts "You chose 4"
      load_students
    else
      puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students, followed by some personal information"
  puts "To finish, just hit return twice"
  students = []
  name = STDIN.gets.strip
  while !name.empty? do
    puts "Which cohort do they belong to?"
      cohort = STDIN.gets.strip
      if cohort.empty?
          cohort = :november
      end
      cohort = cohort.to_sym
    puts "Country of birth"
      country = STDIN.gets.strip
    add_student_to_array(name, cohort, country)
    puts "Now we have #{@students.count} students"
    puts "Please enter another name"
    name = STDIN.gets.strip
  end
end

def add_student_to_array(name, cohort, country)
  @students << {name: name, cohort: cohort, country: country}
end


def print_header
  puts "The students of Villains Academy".center(80)
  puts "_____________".center(80)
end

def print_student_list
  count = 0
  until count == @students.count
    @students.each_with_index do |student, index|
      if student[:name].length < 12
        puts ("#{index + 1}. #{student[:name]}, #{student[:cohort]} cohort, born in #{student[:country]}").center(80)
        count += 1
      end
    end
  end
end

def print_by_cohort
  sorted_by_cohort = {}
  @students.each do |students_under_consideration|
    cohort = students_under_consideration[:cohort]
    name = students_under_consideration[:name]
    if sorted_by_cohort[cohort] == nil
      sorted_by_cohort[cohort] = [name]
    else
      sorted_by_cohort[cohort].push(name)
    end
  end
  sorted_by_cohort.each do |cohort, students|
    puts "#{cohort} cohort:".center(80)
      students.each_with_index do |name, index|
        puts "#{index + 1}. #{name}".center(80)
      end
    end
end

def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student".center(80)
  else
    puts "Overall, we have #{@students.count} great students".center(80)
  end
end

def save_students
  puts "What would you like to call the file?"
  filename = STDIN.gets.chomp
  CSV.open(filename, "w") do |file|
    @students.each do |student|
      file << [student[:name], student[:cohort], student[:country]]
    end
  end
end

def load_students(filename = "students.csv")
  CSV.foreach(filename) do |row|
      add_student_to_array(row[0], row[1], row[3])
    end
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    puts 'Loading students.csv by default'
    load_students
  elsif File.exists?(filename)
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist. Loading students.csv by default"
    load_students 
  end
end

try_load_students
interactive_menu
