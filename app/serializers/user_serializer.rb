class UserSerializer < ActiveModel::Serializer
  attributes :id, :country, :phone, :phone2, :email, :email2, :role, :timezone, :contact_flags
end
