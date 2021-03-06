class Picture < ActiveRecord::Base

  validates :content_type,  presence: true,
                              format: {
                                with: /\Aimage\z/,
                                message: "должно быть изображение"
                              }

  def uploaded_picture=(picture_field)
    self.name = base_part_of(picture_field.original_filename)
    self.content_type = picture_field.content_type.chomp
    self.data = picture_field.read
  end

  def base_part_of(file_name)
    File.basename(file_name).gsub(/[^\w._-]/, '')
  end
end
