class User <ActiveRecord::Base
    has_many :poems
    has_many :places, through: :poems
end