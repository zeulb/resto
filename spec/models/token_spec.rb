require 'rails_helper'

RSpec.describe Token, type: :model do
  it { should validate_presence_of(:token) }
end
