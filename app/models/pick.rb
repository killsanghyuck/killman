class Pick < ApplicationRecord

  enum pick_state: {
      picked: 0,
      entered: 1,
      exited: 2,
      service_in_use: 3,
      completed: 4,
      cancelled: 5
  }

  def self.import(file)
    CSV.foreach(file.path, headers: true, :header_converters => :symbol) do |row|
      pick_hash = row.to_hash # exclude the price field
      pick = Pick.where(id: pick_hash[:id])

      if pick.count == 1
        pick.first.update_attributes(pick_hash)
      else
        Pick.create!(pick_hash)
      end
    end
  end
end
