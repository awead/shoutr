class Shout < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true

  validates :user, presence: true

  delegate :username, to: :user

  # Models know a lot about SQL... or use query object
  # scope :search ->(term) { joins("LEFT JOIN text_shouts ON content_type = 'TextShout' AND content_id = text_shouts.id").where("text_shouts.body LIKE ?", term) }

  # Don't put SQL here
  # def self.search(term)
  #   joins("LEFT JOIN text_shouts ON content_type = 'TextShout' AND content_id = text_shouts.id")
  #     .where("text_shouts.body LIKE ?", term)
  # end

  searchable do
    text :content do
      case content
      when TextShout then content.body
      when PhotoShout then content.image_file_name
      end
    end
  end
end
