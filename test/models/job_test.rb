require 'test_helper'

class JobTest < ActiveSupport::TestCase
  test 'should not save job without job type' do
    job = Job.new(title: 'title',
                  sector: 'sector',
                  salary: 10_000,
                  description: 'text',
                  responsibilities: 'text',
                  location: 'text'
    )
    assert_not job.valid?
    assert_not_nil job.errors[:job_type]
  end

end
