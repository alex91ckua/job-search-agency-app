class Staff < ApplicationRecord
  mount_uploader :image, AttachmentUploader
end
