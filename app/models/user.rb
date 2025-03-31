class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :beverage_entries, dependent: :destroy
  has_many :beverage_entry_additions, through: :beverage_entries
  has_many :beverage_entry_symptoms, through: :beverage_entries
end
