class StoreProfile < ApplicationRecord
  # association
  belongs_to :user
  has_many :orders
  has_many :products

  # upload
  mount_uploader :store_certificate, RegistrationUploader
  mount_uploader :store_photo, RegistrationUploader

  # validations
  validates :store_certificate, presence: true
  validates :store_photo, presence: true
  validates :store_name, presence: true
  validates :store_type, presence: true
  validates :store_address, presence: true
  validates :store_phone, presence: true
  validates :account, presence: true
  
  def self.calc_distance(user_lat, user_lng)
    store_latlng = StoreProfile.pluck(:latitude, :longitude)
    result = store_latlng.map{|store_lat, store_lng| 
    Math.sqrt((store_lat - user_lat.to_f)**2 + (store_lng - user_lng.to_f)**2) }
    result.map.with_index{|x, i| i if x < 0.03 }.compact

    # arrLat = []
    # stores = StoreProfile.all
    # stores.each do |store|
    #   lat = store.latitude * store.latitude
    #   arrLat << lat
    # end

    # arrLng = []
    # stores = StoreProfile.all
    # stores.each do |store|
    #   arrLng << store .latitude
    # end
  end
end
