require 'test_helper'

class StaffTest < ActiveSupport::TestCase
  test 'should not save staff without image and name' do
    staff = Staff.new(description: 'description')
    assert_not staff.valid?
    assert_not_nil staff.errors[:name]
    assert_not_nil staff.errors[:image]
  end
end
