require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it { should belong_to(:ratable) }

  it { should validate_presence_of(:rating) }
  it { should validate_inclusion_of(:rating).in_array([-1, 1]) }
end
