class Product < ActiveRecord::Base
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true, length: { minimum: 5, too_short:
                                               "5 character minimum" }
  validates :image_url, allow_blank: true, format: {
      with: %r{\.(gif|jpg|png)\Z}i,
      message: 'URL должен указывать на изображение формата
                GIF, JPG или PNG.'
  }

  def self.latest
    Product.order(:updated_at).last
  end
end
