class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :released, inclusion: {in: [true, false]}
  validates :artist_name, presence: true
  validates :title, uniqueness: {
                      scope: %i[release_year artist_name],
                      message: 'cannot be repeated by the same artist in the same year'
                    }
  with_options if: :released? do |x|
    x.validates :release_year, presence: true
    x.validates :release_year, numericality: {
                                less_than_or_equal_to: Date.today.year
                              }
  end

  def released?
    released
  end
end