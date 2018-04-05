require 'test_helper'

class CandidateTest < ActiveSupport::TestCase

  test 'invalid without name' do
    candidate = Candidate.new(email: 'john@example.com',
                         last_name: 'Name',
                         phone: '888',
                         job: Job.first
    )
    assert_not candidate.valid?, 'user is valid without a first name'
    assert_not_nil candidate.errors[:first_name], 'no validation error for name present'
  end

  test 'invalid without email' do
    candidate = Candidate.new(first_name: 'Name',
                              last_name: 'Name',
                              phone: '888',
                              job: Job.first
    )
    assert_not candidate.valid?, 'user is valid without email'
    assert_not_nil candidate.errors[:email], 'no validation error for email present'
  end

  test 'valid with email, first_name, last_name, phone and job' do
    candidate = Candidate.new(email: 'john@example.com',
                              first_name: 'Name',
                              last_name: 'Name',
                              phone: '888',
                              job: Job.first
    )
    assert candidate.valid?, 'user is valid with email, first_name, last_name, phone and job'
  end

  test 'invalid without correct email format' do
    candidate = Candidate.new(email: 'john.example.com',
                              first_name: 'Name',
                              last_name: 'Name',
                              phone: '888',
                              job: Job.first
    )
    assert_not candidate.valid?, 'user is invalid without correct email'
    assert_not_nil candidate.errors[:email], 'no validation error for name present'
  end

end
