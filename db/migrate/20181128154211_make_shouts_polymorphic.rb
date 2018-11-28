class MakeShoutsPolymorphic < ActiveRecord::Migration[5.2]
  class Shout < ApplicationRecord
    belongs_to :content, polymorphic: true
  end

  class TextShout < ApplicationRecord; end

  def change
    change_table(:shouts) do |t|
      t.string :content_type
      t.integer :content_id
      t.index [:content_id, :content_type]
    end

    reversible do |direction|
      Shout.reset_column_information
      Shout.find_each do |shout|
        direction.up do
          text_shout = TextShout.create(body: shout.body)
          shout.update(content_id: text_shout.id, content_type: "TextShout")
        end

        direction.down do
          shout.update(body: shout.content.body)
          shout.content.destroy
        end
      end
    end

    # By specifying :string, this makes the removal reversible
    remove_column :shouts, :body, :string
  end
end
