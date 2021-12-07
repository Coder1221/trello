class User < ApplicationRecord
  rolify strict: true
  has_many :boards , dependent: :destroy
  attr_accessor :login , :invited_by_role
  has_many :invitations, class_name: 'User', as: :invited_by
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable 
  # callbacks
  after_create :assign_default_role
  
  def assign_default_role
    self.add_role(:creator) if self.roles.blank?
  end

  def self.find_for_database_authentication warden_condition
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.strip.downcase}]).first
  end   
end