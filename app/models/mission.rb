class Mission < ApplicationRecord
    belongs_to :scientist 
    belongs_to :planet 

    validates :name, :scientist, :planet, presence: true
    validates :scientist, uniqueness: { scope: :mission,
    message: "Cannot join mission twice." }
end
