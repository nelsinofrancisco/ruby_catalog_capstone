class Item
  attr_reader :id, :archived, :author, :genre, :label, :published_date

  def initialize(published_date, archived: false)
    @id = Random.rand(1..1000)
    @archived = archived
    @author = nil
    @genre = nil
    @label = nil
    @published_date = published_date
  end

  def add_author(author)
    @author = author
    author.add_item(self) unless author.items.include?(self)
  end

  def add_genre(genre)
    @genre = genre
    genre.items.push(self) unless genre.items.include?(self)
  end

  def add_label(label, validation: true)
    @label = label
    label.add_item(self) if validation
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  def to_json(*_args)
    JSON.dump({
                id: @id,
                archived: @archived,
                published_date: @published_date
              })
  end

  def self.from_json(data)
    new(data['published_date'], data['archived'])
  end

  private

  def can_be_archived?
    @published_date >= 10
  end
end
