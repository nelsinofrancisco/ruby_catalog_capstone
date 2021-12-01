require_relative 'book'
require_relative './../items/label'

module BookCollection
  def list_all_books
    puts "Your library don't have books yet. Add one first!" if @books.empty?

    @books.each do |book|
      str1 = "Id: #{book.id} Published at: #{book.published_date}, Publisher: #{book.publisher} "
      str2 = "Cover State: #{book.cover_state}"
      result = str1 + str2
      puts result
    end
    puts
  end

  def list_all_labels
    puts "Your library don't have labels yet. Add one first!" if @books.empty?

    @labels.each do |label|
      puts "Id: #{label.id}, Title: #{label.title}, Author: #{label.color}"
    end
    puts
  end

  def add_a_book
    print 'Insert Published Date: '
    date = gets.chomp.to_i
    print 'Insert Publisher Name: '
    name = gets.chomp.capitalize
    print 'Insert Book cover_state: '
    cover_state = gets.chomp

    new_book = Book.new(date, name, cover_state)
    @books << new_book
    puts 'Book created successfully!'
  end

  def add_a_label
    item = select_item_for('Label')
    return unless item

    puts 'Item Selected.'
    previous_label = nil

    unless @labels.empty?
      print 'Do you want to add this Item to a existing Label? [Y/N]: '
      previous_label = true if gets.chomp.capitalize == 'Y'
    end

    if previous_label
      option_id = select_label_from_list

      if option_id
        item.add_label(@labels[option_id])
        puts "Item added to Label with Id: #{@labels[option_id].id}\n\n"
      end
    else
      create_new_label(item)
    end
  end

  private

  def select_label_from_list
    puts 'Select a Label from this option List: '
    @labels.each_with_index do |label, idx|
      puts "[#{idx}] - Title: #{label.title}, Author: #{label.color}"
    end
    print 'Select your option: '
    option_id = gets.chomp.to_i
    if option_id.abs >= @labels.length
      puts "Item could not be added to Label with Id: #{@labels[option_id].id}\n\n"
      return false
    end
    option_id
  end

  def create_new_label(item)
    print 'Insert Label Title: '
    title = gets.chomp
    print 'Insert Label Color: '
    color = gets.chomp

    new_label = Label.new(title, color)
    @labels << new_label
    item.add_label(new_label)
    puts "Label created successfully\n\n"
  end
end
