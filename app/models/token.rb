class Token < ApplicationRecord
  has_secure_password :token, validations: false
end
