class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :projectName
      t.string :projectPet
      t.integer :petHealth
      t.integer :petLevel
      t.string :projectGitHub
      t.string :petImage
      t.hstore :stats, default: {totalWorkTime: 0,
                                 totalWorkSessions: 0,
                                 totalShortPomTime: 0,
                                 totalShortSessions: 0,
                                 totalLongPomTime: 0,
                                 totalLongSessions: 0}, null: false

      t.timestamps
    end
  end
end
