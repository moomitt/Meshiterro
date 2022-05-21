class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  has_one_attached :profile_images
  
  def get_profile_image(width,height)
    unless profile_images.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image_jpeg')
    end
    profile_images.variant(resize_to_limit: [width, height]).processed
  end
  
end
